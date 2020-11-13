/////////////////////////////////////////////////YAWN Click #2/////////////////////////////////////////////////

(
// tempos
~bars.value(300);
//tempo for 4:5 @ 300bpm
~bars.value(240);
~bars.value(170);
~bars.value(120);

Pdef('rit2',
	Pbind(
		\instrument, \click,
		\dur, Pseq([Pseq(1.25!4 ++ (1!4),15),Pseq([1],1)]),
		\freq, Pseq([Pseq(1000 * [2,1,1,1],28),Pseq([2000],8),Pseq([2500],1)],inf),
		\tempo, Pseq((300!24 ++ Array.geom(12,300,0.95).stutter(8))/60,inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('rit2bell',
	Pbind(
		\instrument, \playbackMono,
		\dur, Pseq([Pseq(1.25!4 ++ (1!4),15),Pseq([1],1)]),
		\type, Pseq([\rest!108,[\note,\rest!3]!3,\note].flat),
		\bufnum,Pseq([~buffers[\bell]],inf),
		\tempo, Pseq((300!24 ++ Array.geom(12,300,0.95).stutter(8))/60,inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('open2',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1],inf),
		\freq, Pwhile({~cues["numberTwo"][\open2cue]},Pseq(1000*[2,1,1,1])),
		\tempo, Pseq([120/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('cue2',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1],inf),
		\freq, Pseq(1000 * [2,1,1,1,2,1,1,1,2,1,2,1,2,2,2,2],1),
		\tempo, Pseq([120/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('bell2',
	Pbind(
		\instrument, \playbackMono,
		\dur, Pseq([4,4,2,2,1,1,1,1],1),
		\bufnum,Pseq([~buffers[\bell]],inf),
		\rate,Pseq([1],inf),
		\tempo, Pseq([120/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef(\play2part1,
	Psym(
		Pseq([
			// count off
			't240q2'!2,'t240q1'!4,

			// Intro/A part
			['t240q4','t300q4']!64,

		].flat,1)
	)
);

// 1st Echo Amb A-part

Pdef(\play2part2,
	Psym(
		Pseq([
			// count off
			'open2',
			[['cue2','bell2']],

			// NorskJazz part intro pre solo
			't120q3'!2,'t120q5',
			't120q3'!2,'t120q4',
			't120q3'!3,'t120q5',
			't120q3'!2,'t120q4',
			't120q3',

			// NorskJazz part for realsz
			// A-part:
			't120q3'!2,'t120q5',
			't120q3'!2,'t120q4',
			't120q3'!3,'t120q5',
			't120q3'!2,'t120q4',
			't120q3',

			// B-part:
			't120q3'!16,

			// A-part:
			't120q3'!2,'t120q5',
			't120q3'!2,'t120q4',
			't120q3'!3,'t120q5',
			't120q3'!2,'t120q4',
			't120q3',

			// B-part:
			't120q3'!16,

		].flatten(1),1)
	)
);

// 2nd Echo Amb A-part

Pdef(\play2part3,
	Psym(
		Pseq([
			// count off
			['t170e5','t170e4']!2,

			// A-part modulated
			['t170e5','t170e4']!48,
			't170q4'!2,
			// Outro/A part(no melody)
			['t240q4','t300q4']!2,

			[[['rit2','rit2bell']]]
		].flatten(2),1)
	)
);

"click #2 loaded".postln;
)