///////////////////////////////////////////////// YAWN Data: chaos /////////////////////////////////////////////////
{ |songInstance|
	// var cueKeys = ['chaosIntroLoop','chaosElevenLoop'];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var leads = songInstance.pbTracks['leads'];
	var efx   = songInstance.pbTracks['efx'];
	var perc  = songInstance.pbTracks['perc'];
	var adds  = songInstance.pbTracks['adds'];

	var outs = YAWNShow.outDict;

	[
		(
			name:    'cafeSaraIntro',
			countIn: [[ ]],                    // fix this
			click:   [[ Click(60/0.56836521053797,4,2,9,out: outs['clickAll']) ]],
			lights:  [ ],
			kemper:  [ ],
			bTracks:  [ ],
		),(
			name:    'cafeSaraA',
			countIn: [[ ]],                    // fix this
			click:   [
				[ ClickConCat(4,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(4,ClickEnv([75,120],4),ClickEnv([120,145],4),ClickEnv([145,100],4,curve:1.01.neg),ClickEnv([100,75],4,curve: 2)).out_( outs['clickTorfinn'] ) ],
				[ Click(60/0.56836521053797,4,2,16,out: outs['clickMike']) ]
			],
			lights:  [ ],
			kemper:  [ ],
			bTracks:  [ ],
		),(
			name:    'cafeSaraB',
			countIn: [[ ]],                    // fix this
			click:   [
				[ ClickConCat(4,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(4,ClickEnv([75,120],4),ClickEnv([120,145],4),ClickEnv([145,100],4,curve:1.01.neg),ClickEnv([100,75],4,curve: 2)).out_([ outs['clickTorfinn'], outs['clickMike'] ]) ],
			],
			lights:  [ ],
			kemper:  [ ],
			bTracks:  [ ],
		),(
			name:    'cafeSaraHarmony',
			countIn: [[ ClickConCat(1,Click(145,4),Click(145,4,2)).out_( outs['clickAll'] ) ]],                    // fix this
			click:   [[ ClickConCat(6,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).out_( outs['clickAll'] ),ClickManCue([145,130],2,out: outs['clickAll']) ]],
			lights:  [ ],
			kemper:  [ ],
			bTracks:  [ ],
		),(
			name:    'cafeSaraThrash',
			countIn: [[ ClickConCat(1,Click(90,2,repeats: 2),Click(90,1,repeats: 4)).out_( outs['clickAll'] ) ]],                    // fix this
			click:   [[ Click(90,4,repeats: 8,out: outs['clickAll'] ) ]],
			lights:  [ ],
			kemper:  [ ],
			bTracks:  [ ],
		),(
			name:    'cafeSaraRit',
			countIn: [[ ClickConCat(1,Click(90,2,repeats: 2),Click(90,1,repeats: 4)).out_( outs['clickAll'] ) ]],                    // fix this
			click:   [
				[ ClickConCat(1,Click(90,4,repeats: 2),ClickEnv([90,85],4),ClickEnv([85,76],3),Click(76,4,1,3),Click(76,3,1)).out_([ outs['clickTorfinn'], outs['clickMike'] ]) ],
				[ ClickConCat(1,Click(90,4,repeats: 2),ClickEnv([90,85],4),ClickEnv([85,76],3),Click(76,4,2,3),Click(76,3,2)).out_( outs['clickOskar'] ) ]
			],
			lights:  [ ],
			kemper:  [ ],
			bTracks:  [ ],
		),(
			name:    'cafeSaraEnd',
			countIn: [[ ClickConCat(1,Click(76,2,repeats: 2),Click(76,1,repeats: 4)).out_( outs['clickAll'] ) ]],                    // fix this
			click:   [[ ClickConCat(1,ClickEnv([75,120],4,2),ClickEnv([120,145],4,2),ClickEnv([145,100],4,2),ClickEnv([100,75],4,2)).out_( outs['clickAll'] ) ]],
			lights:  [ ],
			kemper:  [ ],
			bTracks:  [ ],
		)
	]
}