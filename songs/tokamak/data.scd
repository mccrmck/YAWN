///////////////////////////////////////////////// YAWN Data: tokamak /////////////////////////////////////////////////
({ |yawnShow, tokamakInstance|
	var cueKeys = ['tokamakLoop'];
	var pathToDMXMIDI = tokamakInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = tokamakInstance.path +/+ "kemperMIDI/";

	var trackOut = yawnShow.outputs['trackOut'];
	var mainOut  = yawnShow.outputs['masterOut'];
	var leads = tokamakInstance.pbTracks['leads'];
	var efx   = tokamakInstance.pbTracks['efx'];
	var perc  = tokamakInstance.pbTracks['perc'];
	var adds  = tokamakInstance.pbTracks['adds'];
	var bow  = tokamakInstance.pbTracks['bow'];

	[
		(
			name:   'tokamakPB',
			click:  [[ ClickRest(142,4,47) ]],
			lights: [ DMXIS.makePresetPat('tokamakPB',1,4) ],
			bTracks:[ YAWNPlayback.makePat(leads[0],trackOut),YAWNPlayback.makePat(efx[0],trackOut),YAWNPlayback.makePat(perc[0],trackOut) ]
		),(
			name:   'tokamakCount',
			click:  [[ Click(142,2,repeats: 2), Click(142,1,repeats: 4) ]],
			lights: [ DMXIS.makePresetPat('tokamakCount',1,0) ],
			kemper: [ KemperMIDI.makePat('tokamakCount',pathToKemperMIDI +/+ "count.mid") ],
		),(
			name:  'tokamakIntro',
			click: [[ Click(142,4,repeats: 6), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4) ]],
			kemper:[ KemperMIDI.makePat('tokamakIntro',pathToKemperMIDI +/+ "intro.mid") ],
		),(
			name:  'tokamakGuitar',
			click: [[ Click(142,4,repeats: 15), ClickCue(142,1,repeats: 4), Click(142,4,repeats: 30), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4) ]],
			lights:[ DMXIS.makePat('tokamakGuitar',pathToDMXMIDI +/+ "guitar.mid") ],
			kemper:[ KemperMIDI.makePat('tokamakGuitar',pathToKemperMIDI +/+ "guitar.mid") ],
		),(
			name:  'tokamakBreak',
			click: [[ Click(142,4,repeats: 4) ]],
			lights:[ DMXIS.makePat('tokamakBreak',pathToDMXMIDI +/+ "break.mid") ],
			kemper:[ KemperMIDI.makePat('tokamakBreak',pathToKemperMIDI +/+ "break.mid") ],
		),(
			name:  'tokamakFunk',
			click: [[ Click(142,4,repeats: 48) ]],
			lights:[ DMXIS.makePat('tokamakFunk',pathToDMXMIDI +/+ "funk.mid") ],
			kemper:[ KemperMIDI.makePat('tokamakFunk',pathToKemperMIDI +/+ "funk.mid") ],
		),(
			name:  'tokamakImproIntro',
			click: [[ Click(142,4,repeats: 16) ]],
			lights:[ DMXIS.makePat('tokamakImproIntro',pathToDMXMIDI +/+ "improIntro.mid") ],
			kemper:[ KemperMIDI.makePat('tokamakImproIntro',pathToKemperMIDI +/+ "improIntro.mid") ]
		),(
			name:  'tokamakImpro',
			click: [[ ClickLoop(142,loopKey: cueKeys[0]) ]],
			lights:[ DMXIS.makePresetPat('tokamakImpro',1,5) ],
			kemper:[ KemperMIDI.makePat('tokamakImpro',pathToKemperMIDI +/+ "impro.mid") ]
		),(
			name:   'tokamakCue',
			click:  [[ ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4), Click(142,4,repeats: 5) ]],
			lights: [ Pseq([ DMXIS.makePresetPat('tokamakCue',0,0), DMXIS.makePat('tokamakCue',pathToDMXMIDI +/+ "cue.mid") ]) ],
			kemper: [ KemperMIDI.makePat('tokamakCue',pathToKemperMIDI +/+ "cue.mid") ],
			bTracks:[ YAWNPlayback.makePat(adds[1],trackOut),YAWNPlayback.makePat(perc[1],trackOut) ]
		),(
			name:  'tokamakOutro',
			click: [[ Click(142,4,repeats: 57), Click(142,2) ]],
			lights:[ DMXIS.makePat('tokamakOutro',pathToDMXMIDI +/+ "outro.mid") ],
			kemper:[ KemperMIDI.makePat('tokamakOutro',pathToKemperMIDI +/+ "outro.mid") ]
		),(
			name: 'bow',
			click: [[ ClickRest() ]],
			lights:[ DMXIS.makePresetPat('bow',0,8) ],
			bTracks: [ YAWNPlayback.makePat(bow[0],mainOut) ]
		)
	]
})