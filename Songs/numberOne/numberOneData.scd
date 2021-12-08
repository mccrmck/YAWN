///////////////////////////////////////////////// YAWN Data: numberOne /////////////////////////////////////////////////

var cueKeys = [\openOneFour,\openOneEight,\openOneEleven];
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberOne/dmxMIDI/";

[
	/*(
	name: 'oneCountPart1',
	click: [ Click(160,2,repeats: 2), Click(160,1,repeats: 4) ],
	lights:[ ],
	),(
	name: 'oneGit',
	click: [ ClickLoop(160,4,repeats: 4,loopKey: cueKeys[0]) ],
	lights:[],
	),*/
	(
		name: 'oneDrumCue',
		click: [ Click(160,4,repeats: 2), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4) ],
		lights:[ DMXIS.makePat('oneDrumCue',pathToDMXMIDI ++ "drumCue.mid")],
	),(
		name: 'oneGitDrums',
		click: [ ClickLoop(160,4,repeats: 8,loopKey: cueKeys[1])],
		lights:[ DMXIS.makePat('oneGitDrums',pathToDMXMIDI ++ "gitDrums.mid",cueKeys[1]) ],
	),(
		name: 'oneGitDrumsLast',
		click: [
			Click(160,4,repeats: 6), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4),
			Click(160,4,repeats: 2)
		],
		lights:[ DMXIS.makePat('oneGitDrumsLast',pathToDMXMIDI ++ "gitDrumsLast.mid") ],
	),(
		name: 'oneNewTempo',
		click: [ Click(120,4) ],
		lights:[ DMXIS.makePat('oneNewTempo',pathToDMXMIDI ++ "newTempo.mid") ],
	),(
		name: 'oneAsection',
		click: [
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
		],
		lights:[ DMXIS.makePat('oneAsection',pathToDMXMIDI ++ "Asection.mid") ],
	),(
		name: 'oneEleven',
		click: [ ClickConCatLoop(cueKeys[2],ClickMan([1,4/3,1] * 100,1,8),Click(200,4)) ],
		lights:[ DMXIS.makePat('oneEleven',pathToDMXMIDI ++ "eleven.mid",cueKeys[2]) ],
	),(
		name: 'oneElevenLast',
		click: [
			ClickMan([1,4/3,1] * 100,repeats: 4),
			ClickManCue([1,4/3,1] * 100,repeats: 4),
			ClickCue(200,repeats: 4),
			Click(120,3)
		],
		lights:[ DMXIS.makePat('oneElevenLast',pathToDMXMIDI ++ "elevenLast.mid") ],
	),(
		name: 'oneBomb',
		click: [ Click(120,4),Click(120,3) ],
		lights:[ DMXIS.makePat('oneBomb',pathToDMXMIDI ++ "bomb.mid") ],
	),(
		name: 'oneCountPart3',
		click: [
			ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4),
			Click(120,3)
		],
		lights:[ DMXIS.makePat('oneCountPart3',pathToDMXMIDI ++ "countPart3.mid") ],
	),(
		name: 'oneAsectionAgain',
		click: [
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
		],
		lights:[ DMXIS.makePat('oneAsectionAgain',pathToDMXMIDI ++ "AsectionAgain.mid") ],
	),(
		name: 'oneOutro',
		click: [
			Click(120,4,repeats: 15), ClickMan([120,120,180]),
			Click(120,4,repeats: 3)
		],
		lights:[ DMXIS.makePat('oneOutro',pathToDMXMIDI ++ "outro.mid") ],
	)
];