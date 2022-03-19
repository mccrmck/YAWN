///////////////////////////////////////////////// YAWN Data: chaos /////////////////////////////////////////////////
({ |yawnShow, chaosInstance|
	var cueKeys = ['chaosIntroLoop','chaosElevenLoop'];
	var pathToDMXMIDI = chaosInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = chaosInstance.path +/+ "kemperMIDI/";

	var trackOut = yawnShow.outputs['trackOut'];
	var leads = chaosInstance.pbTracks['leads'];
	var efx   = chaosInstance.pbTracks['efx'];
	var perc  = chaosInstance.pbTracks['perc'];
	var adds  = chaosInstance.pbTracks['adds'];

	[
		(
			name:   'chaosIntro',
			click:  [[ ClickLoop(160,4,loopKey: cueKeys[0]) ]],
			lights: [ DMXIS.makePresetPat('chaosIntro',1,6) ],
			kemper: [ KemperMIDI.makePat('chaosIntro',pathToKemperMIDI +/+ "intro.mid") ],
		),(
			name:   'chaosDrumCue',
			click:  [[ Click(160,4,repeats: 6), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4) ]],
			lights: [ Pseq([ DMXIS.makePresetPat('chaosDrumCue', 11.8125, 6),  DMXIS.makePresetPat('chaosDrumCueReset', 0.1, 0) ]) ],
			// lights: [ DMXIS.makePresetPat('chaosDrumCue',1,6) ],
			kemper: [ KemperMIDI.makePat('chaosDrumCue',pathToKemperMIDI +/+ "drumCue.mid") ],
			bTracks:[ YAWNPlayback.makePat(efx[0],trackOut) ]
		),(
			name:   'chaosGitDrums',
			click:  [[
				Click(160,4,repeats: 8 * 3),
				Click(160,4,repeats: 6), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4),
				Click(160,4,repeats: 2)
			]],
			lights: [ DMXIS.makePat('chaosGitDrums',pathToDMXMIDI +/+ "gitDrums.mid") ],
			kemper: [ KemperMIDI.makePat('chaosGitDrums',pathToKemperMIDI +/+ "gitDrums.mid") ],
			bTracks:[ YAWNPlayback.makePat(perc[0],trackOut) ]
		),(
			name:   'chaosNewTempo',
			click:  [[ Click(120,4) ]],
			lights: [ DMXIS.makePat('chaosNewTempo',pathToDMXMIDI +/+ "newTempo.mid") ],
			kemper: [ KemperMIDI.makePat('chaosNewTempo',pathToKemperMIDI +/+ "newTempo.mid") ],
		),(
			name:   'chaosAsection',
			click:  [[
				Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
				Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			]],
			lights: [ DMXIS.makePat('chaosAsection',pathToDMXMIDI +/+ "Asection.mid") ],
			kemper: [ KemperMIDI.makePat('chaosAsection',pathToKemperMIDI +/+ "Asection.mid") ],
			bTracks:[ YAWNPlayback.makePat(adds[0],trackOut),YAWNPlayback.makePat(perc[1],trackOut),YAWNPlayback.makePat(leads[0],trackOut) ]
		),(
			name:   'chaosElevenFirst',
			click:  [[ ClickConCat(1,ClickMan([1,4/3,1] * 100,1,8),Click(200,4)) ]],
			lights: [ DMXIS.makePat('chaosElevenFirst',pathToDMXMIDI +/+ "elevenFirst.mid") ],
			kemper: [ KemperMIDI.makePat('chaosElevenFirst',pathToKemperMIDI +/+ "elevenFirst.mid") ],
		),(
			name:   'chaosEleven',
			click:  [[ ClickConCatLoop(cueKeys[1],ClickMan([1,4/3,1] * 100,1,8),Click(200,4)) ]],
			lights: [ DMXIS.makePresetPat('chaosEleven',1,6) ],
		),(
			name:  'chaosElevenLast',
			click: [[
				ClickMan([1,4/3,1] * 100,repeats: 4),
				ClickManCue([1,4/3,1] * 100,repeats: 4),
				ClickCue(200,repeats: 4),
				Click(120,3)
			]],
			lights: [
				Pseq([ DMXIS.makePat('chaosElevenLast',pathToDMXMIDI ++ "elevenLast.mid"), DMXIS.makePresetPat('chaosElevenLast',1,7) ]),
				DMXIS.makePresetPat('chaosElevenLast',1,0)

			],
			kemper: [ KemperMIDI.makePat('chaosElevenLast',pathToKemperMIDI +/+ "elevenLast.mid") ],
			bTracks:[ YAWNPlayback.makePat(efx[1],trackOut),YAWNPlayback.makePat(perc[2],trackOut),YAWNPlayback.makePat(adds[1],trackOut) ]
		),(
			name:   'chaosBomb',
			click:  [[ Click(120,4),Click(120,3) ]],
			lights: [ Pseq([ DMXIS.makePresetPat('chaosBomb',(60/120 * 3.75),7), DMXIS.makePresetPat('chaosBombReset',(60/120 * 0.25),0), DMXIS.makePat('chaosBomb',pathToDMXMIDI ++ "bomb.mid"), DMXIS.makePresetPat('chaosBombEnd',1,7) ]) ],
			kemper: [ KemperMIDI.makePat('chaosBomb',pathToKemperMIDI +/+ "bomb.mid") ],
			bTracks:[ YAWNPlayback.makePat(adds[2],trackOut),YAWNPlayback.makePat(perc[3],trackOut) ]
		),(
			name:   'chaosCountAgain',
			click:  [[ ClickRest(120,4), ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4), Click(120,3) ]],
			lights: [ Pseq([ DMXIS.makePresetPat('chaosCountAgain',(60/120 * 11.75),7),DMXIS.makePresetPat('chaosCountAgain',(60/120 * 0.25),0) ]),
				DMXIS.makePat('chaosCountAgain',pathToDMXMIDI ++ "countAgain.mid")
			],
			kemper: [ KemperMIDI.makePat('chaosCountAgain',pathToKemperMIDI +/+ "countAgain.mid") ],
			bTracks:[ YAWNPlayback.makePat(adds[3],trackOut),YAWNPlayback.makePat(perc[4],trackOut),YAWNPlayback.makePat(leads[1],trackOut) ]
		),(
			name:   'chaosAsectionAgain',
			click:  [[
				Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
				Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3),
			]],
			lights: [ DMXIS.makePat('chaosAsectionAgain',pathToDMXMIDI ++ "AsectionAgain.mid") ],
			kemper: [ KemperMIDI.makePat('chaosAsectionAgain',pathToKemperMIDI +/+ "AsectionAgain.mid") ],
		),(
			name:   'chaosOutro',
			click:  [[ Click(120,4,repeats: 15), ClickMan([120,120,180]), Click(120,4,repeats: 3) ]],
			lights: [ DMXIS.makePat('chaosOutro',pathToDMXMIDI ++ "outro.mid") ],
			kemper: [ KemperMIDI.makePat('chaosOutro',pathToKemperMIDI +/+ "outro.mid") ],
		)
	]
})