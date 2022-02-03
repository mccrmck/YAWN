///////////////////////////////////////////////// YAWN Data: cement /////////////////////////////////////////////////

var cueKeys = [\openCement];
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/cement/dmxMIDI/";

[
	(
		name: 'cementCount',
		click: [ Click(160,2,repeats: 2), Click(160,1,repeats: 4,)],
		lights:[ DMXIS.makePat('cementCount',pathToDMXMIDI ++ "count.mid") ],
	),(
		name: 'cementIntro',
		click:[
			Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
			Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
			Click(160,7), Click(160,6), Click(160,5), Click(160,4,repeats: 2)
		],
		lights:[ DMXIS.makePat('cementIntro',pathToDMXMIDI ++ "intro.mid") ],
	),(
		name: 'cementAsection',
		click:[
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2)
		],
		lights:[ DMXIS.makePat('cementAsection',pathToDMXMIDI ++ "Asection.mid") ],
	),(
		name: 'cementMelody',
		click:[
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2)
		],
		lights:[ DMXIS.makePat('cementMelody',pathToDMXMIDI ++ "melody.mid") ],
	),(
		name: 'cementBsection',
		click: [ Click(170,4,repeats: 13), Click(170,5)],
		lights:[ DMXIS.makePat('cementBsection',pathToDMXMIDI ++ "Bsection.mid") ],
	),(
		name: 'cementImpro',
		click: [ ClickLoop(170,loopKey: cueKeys[0]) ],
		lights:[ DMXIS.makePat('cementImpro',pathToDMXMIDI ++ "impro.mid",cueKeys[0]) ],
	),(
		name: 'cementCue',
		click:[
			ClickCue(170,4,repeats: 2), ClickCue(170,2,repeats: 2), ClickCue(170,1,repeats: 4),
			Click(170,4),
		],
		lights:[ DMXIS.makePat('cementCue',pathToDMXMIDI ++ "cue.mid") ],
	),(
		name: 'cementBsectionAgain',
		click:[
			Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
			Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
		],
		lights:[ DMXIS.makePat('cementBsectionAgain',pathToDMXMIDI ++ "BsectionAgain.mid") ],
	),(
		name: 'cementGtrSolo',
		click: [ Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3)].dup(4).flat,
		lights:[ DMXIS.makePat('cementGtrSolo',pathToDMXMIDI ++ "gtrSolo.mid") ],
	),(
		name: 'cementQuint',
		click: [
			[ Click(160,4), Click(200,5) ],
			[ Click(160,4), Click(200,5) ],
			[ Click(160,4), Click(200,5) ],
			Click(160,4)
		].dup(3).flatten(1),
		lights:[ DMXIS.makePat('cementQuint',pathToDMXMIDI ++ "quint.mid") ],
	),(
		name: 'cementRit',
		click: [
			(1.0,1.08..2.12).collect({ |i| Click(200 / i) }),
			Click(170 * 2,3)
		].flat,
		lights:[ DMXIS.makePat('cementRit',pathToDMXMIDI ++ "rit.mid") ],
	),(
		name: 'cementAsectionLast',
		click:[
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
		],
		lights:[ DMXIS.makePat('cementAsectionLast',pathToDMXMIDI ++ "AsectionLast.mid") ],
	),
];