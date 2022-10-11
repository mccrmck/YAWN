///////////////////////////////////////////////// YAWN Data: blast /////////////////////////////////////////////////
{ |songInstance, action|
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
	var fivePitch   = Pseq([ count, KemperMIDI.makePat('blastFivePitch',pathToKemperMIDI +/+ "fivePitch.mid") ]);

	var dmxCount       = DMXIS.makePresetPat('breakCount',60/180 * 4,0);

	var oneDMX         = Pseq([ dmxCount, DMXIS.makePat('blastOne',pathToDMXMIDI +/+ "one.mid") ]);
	var twoDMX         = Pseq([ dmxCount, DMXIS.makePat('blastTwo',pathToDMXMIDI +/+ "two.mid") ]);
	var threeDMX       = Pseq([ dmxCount, DMXIS.makePat('blastThree',pathToDMXMIDI +/+ "three.mid") ]);
	var fourDMX        = Pseq([ dmxCount, DMXIS.makePat('blastFour',pathToDMXMIDI +/+ "four.mid") ]);
	var fourPitchDMX   = Pseq([ dmxCount, DMXIS.makePat('blastFourPitch',pathToDMXMIDI +/+ "fourPitch.mid") ]);
	var fourPshiftDMX  = Pseq([ dmxCount, DMXIS.makePat('blastFourPshift',pathToDMXMIDI +/+ "fourPitchShift.mid") ]);
	var fiveDMX        = Pseq([ dmxCount, DMXIS.makePat('blastFive',pathToDMXMIDI +/+ "five.mid") ]);

	var data = [
		(
			name:    'blastA00',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,8)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourDMX ],
			kemper:  [ four ],
		),(
			name:    'blastA01',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,8)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourDMX ],
			kemper:  [ four ],
		),(
			name:    'blastA02',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,0.25)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourDMX ],
			kemper:  [ four ],
		),(
			name:    'blastA03',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'one'),
					Click(180),Click(180),
					ClickRest(60,9)
				).out_( outs['clickAll'] )
			]],
			lights:  [ oneDMX ],
			kemper:  [ one ],
		),(                                                    // here's a bit of a barline
			name:    'blastA04',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,4)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourDMX ],
			kemper:  [ four ],
		),(
			name:    'blastA05',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
					ClickRest(60,1)
				).out_( outs['clickAll'] )
			]],
			lights:  [ threeDMX ],
			kemper:  [ three ],
		),(
			name:    'blastA06',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60,3.5)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourDMX ],
			kemper:  [ four ],
		),(
			name:    'blastA07',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'two'),
					Click(180,2),Click(180),
					ClickRest(60,2)
				).out_( outs['clickAll'] )
			]],
			lights:  [ twoDMX ],
			kemper:  [ two ],
		),(
			name:    'blastA08',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],

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
			lights:  [
				fourDMX,
				Pseq([ ClickRest(180,6).pattern, threeDMX ])
			],
			kemper:   [
				four,
				Pseq([ ClickRest(180,6).pattern, three ])
			],
		),(                                                                        // here's a bit of a barline
			name:    'blastA09',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(180,3)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourDMX ],
			kemper:  [ four ],
		),(
			name:    'blastA10',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(180,0.2)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourDMX ],
			kemper:  [ four ],
		),(
			name:    'blastA11',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ threeDMX ],
			kemper:  [ three ],
		),(
			name:    'blastA12',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'two'),
					Click(180,2),Click(180),
					ClickRest(180,1)
				).out_( outs['clickAll'] )
			]],
			lights:  [ twoDMX ],
			kemper:  [ two ],
		),(
			name:    'blastA13',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'fourDan'),
					Click(180,4),Click(180),
					ClickRest(60,0.5)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourPitchDMX ],
			kemper:  [ fourPitch ],
		),(
			name:    'blastA14',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'fourDan'),
					Click(180,4),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourPitchDMX ],
			kemper:  [ fourPitch ],
		),(
			name:    'blastA15',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'one'),
					Click(180),Click(180),
					ClickRest(60,1)
				).out_( outs['clickAll'] )
			]],
			lights:  [ oneDMX ],
			kemper:  [ one ],
		),(
			name:    'blastA16',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'twoDan'),
					Click(180,2),Click(180),
					ClickRest(60)
				).out_( outs['clickAll'] )
			]],
			lights:  [ twoDMX ],
			kemper:  [ twoPitch ],
		),(
			name:    'blastA17',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'twoDan'),
					Click(180,2),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ twoDMX ],
			kemper:  [ twoPitch ],
		),(
			name:    'blastA18',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'fourDan'),
					Click(180,4),Click(180),
					ClickRest(60,0.5)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourPshiftDMX ],
			kemper:  [ fourPshift ],
		),(
			name:    'blastA19',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'four'),
					Click(180,4),Click(180),
					ClickRest(60)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fourDMX ],
			kemper:  [ four ],
		),(                                                                   // here's a bit of a barline
			name:    'blastBsection',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(190,1,repeats: 4),
					Click(190,4,repeats: 7),
					ClickCue(190,1,repeats: 4),
					Click(190,4,repeats: 2),
					ClickCue(190,1,repeats: 4),
					Click(190,4,repeats: 5),
					ClickCue(190,2,cueKey: 'three'),
					ClickCue(190,2,cueKey: 'five'),
				).out_( outs['clickAll'] )
			]],
			lights:  [ Pseq([ DMXIS.makePresetPat('blastB',60/190 * 4,0), DMXIS.makePat('blastBsection',pathToDMXMIDI +/+ "Bsection.mid") ]) ],
			kemper:  [ KemperMIDI.makePat('blastBsection',pathToKemperMIDI +/+ "Bsection.mid") ],
		),(
			name:    'blastC00',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					Click(180,3),Click(180),
					ClickRest(180),
					Click(180,5),Click(180)
				).out_( outs['clickAll'] )
			]],
			lights:  [
				DMXIS.makePat('blastThree',pathToDMXMIDI +/+ "three.mid"),
				Pseq([ ClickRest(180,1).pattern, fiveDMX ])
			],
			kemper: [
				KemperMIDI.makePat('blastThree',pathToKemperMIDI +/+ "three.mid"),
				Pseq([ ClickRest(180,1).pattern, five ])
			]
		),(
			name:    'blastC01',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,2,cueKey: 'one'),
					ClickCue(180,2,cueKey: 'three'),
					Click(180),Click(180),
					ClickRest(180),
					Click(180,3),Click(180)
				).out_( outs['clickAll'] )
			]],
			lights:  [
				oneDMX,
				Pseq([ ClickRest(180,3).pattern, threeDMX ])
			],
			kemper:  [
				one,
				Pseq([ ClickRest(180,3).pattern, three ])
			]
		),(
			name:    'blastC02',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,2,cueKey: 'two'),
					ClickCue(180,2,cueKey: 'four'),
					Click(180,2),Click(180),
					ClickRest(180),
					Click(180,4),Click(180)
				).out_( outs['clickAll'] )
			]],
			lights:  [
				twoDMX,
				Pseq([ ClickRest(180,4).pattern, fourDMX ])
			],
			kemper:  [
				two,
				Pseq([ ClickRest(180,4).pattern, four ])
			],
		),(                                                                             // here's a bit of a barline - these could be longer
			name:    'blastC03',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'five'),
					ClickCue(180,1,repeats: 5,amp: [0.7,0.5,0.5]),ClickCue(180,amp: [0.7,0.5,0.5]),
					ClickRest(60,4.5)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fiveDMX ],
			kemper:  [ five ],
		),(
			name:    'blastC04',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'five'),
					Click(180,5),Click(180),
					ClickRest(60,3)
				).out_( outs['clickAll'] )
			]],
			lights:  [ fiveDMX ],
			kemper:  [ five ],
		),(
			name:    'blastC05',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'five'),
					Click(180,5),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ fiveDMX ],
			kemper:  [ five ],
		),(
			name:    'blastC06',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'oneDan'),
					Click(180),Click(180),
					ClickRest(60,3),
				).out_( outs['clickAll'] )
			]],
			lights:  [ oneDMX ],
			kemper:  [ onePitch ],
		),(
			name:    'blastC07',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'oneDan'),
					Click(180),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ oneDMX ],
			kemper:  [ onePitch ],
		),(
			name:    'blastC08',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'twoDan'),
					Click(180,2),Click(180),
					ClickRest(60,1.5),
				).out_( outs['clickAll'] )
			]],
			lights:  [ twoDMX ],
			kemper:  [ twoPitch ],
		),
		(
			name:    'blastC09',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'one'),
					Click(180),Click(180),
				).out_( outs['clickAll'] )
			]],
			lights:  [ oneDMX ],
			kemper:  [ one ],
		),(
			name:    'blastC10',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,2,cueKey: 'fourDan'),
					ClickCue(180,2,cueKey: 'fourDan'),
					Click(180,4),Click(180),
					ClickRest(180),
					Click(180,4),Click(180),
					ClickRest(180,4)
				).out_( outs['clickAll'] )
			]],
			lights:  [
				fourPitchDMX,
				Pseq([ ClickRest(180,6).pattern, fourDMX ])
			],
			kemper:  [
				fourPitch,
				Pseq([ ClickRest(180,6).pattern, fourPshift ])
			],
		),(
			name:    'blastC11',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'three'),
					Click(180,3),Click(180),
					ClickRest(60,2.5)
				).out_( outs['clickAll'] )
			]],
			lights:  [ threeDMX ],
			kemper:  [ three ],
		),(
			name:    'blastC12',
			countIn: [[ ClickCue(60,cueKey: 'blast',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,
					ClickCue(180,4,cueKey: 'one'),
					Click(180,1),Click(180),
					ClickRest(60,2)
				).out_( outs['clickAll'] )
			]],
			lights:  [ oneDMX ],
			kemper:  [ one ],
		)
	];
	action.value;
	data
}