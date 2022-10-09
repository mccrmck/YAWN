///////////////////////////////////////////////// YAWN Data: blast /////////////////////////////////////////////////
{ |songInstance|
	// var cueKeys = [];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var ambience = songInstance.pbTracks['ambience'];
	var bass     = songInstance.pbTracks['bass'];
	var gtrs     = songInstance.pbTracks['gtrs'];
	var perc     = songInstance.pbTracks['perc'];
	var synths   = songInstance.pbTracks['synths'];

	var outs        = YAWNShow.outDict;

	var count       = ClickRest(180,4).pattern;

	var one         = Pseq([ count, KemperMIDI.makePat('blastOne',pathToKemperMIDI +/+ "one.mid") ]);
	var onePitch    = Pseq([ count, KemperMIDI.makePat('blastOnePitch',pathToKemperMIDI +/+ "onePitch.mid") ]);
	var two         = Pseq([ count, KemperMIDI.makePat('blastTwo',pathToKemperMIDI +/+ "two.mid") ]);
	var twoPitch    = Pseq([ count, KemperMIDI.makePat('blastTwoPitch',pathToKemperMIDI +/+ "twoPitch.mid") ]);
	var three       = Pseq([ count, KemperMIDI.makePat('blastThree',pathToKemperMIDI +/+ "three.mid") ]);
	var threePshift = Pseq([ count, KemperMIDI.makePat('blastThreePshift',pathToKemperMIDI +/+ "threePitchShift.mid") ]);
	var four        = Pseq([ count, KemperMIDI.makePat('blastFour',pathToKemperMIDI +/+ "four.mid") ]);
	var fourPitch   = Pseq([ count, KemperMIDI.makePat('blastFourPitch',pathToKemperMIDI +/+ "fourPitch.mid") ]);
	var fourPshift  = Pseq([ count, KemperMIDI.makePat('blastFourPshift',pathToKemperMIDI +/+ "fourPitchShift.mid") ]);
	var five        = Pseq([ count, KemperMIDI.makePat('blastFive',pathToKemperMIDI +/+ "five.mid") ]);
	var fivePitch   = Pseq([ count, KemperMIDI.makePat('blastFive',pathToKemperMIDI +/+ "fivePitch.mid") ]);

	[
		(
			name:    'blastA00',
			countIn: [[ ClickCue(30,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,9)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ four ],
		),(
			name:    'blastA01',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,9)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ four ],
		),(
			name:    'blastA02',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,0.25)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ four ],
		),(
			name:    'blastA03',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'one'),
					Click(180),Click(180),
					ClickRest(60,11)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ one ],
		),(                                                    // here's a bit of a barline
			name:    'blastA04',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,7)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ four ],
		),(
			name:    'blastA05',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,4),Click(180),
					ClickRest(60,7)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ three ],
		),(
			name:    'blastA06',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,3)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ four ],
		),(
			name:    'blastA07',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'two'),
					Click(180,2),Click(180),
					ClickRest(60,2)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ two ],
		),(
			name:    'blastA08',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,2,cueKey: 'four'),
					ClickCue(180,2,cueKey: 'three'),
					Click(180,4),Click(180),
					ClickRest(180,1),
					Click(180,3),Click(180),
					ClickRest(60,5),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ Pseq([ four,three ]) ],                                       // this needs to be fixed - all midi files should be the length of their phrases
		),(                                                                        // here's a bit of a barline
			name:    'blastA09',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(180,3)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ four ],
		),(
			name:    'blastA10',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(180,0.2)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ four ],
		),(
			name:    'blastA11',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ three ],
		),(
			name:    'blastA12',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'two'),
					Click(180,2),Click(180),
					ClickRest(180,1)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ two ],
		),(
			name:    'blastA13',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'fourDan'),
					Click(180,4),Click(180),
					ClickRest(60,0.5)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ fourPitch ],
		),(
			name:    'blastA14',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'fourDan'),
					Click(180,4),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ fourPitch ],
		),(
			name:    'blastA15',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'one'),
					Click(180),Click(180),
					ClickRest(60,1)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ one ],
		),(
			name:    'blastA16',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'twoDan'),
					Click(180,2),Click(180),
					ClickRest(60,1)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ twoPitch ],
		),(
			name:    'blastA17',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'twoDan'),
					Click(180,2),Click(180),
					ClickRest(60,1)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ twoPitch ],
		),(
			name:    'blastA18',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'fourDan'),
					Click(180,4),Click(180),
					ClickRest(60,0.5)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ fourPshift ],
		),(
			name:    'blastA19',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,4)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ four ],
		),(                                                    // here's a bit of a barline
			name:    'blastB',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(190,1,repeats: 4),
					Click(190,4,repeats: 7),
					ClickCue(190,1,repeats: 4),
					Click(190,4,repeats: 2),
					ClickCue(190,1,repeats: 4),
					Click(190,4,repeats: 5),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ KemperMIDI.makePat('blastBsection',pathToKemperMIDI +/+ "Bsection.mid") ],
		),


		//from here

		(
			name:    'blastCstart',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ three ],
		),(
			name:    'blastC01',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ three ],
		),(
			name:    'blastC02',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'fourDan'),
					Click(180,4),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ fourPitch ],
		),(
			name:    'blastC03',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'fiveDan'),
					Click(180,5),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ fivePitch ],
		),(
			name:    'blastC04',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
					ClickRest(180 * 2,3),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ three ],
		),(
			name:    'blastC05',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'five'),
					Click(180,5),Click(180),
					ClickRest(180 * 2,5),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ five ],
		),(
			name:    'blastC06',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
					ClickRest(180,3),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ three ],
		),(
			name:    'blastC07',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'threeDan'),
					Click(180,3),Click(180),
					ClickRest(180,2),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ threePshift ],
		),(
			name:    'blastC08',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'five'),
					Click(180,5),Click(180),
					ClickRest(180 * 2,5)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ five ],
		),
		(
			name:    'blastC09',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
					ClickRest(180 * 2,3)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ three ],
		),(
			name:    'blastC10',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
					ClickRest(180,6)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ three ],
		),(
			name:    'blastC11',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
					ClickRest(180,10)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ three ],
		),(
			name:    'blastC12',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(180,10)
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ four ],
		),(
			name:    'blastC13',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ four ],
		)
	]
}