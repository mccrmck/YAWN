/////////////////////////////////////////////////YAWN Click #2/////////////////////////////////////////////////

(
// var amp = some Bus?
// var out = some Bus?

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

Pdef(\play2part1,
	Psym(
		Pseq([
			// count off     ->  turn into ClickCues!!!
			Click(240,2,repeats: 2), Click(240,1,repeats: 4),

			// Intro/A part
			[ Click(240,4), Click(300,4) ].dup(64)

		].flat.clickKeys)
	)
);

Pdef(\play2part2,
	Psym(
		Pseq([
			// count off
			ClickLoop(120,4,loopKey: \openTwo),
			[[ 'cue2','bell2' ]],                                  // make into ClickCues

			// NorskJazz part intro pre solo                                   // this can probably be simplified, no?
			Click(120,3,repeats: 2), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3,repeats: 3), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3),

			// NorskJazz part for realsz
			// A-part:
			Click(120,3,repeats: 2), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3,repeats: 3), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3),

			// B-part:
			Click(120,3,repeats: 16),

			// A-part:
			Click(120,3,repeats: 2), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3,repeats: 3), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3),

			// B-part:
			Click(120,3,repeats: 16)

		].flatten(1).clickKeys)
	)
);

Pdef(\play2part3,
	Psym(
		Pseq([
			// count off     ->  turn into ClickCues!!!
			[ Click(240,5), Click(240,4) ].dup(2),

			// A-part modulated
			[ Click(240,5), Click(240,4) ].dup(48),
			Click(170,4,repeats: 2)

			// Outro/A part(no melody)
			[ Click(240,4), Click(300,4) ].dup(2),

			[[ 'rit2','rit2bell' ]]       // make into ClickMan or ClickEnv?
		].flatten(1).clickKeys)
	)
);

"click #2 loaded".postln;
)