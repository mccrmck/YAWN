///////////////////////////////////////////////// YAWN Click: #4 /////////////////////////////////////////////////
(
var tempo = 142;
// var amp = some Bus?
// var out = some Bus?

Pdef(\numberFourClick,
	Psym(
		Pseq([

			// count off     ->  turn into ClickCues!!!
			Click(tempo,2,repeats: 2), Click(tempo,1,repeats: 4),

			//beginning
			Click(tempo,4,repeats: 116),

			//ambient solo
			ClickLoop(142,loopKey: \openFour),

			// cue ????
			[['cue4','bell4']],

			//synth sample buildup
			Click(tempo,4,repeats: 5), Click(tempo,2),

			// outro
			Click(tempo,4,repeats: 57),
			Click(tempo,2)           // last beat
		].flatten(1).clickKeys)
	)
);
"click #4 loaded".postln;
)