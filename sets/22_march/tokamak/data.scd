///////////////////////////////////////////////// YAWN Data: tokamak /////////////////////////////////////////////////
{ |songInstance|
	var cueKeys = ['tokamakLoop'];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var leads = songInstance.pbTracks['leads'];
	var efx   = songInstance.pbTracks['efx'];
	var perc  = songInstance.pbTracks['perc'];
	var adds  = songInstance.pbTracks['adds'];
	var bow   = songInstance.pbTracks['bow'];

	var outs = YAWNShow.outDict;

	[
		(
			name:    'tokamakPB',
			countIn: [[ ]],
			click:   [[ ClickRest(142,4,47,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePresetPat('tokamakPB',1,4) ],
			bTracks: [
				YAWNPlayback.makeStereoPat(leads[0],outs['leadsOut']),
				YAWNPlayback.makeStereoPat(efx[0],outs['efxOut']),
				YAWNPlayback.makeStereoPat(perc[0],outs['percOut'])
			]
		),(
			name:    'tokamakCount',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePresetPat('tokamakCount',1,0) ],
			kemper:  [ KemperMIDI.makePat('tokamakCount',pathToKemperMIDI +/+ "count.mid") ],
		),(
			name:    'tokamakIntro',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(142,4,repeats: 6), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			kemper:  [ KemperMIDI.makePat('tokamakIntro',pathToKemperMIDI +/+ "intro.mid") ],
		),(
			name:    'tokamakGuitar',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1,Click(142,4,repeats: 15), ClickCue(142,1,repeats: 4), Click(142,4,repeats: 30), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('tokamakGuitar',pathToDMXMIDI +/+ "guitar.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakGuitar',pathToKemperMIDI +/+ "guitar.mid") ],
		),(
			name:    'tokamakBreak',
			countIn: [[ ]],
			click:   [[ Click(142,4,repeats: 4,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePat('tokamakBreak',pathToDMXMIDI +/+ "break.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakBreak',pathToKemperMIDI +/+ "break.mid") ],
		),(
			name:    'tokamakFunk',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ Click(142,4,repeats: 48,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePat('tokamakFunk',pathToDMXMIDI +/+ "funk.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakFunk',pathToKemperMIDI +/+ "funk.mid") ],
		),(
			name:    'tokamakImproIntro',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ Click(142,4,repeats: 16,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePat('tokamakImproIntro',pathToDMXMIDI +/+ "improIntro.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakImproIntro',pathToKemperMIDI +/+ "improIntro.mid") ]
		),(
			name:    'tokamakImpro',
			countIn: [[ ]],
			click:   [[ ClickLoop(142,loopKey: cueKeys[0],out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePresetPat('tokamakImpro',1,5) ],
			kemper:  [ KemperMIDI.makePat('tokamakImpro',pathToKemperMIDI +/+ "impro.mid") ]
		),(
			name:    'tokamakCue',
			countIn: [[ ]],
			click:   [[ ClickConCat(1,ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4), Click(142,4,repeats: 5)).out_( outs['clickAll'] ) ]],
			lights:  [ Pseq([ DMXIS.makePresetPat('tokamakCue',0,0), DMXIS.makePat('tokamakCue',pathToDMXMIDI +/+ "cue.mid") ]) ],
			kemper:  [ KemperMIDI.makePat('tokamakCue',pathToKemperMIDI +/+ "cue.mid") ],
			bTracks: [
				YAWNPlayback.makeStereoPat(adds[1],outs['addsOut']),
				YAWNPlayback.makeStereoPat(perc[1],outs['percOut'])
			]
		),(
			name:    'tokamakOutro',
			countIn: [[ ]],
			click:   [[ ClickConCat(1,Click(142,4,repeats: 57), Click(142,2)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('tokamakOutro',pathToDMXMIDI +/+ "outro.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakOutro',pathToKemperMIDI +/+ "outro.mid") ]
		),(
			name:    'bow',
			countIn: [[ ]],
			click:   [[ ClickRest(out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePresetPat('bow',0,8) ],
			bTracks: [ YAWNPlayback.makeStereoPat(bow[0],outs['synthOut']) ]
		)
	]
}