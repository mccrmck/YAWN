///////////////////////////////////////////////// YAWN Data: lachrymator /////////////////////////////////////////////////
{ |songInstance|
	var cueKeys = ['lachTap'];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var leads = songInstance.pbTracks['leads'];
	var efx   = songInstance.pbTracks['efx'];
	var perc  = songInstance.pbTracks['perc'];
	var adds  = songInstance.pbTracks['adds'];

	var outs = YAWNShow.outDict;

	[
		(
			name:    'lachCountPart1',
			countIn: [[ ]],
			click:   [[ ClickConCat(1, Click(240,2,repeats: 2), Click(240,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePresetPat('lachCountPart1',1,0) ],
			kemper:  [ KemperMIDI.makePat('lachCountPart1',pathToKemperMIDI +/+ "countPart1.mid") ],
			bTracks: [
				YAWNPlayback.makePat(leads[0],outs['leadsOut']),
				YAWNPlayback.makePat(efx[0],outs['efxOut']),
				YAWNPlayback.makePat(adds[0],outs['addsOut'])
			]
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
					ClickConCat(34,Click(240,4), Click(300,4))  //transition to impro
				).out_( outs['clickAll'] )
			]],
			lights:  [ Pseq([ DMXIS.makePat('lachAsection',pathToDMXMIDI ++ "Asection.mid"), DMXIS.makePresetPat('lachAsection',0,2) ]) ],
			kemper:  [ KemperMIDI.makePat('lachAsection',pathToKemperMIDI +/+ "Asection.mid") ],
		),(
			name:    'lachTapping',
			countIn: [[ ]],
			click:   [[ ClickLoop(120,4,loopKey: cueKeys[0],out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePresetPat('lachTapping',0,2) ],
			kemper:  [ KemperMIDI.makePat('lachTapping',pathToKemperMIDI +/+ "tapping.mid") ],
		),(
			name:    'lachCountPart2',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[
				ClickConCat(1,
					Click(120,4,repeats: 4), ClickCue(120,4,repeats: 2),
					ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4)
				).out_( outs['clickAll'] )
			]],
			lights:  [ Pseq([ DMXIS.makePresetPat('lachCountPart2',(60/120) * 31.5,2), DMXIS.makePresetPat('lachJazzIntro',(60/120) * 0.5,0) ]) ],
			bTracks: [
				YAWNPlayback.makePat(leads[1],outs['leadsOut']),
				YAWNPlayback.makePat(efx[1],outs['efxOut']),
				YAWNPlayback.makePat(perc[0],outs['percOut'])
			]
		),(
			name:    'lachJazzIntro',
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
			lights:  [ DMXIS.makePat('lachJazzIntro',pathToDMXMIDI ++ "jazzIntro.mid") ],
			kemper:  [ KemperMIDI.makePat('lachJazzIntro',pathToKemperMIDI +/+ "jazzIntro.mid") ],
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
			lights:  [ DMXIS.makePat('lachJazzAsection',pathToDMXMIDI ++ "jazzAsection.mid") ],
			kemper:  [ KemperMIDI.makePat('lachJazzAsection',pathToKemperMIDI +/+ "jazzAsection.mid") ],
		),(
			name:    'lachJazzBsection',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ Click(120,3,repeats: 16,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePat('lachJazzBsection',pathToDMXMIDI ++ "jazzBsection.mid") ],
			kemper:  [ KemperMIDI.makePat('lachJazzBsection',pathToKemperMIDI +/+ "jazzBsection.mid") ],
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
			lights:  [ DMXIS.makePat('lachJazzAsectionAgain',pathToDMXMIDI ++ "jazzAsectionAgain.mid") ],
			kemper:  [ KemperMIDI.makePat('lachJazzAsectionAgain',pathToKemperMIDI +/+ "jazzAsectionAgain.mid") ],
		),(
			name:    'lachJazzBsectionAgain',
			countIn: [[ ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1, Click(120,3,repeats: 15), Click(120,2)).out_( outs['clickAll'] ) ]],
			lights:  [ Pseq([ DMXIS.makePat('lachJazzBsectionAgain',pathToDMXMIDI ++ "jazzBsectionAgain.mid"), DMXIS.makePresetPat('lachJazzBsectionAgain',0,3) ]) ],
			kemper:  [ KemperMIDI.makePat('lachJazzBsectionAgain',pathToKemperMIDI +/+ "jazzBsectionAgain.mid") ],
		),(
			name:    'lachCountPart3',
			countIn: [[  ]],
			click:   [[ ClickRest(60 / 6.3529411764706,out: outs['clickAll'] ), ClickConCat(2, Click(340,5), Click(340,4)).out_( outs['clickAll'] ) ]],
			lights:  [ Pseq([ DMXIS.makePresetPat('lachCountPart3', 9.3529411764706, 3), DMXIS.makePresetPat('lachAsectionNine',0,0) ]) ],
			kemper:  [ KemperMIDI.makePat('lachCountPart3',pathToKemperMIDI +/+ "countPart3.mid") ],
			bTracks: [
				YAWNPlayback.makePat(leads[2],outs['leadsOut']),
				YAWNPlayback.makePat(efx[2],outs['efxOut']),
				YAWNPlayback.makePat(perc[1],outs['percOut']),
				YAWNPlayback.makePat(adds[1],outs['addsOut'])
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
			lights:  [ Pseq([ DMXIS.makePat('lachOutro',pathToDMXMIDI ++ "outro.mid"), DMXIS.makePresetPat('lachOutro',1,4) ]) ],
		)
	]
}