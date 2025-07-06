///////////////////////////////////////////////// YAWN Data: tokamak /////////////////////////////////////////////////
{ |songInstance, action|
	var cueKeys = ['tokamakLoop'];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var ambience = songInstance.pbTracks['ambience'];
	var bass     = songInstance.pbTracks['bass'];
	var gtrs     = songInstance.pbTracks['gtrs'];
	var perc     = songInstance.pbTracks['perc'];
	var synths   = songInstance.pbTracks['synths'];
	var voice    = songInstance.pbTracks['voice'];

	var outs = YAWNShow.outDict;

	var data = [
		(
			name:    'tokamakPB',
			countIn: [[ ClickCue(75,cueKey: 'tokamak',out: outs['clickAll']) ]],
			click:   [[ ClickRest(142,4,47,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePresetPat('tokamakPB',0,9) ],
			bTracks: [
				YAWNPlayback.makeStereoOverlap( ambience[0], outs['ambienceOut'] ),
				YAWNPlayback.makeStereoPat( perc[0], outs['percOut'] )
			]
		),(
			name:    'tokamakCount',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePresetPat('tokamakCount',0,9) ],
			bTracks: [
				YAWNPlayback.makeStereoPat( perc[1], outs['percOut'] )
			]
		),(
			name:    'tokamakIntro',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1, Click(142,4,repeats: 6), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			lights:  [ Pseq([ DMXIS.makePresetPat('tokamakIntro',(60/142 * 31.5),9), DMXIS.makePresetPat('tokamakReset',0,0) ]) ],
			kemper:  [ KemperMIDI.makePat('tokamakIntro',pathToKemperMIDI +/+ "intro.mid") ],
			bTracks: [
				YAWNPlayback.makeStereoPat( perc[2], outs['percOut'] )
			]
		),(
			name:    'tokamakGuitar',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1,Click(142,4,repeats: 46), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('tokamakGuitar',pathToDMXMIDI +/+ "guitar.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakGuitar',pathToKemperMIDI +/+ "guitar.mid") ],
			bTracks: [
				YAWNPlayback.makeStereoPat( perc[3], outs['percOut'] ),
				Pseq([ ClickRest(142,64).pattern,YAWNPlayback.makeStereoPat( synths[0], outs['synthsOut'] ) ])
			]
		),(
			name:    'tokamakBreak',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ Click(142,4,repeats: 4,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePat('tokamakBreak',pathToDMXMIDI +/+ "break.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakBreak',pathToKemperMIDI +/+ "break.mid") ],
			bTracks: [ YAWNPlayback.makeStereoPat( perc[4], outs['percOut'] ) ]
		),(
			name:    'tokamakFunk',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ Click(142,4,repeats: 48,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePat('tokamakFunk',pathToDMXMIDI +/+ "funk.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakFunk',pathToKemperMIDI +/+ "funk.mid") ],
			bTracks: [
				YAWNPlayback.makeStereoOverlap( ambience[1], outs['ambienceOut'] ),
				YAWNPlayback.makeMonoPat( bass[0], outs['bassOut'] ),
				YAWNPlayback.makeStereoPat( synths[1], outs['synthsOut'] ),
				YAWNPlayback.makeStereoPat( perc[5], outs['percOut'] )
			]
		),(
			name:    'tokamakImproIntro',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ Click(142,4,repeats: 16,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePat('tokamakImproIntro',pathToDMXMIDI +/+ "improIntro.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakImproIntro',pathToKemperMIDI +/+ "improIntro.mid") ],
			bTracks: [
				YAWNPlayback.makeStereoOverlap( perc[6], outs['percOut'] )
			]
		),(
			name:    'tokamakImpro',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickLoop(142,loopKey: cueKeys[0],out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePresetPat('tokamakImpro',0,8) ],
			kemper:  [ KemperMIDI.makePat('tokamakImpro',pathToKemperMIDI +/+ "impro.mid") ],         // maybe a problem with the kemper, maybe a problem with the tracks...
		),(
			name:    'tokamakCue',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1,Click(142,4),ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4), Click(142,4,repeats: 5)).out_( outs['clickAll'] ) ]],
			lights:  [ Pseq([ DMXIS.makePresetPat('tokamakImpro',60/142 * 19,8),DMXIS.makePresetPat('tokamakCue',60/142,0), DMXIS.makePat('tokamakCue',pathToDMXMIDI +/+ "cue.mid") ]) ],
			kemper:  [ Pseq([ ClickRest(142,4).pattern, KemperMIDI.makePat('tokamakCue',pathToKemperMIDI +/+ "cue.mid") ]) ],
			bTracks: [
				Pseq([ ClickRest(142,4,5).pattern,YAWNPlayback.makeStereoPat( perc[7], outs['percOut'] ) ]),
			]
		),(
			name:    'tokamakOutro',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1,Click(142,4,repeats: 57), Click(142,2)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('tokamakOutro',pathToDMXMIDI +/+ "outro.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakOutro',pathToKemperMIDI +/+ "outro.mid") ],
			bTracks: [
				Pseq([ ClickRest(142,16).pattern,YAWNPlayback.makeMonoPat( bass[1], outs['bassOut'] ) ]),
				Pseq([ ClickRest(142,16).pattern,YAWNPlayback.makeStereoPat( perc[8], outs['percOut'] ) ]),
				Pseq([ ClickRest(142,16).pattern,YAWNPlayback.makeStereoPat( synths[2], outs['synthsOut'] ) ])
			]
		),(
			name:    'tokamakBow',
			countIn: [[ ]],
			click:   [[ ClickRest(60, out: outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('tokamakBow',pathToDMXMIDI +/+ "bow.mid") ],
			kemper:  [ ],
			bTracks: [ YAWNPlayback.makeStereoPat(voice[0],outs['processOut'],5.dbamp) ]
		)
	];
	action.value;
	data
}