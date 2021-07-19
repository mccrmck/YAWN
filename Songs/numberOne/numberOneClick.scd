/////////////////////////////////////////////////YAWN Click #1/////////////////////////////////////////////////

(
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
		\freq, Pwhile({~cues["numberOne"][\elevenRiffcue]},Pseq([Pseq(1000 * [2,1,1],8),Pseq(1000*[2,1,1,1])])),
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
			// count off     ->  turn into ClickCues!!!
			Click(160,2,repeats: 2), Click(160,1,repeats: 4),

			// Pre intro(only Gtr)
			ClickLoop(160,4,repeats: 4,loopKey: \openOneFourLoop),
			[['cue1loop4','bell1loop4']],

			// Intro with drums
			ClickLoop(160,4,repeats: 8,loopKey: \openOneEightLoop),
			[['cue1loop8','bell1loop8']],
			Click(160,4,repeats: 2),
			// CUE into the BREAK

			// count in to new tempo
			Click(120,4),

			// A riff 1
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),

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
			Click(120,4)
		].clickKeys)
	)
);

Pdef(\play1part3,
	Psym(
		Pseq([
			// count off
			['t120q2','bell1part3']!2,
			['t120q1','bell1part3']!4,

			Click(120,3),

			// A riff 2
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),

			// Outro
			Click(120,4,repeats: 15), 'small4bar',     // ClickMan?
			Click(120,4,repeats: 3),
		].flatten(1).clickKeys)
	)
);
"click #1 loaded".postln;
)