///////////////////////////////////////////////// YAWN Click: Cement /////////////////////////////////////////////////

(
var tempoA = 160;
var tempoB = 170;
// var amp = some Bus?
// var out = some Bus?

// this can eventually disappear as well...
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
Pdef(\cementClick,
	Psym(
		Pseq([
			// count off     ->  turn into ClickCues!!!
			Click(tempoA,2,repeats: 2), Click(tempoA,1,repeats: 4),

			// intro
			Click(tempoA,7), Click(tempoA,6), Click(tempoA,5), Click(tempoA,4), Click(tempoA,3),
			Click(tempoA,7), Click(tempoA,6), Click(tempoA,5), Click(tempoA,4), Click(tempoA,3),
			Click(tempoA,7), Click(tempoA,6), Click(tempoA,5), Click(tempoA,4,repeats: 2),

			// A-section
			Click(tempoB,7), Click(tempoB,6), Click(tempoB,5), Click(tempoB,4), Click(tempoB,3),
			Click(tempoB,7), Click(tempoB,6), Click(tempoB,5), Click(tempoB,4), Click(tempoB,3),
			Click(tempoB,7), Click(tempoB,6), Click(tempoB,5), Click(tempoB,4,repeats: 2),

			// A-section w/ melody
			Click(tempoB,7), Click(tempoB,6), Click(tempoB,5), Click(tempoB,4), Click(tempoB,3),
			Click(tempoB,7), Click(tempoB,6), Click(tempoB,5), Click(tempoB,4), Click(tempoB,3),
			Click(tempoB,7), Click(tempoB,6), Click(tempoB,5), Click(tempoB,4,repeats: 2),

			// B-section
			Click(tempoB,4,repeats: 13), Click(tempoB,5),

			// Open Section
			ClickLoop(tempoB,loopKey: \openCement),
			[[ 'cue3', 'bell3' ]],                                     // make into ClickCues
			Click(tempoB,4), //break

			// B-section after Open Section
			Click(tempoB,4,repeats: 10), Click(tempoB,2), Click(tempoB,4,repeats: 5), Click(tempoB,5), Click(tempoB * 2,3),
			Click(tempoB,4,repeats: 10), Click(tempoB,2), Click(tempoB,4,repeats: 5), Click(tempoB,5), Click(tempoB * 2,3),

			// Gtr Solo
			[Click(tempoB,4,repeats: 10), Click(tempoB,2), Click(tempoB,4,repeats: 5), Click(tempoB,5), Click(tempoB * 2,3)].dup(4),

			// QUINTUPLETS
			[
				[ Click(tempoB,4), Click(tempoB,5) ],
				[ Click(tempoB,4), Click(tempoB,5) ],
				[ Click(tempoB,4), Click(tempoB,5) ],
				Click(tempoB,4)
			].dup(3),

			'rit3',                                       // make into ClickMan or ClickEnv?
			Click(tempoB * 2,3),

			// A-section melody last time
			Click(tempoB,7), Click(tempoB,6), Click(tempoB,5), Click(tempoB,4), Click(tempoB,3),
			Click(tempoB,7), Click(tempoB,6), Click(tempoB,5), Click(tempoB,4), Click(tempoB,3),
			Click(tempoB,7), Click(tempoB,6), Click(tempoB,5), Click(tempoB,4,repeats: 2),
			Click(tempoB,7), Click(tempoB,6), Click(tempoB,5), Click(tempoB,4), Click(tempoB,3),

		].flatten(2).clickKeys)
	)
);
"click #3 loaded".postln;
)