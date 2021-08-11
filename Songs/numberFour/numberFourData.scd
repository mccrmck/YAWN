///////////////////////////////////////////////// YAWN Data: numberFour /////////////////////////////////////////////////
(
[
	(
		name: 'count_off',
		click: [Click(142,2,repeats: 2), Click(142,1,repeats: 4)],
	),
	(
		name: 'beginning',
		click:[Click(142,4,repeats: 116)],
	),
	(
		name: 'ambient_solo',
		click: [ClickLoop(142,loopKey: \openFour)],
	),(
		name: 'cue',
		click: [ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4)],
	),(
		name:'synthBuildup',
		click: [Click(142,4,repeats: 5), Click(142,2)],
	),
	(
		name: 'outro',
		click: [Click(142,4,repeats: 57), Click(142,2)],  // last beat
	)
];
)
