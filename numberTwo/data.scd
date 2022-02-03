///////////////////////////////////////////////// YAWN Data: numberTwo /////////////////////////////////////////////////

var cueKeys = [\openTwo];
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberTwo/dmxMIDI/";

[
	(
		name: 'twoCountPart1',
		click: [ Click(240,2,repeats: 2), Click(240,1,repeats: 4) ],
		lights:[ DMXIS.makePat('twoCountPart1',pathToDMXMIDI ++ "countPart1.mid") ],
	),(
		name: 'twoAsection',
		click: [ Click(240,4), Click(300,4) ].dup(64).flat,
		lights:[ DMXIS.makePat('twoAsection',pathToDMXMIDI ++ "Asection.mid") ],
	),(
		name: 'twoTapping',
		click: [ ClickLoop(120,4,loopKey: cueKeys[0]),],
		lights:[ DMXIS.makePat('twoTapping',pathToDMXMIDI ++ "tapping.mid",cueKeys[0]) ],
	),(
		name: 'twoCountPart2',
		click: [ ClickCue(120,4,repeats: 2), ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4) ],
		lights:[ DMXIS.makePat('twoCountPart2',pathToDMXMIDI ++ "countPart2.mid") ],
	),(
		name: 'twoJazzIntro',
		click: [
			Click(120,3,repeats: 2), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3,repeats: 3), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3)
		],
		lights:[ DMXIS.makePat('twoJazzIntro',pathToDMXMIDI ++ "jazzIntro.mid") ],

	),(
		name: 'twoJazzAsection',
		click: [
			Click(120,3,repeats: 2), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3,repeats: 3), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3)
		],
		lights:[ DMXIS.makePat('twoJazzAsection',pathToDMXMIDI ++ "jazzAsection.mid") ],
	),(
		name: 'twoJazzBsection',
		click: [ Click(120,3,repeats: 16) ],
		lights:[ DMXIS.makePat('twoJazzBsection',pathToDMXMIDI ++ "jazzBsection.mid") ],
	),(
		name: 'twoJazzAsectionAgain',
		click: [
			Click(120,3,repeats: 2), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3,repeats: 3), Click(120,5),
			Click(120,3,repeats: 2), Click(120,4),
			Click(120,3)
		],
		lights:[ DMXIS.makePat('twoJazzAsectionAgain',pathToDMXMIDI ++ "jazzAsectionAgain.mid") ],
	),(
		name: 'twoJazzBsectionAgain',
		click: [ Click(120,3,repeats: 16) ],
		lights:[ DMXIS.makePat('twoJazzBsectionAgain',pathToDMXMIDI ++ "jazzBsectionAgain.mid") ],
	),(
		name: 'twoCountPart3',
		click: [ Click(340,5), Click(340,4) ].dup(2).flat,
		lights:[ DMXIS.makePat('twoCountPart3',pathToDMXMIDI ++ "countPart3.mid") ],
	),(
		name: 'twoAsectionNine',
		click: [
			[ Click(340,5), Click(340,4) ].dup(48),
			Click(170,4,repeats: 2)
		].flat,
		lights:[ DMXIS.makePat('twoAsectionNine',pathToDMXMIDI ++ "AsectionNine.mid") ],
	),(
		name: 'twoOutro',
		click: [
			[ Click(240,4), Click(300,4) ].dup(2),

			// this is separated from the above line for clarity - everything below was part of \rit2
			[ Click(240,4), Click(300,4) ].dup(3),
			Array.geom(12,300,0.95).collect({ |item, index|

				case
				{index < 10 }{ [Click(item * 0.8,4), Click(item,4)] }
				{index == 10}{ [Click(item * 0.8,4), ClickCue(item,4)] }
				{index > 10 }{ [ClickCue(item * 0.8,4), ClickCue(item,4)] }
			}),
			ClickCue()
		].flat,
		lights:[ DMXIS.makePat('twoOutro',pathToDMXMIDI ++ "outro.mid") ],
	)
];