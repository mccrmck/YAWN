
/////////////////////////////////////////////////YAWN Click #4/////////////////////////////////////////////////

(
// tempos
~bars.value(142);

Pdef('open4',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1],inf),
		\freq, Pwhile({~cues["numberFour"][\open4cue]},Pseq([1000])),
		\tempo, Pseq([142/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('cue4',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1],inf),
		\freq, Pseq(1000 * [2,1,1,1,2,1,1,1,2,1,2,1,2,2,2,2],1),
		\tempo, Pseq([142/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('bell4',
	Pbind(
		\instrument, \playbackMono,
		\dur, Pseq([4,4,2,2,1,1,1,1],1),
		\bufnum,Pseq([~buffers[\bell]],inf),
		\rate,Pseq([1],inf),
		\tempo, Pseq([142/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

//master click
Pdef(\play4,
	Psym(
		Pseq([
			// count off
			't142q2'!2,'t142q1'!4,
			//beginning
			't142q4'!116,
			//ambient solo
			'open4',
			[['cue4','bell4']],
			//synth sample buildup
			't142q4'!5,'t142q2',
			//heavy outro
			't142q4'!57,
			't142q2' // - last beat
		].flatten(1),1)
	)
);
"click #4 loaded".postln;
)

//rehearsal mark Pdefs!!!