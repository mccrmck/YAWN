///////////////////////////////////////////////// YAWN Data: numberTwo /////////////////////////////////////////////////
(
var cueKeys = [\openOneFourLoop,\openOneEightLoop,\elevenRiff];
[
	(
		name: 'p1_count_off',
		click: [ Click(160,2,repeats: 2), Click(160,1,repeats: 4) ],
	),(
		name: 'p1_introGit',
		click: [
			ClickLoop(160,4,repeats: 4,loopKey: \openOneFourLoop),         // cueKeys[0]
			Click(160,4,repeats: 2), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4)
		],
	),(
		name: 'p1_introGitDrums',
		click: [
			ClickLoop(160,4,repeats: 8,loopKey: \openOneEightLoop),        // cueKeys[1]
			Click(160,4,repeats: 6), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4),
			Click(160,4,repeats: 2)
		],
	),(
		name: 'p1_newTempo',
		click: [ Click(120,4) ],
	),(
		name: 'p1_aRiff',
		click: [
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
		],
	),
	/*(
	name: 'p1_elevenRiff',
	click: [],                               //not ready yet!!!!
	),*/
	(
		name: 'p2_bombs',
		click: [ Click(120,4) ],
	),(
		name: 'p3_count_off',
		click: [
			ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4),
			Click(120,3)
		],
	),(
		name: 'p3_aRiff',
		click: [
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
		],
	),(
		name: 'outro',
		click: [
			Click(120,4,repeats: 15), ClickMan([120,120,180]),
			Click(120,4,repeats: 3)
		],
	)
];
)