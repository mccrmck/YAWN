///////////////////////////////////////////////// YAWN Data: chaos /////////////////////////////////////////////////
{ |songInstance|
	var cueKeys = ['chaosIntroLoop','chaosElevenLoop'];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var leads = songInstance.pbTracks['leads'];
	var efx   = songInstance.pbTracks['efx'];
	var perc  = songInstance.pbTracks['perc'];
	var adds  = songInstance.pbTracks['adds'];

	var outs = YAWNShow.outDict;

	[
		(
			name:    'chaosIntro',
			countIn: [[ ]],
			click:   [[ ClickLoop(160,4,loopKey: cueKeys[0],out: outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePresetPat('chaosIntro',1,6) ],
			kemper:  [ KemperMIDI.makePat('chaosIntro',pathToKemperMIDI +/+ "intro.mid") ],
		),(
			name:    'chaosDrumCue',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(160,4,repeats: 6), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			lights:  [ Pseq([ DMXIS.makePresetPat('chaosDrumCue', 11.8125, 6), DMXIS.makePresetPat('chaosDrumCueReset', 0.1, 0) ]) ],
			kemper:  [ KemperMIDI.makePat('chaosDrumCue',pathToKemperMIDI +/+ "drumCue.mid") ],
			bTracks: [ ]
		),(
			name:    'chaosGitDrums',
			countIn: [[ ClickConCat(1, Click(160,2,repeats: 2), Click(160,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[
				ClickConCat(1,
					Click(160,4,repeats: 8 * 3),
					Click(160,4,repeats: 6), ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4),
					Click(160,4,repeats: 2)
				).out_( outs['clickAll'] )
			]],
			lights:  [ DMXIS.makePat('chaosGitDrums',pathToDMXMIDI +/+ "gitDrums.mid") ],
			kemper:  [ KemperMIDI.makePat('chaosGitDrums',pathToKemperMIDI +/+ "gitDrums.mid") ],
			bTracks: [ ]
		),(
			name:    'chaosNewTempo',
			countIn: [[ ]],
			click:   [[ Click(120,4,out: outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('chaosNewTempo',pathToDMXMIDI +/+ "newTempo.mid") ],
			kemper:  [ KemperMIDI.makePat('chaosNewTempo',pathToKemperMIDI +/+ "newTempo.mid") ],
		),(
			name:    'chaosAsection',
			countIn: [[ ]],
			click:   [[ ClickConCat(2, Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3) ).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('chaosAsection',pathToDMXMIDI +/+ "Asection.mid") ],
			kemper:  [ KemperMIDI.makePat('chaosAsection',pathToKemperMIDI +/+ "Asection.mid") ],
			bTracks: [ ]
		),(
			name:    'chaosElevenFirst',
			countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1, ClickMan([1,4/3,1] * 100,1,8), Click(200,4)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('chaosElevenFirst',pathToDMXMIDI +/+ "elevenFirst.mid") ],
			kemper:  [ KemperMIDI.makePat('chaosElevenFirst',pathToKemperMIDI +/+ "elevenFirst.mid") ],
		),(
			name:    'chaosEleven',
			countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCatLoop(cueKeys[1], ClickMan([1,4/3,1] * 100,1,8), Click(200,4)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePresetPat('chaosEleven',1,6) ],
		),(
			name:   'chaosElevenLast',
			countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[
				ClickConCat(1,
					ClickMan([1,4/3,1] * 100,repeats: 4),
					ClickManCue([1,4/3,1] * 100,repeats: 4),
					ClickCue(200,repeats: 4),
					Click(120,3)
				).out_( outs['clickAll'] )
			]],
			lights:  [
				Pseq([ DMXIS.makePat('chaosElevenLast',pathToDMXMIDI ++ "elevenLast.mid"), DMXIS.makePresetPat('chaosElevenLast',1,7) ]),
				DMXIS.makePresetPat('chaosElevenLast',1,0)                                                                                                                           // what is this???!?!
			],
			kemper:  [ KemperMIDI.makePat('chaosElevenLast',pathToKemperMIDI +/+ "elevenLast.mid") ],
			bTracks: [ ]
		),(
			name:    'chaosBomb',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(120,4), Click(120,3)).out_( outs['clickAll'] ) ]],
			lights:  [
				Pseq([
					DMXIS.makePresetPat('chaosBomb',(60/120 * 3.75),7),
					DMXIS.makePresetPat('chaosBombReset',(60/120 * 0.25),0),
					DMXIS.makePat('chaosBomb',pathToDMXMIDI ++ "bomb.mid"),
					DMXIS.makePresetPat('chaosBombEnd',1,7)
				])
			],
			kemper:  [ KemperMIDI.makePat('chaosBomb',pathToKemperMIDI +/+ "bomb.mid") ],
			bTracks: [ ]
		),(
			name:    'chaosCountAgain',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, ClickRest(120,4), ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4), Click(120,3)).out_( outs['clickAll'] ) ]],
			lights:  [
				Pseq([ DMXIS.makePresetPat('chaosCountAgain',(60/120 * 11.75),7),DMXIS.makePresetPat('chaosCountAgain',(60/120 * 0.25),0) ]),
				DMXIS.makePat('chaosCountAgain',pathToDMXMIDI ++ "countAgain.mid")
			],
			kemper:  [ KemperMIDI.makePat('chaosCountAgain',pathToKemperMIDI +/+ "countAgain.mid") ],
			bTracks: [ ]
		),(
			name:    'chaosAsectionAgain',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(2, Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('chaosAsectionAgain',pathToDMXMIDI ++ "AsectionAgain.mid") ],
			kemper:  [ KemperMIDI.makePat('chaosAsectionAgain',pathToKemperMIDI +/+ "AsectionAgain.mid") ],
		),(
			name:    'chaosOutro',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1, Click(120,4,repeats: 15), ClickMan([120,120,180]), Click(120,4,repeats: 3)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('chaosOutro',pathToDMXMIDI ++ "outro.mid") ],
			kemper:  [ KemperMIDI.makePat('chaosOutro',pathToKemperMIDI +/+ "outro.mid") ],
		)
	]
}