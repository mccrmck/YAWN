/////////////////////////////////////////////////YAWN Click #1/////////////////////////////////////////////////
(
// var amp = some Bus?
// var out = some Bus?

// ClickMan(([1,4/3,1]!8 ++ (2!4)).flat * 100) // almost, accents aren't right yet...
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

Pdef(\play1part1,
	Psym(
		Pseq([
			// count off
			Click(160,2,repeats: 2), Click(160,1,repeats: 4),

			// Pre intro(only Gtr)
			ClickLoop(160,4,repeats: 4,loopKey: \openOneFourLoop),
			Click(160,4,repeats: 2), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4),

			// Intro with drums
			ClickLoop(160,4,repeats: 8,loopKey: \openOneEightLoop),

			Click(160,4,repeats: 6), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4),
			// CUE into the BREAK
			Click(160,4,repeats: 2),

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
			ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4),

			Click(120,3),

			// A riff 2
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),

			// Outro
			Click(120,4,repeats: 15), ClickMan([120,120,180]),
			Click(120,4,repeats: 3),
		].flatten(1).clickKeys)
	)
);
"click #1 loaded".postln;
)

