YAWNKemper {
	classvar <loopCues, <>midiOut;
	var <song, <section;
	var pathToMIDI;

	*initClass {
		loopCues = IdentityDictionary();
	}

	*initMIDI { |device, port|
		var cond = CondVar();

		fork {
			MIDIClient.init;
			cond.wait({ MIDIClient.initialized });
			midiOut = MIDIOut.newByName(device.asString, port.asString);
			midiOut.postln
		};
	}

	*new { |songKey, sectionKey|
		^super.newCopyArgs(songKey, sectionKey).init
	}

	init {
		var songDir   = song.firstToUpper.asClass.filenameSymbol.asString.dirname;
		var kemperDir = songDir +/+ "kemper/";
		var filePath  = (kemperDir +/+ section ++ ".mid").pathMatch;

		case
		{ filePath.size == 0 }{ "no files found at key: %".format(section).throw }
		{ filePath.size >  1 }{ "duplicate files found at key: %".format(section).throw }
		{ filePath.size == 1 }{ pathToMIDI = filePath[0] };
	}

	makePattern { |delta = 0, loop = false|
		var pattern;
		var file = SimpleMIDIFile.read( pathToMIDI ).timeMode_(\seconds).midiEvents;

		if(file.size > 0,{
			var times = file.collect({ |event| event[1] }).differentiate.add(0);
			var cmds  = file.collect({ |event| event = event.replace(\cc,'control'); event[2] });
			var chans = file.collect({ |event| event[3] });
			var nums  = file.collect({ |event| event[4] });
			var vals  = file.collect({ |event| event[5] ? 0 });

			pattern = Pseq([
				Pbind(
					\dur, Pseq([ times[0] ]),
					\note, Rest()
				),
				Pbind(
					\type,\midi,
					\midiout,midiOut,
					\dur, Pseq( times[1..] ),
					\midicmd, Pseq( cmds ),
					\chan, Pseq( chans ),   // 0-15

					\nums, Pseq( nums ),
					\vals, Pseq( vals ),
					\dummy, Pfunc({ |event|
						if(event['midicmd'] == 'program',{
							event.put('progNum',event['nums']);
						},{
							event.put('ctlNum', event['nums']);
							event.put('control',event['vals']);
						});
					})
				)
			]);
		},{
			pattern = Pbind(
				\dur,Pseq([ 0 ]),
				\note, Rest(0.01)
			);
		});

		if( loop,{
			var uniqueKey = (song ++ section.firstToUpper).asSymbol;
			loopCues.put(uniqueKey , true);
			pattern = Pwhile({ loopCues.at( uniqueKey ) }, pattern )
		});

		pattern = Pseq([
			Rest(delta),
			pattern
		]);

		^pattern
	}
}
