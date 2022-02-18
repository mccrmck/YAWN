///////////////////////////////////////////////// YAWN Data: lachrymator /////////////////////////////////////////////////
({ |lachrymatorInstance|
	var cueKeys = ['lachTap'];
	var pathToDMXMIDI = lachrymatorInstance.path +/+ "dmxMIDI/";

	[
		(
			name: 'lachCountPart1',
			click: [[ Click(240,2,repeats: 2), Click(240,1,repeats: 4) ]],
			lights:[ DMXIS.makePat('lachCountPart1',pathToDMXMIDI ++ "countPart1.mid") ],
		),(
			name: 'lachAsection',
			click: [[
				ClickConCat(7, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
				ClickConCat(6, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
				ClickConCat(7, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
				ClickConCat(11, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
				ClickConCat(5, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
				ClickConCat(5, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
				ClickConCat(9, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
				ClickConCat(34,Click(240,4), Click(300,4))  //transition to impro
			]],
			lights:[ DMXIS.makePat('lachAsection',pathToDMXMIDI ++ "Asection.mid") ],
		),(
			name: 'lachTapping',
			click: [[ ClickLoop(120,4,loopKey: cueKeys[0]) ]],
			lights:[ DMXIS.makePat('lachTapping',pathToDMXMIDI ++ "tapping.mid",cueKeys[0]) ],
		),(
			name: 'lachCountPart2',
			click: [[ ClickCue(120,4,repeats: 2), ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4) ]],
			lights:[ DMXIS.makePat('lachCountPart2',pathToDMXMIDI ++ "countPart2.mid") ],
		),(
			name: 'lachJazzIntro',
			click: [[
				Click(120,3,repeats: 2), Click(120,5),
				Click(120,3,repeats: 2), Click(120,4),
				Click(120,3,repeats: 3), Click(120,5),
				Click(120,3,repeats: 2), Click(120,4),
				Click(120,3)
			]],
			lights:[ DMXIS.makePat('lachJazzIntro',pathToDMXMIDI ++ "jazzIntro.mid") ],
		),(
			name: 'lachJazzAsection',
			click: [[
				Click(120,3,repeats: 2), Click(120,5),
				Click(120,3,repeats: 2), Click(120,4),
				Click(120,3,repeats: 3), Click(120,5),
				Click(120,3,repeats: 2), Click(120,4),
				Click(120,3)
			]],
			lights:[ DMXIS.makePat('lachJazzAsection',pathToDMXMIDI ++ "jazzAsection.mid") ],
		),(
			name: 'lachJazzBsection',
			click: [[ Click(120,3,repeats: 16) ]],
			lights:[ DMXIS.makePat('lachJazzBsection',pathToDMXMIDI ++ "jazzBsection.mid") ],
		),(
			name: 'lachJazzAsectionAgain',
			click: [[
				Click(120,3,repeats: 2), Click(120,5),
				Click(120,3,repeats: 2), Click(120,4),
				Click(120,3,repeats: 3), Click(120,5),
				Click(120,3,repeats: 2), Click(120,4),
				Click(120,3)
			]],
			lights:[ DMXIS.makePat('lachJazzAsectionAgain',pathToDMXMIDI ++ "jazzAsectionAgain.mid") ],
		),(
			name: 'lachJazzBsectionAgain',
			click: [[ Click(120,3,repeats: 15), Click(120,2) ]],
			lights:[ DMXIS.makePat('lachJazzBsectionAgain',pathToDMXMIDI ++ "jazzBsectionAgain.mid") ],
		),(
			name: 'lachCountPart3',
			click: [[ ClickConCat(2, Click(340,5), Click(340,4)) ]],
			lights:[ DMXIS.makePat('lachCountPart3',pathToDMXMIDI ++ "countPart3.mid") ],
		),(
			name: 'lachAsectionNine',
			click: [[
				ClickConCat(3, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
				ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
				ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
				ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,1, repeats: 5), Click(340,4),
				ClickConCat(4, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),

				ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
				ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
				ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,1,repeats: 5), Click(340,4),
				ClickConCat(4, Click(340,5), Click(340,4)),	Click(170,4,repeats: 2)
			]],
			lights:[ DMXIS.makePat('lachAsectionNine',pathToDMXMIDI ++ "AsectionNine.mid") ],
		),(
			name: 'lachOutro',
			click: [[
				ClickConCat(2, Click(240,4), Click(300,4)),

				// this is separated from the above line for clarity - everything below was part of \rit2
				ClickConCat(3, Click(240,4), Click(300,4)),
				Array.geom(12,300,0.95).collect({ |item, index|

					case
					{index < 10 }{ [Click(item * 0.8,4), Click(item,4)] }
					{index == 10}{ [Click(item * 0.8,4), ClickCue(item,4)] }
					{index > 10 }{ [ClickCue(item * 0.8,4), ClickCue(item,4)] }
				}),
				ClickCue()
			].flat],
			lights:[ DMXIS.makePat('lachOutro',pathToDMXMIDI ++ "outro.mid") ],
		)
	]
})