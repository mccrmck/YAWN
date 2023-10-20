YAWNDMXIS {

	classvar <loopCues, <vst;
	var <song, <section;
	var pathToMIDI;

	*initClass {
		loopCues = IdentityDictionary();

		StartUp.add{

			SynthDef(\dmxis,{
				OffsetOut.ar(
					\outBus.kr(0),
					VSTPlugin.ar(numOut: 1))
			}).add;
		}
	}

	*initVST {
		var cond = CondVar();
		vst = VSTPluginController( Synth(\dmxis) );

		fork{
			vst.open("DMXIS-Inst.vst", action:{ |v, bool|
				if(bool,{
					cond.signalOne
				},{
					"DMXIS failed to load".postln
				})
			});
			cond.wait { vst.loaded };
			vst.set(\Preset,0.01);
			0.1.wait;
			vst.set(\Preset,0);
			"Preset: 0".postln;
		}

		^vst
	}

	*new { |songKey, sectionKey|
		^super.newCopyArgs(songKey, sectionKey).init
	}

	init {
		var songDir  = song.firstToUpper.asClass.filenameSymbol.asString.dirname;
		var dmxisDir = songDir +/+ "dmxis/";
		var filePath = (dmxisDir +/+ section ++ ".mid").pathMatch;

		case
		{ filePath.size == 0 }{ "no files found at key: %".format(section).throw }
		{ filePath.size > 1  }{ "duplicate files found at key: %".format(section).throw }
		{ filePath.size == 1 }{ pathToMIDI = filePath[0] };
	}

	*free {
		vst.synth.free;
	}

	*setPreset { |preset| this.presetChange(0, preset) }

	*presetChange { |delta, preset|

		^Pbind(
			\type,\vst_set,
			\vst,Pfunc({ DMXIS.vst }),
			\params,[ \Preset ],
			\dur,Pseq( delta.asArray ),
			\Preset,Pseq( preset.asArray / 100 ),
		);
	}

	makePattern { |delta = 0, loop = false|

		var file = SimpleMIDIFile.read(pathToMIDI).timeMode_(\seconds).midiEvents;
		var notes    = file.reject({ |event| event[2] == 'cc' });
		var control  = file.select({ |event| event[2] == 'cc' });

		var notePats = 128.collect({ |midiNote|
			var num  = notes.select({ |event| event[4] == midiNote });

			if( num.size > 0,{
				var times = num.collect({ |event| event[1] }).differentiate.add(0.0);
				var chans = num.collect({ |event| event[3] });
				var vals  = num.collect({ |event| event[5] ? 0 });

				Pseq([
					Pbind(
						\dur, Pseq([ times[0] ]),
						\note, Rest()
					),
					Pbind(
						\type,Pseq([\vst_midi,\rest],inf), // manage with a Pfunc? load cmds, if(Pkey(\cmd) == noteOn, {type = \vst_midi},{type = \rest})
						\vst,Pfunc({ DMXIS.vst }),
						\dur,Pseq( times[1..] ),  // times
						\legato, 0.999,
						\midicmd, \noteOn,        // cmds
						\chan,Pseq( chans ),      // chans
						\midinote, num,           // nums
						\amp, Pseq( vals / 127 ), // vals
					)
				])
			})
		});

		var cTimes = control.collect({ |event| event[1] }).differentiate.add(0.0);
		var cChans = control.collect({ |event| event[3] }).add(0.0);
		var cNums = control.collect({ |event| event[4] }).add(0.0);
		var cVals = control.collect({ |event| event[5] }).add(0.0);

		var ccPat = if( cTimes.size > 1,{

			Pseq([
				Pbind(
					\dur, Pseq([ cTimes[0] ]),
					\note, Rest()
				),
				Pbind(
					\type,\vst_midi,
					\vst,Pfunc({ DMXIS.vst }),
					\dur,Pseq( cTimes[1..] ), // times
					\midicmd, \control,       // cmds
					\chan,Pseq( cChans ),     // chans
					\ctlNum, Pseq( cNums ),   // nums
					\control, Pseq( cVals ),  // vals
				)
			]);
		},{
			Pbind(
				\dur, Pseq([ cTimes[0] ]),
				\note, Rest()
			)
		});

		var pattern = Ppar( notePats ++ ccPat );

		if( loop,{
			var uniqueKey = (song ++ section.firstToUpper).asSymbol;
			loopCues.put(uniqueKey.asSymbol, true);
			pattern = Pwhile({ loopCues.at(uniqueKey.asSymbol) }, pattern )
		});

		pattern = Pseq([
			Rest(delta),
			pattern
		]);

		^pattern
	}
}