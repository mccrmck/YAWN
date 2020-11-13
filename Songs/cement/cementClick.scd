/////////////////////////////////////////////////YAWN Click #3/////////////////////////////////////////////////

(
// tempos
~bars.value(160);
~bars.value(170);
//quintuplets @ 200 (160*5/4)
~bars.value(200);

Pdef('open3',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1],inf),
		\freq, Pwhile({~cues["numberThree"][\open3cue]},Pseq([1000])),
		\tempo, Pseq([170/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('cue3',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1],inf),
		\freq, Pseq(1000 * [2,1,1,1,2,1,1,1,2,1,2,1,2,2,2,2],1),
		\tempo, Pseq([170/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('bell3',
	Pbind(
		\instrument, \playbackMono,
		\dur, Pseq([4,4,2,2,1,1,1,1],1),
		\bufnum,Pseq([~buffers[\bell]],inf),
		\rate,Pseq([1],inf),
		\tempo, Pseq([170/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('quint160',
	Pbind(
		\instrument, \click,
		\dur, Pseq([4/5],inf),
		\freq, Pseq(1000 * [2,1,1,1,1],1),
		\tempo, Pseq([160/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('rit3',
	Pbind(
		\instrument, \click,
		\dur, Pseq((1.0,1.08..2.12),1), // or use Pseries? // this suddenly doesn't generate the whole array...
		\freq, Pseq([1000] * 2,inf),
		\tempo, Pseq([200/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

//master click
Pdef(\play3,
	Psym(
		Pseq([
			// count off
			't160q2'!2,'t160q1'!4,
			// intro
			['t160q7','t160q6','t160q5','t160q4','t160q3']!2,
			't160q7','t160q6','t160q5','t160q4','t160q4',
			// A-section
			['t170q7','t170q6','t170q5','t170q4','t170q3']!2,
			't170q7','t170q6','t170q5','t170q4','t170q4',
			// A-section w/ melody
			['t170q7','t170q6','t170q5','t170q4','t170q3']!2,
			't170q7','t170q6','t170q5','t170q4','t170q4',

			// B-section
			't170q4'!13,'t170q5',

			// Open Section
			'open3',
			[[['cue3','bell3']]],
			't170q4', //break

			// B-section after Open Section
			't170q4'!10,'t170q2','t170q4'!5,'t170q5','t170e3',
			't170q4'!10,'t170q2','t170q4'!5,'t170q5','t170e3',

			// Gtr Solo
			't170q4'!10,'t170q2','t170q4'!5,'t170q5','t170e3',
			't170q4'!10,'t170q2','t170q4'!5,'t170q5','t170e3',
			't170q4'!10,'t170q2','t170q4'!5,'t170q5','t170e3',
			't170q4'!10,'t170q2','t170q4'!5,'t170q5','t170e3',

			// QUINTUPLETS

			[['t160q4','quint160']]!3,
			't160q4',
			[['t160q4','quint160']]!3,
			't160q4',
			[['t160q4','quint160']]!3,
			't160q4',

			'rit3',
			't170e3',

			// A-section melody last time
			['t170q7','t170q6','t170q5','t170q4','t170q3']!2,
			't170q7','t170q6','t170q5','t170q4','t170q4',
			't170q7','t170q6','t170q5','t170q4','t170q3'
		].flatten(2),1)
	)
);
"click #3 loaded".postln;
)