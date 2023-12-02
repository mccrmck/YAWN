YAWNPB {

	var <song, <section, <outKey;
	var pathToWAV, outBus;
	var <bufnum, <ampBus;

	*initClass {

		StartUp.add{

			[\monoYawnPlayback, \stereoYawnPlayback].do({ |key, index|
				var channels = index + 1;

				SynthDef(key,{
					var bufnum = \buf.kr();
					var sig = PlayBuf.ar(channels,bufnum,BufRateScale.kr(bufnum),loop: \loop.kr(0),doneAction: 2);
					OffsetOut.ar(\out.kr(0),sig  * \amp.kr(-20.dbamp));
				}).add;
			})
		}
	}

	*new { |songKey, sectionKey, busKey|
		^super.newCopyArgs(songKey.firstToUpper, sectionKey, busKey).init
	}

	init {
		var songDir   = song.asClass.filenameSymbol.asString.dirname;
		var tracksDir = songDir +/+ "tracks/";
		var filePath  = (tracksDir +/+ outKey +/+ section ++ ".wav").pathMatch;
		outBus = song.asClass.mixerDict[outKey] ?? { "invalid outKey specified".throw };

		case
		{ filePath.size == 0 }{ "no files found at key: %".format(section).throw }
		{ filePath.size > 1  }{ "duplicate files found at key: %".format(section).throw }
		{ filePath.size == 1 }{ pathToWAV = filePath[0] };

		// can I do a check to prevent channels spilling over (mono) busses?
 	}

	makePattern { |delta = 0, amp = 0.1|
		var bufDir = song.asClass.pbTracks[outKey];
		var bufnum = try { bufDir[section] } { "pbTracks not loaded\n".postln };
		var key = switch(bufnum.numChannels,
			1, \monoYawnPlayback,
			2, \stereoYawnPlayback,
		);

		^Pseq([
			Rest(delta),
			Pmono(
				key,
				\buf, Pseq([ bufnum ]),
				\dur, bufnum.duration,
				\amp, amp,
				\out, outBus                                  // this needs to point to a bus somewhere....
			)
		])
	}

	makeOverlapPattern {|delta = 0, amp = 0.1|
		var bufDir = song.asClass.pbTracks[outKey];
		var bufnum = try { bufDir[section] } { "pbTracks not loaded\n".postln; ^nil };
		// var outBus = song.asClass.mixerDict[outKey] ?? "invalid outKey specified".postln;
		var key = switch(bufnum.numChannels,
			1, \monoYawnPlayback,
			2, \stereoYawnPlayback,
		);

		^Pseq([
			Rest(delta),
			Pbind(
				\instrument,key,
				\buf, Pseq([ bufnum ]),
				\dur, 0,
				\amp, amp,
				\out, outBus                                 // this needs to point to a bus somewhere....
			)
		])
	}
}