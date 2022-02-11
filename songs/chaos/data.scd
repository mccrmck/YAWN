///////////////////////////////////////////////// YAWN Data: chaos /////////////////////////////////////////////////

var cueKeys = ['chaosIntroLoop','chaosElevenLoop'];
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/chaos/dmxMIDI/";

[
	(
		name:  'chaosGitIntro',
		click: [[ ClickLoop(160,4,repeats: 4,loopKey: cueKeys[0]) ]],
		lights:[ DMXIS.makePat('chaosGitIntro',pathToDMXMIDI ++ "gitIntro.mid",cueKeys[0]) ],
	),
	(
		name:  'chaosDrumCue',
		click: [[ Click(160,4,repeats: 2), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4) ]],
		lights:[ DMXIS.makePat('chaosDrumCue',pathToDMXMIDI ++ "drumCue.mid") ],
	),(
		name:  'chaosGitDrums',
		click: [[
			Click(160,4,repeats: 8 * 3),
			Click(160,4,repeats: 6), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4),
			Click(160,4,repeats: 2)
		]],
		lights:[ DMXIS.makePat('chaosGitDrums',pathToDMXMIDI ++ "gitDrums.mid") ],   // must change!!!
	),(
		name:  'chaosNewTempo',
		click: [[ Click(120,4) ]],
		lights:[ DMXIS.makePat('chaosNewTempo',pathToDMXMIDI ++ "newTempo.mid") ],
	),(
		name:  'chaosAsection',
		click: [[
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
		]],
		lights:[ DMXIS.makePat('chaosAsection',pathToDMXMIDI ++ "Asection.mid") ],
	),(
		name:  'chaosEleven',
		click: [[ ClickConCatLoop(cueKeys[1],ClickMan([1,4/3,1] * 100,1,8),Click(200,4)) ]],
		lights:[ DMXIS.makePat('chaosEleven',pathToDMXMIDI ++ "eleven.mid",cueKeys[1]) ],
	),(
		name:  'chaosElevenLast',
		click: [[
			ClickMan([1,4/3,1] * 100,repeats: 4),
			ClickManCue([1,4/3,1] * 100,repeats: 4),
			ClickCue(200,repeats: 4),
			Click(120,3)
		]],
		lights:[ DMXIS.makePat('chaosElevenLast',pathToDMXMIDI ++ "elevenLast.mid") ],
	),(
		name:  'chaosBomb',
		click: [[ Click(120,4),Click(120,3) ]],
		lights:[ DMXIS.makePat('chaosBomb',pathToDMXMIDI ++ "bomb.mid") ],
	),(
		name:  'chaosCountAgain',
		click: [[ ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4), Click(120,3) ]],
		lights:[ DMXIS.makePat('chaosCountAgain',pathToDMXMIDI ++ "countAgain.mid") ],
	),(
		name:  'chaosAsectionAgain',
		click: [[
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
		]],
		lights:[ DMXIS.makePat('chaosAsectionAgain',pathToDMXMIDI ++ "AsectionAgain.mid") ],
	),(
		name:  'chaosOutro',
		click: [[ Click(120,4,repeats: 15), ClickMan([120,120,180]), Click(120,4,repeats: 3) ]],
		lights:[ DMXIS.makePat('chaosOutro',pathToDMXMIDI ++ "outro.mid") ],
	)
];