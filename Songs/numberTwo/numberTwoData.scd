///////////////////////////////////////////////// YAWN Data: numberTwo /////////////////////////////////////////////////
(
[
	(
		name: 'p1_count_off',
		click: [Click(240,2,repeats: 2), Click(240,1,repeats: 4)],
	),
	(
		name: 'p1_a_part',
		click: [ Click(240,4), Click(300,4) ].dup(64).flat
	),
	(
		name: 'p2_count_off',
		click: [
			ClickLoop(120,4,loopKey: \openTwo),
			ClickCue(120,4,repeats: 2), ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4),
		],
	),
	(
		name: 'p2_jazzIntro',
		click: [
			Click(120,3,repeats: 2), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3,repeats: 3), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3)
		],
	),
	(
		name: 'p2_jazz4Realz',
		click: [
			Click(120,3,repeats: 2), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3,repeats: 3), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3)
		],
	),
	(
		name: 'p2_b_part',
		click: [Click(120,3,repeats: 16)],
	),
	(
		name: 'p2_jazz4RealzAgain',
		click: [
			Click(120,3,repeats: 2), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3,repeats: 3), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3)
		],
	),
	(
		name: 'p2_b_partAgain',
		click: [Click(120,3,repeats: 16)],
	),
	(
		name: 'p3_count_off',
		click: [ Click(240,5), Click(240,4) ].dup(2).flat,
	),
	(
		name: 'p3_modA+part',
		click: [
			[ Click(240,5), Click(240,4) ].dup(4),
			Click(170,4,repeats: 2)
		].flat,
	),
	(
		name: 'p3_outro',
		click: [
			[ Click(240,4), Click(300,4) ].dup(2),

			// this is separated from the above line for redundancy - everything below was part of \rit2
			[ Click(240,4), Click(300,4) ].dup(3),
			Array.geom(12,300,0.95).collect({ |item, index|

				case
				{index < 10}{ [Click(item * 0.8,4), Click(item,4)] }
				{index == 10}{ [Click(item * 0.8,4), ClickCue(item,4)] }
				{index > 10}{ [ClickCue(item * 0.8,4), ClickCue(item,4)] }
			});,
			ClickCue().key
		].flat,
	),
];
)