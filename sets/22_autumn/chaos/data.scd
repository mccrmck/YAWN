///////////////////////////////////////////////// YAWN Data: chaos /////////////////////////////////////////////////
{ |songInstance, action|
	var cueKeys = ['chaosElevenLoopOne','chaosElevenLoopTwo'];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var ambience = songInstance.pbTracks['ambience'];
	var bass     = songInstance.pbTracks['bass'];
	var gtrs     = songInstance.pbTracks['gtrs'];
	var perc     = songInstance.pbTracks['perc'];
	var synths   = songInstance.pbTracks['synths'];

	var outs = YAWNShow.outDict;

	var data = [
		(
			name:    'chaosCount',
			countIn: [[ ClickCue(75,cueKey: 'chaos',out: outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1, Click(160,2,repeats: 2), Click(160,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePresetPat('chaosCount',0,0), DMXIS.makePat('chaosCount',pathToDMXMIDI +/+ "count.mid")],
			kemper:  [ KemperMIDI.makePat('chaosCount',pathToKemperMIDI +/+ "count.mid") ],
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
			bTracks: [
				YAWNPlayback.makeStereoOverlap( ambience[0], outs['ambienceOut']),
				YAWNPlayback.makeMonoPat( bass[0], outs['bassOut']),
				YAWNPlayback.makeStereoPat( perc[0], outs['percOut']),
			]
		),(
			name:    'chaosElevenFirst',
			countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1, ClickMan([1,4/3,1] * 100,1,8), Click(200,4)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('chaosElevenFirst',pathToDMXMIDI +/+ "elevenFirst.mid") ],
			kemper:  [ KemperMIDI.makePat('chaosElevenFirst',pathToKemperMIDI +/+ "elevenFirst.mid") ],                               // check this
			bTracks: [
				YAWNPlayback.makeMonoPat( bass[1], outs['bassOut']),
				YAWNPlayback.makeStereoOverlap( gtrs[0], outs['gtrsOut']),
				YAWNPlayback.makeStereoPat( perc[1], outs['percOut']),
			]
		),(
			name:    'chaosElevenLoopOne',
			countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCatLoop(cueKeys[0], ClickMan([1,4/3,1] * 100,1,8), Click(200,4)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('chaosElevenLoopOne',pathToDMXMIDI +/+ "elevenLoopOne.mid",true) ],
		),(
			name:    'chaosElevenLoopTwo',
			countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCatLoop(cueKeys[1], ClickMan([1,4/3,1] * 100,1,8), Click(200,4)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('chaosElevenLoopTwo',pathToDMXMIDI +/+ "elevenLoopTwo.mid",true) ],
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
			lights:  [ DMXIS.makePat('chaosElevenLast',pathToDMXMIDI +/+ "elevenLast.mid") ],
			kemper:  [ KemperMIDI.makePat('chaosElevenLast',pathToKemperMIDI +/+ "elevenLast.mid") ],
			bTracks: [
				YAWNPlayback.makeStereoOverlap( ambience[1], outs['ambienceOut']),
				Pseq([ ClickRest(60,9.3).pattern,YAWNPlayback.makeStereoPat( perc[2], outs['percOut']) ]),
				Pseq([ ClickRest(60,15.9).pattern,YAWNPlayback.makeStereoPat( perc[3], outs['percOut']) ]),
			]
		),(
			name:    'chaosBomb',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(120,4), Click(120,3),Click(120)).out_( outs['clickAll'] ) ]],
			lights:  [
				Pseq([
					DMXIS.makePresetPat('chaosBomb',(60/120 * 3.75),7),
					DMXIS.makePresetPat('chaosBombReset',(60/120 * 0.25),0),
					DMXIS.makePat('chaosBomb',pathToDMXMIDI ++ "bomb.mid"),
					DMXIS.makePresetPat('chaosBombEnd',1,7)
				])
			],
			kemper:  [ KemperMIDI.makePat('chaosBomb',pathToKemperMIDI +/+ "bomb.mid") ],
			bTracks: [
				Pseq([ ClickRest(120,7).pattern, YAWNPlayback.makeMonoPat( bass[2], outs['bassOut']) ]),
				YAWNPlayback.makeStereoPat( perc[4], outs['percOut']),
				Pseq([ ClickRest(120,4).pattern, YAWNPlayback.makeStereoPat( synths[0], outs['synthsOut']) ]),
				Pseq([ ClickRest(120,7).pattern, YAWNPlayback.makeStereoPat( synths[1], outs['synthsOut']) ]),
			]
		),(
			name:    'chaosCountAgain',
			countIn: [[ ]],
			click:   [[ ClickConCat(1,ClickRest(120,4),ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4), Click(120,3)).out_( outs['clickAll'] ) ]],
			lights:  [
				Pseq([
					DMXIS.makePresetPat('chaosBombLast',(60/120 * 11.75),7),
					DMXIS.makePresetPat('chaosBombResetLast',(60/120 * 0.25),0),
					DMXIS.makePat('chaosCountAgain',pathToDMXMIDI +/+ "countAgain.mid")
				])
			],
			kemper:  [ KemperMIDI.makePat('chaosCountAgain',pathToKemperMIDI +/+ "countAgain.mid") ],
			bTracks: [
				YAWNPlayback.makeStereoOverlap( perc[5], outs['percOut']),
			]
		),(
			name:    'chaosAsectionAgain',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(2, Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('chaosAsectionAgain',pathToDMXMIDI ++ "AsectionAgain.mid") ],
			kemper:  [ KemperMIDI.makePat('chaosAsectionAgain',pathToKemperMIDI +/+ "AsectionAgain.mid") ],
			bTracks: [
				YAWNPlayback.makeMonoPat( bass[3], outs['bassOut']),
				YAWNPlayback.makeStereoOverlap( ambience[2], outs['ambienceOut']),
				Pseq([ ClickRest(120,77).pattern,YAWNPlayback.makeStereoOverlap( perc[6], outs['percOut']) ]),
			]
		),(
			name:    'chaosOutro',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1, Click(120,4,repeats: 15), ClickMan([120,120,180]), Click(120,4,repeats: 3)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('chaosOutro',pathToDMXMIDI ++ "outro.mid") ],
			kemper:  [ KemperMIDI.makePat('chaosOutro',pathToKemperMIDI +/+ "outro.mid") ],
			bTracks: [
				YAWNPlayback.makeMonoPat( bass[4], outs['bassOut']),
				Pseq([ClickRest(120,40).pattern,YAWNPlayback.makeStereoPat( perc[7], outs['percOut']) ]),
			]
		)
	];
	action.value;
	data
}