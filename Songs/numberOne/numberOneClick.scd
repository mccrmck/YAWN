/////////////////////////////////////////////////YAWN Click #1/////////////////////////////////////////////////

(
// tempos
~bars.value(120);
~bars.value(160);

Pdef('loop4',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1],inf),
		\freq, Pwhile({~cues["numberOne"][\loop4cue]},Pseq((1000 * [2,1,1,1]!4).flat)),
		\tempo, Pseq([160/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('cue1loop4',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1],inf),
		\freq, Pseq(1000 * [2,1,1,1,2,1,1,1,2,1,2,1,2,2,2,2],1),
		\tempo, Pseq([160/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('bell1loop4',
	Pbind(
		\instrument, \playbackMono,
		\dur, Pseq([8,2,2,1,1,1,1],1),
		\type, Pseq([\rest,\note!6].flat),
		\bufnum,Pseq([~buffers[\bell]],inf),
		\rate,Pseq([1],inf),
		\tempo, Pseq([160/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('loop8',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1],inf),
		\freq, Pwhile({~cues["numberOne"][\loop8cue]},Pseq((1000 * [2,1,1,1]!8).flat)),
		\tempo, Pseq([160/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('cue1loop8',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1],inf),
		\freq, Pseq([Pseq(1000 * [2,1,1,1],6),Pseq(1000 * [2,1,2,1,2,2,2,2],1)],1),
		\tempo, Pseq([160/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('bell1loop8',
	Pbind(
		\instrument, \playbackMono,
		\dur, Pseq([24,2,2,1,1,1,1],1),
		\type, Pseq([\rest,\note!6].flat),
		\bufnum,Pseq([~buffers[\bell]],inf),
		\rate,Pseq([1],inf),
		\tempo, Pseq([160/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('elevenRiff',
	Pbind(
		\instrument, \click,
		\dur, Pseq([[[2,3/2,2]!8] ++ [1!4]].flat,inf),
		\freq, Pwhile({~cues["numberOne"][\elevenRiffcue]},Pseq([Pseq(1000 * [2,1,1],8),Pseq(1000*[2,1,1,1],1)])),
		\tempo, Pseq([200/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('elevenRiffcue',
	Pbind(
		\instrument, \click,
		\dur, Pseq([[[2,3/2,2]!8] ++ [1!4]].flat,1),
		\freq, Pseq([Pseq(1000 * [2,1,1],6),Pseq(1000 * [2,2,2],2),Pseq(1000*[2.5,2,2,2])]),
		\tempo, Pseq([200/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('elevenRiffcueBell',
	Pbind(
		\instrument, \playbackMono,
		\dur, Pseq([[[2,3/2,2]!8] ++ [1!4]].flat,1),
		\type, Pseq([\rest!12,[\note,\rest,\rest]!4,\note!4].flat),
		\bufnum,Pseq([~buffers[\bell]],inf),
		\rate,Pseq([1],inf),
		\tempo, Pseq([200/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('bell1part3',
	Pbind(
		\instrument, \playbackMono,
		\dur, Pseq([1],1),
		\bufnum,Pseq([~buffers[\bell]],inf),
		\rate,Pseq([1],inf),
		\tempo, Pseq([120/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef('small4bar',
	Pbind(
		\instrument, \click,
		\dur, Pseq([1,1,2/3],inf),
		\freq, Pseq((1000 * [2,1,1]).flat,1),
		\tempo, Pseq([120/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

Pdef(\play1part1,
	Psym(
		Pseq([
			// count off
			't160q2'!2,'t160q1'!4,

			// Pre intro(only Gtr)
			'loop4',
			[['cue1loop4','bell1loop4']],

			// Intro with drums
			'loop8',
			[['cue1loop8','bell1loop8']],
			't160q4'!2,
			// CUE into the BREAK

			// count in to new tempo
			't120q4',
			// A riff 1
			't120q4'!5,'t120q3','t120q4'!2,'t120q2','t120q4'!2,'t120q3',
			't120q4'!5,'t120q3','t120q4'!2,'t120q2','t120q4'!2,'t120q3',

			// Solo part(11/8)
			'elevenRiff',
			[['elevenRiffcue','elevenRiffcueBell']],

		].flatten(1),1)
	)
);

// count in to BOMBS
Pdef(\play1part2,
	Psym(
		Pseq([
			't120q4',
		].flat,1)
	)
);

Pdef(\play1part3,
	Psym(
		Pseq([
			// count off
			['t120q2','bell1part3']!2,
			['t120q1','bell1part3']!4,

			't120q3',

			// A riff 2
			't120q4'!5,'t120q3','t120q4'!2,'t120q2','t120q4'!2,'t120q3',
			't120q4'!5,'t120q3','t120q4'!2,'t120q2','t120q4'!2,'t120q3',

			// Outro
			't120q4'!15,'small4bar',
			't120q4'!3,
		].flatten(1),1)
	)
);
"click #1 loaded".postln;
)
