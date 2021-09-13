///////////////////////////////////////////////// YAWN Click: #4 /////////////////////////////////////////////////
(
// var amp = some Bus?
// var out = some Bus?

Pdef(\numberFourClick,
	Psym(
		Pseq([
			// count off
			Click(142,2,repeats: 2), Click(142,1,repeats: 4),

			//beginning
			Click(142,4,repeats: 116),

			//ambient solo
			ClickLoop(142,loopKey: \openFour),

			// cue
			ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4),

			//synth sample buildup
			Click(142,4,repeats: 5), Click(142,2),

			// outro
			Click(142,4,repeats: 57),
			Click(142,2)           // last beat
		].flatten(1).clickKeys)
	)
);
"click #4 loaded".postln;
)

