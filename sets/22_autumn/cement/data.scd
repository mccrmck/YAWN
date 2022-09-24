///////////////////////////////////////////////// YAWN Data: cement /////////////////////////////////////////////////
{ |songInstance|
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var ambience = songInstance.pbTracks['ambience'];
	var bass     = songInstance.pbTracks['bass'];
	var gtrs     = songInstance.pbTracks['gtrs'];
	var perc     = songInstance.pbTracks['perc'];
	var synths   = songInstance.pbTracks['synths'];

	var outs     = YAWNShow.outDict;
	var countIn  = ClickConCat(1, Click(170,2,repeats: 2), Click(170,1,repeats: 4) ).out_( outs['clickAll'] );

	[
		(
			name:    'cementCount',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(160,2,repeats: 2), Click(160,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('cementCount',pathToDMXMIDI +/+ "count.mid") ],
			kemper:  [ KemperMIDI.makePat('cementCount',pathToKemperMIDI +/+ "count.mid") ],
		),(
			name:    'cementIntro',
			countIn: [[ ClickConCat(1, Click(160,2,repeats: 2), Click(160,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[
				ClickConCat(1,
					Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
					Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
					Click(160,7), Click(160,6), Click(160,5), Click(160,4,repeats: 2)
				).out_( outs['clickAll'] )
			]],
			lights:  [ DMXIS.makePat('cementIntro',pathToDMXMIDI +/+ "intro.mid") ],
			kemper:  [ KemperMIDI.makePat('cementIntro',pathToKemperMIDI +/+ "intro.mid") ],
			bTracks: [
				YAWNPlayback.makeStereoPat( gtrs[0], outs['gtrsOut'] ),
				YAWNPlayback.makeStereoPat( perc[0], outs['percOut'] ),
			]
		),(
			name:    'cementAsection',
			countIn: [[ countIn ]],
			click:   [[
				ClickConCat(1,
					Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
					Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
					Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2)
				).out_( outs['clickAll'] )
			]],
			lights:  [ DMXIS.makePat('cementAsection',pathToDMXMIDI +/+ "Asection.mid") ],
			kemper:  [ KemperMIDI.makePat('cementAsection',pathToKemperMIDI +/+ "Asection.mid") ],
			bTracks: [
				YAWNPlayback.makeStereoPat( ambience[0], outs['ambienceOut'] ),
				YAWNPlayback.makeMonoPat( bass[0], outs['bassOut'] ),
				YAWNPlayback.makeStereoPat( perc[1], outs['percOut'] ),
				YAWNPlayback.makeStereoPat( synths[0], outs['synthsOut'] ),
			]
		),(
			name:    'cementMelody',
			countIn: [[ countIn ]],
			click:   [[
				ClickConCat(1,
					Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
					Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
					Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2)
				).out_( outs['clickAll'] )
			]],
			lights:  [ DMXIS.makePat('cementMelody',pathToDMXMIDI +/+ "melody.mid") ],
			kemper:  [ KemperMIDI.makePat('cementMelody',pathToKemperMIDI +/+ "melody.mid") ],
			bTracks: [
				YAWNPlayback.makeMonoPat( bass[1], outs['bassOut'] ),
				// YAWNPlayback.makeStereoPat( gtrs[0], outs['gtrsOut'] ),                                              // this needs to be a different file
				YAWNPlayback.makeStereoPat( perc[2], outs['percOut'] ),
				YAWNPlayback.makeStereoPat( synths[1], outs['synthsOut'] ),
			]
		),(
			name:    'cementImpro',
			countIn: [[  ]],
			click:   [[ ]],
			lights:  [  ],
			kemper:  [ ],
			bTracks: []
		),(
			name:    'cementBsection',
			countIn: [[ countIn ]],
			click:   [[ ClickConCat(1,Click(170,4,repeats: 14), Click(170,3) ).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('cementBsection',pathToDMXMIDI +/+ "Bsection.mid") ],
			kemper:  [ KemperMIDI.makePat('cementBsection',pathToKemperMIDI +/+ "Bsection.mid") ],
			bTracks: [
				YAWNPlayback.makeMonoPat( bass[2], outs['bassOut'] ),
				Pseq([ ClickRest(170,58).pattern,YAWNPlayback.makeStereoPat( gtrs[1], outs['gtrsOut'] ) ]),
				Pseq([ ClickRest(170,58).pattern,YAWNPlayback.makeStereoPat( perc[4], outs['percOut'] ) ]),
				YAWNPlayback.makeStereoPat( perc[3], outs['percOut'] ),
				YAWNPlayback.makeStereoPat( synths[2], outs['synthsOut'] ),
			]
		),(
			name:    'cementCountAgain',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(160,2,repeats: 2), Click(160,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			// lights:  [ DMXIS.makePat('cementIntro',pathToDMXMIDI +/+ "countAgain.mid") ],
			kemper:  [ KemperMIDI.makePat('cementIntro',pathToKemperMIDI +/+ "countAgain.mid") ],
		),(
			name:    'cementBsectionAgain',
			countIn: [[ countIn ]],
			click:   [[
				ClickConCat(1,
					Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
					Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
				).out_( outs['clickAll'] )
			]],
			lights:  [ DMXIS.makePat('cementBsectionAgain',pathToDMXMIDI +/+ "BsectionAgain.mid") ],
			kemper:  [ KemperMIDI.makePat('cementBsectionAgain',pathToKemperMIDI +/+ "BsectionAgain.mid") ],
			bTracks: [
				YAWNPlayback.makeMonoPat( bass[3], outs['bassOut'] ),
				YAWNPlayback.makeStereoPat( perc[6], outs['percOut'] ),
				YAWNPlayback.makeStereoPat( synths[3], outs['synthsOut'] ),
			]
		),(
			name:    'cementSolo',
			countIn: [[ countIn ]],
			click:   [[
				ClickConCat(4,
					Click(170,4,repeats: 10), Click(170,2),
					Click(170,4,repeats: 5), Click(170,5),
					Click(170 * 2,3)
				).out_( outs['clickAll'] )
			]],
			lights:  [ DMXIS.makePat('cementSolo',pathToDMXMIDI +/+ "solo.mid") ],
			kemper:  [ KemperMIDI.makePat('cementSolo',pathToKemperMIDI +/+ "solo.mid") ],
			bTracks: [
				Pseq([ ClickRest(170,137).pattern,YAWNPlayback.makeMonoPat( bass[4], outs['bassOut'] ) ]),
				Pseq([ ClickRest(170,137).pattern,YAWNPlayback.makeStereoPat( synths[4], outs['synthsOut'] ) ]),
				YAWNPlayback.makeStereoPat( perc[7], outs['percOut'] ),
				Pseq([ ClickRest(170,114.5).pattern,YAWNPlayback.makeStereoPat( ambience[2], outs['ambienceOut'] ) ]),
			]
		),(
			name:    'cementQuint',
			countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [
				[ ClickConCat(3, Click(160,4,repeats: 3), ClickRest(160,4)).out_( outs['clickAll'] ) ],  // should these be -3.dbamp?
				[ ClickConCat(3, Click(200,5,repeats: 3), Click(160,4)).out_( outs['clickAll'] ) ]
			],
			lights:  [ DMXIS.makePat('cementQuint',pathToDMXMIDI +/+ "quint.mid") ],
			kemper:  [ KemperMIDI.makePat('cementQuint',pathToKemperMIDI +/+ "quint.mid") ],                                        // this is fucked also
			bTracks: [
				YAWNPlayback.makeMonoPat( bass[5], outs['bassOut'] ),
				YAWNPlayback.makeStereoPat( perc[8], outs['percOut']),
				YAWNPlayback.makeStereoPat( synths[5], outs['synthsOut'])
			]
		),(
			name:    'cementRit',
			countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1,(1.0,1.08..2.12).collect({ |i| Click(200 / i) }), Click(170 * 2,3) ).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('cementRit',pathToDMXMIDI +/+ "rit.mid") ],
			kemper:  [ Pseq([ ClickRest(60/6.384).pattern, KemperMIDI.makePat('cementQuint',pathToKemperMIDI +/+ "rit.mid")] ) ],
			bTracks: [
				YAWNPlayback.makeMonoPat( bass[6], outs['bassOut'] ),
				YAWNPlayback.makeStereoPat( perc[9], outs['percOut']),
				YAWNPlayback.makeStereoPat( synths[6], outs['synthsOut'])
			]
		),(
			name:    'cementAsectionLast',
			countIn: [[ countIn ]],
			click:   [[
				ClickConCat(1,
					Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
					Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
					Click(170,7), Click(170,6), Click(170,5), Click(170,4, repeats: 2),
					Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
				).out_( outs['clickAll'] )
			]],
			lights:  [ DMXIS.makePat('cementAsectionLast',pathToDMXMIDI +/+ "AsectionLast.mid") ],
			kemper:  [ KemperMIDI.makePat('cementAsectionLast',pathToKemperMIDI +/+ "AsectionLast.mid") ],
			bTracks: [
				YAWNPlayback.makeMonoPat( bass[7], outs['bassOut'] ),
				Pseq([ ClickRest(170,75).pattern,YAWNPlayback.makeStereoPat( gtrs[2], outs['gtrsOut'] ) ]),
				YAWNPlayback.makeStereoPat( perc[10], outs['percOut']),
				YAWNPlayback.makeStereoPat( synths[7], outs['synthsOut']),
			]
		),
	]
}