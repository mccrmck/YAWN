/////////////////////////////////////////////////YAWN Click #2/////////////////////////////////////////////////
(
// var amp = some Bus?
// var out = some Bus?
var fast = Array.geom(12,300,0.95);
var slow = fast  * 0.8;
var endRit = fast.collect({ |item, index|

	case
	{index < 10}{ [Click(slow[index],4), Click(item,4)] }
	{index == 10}{ [Click(slow[index],4), ClickCue(item,4)] }
	{index > 10}{ [ClickCue(slow[index],4), ClickCue(item,4)] }
});

Pdef(\play2part1,
	Psym(
		Pseq([
			// count off
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
			ClickCue(120,4,repeats: 2), ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4),

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
			// count off
			[ Click(240,5), Click(240,4) ].dup(2),

			// A-part modulated
			[ Click(240,5), Click(240,4) ].dup(48),
			Click(170,4,repeats: 2)

			// Outro/A part(no melody)
			[ Click(240,4), Click(300,4) ].dup(2),

			// this is separated from the above line for redundancy - everything below was part of \rit2
			[ Click(240,4), Click(300,4) ].dup(3),
			endRit,
			ClickCue(fast.last,1),
		].flatten(1).clickKeys)
	)
);

"click #2 loaded".postln;
)