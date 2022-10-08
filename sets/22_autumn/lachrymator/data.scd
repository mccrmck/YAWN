///////////////////////////////////////////////// YAWN Data: lachrymator /////////////////////////////////////////////////
{ |songInstance|
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
			name:    'lachCountPart1',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(240,2,repeats: 2), Click(240,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			// lights:  [ DMXIS.makePresetPat('lachCountPart1',1,0) ],
			kemper:  [ KemperMIDI.makePat('lachCountPart1',pathToKemperMIDI +/+ "countPart1.mid") ],
			bTracks: [ ]
		),(
			name:    'lachAsection',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickConCat(7, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(6, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(7, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(11, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(5, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(5, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(9, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(25,Click(240,4), Click(300,4))  //transition to impro                                                             // this doesn't need to be so long...
				).out_( outs['clickAll'] )
			]],
			lights:  [ Pseq([ DMXIS.makePat('lachAsection',pathToDMXMIDI ++ "Asection.mid") ]) ],
			kemper:  [ KemperMIDI.makePat('lachAsection',pathToKemperMIDI +/+ "Asection.mid") ],
			bTracks: [
				Pseq([ ClickRest(60/97.2).pattern,YAWNPlayback.makeStereoPat( ambience[0], outs['ambienceOut']) ]),
				YAWNPlayback.makeMonoPat( bass[0], outs['bassOut']),
				YAWNPlayback.makeStereoPat( gtrs[0], outs['gtrsOut']),
				YAWNPlayback.makeStereoPat( perc[0], outs['percOut']),
				Pseq([ ClickRest(60/14.4).pattern,YAWNPlayback.makeStereoPat( synths[0], outs['synthsOut']) ]),
				Pseq([ ClickRest(60/66.6).pattern,YAWNPlayback.makeStereoPat( synths[1], outs['synthsOut']) ]),
				Pseq([ ClickRest(60/14.4).pattern,YAWNPlayback.makeStereoPat( synths[2], outs['synthsOut']) ]), // vocal tracks
				Pseq([ ClickRest(60/66.6).pattern,YAWNPlayback.makeStereoPat( synths[3], outs['synthsOut']) ]), // vocal tracks
			]
		),(
			name:    'lachTapping',
			countIn: [[ ]],
			click:   [[ ClickConCat(1,Click(120,4,repeats: 16 ),ClickCue(120,4,1,2),ClickCue(120,2,1,2),ClickCue(120,1,1,4)).out_(outs['clickAll']) ]],
			lights:  [ DMXIS.makePresetPat('lachTapping',0,2) ],
			kemper:  [ KemperMIDI.makePat('lachTapping',pathToKemperMIDI +/+ "tapping.mid") ],
			bTracks: [
				Pseq([ ClickRest(60/24).pattern,YAWNPlayback.makeStereoOverlap( ambience[1], outs['ambienceOut']) ]),
				Pseq([ ClickRest(60/24).pattern,YAWNPlayback.makeStereoOverlap( perc[1], outs['percOut']) ]),
				Pseq([ ClickRest(60/37).pattern,YAWNPlayback.makeStereoOverlap( synths[4], outs['synthsOut']) ]),
			]
		),(
			name:    'lachJazzIntro',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[
				ClickConCat(1,
					Click(120,3,repeats: 2), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),Click(120,3),
					Click(120,3,repeats: 2), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),Click(120,3)
				).out_( outs['clickAll'] )
			]],
			// lights:  [ DMXIS.makePat('lachJazzIntro',pathToDMXMIDI ++ "jazzIntro.mid") ],
			kemper:  [ KemperMIDI.makePat('lachJazzIntro',pathToKemperMIDI +/+ "jazzIntro.mid") ],
			bTracks: [
				// YAWNPlayback.makeMonoPat( bass[1], outs['bassOut'])
			]
		),(
			name:    'lachJazzAsection',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[
				ClickConCat(1,
					Click(120,3,repeats: 2), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),
					Click(120,3,repeats: 3), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),
					Click(120,3)
				).out_( outs['clickAll'] )
			]],
			// lights:  [ DMXIS.makePat('lachJazzAsection',pathToDMXMIDI ++ "jazzAsection.mid") ],
			kemper:  [ KemperMIDI.makePat('lachJazzAsection',pathToKemperMIDI +/+ "jazzAsection.mid") ],
			bTracks: [
				// YAWNPlayback.makeMonoPat( bass[2], outs['bassOut'])
			]
		),(
			name:    'lachJazzBsection',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ Click(120,3,repeats: 16,out: outs['clickAll']) ]],
			// lights:  [ DMXIS.makePat('lachJazzBsection',pathToDMXMIDI ++ "jazzBsection.mid") ],
			kemper:  [ KemperMIDI.makePat('lachJazzBsection',pathToKemperMIDI +/+ "jazzBsection.mid") ],
			bTracks: [
				// YAWNPlayback.makeMonoPat( bass[3], outs['bassOut'])
			]
		),(
			name:    'lachJazzAsectionAgain',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[
				ClickConCat(1,
					Click(120,3,repeats: 2), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),
					Click(120,3,repeats: 3), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),
					Click(120,3)
				).out_( outs['clickAll'] )
			]],
			// lights:  [ DMXIS.makePat('lachJazzAsectionAgain',pathToDMXMIDI ++ "jazzAsectionAgain.mid") ],
			kemper:  [ KemperMIDI.makePat('lachJazzAsectionAgain',pathToKemperMIDI +/+ "jazzAsectionAgain.mid") ],
			bTracks: [
				Pseq([ ClickRest(120,18).pattern,YAWNPlayback.makeStereoOverlap( ambience[2], outs['ambienceOut']) ]),
				// YAWNPlayback.makeMonoPat( bass[4], outs['bassOut']),
			]
		),(
			name:    'lachJazzBsectionAgain',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1, Click(120,3,repeats: 15), Click(120,2)).out_( outs['clickAll'] ) ]],
			// lights:  [ Pseq([ DMXIS.makePat('lachJazzBsectionAgain',pathToDMXMIDI ++ "jazzBsectionAgain.mid"), DMXIS.makePresetPat('lachJazzBsectionAgain',0,3) ]) ],
			kemper:  [ KemperMIDI.makePat('lachJazzBsectionAgain',pathToKemperMIDI +/+ "jazzBsectionAgain.mid") ],
			bTracks: [
				// YAWNPlayback.makeMonoPat( bass[5], outs['bassOut']),
			]
		),(
			name:    'lachCountPart3',
			countIn: [[  ]],
			click:   [[ ClickRest(60,5.588),ClickConCat(2, Click(340,5), Click(340,4)).out_( outs['clickAll'] ) ]],
			lights:  [ ],
			kemper:  [ Pseq([ ClickRest(60,5.588).pattern,KemperMIDI.makePat('lachCountPart3',pathToKemperMIDI +/+ "countPart3.mid") ]) ],
			bTracks: [
				YAWNPlayback.makeStereoPat( ambience[3], outs['ambienceOut']),
			]
		),(
			name:    'lachAsectionNine',
			countIn: [[ ClickConCat(2, Click(340,5), Click(340,4)).out_( outs['clickAll'] ) ]],
			click:   [[
				ClickConCat(1,
					ClickConCat(3, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,1, repeats: 5), Click(340,4),
					ClickConCat(4, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),

					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,1,repeats: 5), Click(340,4),
					ClickConCat(3, Click(340,5), Click(340,4)),	Click(170,4,repeats: 2)
				).out_( outs['clickAll'] )
			]],
			lights:  [ DMXIS.makePat('lachAsectionNine',pathToDMXMIDI ++ "AsectionNine.mid") ],
			kemper:  [ KemperMIDI.makePat('lachAsectionNine',pathToKemperMIDI +/+ "AsectionNine.mid") ],
			bTracks: [
				Pseq([ ClickRest(340,35).pattern,YAWNPlayback.makeStereoOverlap( ambience[4], outs['ambienceOut']) ]),
				Pseq([ ClickRest(340,416).pattern,YAWNPlayback.makeStereoPat( ambience[5], outs['ambienceOut']) ]),
				Pseq([ ClickRest(340,142.5).pattern,YAWNPlayback.makeMonoPat( bass[6], outs['bassOut']) ]),
				Pseq([ ClickRest(340,35).pattern,YAWNPlayback.makeStereoOverlap( synths[5], outs['synthsOut']) ]),
				Pseq([ ClickRest(340,243).pattern,YAWNPlayback.makeStereoPat( synths[6], outs['synthsOut']) ]),
				YAWNPlayback.makeStereoOverlap(perc[2], outs['percOut']),
			]
		),(
			name:    'lachOutro',
			countIn: [[ ClickConCat(1, Click(240,2,repeats: 2), Click(240,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[
				ClickConCat(1,
					ClickConCat(5, Click(240,4), Click(300,4)),
					Array.geom(12,300,0.95).collect({ |item, index|

						case
						{index < 10 }{ [Click(item * 0.8,4), Click(item,4)] }
						{index == 10}{ [Click(item * 0.8,4), ClickCue(item,4)] }
						{index > 10 }{ [ClickCue(item * 0.8,4), ClickCue(item,4)] }
					}).flat,
					ClickCue()
				).out_( outs['clickAll'] )
			]],
			// lights:  [ Pseq([ DMXIS.makePat('lachOutro',pathToDMXMIDI ++ "outro.mid"), DMXIS.makePresetPat('lachOutro',1,4) ]) ],
			bTracks: [
				YAWNPlayback.makeStereoPat( ambience[6], outs['ambienceOut']),
				YAWNPlayback.makeMonoPat( bass[7], outs['bassOut']),
				YAWNPlayback.makeStereoPat( gtrs[1], outs['gtrsOut']),
			]
		)
	]
}