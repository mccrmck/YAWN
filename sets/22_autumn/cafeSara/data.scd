///////////////////////////////////////////////// YAWN Data: cafeSara  /////////////////////////////////////////////////
{ |songInstance|
	var cueKeys = ['cafeSaraIntro'];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var ambience = songInstance.pbTracks['ambience'];
	var bass     = songInstance.pbTracks['bass'];
	var gtrs     = songInstance.pbTracks['gtrs'];
	var perc     = songInstance.pbTracks['perc'];
	var synths   = songInstance.pbTracks['synths'];

	var outs     = YAWNShow.outDict;

	[
		(
			name:    'cafeSaraIntroLoop',
			countIn: [[ ]],
			click:   [[ ClickConCat(1,ClickCue(30,1,cueKey: 'cafeSara',out: outs['clickAll'] ),ClickLoop(60/0.56836521053797,4,2,4,cueKeys[0],out: outs['clickMike']) ) ]],
			lights:  [ DMXIS.makePresetPat('cafeSaraIntroLoop',0,5) ],
			kemper:  [ ],
			bTracks: [ ],
		),(
			name:    'cafeSaraIntro',
			countIn: [[ ClickConCat(1,Click(60/0.56836521053797,4),Click(60/0.56836521053797,4,2)).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1,Click(60/0.56836521053797,4,2,2),ClickCue(60/0.56836521053797,2,2,2),ClickCue(60/0.56836521053797,1,2,4),Click(60/0.56836521053797,4,2,4) ).out_( outs['clickAll'] ) ]],
			lights:  [
				DMXIS.makePat('cafeSaraIntro',pathToDMXMIDI +/+ "intro.mid"),
				Pseq([ DMXIS.makePresetPat('cafeSaraIntroLoop',0.56836521053797 * 4 * 7.75,5),	DMXIS.makePresetPat('cafeSaraIntro',0.56836521053797 * 0.25,0) ]),
			],
			kemper:  [ KemperMIDI.makePat('cafeSaraIntro', pathToKemperMIDI +/+ "intro.mid") ],
			bTracks: [ ],
		),(
			name:    'cafeSaraAplusBreak',
			countIn: [
				[ ClickConCat(1,ClickRest(60,3.0896551724138),Click(145,2,repeats: 2),Click(145,1,2,4)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(1,Click(75,2,repeats: 2),Click(75,1,repeats: 4)).out_( outs['clickTorfinn'] ) ],
				[ ClickConCat(1,ClickRest(60,1.8530783156962),Click(60/0.56836521053797,2,repeats: 2),Click(60/0.56836521053797,1,2,4)).out_( outs['clickMike'] ) ],
			],
			click:   [
				[ ClickConCat(4,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).out_( outs['clickOskar'] ),ClickCue(60/0.56836521053797,1,2, out: outs['clickOskar']) ],
				[ ClickConCat(4,ClickEnv([75,120],4),ClickEnv([120,145],4),ClickEnv([145,100],4,curve:1.01.neg),ClickEnv([100,75],4,curve: 2)).out_( outs['clickTorfinn'] ),ClickCue(60/0.56836521053797,1,2, out: outs['clickTorfinn']) ],
				[ Click(60/0.56836521053797,4,2,16,out: outs['clickMike']),ClickCue(60/0.56836521053797,1,2, out: outs['clickMike']) ]
			],
			lights:  [ DMXIS.makePat('cafeSaraAplusBreak',pathToDMXMIDI +/+ "AplusBreak.mid") ],
			kemper:  [ KemperMIDI.makePat('cafeSaraAplusBreak',pathToKemperMIDI +/+ "AplusBreak.mid") ],
			bTracks: [
				YAWNPlayback.makeMonoPat(bass[0], outs['bassOut']),
				Pseq([ ClickRest(60/0.56836521053797,4,8).pattern, YAWNPlayback.makeMonoPat(bass[1], outs['bassOut']) ])
			],
		),(
			name:    'cafeSaraAagain',
			countIn: [
				[ ClickConCat(1,ClickRest(60,3.0896551724138),Click(145,2,repeats: 2),Click(145,1,2,4)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(1,Click(75,2,repeats: 2),Click(75,1,repeats: 4)).out_( outs['clickTorfinn'] ) ],
				[ ClickConCat(1,ClickRest(60,1.8530783156962),Click(60/0.56836521053797,2,repeats: 2),Click(60/0.56836521053797,1,2,4)).out_( outs['clickMike'] ) ],
			],
			click:   [
				[ ClickConCat(2,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(2,ClickEnv([75,120],4),ClickEnv([120,145],4),ClickEnv([145,100],4,curve:1.01.neg),ClickEnv([100,75],4,curve: 2)).out_( outs['clickTorfinn'] ) ],
				[ Click(60/0.56836521053797,4,2,8,out: outs['clickMike']) ]
			],
			lights:  [ DMXIS.makePat('cafeSaraAagain',pathToDMXMIDI +/+ "Aagain.mid") ],
			kemper:  [ KemperMIDI.makePat('cafeSaraAagain',pathToKemperMIDI +/+ "Aagain.mid") ],
			bTracks: [ YAWNPlayback.makeMonoPat(bass[2], outs['bassOut']) ],
		),(
			name:    'cafeSaraCriff',
			countIn: [
				[ ClickConCat(1,ClickRest(60,3.0896551724138),Click(145,2,repeats: 2),Click(145,1,2,4)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(1,Click(75,2,repeats: 2),Click(75,1,repeats: 4)).out_( outs['clickTorfinn'] ) ],
				[ ClickConCat(1,ClickRest(60,1.8530783156962),Click(60/0.56836521053797,2,repeats: 2),Click(60/0.56836521053797,1,2,4)).out_( outs['clickMike'] ) ],
			],
			click:   [
				[ ClickConCat(2,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(2,ClickEnv([75,120],4),ClickEnv([120,145],4),ClickEnv([145,100],4,curve:1.01.neg),ClickEnv([100,75],4,curve: 2)).out_( outs['clickTorfinn'] ) ],
				[ Click(60/0.56836521053797,4,2,8,out: outs['clickMike']) ]
			],
			lights:  [ DMXIS.makePat('cafeSaraCriff',pathToDMXMIDI +/+ "Criff.mid") ],
			kemper:  [ KemperMIDI.makePat('cafeSaraCriff', pathToKemperMIDI +/+ "Criff.mid") ],
			bTracks: [ YAWNPlayback.makeMonoPat(bass[3], outs['bassOut']) ],
		),(
			name:    'cafeSaraAlast',
			countIn: [
				[ ClickConCat(1,ClickRest(60,3.0896551724138),Click(145,2,repeats: 2),Click(145,1,2,4)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(1,Click(75,2,repeats: 2),Click(75,1,repeats: 4)).out_( outs['clickTorfinn'] ) ],
				[ ClickConCat(1,ClickRest(60,1.8530783156962),Click(60/0.56836521053797,2,repeats: 2),Click(60/0.56836521053797,1,2,4)).out_( outs['clickMike'] ) ],
			],
			click:   [
				[ ClickConCat(2,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(2,ClickEnv([75,120],4),ClickEnv([120,145],4),ClickEnv([145,100],4,curve:1.01.neg),ClickEnv([100,75],4,curve: 2)).out_( outs['clickTorfinn'] ) ],
				[ Click(60/0.56836521053797,4,2,8,out: outs['clickMike']) ]
			],
			lights:  [ DMXIS.makePat('cafeSaraAlast',pathToDMXMIDI +/+ "Alast.mid") ],
			kemper:  [ KemperMIDI.makePat('cafeSaraAlast', pathToKemperMIDI +/+ "Alast.mid") ],
			bTracks: [ YAWNPlayback.makeMonoPat(bass[4], outs['bassOut']) ],
		),(
			name:    'cafeSaraBreak',
			countIn: [[ ClickConCat(1,Click(60/0.56836521053797,2,repeats: 2),Click(60/0.56836521053797,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			click:   [[ Click(60/0.56836521053797,4,out: outs['clickAll']) ] ],
			lights:  [ DMXIS.makePat('cafeSaraBreak',pathToDMXMIDI +/+ "break.mid") ],
			kemper:  [ KemperMIDI.makePat('cafeSaraBreak', pathToKemperMIDI +/+ "break.mid") ],
			bTracks: [ YAWNPlayback.makeMonoPat(bass[5], outs['bassOut']) ],
		),(
			name:    'cafeSaraBsection',
			countIn: [
				[ ClickConCat(1,ClickRest(60,3.0896551724138),Click(145,2,repeats: 2),Click(145,1,2,4)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(1,Click(75,2,repeats: 2),Click(75,1,repeats: 4)).out_([ outs['clickTorfinn'], outs['clickMike'] ]) ]
			],
			click:   [
				[ ClickConCat(6,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).out_( outs['clickOskar'] ) ],
				[ ClickConCat(6,ClickEnv([75,120],4),ClickEnv([120,145],4),ClickEnv([145,100],4,curve:1.01.neg),ClickEnv([100,75],4,curve: 2)).out_([ outs['clickTorfinn'], outs['clickMike'] ]) ],
			],
			lights:  [ Pseq([ DMXIS.makePat('cafeSaraBsection',pathToDMXMIDI +/+ "Bsection.mid"),DMXIS.makePresetPat('cafeSaraBsection',0,6) ]) ],
			kemper:  [ KemperMIDI.makePat('cafeSaraBsection', pathToKemperMIDI +/+ "Bsection.mid") ],
			bTracks: [ YAWNPlayback.makeMonoPat(bass[6], outs['bassOut']) ],
		),(
			name:    'cafeSaraHarmonyCount',
			countIn: [[ ]],
			click:   [[ ClickConCat(1,Click(145,2,repeats: 2),Click(145,1,2,4)).out_( outs['clickAll'] ) ]],
			lights:  [ Pseq([ DMXIS.makePresetPat('cafeSaraHarmonyCount',60/145 * 7.75,6),DMXIS.makePresetPat('cafeSaraHarmony',60/145 * 0.25,0) ]) ],
			kemper:  [ ],
			bTracks: [ ],
		),(
			name:    'cafeSaraHarmony',
			countIn: [[ ]],
			click:   [[ ClickConCat(6,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).out_( outs['clickAll'] ),ClickEnvCue([145,130],2,2,out: outs['clickAll']) ]],
			lights:  [ DMXIS.makePat('cafeSaraHarmony',pathToDMXMIDI +/+ "harmony.mid") ],
			kemper:  [ KemperMIDI.makePat('cafeSaraHarmony', pathToKemperMIDI +/+ "harmony.mid") ],
			bTracks: [ YAWNPlayback.makeMonoPat(bass[7], outs['bassOut']) ],
		),(
			name:    'cafeSaraThrash',
			countIn: [[ ClickConCat(1,Click(90,2,repeats: 2),Click(90,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			click:   [[ Click(90,4,repeats: 8,out: outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('cafeSaraThrash',pathToDMXMIDI +/+ "thrash.mid") ],
			kemper:  [ KemperMIDI.makePat('cafeSaraThrash',pathToKemperMIDI +/+ "thrash.mid") ],
			bTracks: [ YAWNPlayback.makeMonoPat(bass[8], outs['bassOut']) ],
		),(
			name:    'cafeSaraRit',
			countIn: [[ ClickConCat(1,Click(90,2,repeats: 2),Click(90,1,repeats: 4)).out_( outs['clickAll'] ) ]],
			click:   [
				[ ClickConCat(1,Click(90,4,repeats: 2),ClickEnv([90,85],4),ClickEnv([85,76],3),Click(76,4,1,3),Click(76,3,1)).out_([ outs['clickTorfinn'], outs['clickMike'] ]) ],
				[ ClickConCat(1,Click(90,4,repeats: 2),ClickEnv([90,85],4),ClickEnv([85,76],3),Click(76,4,2,3),Click(76,3,2)).out_( outs['clickOskar'] ) ]
			],
			lights:  [ DMXIS.makePat('cafeSaraRit',pathToDMXMIDI +/+ "rit.mid") ],
			kemper:  [ KemperMIDI.makePat('cafeSaraRit', pathToKemperMIDI +/+ "rit.mid") ],
			bTracks: [ YAWNPlayback.makeMonoPat(bass[9], outs['bassOut']) ],
		),(
			name:    'cafeSaraOutro',
			countIn: [[ ClickConCat(1,Click(76,2,2,2),Click(76,1,2,4)).out_( outs['clickAll'] ) ]],
			click:   [[ ClickConCat(1,ClickEnv([75,120],4,2),ClickEnv([120,145],4,2),ClickEnv([145,100],4,2),ClickEnv([100,75],4,2)).out_( outs['clickAll'] ) ]],
			lights:  [ DMXIS.makePat('cafeSaraOutro',pathToDMXMIDI +/+ "outro.mid") ],
			kemper:  [ KemperMIDI.makePat('cafeSaraOutro',pathToKemperMIDI +/+ "outro.mid") ],
			bTracks: [ YAWNPlayback.makeMonoPat(bass[10], outs['bassOut']) ],
		)
	]
}