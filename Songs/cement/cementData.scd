///////////////////////////////////////////////// YAWN Data: cement /////////////////////////////////////////////////

var cueKeys = [\openCement];
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/cement/dmxMIDI/";

[
	(
		name: 'count_off',
		click: [Click(160,2,repeats: 2), Click(160,1,repeats: 4,)],
	),(
		name: 'intro',
		click:[
			Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
			Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
			Click(160,7), Click(160,6), Click(160,5), Click(160,4,repeats: 2)
		],
	),(
		name: 'a_section',
		click:[
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2)
		],
	),(
		name: 'a_sectionMelody',
		click:[
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2)
		],
	),(
		name: 'b_section',
		click:[Click(170,4,repeats: 13), Click(170,5)],
	),(
		name: 'open_section',
		click:[
			ClickLoop(170,loopKey: cueKeys[0]),
			ClickCue(170,4,repeats: 2), ClickCue(170,2,repeats: 2), ClickCue(170,1,repeats: 4),
			Click(170,4),
		],
	),(
		name: 'b_sectionAgain',
		click:[
			Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
			Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
		],
	),(
		name: 'gtr_solo',
		click: [Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3)].dup(4).flat,
	),(
		name: 'quintuplets',
		click: [
			[ Click(160,4), Click(200,5) ],
			[ Click(160,4), Click(200,5) ],
			[ Click(160,4), Click(200,5) ],
			Click(160,4)
		].dup(3).flatten(1),
	),(
		name: 'rit',
		click: [
			(1.0,1.08..2.12).collect({ |i| Click(200/i) });,
			Click(170 * 2,3)
		].flat
	),(
		name: 'lastA_section',
		click:[
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
		],
	),
];