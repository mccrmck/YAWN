///////////////////////////////////////////////// YAWN Data: tokamak /////////////////////////////////////////////////
{ |songInstance|
	var cueKeys = ['tokamakLoop'];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var ambience = songInstance.pbTracks['ambience'];
	var bass     = songInstance.pbTracks['bass'];
	var gtrs     = songInstance.pbTracks['gtrs'];
	var perc     = songInstance.pbTracks['perc'];
	var synths   = songInstance.pbTracks['synths'];

	var outs = YAWNShow.outDict;

	[
		(
			name:    'tokamakPB',
			countIn: [[ ]],
			click:   [[ ClickRest(142,4,47,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePresetPat('tokamakPB',1,4) ],
			bTracks: [
				YAWNPlayback.makeStereoPat( ambience[0], outs['ambienceOut'] ),
				YAWNPlayback.makeStereoPat( perc[0], outs['percOut'] )
			]
		),(
			name:    'tokamakCount',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePresetPat('tokamakCount',1,0) ],
		),(
			name:    'tokamakIntro',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(142,4,repeats: 6), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			kemper:  [ KemperMIDI.makePat('tokamakIntro',pathToKemperMIDI +/+ "intro.mid") ],
		),(
			name:    'tokamakGuitar',
			countIn: [[ ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1,Click(142,4,repeats: 46), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('tokamakGuitar',pathToDMXMIDI +/+ "guitar.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakGuitar',pathToKemperMIDI +/+ "guitar.mid") ],
			bTracks: [
				Pseq([ ClickRest(142,4,24).pattern,YAWNPlayback.makeStereoPat( perc[1], outs['percOut'] ) ]),
				Pseq([ ClickRest(142,4,32).pattern,YAWNPlayback.makeStereoPat( perc[2], outs['percOut'] ) ]),
				Pseq([ ClickRest(142,4,27).pattern,YAWNPlayback.makeStereoPat( perc[3], outs['percOut'] ) ]),
				Pseq([ ClickRest(142,4,16).pattern,YAWNPlayback.makeStereoPat( synths[0], outs['synthsOut'] ) ])
			]
		),(
			name:    'tokamakBreak',
			countIn: [[ ]],
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
				YAWNPlayback.makeStereoPat( ambience[1], outs['ambienceOut'] ),
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
				YAWNPlayback.makeStereoPat( ambience[2], outs['ambienceOut'] ),
				YAWNPlayback.makeStereoPat( perc[6], outs['percOut'] )
			]
		),(
			name:    'tokamakImpro',
			countIn: [[ ]],
			click:   [[ ClickLoop(142,loopKey: cueKeys[0],out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePresetPat('tokamakImpro',1,5) ],
			kemper:  [ KemperMIDI.makePat('tokamakImpro',pathToKemperMIDI +/+ "impro.mid") ],         // maybe a problem with the kemper, maybe a problem with the tracks...
			bTracks: [
				YAWNPlayback.makeStereoPat( ambience[3], outs['ambienceOut'] ),
				YAWNPlayback.makeStereoPat( perc[7], outs['percOut'] )
			]
		),(
			name:    'tokamakCue',
			countIn: [[ ]],
			click:   [[ ClickConCat(1,ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4), Click(142,4,repeats: 5)).out_( outs['clickAll'] ) ]],
			lights:  [ Pseq([ DMXIS.makePresetPat('tokamakCue',0,0), DMXIS.makePat('tokamakCue',pathToDMXMIDI +/+ "cue.mid") ]) ],
			kemper:  [ KemperMIDI.makePat('tokamakCue',pathToKemperMIDI +/+ "cue.mid") ],
			bTracks: [
				Pseq([ ClickRest(142,16).pattern,YAWNPlayback.makeStereoPat( perc[8], outs['percOut'] ) ]),
				Pseq([ ClickRest(142,28).pattern,YAWNPlayback.makeStereoPat( perc[9], outs['percOut'] ) ])
			]
		),(
			name:    'tokamakOutro',
			countIn: [[ ]],
			click:   [[ ClickConCat(1,Click(142,4,repeats: 57), Click(142,2)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('tokamakOutro',pathToDMXMIDI +/+ "outro.mid") ],
			kemper:  [ KemperMIDI.makePat('tokamakOutro',pathToKemperMIDI +/+ "outro.mid") ],
			bTracks: [
				Pseq([ ClickRest(142,16).pattern,YAWNPlayback.makeMonoPat( bass[1], outs['bassOut'] ) ]),
				Pseq([ ClickRest(142,16).pattern,YAWNPlayback.makeStereoPat( synths[2], outs['synthsOut'] ) ]),
				Pseq([ ClickRest(142,16).pattern,YAWNPlayback.makeStereoPat( perc[10], outs['percOut'] ) ])
			]
		)
	]
}