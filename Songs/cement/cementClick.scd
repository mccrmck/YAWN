///////////////////////////////////////////////// YAWN Click: Cement /////////////////////////////////////////////////
(
// var amp = some Bus?
// var out = some Bus?

// this can eventually disappear as well...find a ClickEnv solution!!
Pdef('rit3',
	Pbind(
		\instrument, \click,
		\dur, Pseq((1.0,1.08..2.12),1),
		\freq, Pseq([1000] * 2,inf),
		\tempo, Pseq([200/60],inf),
		\amp, Pfunc({~busses["clickAmp"].getSynchronous}),
		\outBus, ~outputs["click"],
	)
);

//master click
Pdef(\cementClick,
	Psym(
		Pseq([
			// count off
			Click(160,2,repeats: 2), Click(160,1,repeats: 4),

			// intro
			Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
			Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
			Click(160,7), Click(160,6), Click(160,5), Click(160,4,repeats: 2),

			// A-section
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2),

			// A-section w/ melody
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2),

			// B-section
			Click(170,4,repeats: 13), Click(170,5),

			// Open Section
			ClickLoop(170,loopKey: \openCement),
			ClickCue(170,4,repeats: 2), ClickCue(170,2,repeats: 2), ClickCue(170,1,repeats: 4),
			Click(170,4), //break

			// B-section after Open Section
			Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
			Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),

			// Gtr Solo
			[Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3)].dup(4),

			// QUINTUPLETS
			[
				[ Click(170,4), Click(170,5) ],
				[ Click(170,4), Click(170,5) ],
				[ Click(170,4), Click(170,5) ],
				Click(170,4)
			].dup(3),

			'rit3',                                       // make into ClickMan or ClickEnv?
			Click(170 * 2,3),

			// A-section melody last time
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),

		].flatten(2).clickKeys)
	)
);
"click #3 loaded".postln;
)