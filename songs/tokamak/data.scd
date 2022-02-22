///////////////////////////////////////////////// YAWN Data: tokamak /////////////////////////////////////////////////
({ |yawnShow, tokamakInstance|
	var cueKeys = ['tokamakLoop'];
	var pathToDMXMIDI = tokamakInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = tokamakInstance.path +/+ "kemperMIDI/";

	var trackOut = yawnShow.outputs['trackOut'];
	var leads = tokamakInstance.pbTracks['leads'];
	var efx   = tokamakInstance.pbTracks['efx'];
	var perc  = tokamakInstance.pbTracks['perc'];
	var adds  = tokamakInstance.pbTracks['adds'];

	[
		(
			name:  'tokamakPB',
			click: [[ ClickRest(142,4,47) ]],
			bTracks: [ YAWNPlayback.makePat(leads[0],trackOut),YAWNPlayback.makePat(efx[0],trackOut),YAWNPlayback.makePat(perc[0],trackOut) ]
		),(
			name:  'tokamakCount',
			click: [[ Click(142,2,repeats: 2), Click(142,1,repeats: 4) ]],
			lights:[ DMXIS.makePat('tokamakCount',pathToDMXMIDI +/+ "count.mid") ],
			kemper:[ KemperMIDI.makePat('tokamakCount',pathToKemperMIDI +/+ "count.mid") ],
		),(
			name:  'tokamakIntro',
			click: [[ Click(142,4,repeats: 6), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4) ]],
			lights:[ ],
			kemper:[ KemperMIDI.makePat('tokamakIntro',pathToKemperMIDI +/+ "intro.mid") ],
		),(
			name:  'tokamakGuitar',
			click: [[ Click(142,4,repeats: 15), ClickCue(142,1,repeats: 4),Click(142,4,repeats: 30), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4) ]],
			lights:[ ],
			kemper:[ KemperMIDI.makePat('tokamakGuitar',pathToKemperMIDI +/+ "guitar.mid") ],
		),(
			name:  'tokamakBreak',
			click: [[ Click(142,4,repeats: 4) ]],
			lights:[ ],
			kemper:[ KemperMIDI.makePat('tokamakBreak',pathToKemperMIDI +/+ "break.mid") ],
		),(
			name:  'tokamakFunk',
			click: [[ Click(142,4,repeats: 48) ]],
			lights:[ ],
			kemper:[ KemperMIDI.makePat('tokamakFunk',pathToKemperMIDI +/+ "funk.mid") ],
		),(
			name:  'tokamakImproIntro',
			click: [[ Click(142,4,repeats: 16) ]],
			lights:[ DMXIS.makePat('tokamakImproIntro',pathToDMXMIDI +/+ "impro.mid")],    //this needs to change!!!
			kemper:[ KemperMIDI.makePat('tokamakImproIntro',pathToKemperMIDI +/+ "improIntro.mid") ]
		),(
			name:  'tokamakImpro',
			click: [[ ClickLoop(142,loopKey: cueKeys[0]) ]],
			lights:[ DMXIS.makePat('tokamakImproLoop',pathToDMXMIDI +/+ "impro.mid",cueKeys[0])],
			kemper:[ KemperMIDI.makePat('tokamakImproLoop',pathToKemperMIDI +/+ "impro.mid") ]
		),(
			name:  'tokamakCue',
			click: [[ ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4), Click(142,4,repeats: 5) ]],
			lights:[ DMXIS.makePat('tokamakCue',pathToDMXMIDI +/+ "cue.mid")],
			kemper:[ KemperMIDI.makePat('tokamakCue',pathToKemperMIDI +/+ "cue.mid") ],
			bTracks: [ YAWNPlayback.makePat(adds[1],trackOut),YAWNPlayback.makePat(perc[1],trackOut) ]
		),(
			name:  'tokamakOutro',
			click: [[ Click(142,4,repeats: 57), Click(142,2) ]],
			lights:[ DMXIS.makePat('tokamakOutro',pathToDMXMIDI +/+ "outro.mid") ],
			kemper:[ KemperMIDI.makePat('tokamakOutro',pathToKemperMIDI +/+ "outro.mid") ]
		)
	]
})