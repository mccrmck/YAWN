Cement : YAWNSong {

	// must be able to pass values into the data arrays
	// ie. input/output busses, paths to files

	*data {
		var countIn = ClickConCat(1, Click(170,2,repeats: 2), Click(170,1,repeats: 4) ).out_( outs['clickAll'] );

		^[
			'count' -> (
				click: [[ ClickConCat(1,Click(160,2,repeats: 2), Click(160,1,repeats: 4) ).out_( ) ]],  // do these really all need to be (nested) arrays?

				// to test: can I just have a ClickConCat that gets a .size check;
				// if out == anArray, it's played in parallel; if .size > 1 it gets wrapped in a Ppar?

				lights: [ DMXIS.makePresetPat('cementCount',0,0) ],
				kemper: [ KemperMIDI.makePat('cementCount') ], // needs a path, could be a variable of YAWNSong
			),
			'intro' -> (
				countIn: [], // do we still want these? Is there a better way?
				click: [[
					ClickConCat(1,
						Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
						Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
						Click(160,7), Click(160,6), Click(160,5), Click(160,4,repeats: 2)
					).out_( )
				]],
				lights:  [ DMXIS.makePat('cementIntro') ],   // needs a path
				kemper:  [ KemperMIDI.makePat('cementIntro') ], // needs a path
				bTracks: [ YAWNPlayback.makeStereoPat() ]                                            // these suckers need a bufnum and an output argument
			),

			'aSection' -> (
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
					Pseq([ ClickRest(170,25).pattern, YAWNPlayback.makeStereoPat( ambience[0], outs['ambienceOut'] ) ]),
					Pseq([ ClickRest(170,63).pattern, YAWNPlayback.makeStereoPat( ambience[1], outs['ambienceOut'] ) ]),
					YAWNPlayback.makeMonoPat( bass[0], outs['bassOut'] ),
					YAWNPlayback.makeStereoPat( perc[1], outs['percOut'] ),
					YAWNPlayback.makeStereoPat( synths[0], outs['synthsOut'] ),
				]
			),
			'melody' ->(
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
					YAWNPlayback.makeStereoPat( gtrs[1], outs['gtrsOut'] ),
					YAWNPlayback.makeStereoPat( perc[2], outs['percOut'] ),
					YAWNPlayback.makeStereoPat( synths[1], outs['synthsOut'] ),
					YAWNPlayback.makeStereoOverlap( synths[2], outs['synthsOut'] ),
				]
			),
			'bSection' -> (
				countIn: [[ countIn ]],
				click:   [[ ClickConCat(1,Click(170,4,repeats: 14), Click(170,3) ).out_( outs['clickAll'] ) ]],
				lights:  [ Pseq([ DMXIS.makePat('cementBsection',pathToDMXMIDI +/+ "Bsection.mid"), DMXIS.makePresetPat('cementImpro',0,3) ]) ],
				kemper:  [ KemperMIDI.makePat('cementBsection',pathToKemperMIDI +/+ "Bsection.mid") ],
				bTracks: [
					YAWNPlayback.makeMonoPat( bass[2], outs['bassOut'] ),
					Pseq([ ClickRest(170,58.5).pattern,YAWNPlayback.makeMonoPat( bass[3], outs['bassOut'] ) ]),
					Pseq([ ClickRest(170,58.5).pattern,YAWNPlayback.makeStereoPat( perc[3], outs['percOut'] ) ]),
					YAWNPlayback.makeStereoPat( synths[3], outs['synthsOut'] ),
				]
			),
			'countAgain' -> (
				name:    'cementCountAgain',
				countIn: [[ ]],
				click:   [[ ClickConCat(1, ClickCue(160,2,cueKey: 'cement'),Click(160,2), Click(160,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
				lights:  [ DMXIS.makePresetPat('cementCountAgain',0,0) ],
				kemper:  [ KemperMIDI.makePat('cementCountAgain',pathToKemperMIDI +/+ "countAgain.mid") ],
			),
			'bSectionAgain' ->(
				countIn: [[ countIn ]],
				click:   [[
					ClickConCat(1,
						Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
						Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
					).out_( outs['clickAll'] )
				]],
				lights:  [ DMXIS.makePat('cementBsectionAgain',pathToDMXMIDI +/+ "BsectionAgain.mid") ],
				kemper:  [ KemperMIDI.makePat('cementBsectionAgain',pathToKemperMIDI +/+ "BsectionAgain.mid") ],             // weird shit happening in mike's guitar
				bTracks: [
					YAWNPlayback.makeStereoOverlap( ambience[2], outs['ambienceOut'] ),
					Pseq([ ClickRest(170,68.5).pattern,YAWNPlayback.makeStereoOverlap( ambience[3], outs['ambienceOut']  ) ]),
					YAWNPlayback.makeMonoPat( bass[4], outs['bassOut'] ),
					YAWNPlayback.makeStereoPat( perc[4], outs['percOut'] ),
					YAWNPlayback.makeStereoOverlap( synths[4], outs['synthsOut'] ),
				]
			),
			'solo' ->(
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
					Pseq([ ClickRest(170,114.5).pattern,YAWNPlayback.makeStereoPat( ambience[4], outs['ambienceOut'] ) ]),
					Pseq([ ClickRest(170,137).pattern,YAWNPlayback.makeMonoPat( bass[5], outs['bassOut'] ) ]),
					Pseq([ ClickRest(170,137).pattern,YAWNPlayback.makeStereoPat( gtrs[2], outs['gtrsOut'] ) ]),
					Pseq([ ClickRest(170,137).pattern,YAWNPlayback.makeStereoPat( synths[5], outs['synthsOut'] ) ]),
					YAWNPlayback.makeStereoPat( perc[5], outs['percOut'] ),
				]
			),
			'quint' -> (
				countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
				click:   [
					[ ClickConCat(3, Click(160,4,repeats: 3), ClickRest(160,4)).out_( outs['clickAll'] ) ],  // should these be -3.dbamp?
					[ ClickConCat(3, Click(200,5,repeats: 3), Click(160,4)).out_( outs['clickAll'] ) ]
				],
				lights:  [ DMXIS.makePat('cementQuint',pathToDMXMIDI +/+ "quint.mid") ],
				kemper:  [ KemperMIDI.makePat('cementQuint',pathToKemperMIDI +/+ "quint.mid") ],
				bTracks: [
					YAWNPlayback.makeMonoPat( bass[6], outs['bassOut'] ),
					YAWNPlayback.makeStereoPat( perc[6], outs['percOut']),
					YAWNPlayback.makeStereoPat( synths[6], outs['synthsOut'])
				]
			),
			'rit' -> (
				countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
				click:   [[ ClickConCat(1,(1.0,1.08..2.12).collect({ |i| Click(200 / i) }), Click(170 * 2,3) ).out_( outs['clickAll'] ) ]],
				lights:  [ DMXIS.makePat('cementRit',pathToDMXMIDI +/+ "rit.mid") ],
				kemper:  [ Pseq([ ClickRest(60/6.384).pattern, KemperMIDI.makePat('cementQuint',pathToKemperMIDI +/+ "rit.mid")] ) ],
				bTracks: [
					YAWNPlayback.makeMonoPat( bass[7], outs['bassOut'] ),
					YAWNPlayback.makeStereoPat( perc[7], outs['percOut']),
					YAWNPlayback.makeStereoPat( synths[7], outs['synthsOut'])
				]
			),
			'aSectionLast' -> (
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
					YAWNPlayback.makeMonoPat( bass[8], outs['bassOut'] ),
					YAWNPlayback.makeStereoPat( gtrs[3], outs['gtrsOut'] ),
					Pseq([ ClickRest(170,76).pattern,YAWNPlayback.makeStereoPat( gtrs[4], outs['gtrsOut'] ) ]),
					YAWNPlayback.makeStereoPat( perc[8], outs['percOut']),
					YAWNPlayback.makeStereoPat( synths[8], outs['synthsOut']),
					YAWNPlayback.makeStereoPat( synths[9], outs['synthsOut']),
				]
			),

		]
	}

}

// these songs can inherit some methods from YAWNSong so that we don't have to pass filepaths, etc.

// YAWNSong gets a whole bunch of methods that trickle down:
// *section { this.data.keys}, etc.

// Is YAWNSet obsolete? Maybe it's just YAWNShow.setlist?
// array w/ Cement.loadSection('countAgain','AsectionLast') // from/to; booleans for lights, etc. belong to YAWNShow

// maybe it's an YAWNShow.addCue('startShow',{}), YAWNShow.addCue('cue',[])
// can I autobuild a gui too?!?!?!

// YAWNShow gets a mixer - right?
// mixer channels get routed to hardware outputs (actually, Dante I/O) defined at startup
// or is this necessary? maybe pre-production removes the need for decent bus processing?