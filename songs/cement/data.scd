///////////////////////////////////////////////// YAWN Data: cement /////////////////////////////////////////////////
({ |yawnShow, cementInstance|
	var cueKeys = ['cementLoop'];
	var pathToDMXMIDI = cementInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = cementInstance.path +/+ "kemperMIDI/";

	var mainOut = yawnShow.outputs['masterOut'];
	var trackOut = yawnShow.outputs['trackOut'];
	var welcome = cementInstance.pbTracks['welcome'];
	var leads = cementInstance.pbTracks['leads'];
	var efx   = cementInstance.pbTracks['efx'];
	var perc  = cementInstance.pbTracks['perc'];
	var adds  = cementInstance.pbTracks['adds'];

	[
		(
			name: 'cementCount',
			click: [[ ClickRest( 60 / (leads[0].duration - Click(160,8).duration) ), Click(160,2,repeats: 2), Click(160,1,repeats:4) ]],
			// click: [[ Click(160,2,repeats: 2), Click(160,1,repeats:4) ]],
			// lights:[ DMXIS.makePat('cementCount',pathToDMXMIDI +/+ "count.mid") ],
			kemper: [ KemperMIDI.makePat('cementCount',pathToKemperMIDI +/+ "count.mid") ],
			bTracks:[ YAWNPlayback.makePat(welcome[0],mainOut)]
		),(
			name: 'cementIntro',
			click:[[
				Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
				Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
				Click(160,7), Click(160,6), Click(160,5), Click(160,4,repeats: 2)
			]],
			// lights:[ DMXIS.makePat('cementIntro',pathToDMXMIDI +/+ "intro.mid") ],
			kemper: [ KemperMIDI.makePat('cementIntro',pathToKemperMIDI +/+ "intro.mid") ],
			bTracks:[ YAWNPlayback.makePat(efx[0],trackOut), YAWNPlayback.makePat(perc[0],trackOut), YAWNPlayback.makePat(adds[0],trackOut) ]
		),(
			name: 'cementAsection',
			click:[[
				Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
				Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
				Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2)
			]],
			// lights:[ DMXIS.makePat('cementAsection',pathToDMXMIDI +/+ "Asection.mid") ],
			kemper: [ KemperMIDI.makePat('cementAsection',pathToKemperMIDI +/+ "Asection.mid") ],
		),(
			name: 'cementMelody',
			click:[[
				Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
				Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
				Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2)
			]],
			// lights:[ DMXIS.makePat('cementMelody',pathToDMXMIDI +/+ "melody.mid") ],
			kemper: [ KemperMIDI.makePat('cementMelody',pathToKemperMIDI +/+ "melody.mid") ],
		),(
			name:  'cementBsection',
			click: [[ Click(170,4,repeats: 14), Click(170,3) ]],
			// lights:[ DMXIS.makePat('cementBsection',pathToDMXMIDI +/+ "Bsection.mid") ],
			kemper: [ KemperMIDI.makePat('cementBsection',pathToKemperMIDI +/+ "Bsection.mid") ],
		),(
			name:  'cementImpro',
			click: [[ ClickLoop(170,loopKey: cueKeys[0]) ]],
			// lights:[ DMXIS.makePat('cementImpro',pathToDMXMIDI +/+ "impro.mid",cueKeys[0]) ],
		),(
			name:  'cementCue',
			click: [[ ClickCue(170,4,repeats: 2), ClickCue(170,2,repeats: 2), ClickCue(170,1,repeats: 4), Click(170,4) ]],
			// lights:[ DMXIS.makePat('cementCue',pathToDMXMIDI +/+ "cue.mid") ],
			kemper: [ KemperMIDI.makePat('cementCue',pathToKemperMIDI +/+ "cue.mid") ],
			bTracks:[ YAWNPlayback.makePat(leads[0],trackOut),YAWNPlayback.makePat(efx[1],trackOut), YAWNPlayback.makePat(perc[1],trackOut), YAWNPlayback.makePat(adds[1],trackOut) ]
		),(
			name:  'cementBsectionAgain',
			click: [[
				Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
				Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
			]],
			// lights:[ DMXIS.makePat('cementBsectionAgain',pathToDMXMIDI +/+ "BsectionAgain.mid") ],
			kemper: [ KemperMIDI.makePat('cementBsectionAgain',pathToKemperMIDI +/+ "BsectionAgain.mid") ],
		),(
			name:  'cementGtrSolo',
			click: [[ ClickConCat(4, Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3)) ]],
			// lights:[ DMXIS.makePat('cementGtrSolo',pathToDMXMIDI +/+ "gtrSolo.mid") ],
			kemper: [ KemperMIDI.makePat('cementGtrSolo',pathToKemperMIDI +/+ "gtrSolo.mid") ],
		),(
			name: 'cementQuint',
			click: [
				[ ClickConCat(3, Click(160,4,repeats: 3), ClickRest(160,4)) ],
				[ ClickConCat(3, Click(200,5,repeats: 3), Click(160,4)) ]
			],
			// lights:[ DMXIS.makePat('cementQuint',pathToDMXMIDI +/+ "quint.mid") ],
			kemper: [ KemperMIDI.makePat('cementQuint',pathToKemperMIDI +/+ "quint.mid") ],
		),(
			name: 'cementRit',
			click: [[ ClickConCat(1,(1.0,1.08..2.12).collect({ |i| Click(200 / i) })), Click(170 * 2,3) ]],
			// lights:[ DMXIS.makePat('cementRit',pathToDMXMIDI +/+ "rit.mid") ],
		),(
			name: 'cementAsectionLast',
			click:[[
				Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
				Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
				Click(170,7), Click(170,6), Click(170,5), Click(170,4, repeats: 2),
				Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			]],
			// lights:[ DMXIS.makePat('cementAsectionLast',pathToDMXMIDI +/+ "AsectionLast.mid") ],
			kemper: [ KemperMIDI.makePat('cementAsectionLast',pathToKemperMIDI +/+ "AsectionLast.mid") ],
			bTracks:[ YAWNPlayback.makePat(perc[2],trackOut), YAWNPlayback.makePat(adds[2],trackOut) ]
		),
	]
})