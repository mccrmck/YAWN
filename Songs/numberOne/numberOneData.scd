///////////////////////////////////////////////// YAWN Data: numberOne /////////////////////////////////////////////////

var cueKeys = [\openOneFour,\openOneEight,\openOneEleven];
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberOne/dmxMIDI/";

[
	/*(
	name: 'oneCountPart1',
	click: [ Click(160,2,repeats: 2), Click(160,1,repeats: 4) ],
	lights:[ DMXIS.loadFromMIDI('oneCountPart1',pathToDMXMIDI ++ "countPart1.mid") ],
	),(
	name: 'oneGit',
	click: [ ClickLoop(160,4,repeats: 4,loopKey: cueKeys[0]) ],
	lights:[ DMXIS.loadFromMIDI('oneGitIntro',pathToDMXMIDI ++ "gitIntro.mid",cueKeys[0]) ],
	),*/
	(
		name: 'oneDrumCue',
		click: [ Click(160,4,repeats: 2), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4) ],
		lights:[ DMXIS.loadFromMIDI('oneDrumCue',pathToDMXMIDI ++ "drumCue.mid") ],
	),(
		name: 'oneGitDrums',
		click: [ ClickLoop(160,4,repeats: 8,loopKey: cueKeys[1])],
		lights:[ DMXIS.loadFromMIDI('oneGitDrums',pathToDMXMIDI ++ "gitDrums.mid",cueKeys[1]) ],
	),(
		name: 'oneGitDrumsLast',
		click: [
			Click(160,4,repeats: 6), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4),
			Click(160,4,repeats: 2)
		],
		lights:[ DMXIS.loadFromMIDI('oneGitDrumsLast',pathToDMXMIDI ++ "gitDrumsLast.mid") ],
	),(
		name: 'oneNewTempo',
		click: [ Click(120,4) ],
		lights:[ DMXIS.loadFromMIDI('oneNewTempo',pathToDMXMIDI ++ "newTempo.mid") ],
	),(
		name: 'oneAsection',
		click: [
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
		],
		lights:[ DMXIS.loadFromMIDI('oneAsection',pathToDMXMIDI ++ "Asection.mid") ],
	),(
		name: 'oneEleven',
		click: [ ClickConCatLoop(cueKeys[2],ClickMan([1,4/3,1] * 100,1,8),Click(200,4)) ],
		lights:[ DMXIS.loadFromMIDI('oneEleven',pathToDMXMIDI ++ "eleven.mid",cueKeys[2]) ],
	),(
		name: 'oneElevenLast',
		click: [
			ClickMan([1,4/3,1] * 100,repeats: 4),
			ClickManCue([1,4/3,1] * 100,repeats: 4),
			ClickCue(200,repeats: 4),
			Click(120,3)
		],
		lights:[ DMXIS.loadFromMIDI('oneElevenLast',pathToDMXMIDI ++ "elevenLast.mid") ],
	),(
		name: 'oneBomb',
		click: [ Click(120,4),Click(120,3) ],
		lights:[ DMXIS.loadFromMIDI('oneBomb',pathToDMXMIDI ++ "bomb.mid") ],
	),(
		name: 'oneCountPart3',
		click: [
			ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4),
			Click(120,3)
		],
		lights:[ DMXIS.loadFromMIDI('oneCountPart3',pathToDMXMIDI ++ "countPart3.mid") ],
	),(
		name: 'oneAsectionAgain',
		click: [
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
		],
		lights:[ DMXIS.loadFromMIDI('oneAsectionAgain',pathToDMXMIDI ++ "AsectionAgain.mid") ],
	),(
		name: 'oneOutro',
		click: [
			Click(120,4,repeats: 15), ClickMan([120,120,180]),
			Click(120,4,repeats: 3)
		],
		lights:[ DMXIS.loadFromMIDI('oneOutro',pathToDMXMIDI ++ "outro.mid") ],
	)
];