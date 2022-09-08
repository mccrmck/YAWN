///////////////////////////////////////////////// YAWN Data: cement /////////////////////////////////////////////////
{ |songInstance|
	var cueKeys = ['cementLoop'];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var welcome = songInstance.pbTracks['welcome'];
	var leads   = songInstance.pbTracks['leads'];
	var efx     = songInstance.pbTracks['efx'];
	var perc    = songInstance.pbTracks['perc'];
	var adds    = songInstance.pbTracks['adds'];

	var outs    = YAWNShow.outDict;
	var countIn = ClickConCat(1, Click(170,2,repeats: 2), Click(170,1,repeats: 4) ).out_( outs['clickAll'] );

	[
		(
			name:    'cementCount',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickRest( 60 / (welcome[0].duration - 3) ), // 3s is duration of the two bar countIn!
					Click(160,2,repeats: 2),
					Click(160,1,repeats:4)
				).out_( outs['clickAll'] )
			]],
			lights:  [ DMXIS.makePat('cementCount',pathToDMXMIDI +/+ "count.mid") ],
			kemper:  [ KemperMIDI.makePat('cementCount',pathToKemperMIDI +/+ "count.mid") ],
			bTracks: [ YAWNPlayback.makeStereoPat(welcome[0], outs['synthOut'] ) ]
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
				YAWNPlayback.makeStereoPat( efx[0], outs['efxOut'] ),
				YAWNPlayback.makeStereoPat(perc[0], outs['percOut'] ),
				YAWNPlayback.makeStereoPat(adds[0], outs['addsOut'] )
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
		),(
			name:    'cementBsection',
			countIn: [[ countIn ]],
			click:   [[ ClickConCat(1,Click(170,4,repeats: 14), Click(170,3) ).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('cementBsection',pathToDMXMIDI +/+ "Bsection.mid") ],
			kemper:  [ KemperMIDI.makePat('cementBsection',pathToKemperMIDI +/+ "Bsection.mid") ],
		),(
			name:    'cementImpro',
			countIn: [[ countIn ]],
			click:   [[ ClickLoop(170,loopKey: cueKeys[0], out: outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePresetPat('cementImpro',1,1) ],
		),(
			name:    'cementCue',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(170,4,repeats: 2), ClickCue(170,2,repeats: 2),
					ClickCue(170,1,repeats: 4), Click(170,4)
				).out_( outs['clickAll'] )
			]],
			lights:  [ Pseq([ DMXIS.makePresetPat('cementImpro',(60/170) * 16,1), DMXIS.makePresetPat('cementImpro',1,0) ]) ],    // is this the best solution here???
			kemper:  [ KemperMIDI.makePat('cementCue',pathToKemperMIDI +/+ "cue.mid") ],
			bTracks: [
				YAWNPlayback.makeStereoPat(leads[0], outs['leadsOut'] ),
				YAWNPlayback.makeStereoPat( efx[1], outs['efxOut'] ),
				YAWNPlayback.makeStereoPat(perc[1], outs['percOut'] ),
				YAWNPlayback.makeStereoPat(adds[1], outs['addsOut'] )
			]
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
		),(
			name:    'cementQuint',
			countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [
				[ ClickConCat(3, Click(160,4,repeats: 3), ClickRest(160,4)).out_( outs['clickAll'] ) ],  // should these be -3.dbamp?
				[ ClickConCat(3, Click(200,5,repeats: 3), Click(160,4)).out_( outs['clickAll'] ) ]
			],
			lights:  [ DMXIS.makePat('cementQuint',pathToDMXMIDI +/+ "quint.mid") ],
			kemper:  [ KemperMIDI.makePat('cementQuint',pathToKemperMIDI +/+ "quint.mid") ],
		),(
			name:    'cementRit',
			countIn: [[ ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1,(1.0,1.08..2.12).collect({ |i| Click(200 / i) }) ).out_( outs['clickAll'] ), Click(170 * 2,3,out: outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('cementRit',pathToDMXMIDI +/+ "rit.mid") ],
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
				YAWNPlayback.makeStereoPat(perc[2], outs['percOut'] ),
				YAWNPlayback.makeStereoPat(adds[2], outs['addsOut'] )
			]
		),
	]
}