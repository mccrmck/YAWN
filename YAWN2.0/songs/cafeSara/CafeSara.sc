CafeSara : YAWNSongNew {

	*loadSynthDefs {
		SynthDef(\cafeSaraPads,{
			var freq = \freq.kr(440);
			var harms = \harms.kr(1!6);
			var root = SinOsc.ar(freq * [0.5,1],mul: \rootGain.kr(0).linlin(0,1,1,8)).sum.tanh;
			var sig = SinOsc.ar(harms, mul: \sigGain.kr(0).linlin(0,1,1,8)).tanh;

			sig = sig.scramble * LFNoise2.ar(0.8!harms.size).range(0,0.5);

			sig = sig + RLPF.ar(HPF.ar(BrownNoise.ar(0.1),freq * 2),harms * 4,0.01);
			sig = Splay.ar(sig);
			root = (root * 0.3)!2 * LFNoise2.ar(0.3).range(0.5,1);
			sig = sig + root;
			sig = HPFSides.ar(sig,180);
			sig = sig * -9.dbamp;
			sig = sig * Env.asr(\atk.kr(4),1,\rls.kr(4),\curve.kr(2)).ar(2,\gate.kr(1) + Impulse.kr(0));
			Out.ar(\verbBus.kr(0),sig * \verbAmp.kr(0).linexp(0,1,0.001,1));
			Out.ar(\outBus.kr(0),sig * \amp.kr(0).linexp(0,1,0.001,1))
		}).add;

		"%: synthDefs loaded".format(this).postln;
	}

	*loadOscDefs {
		var synths = 0!3;
		var synthBus = Bus.control(server,2).set([0.3,0.4]);
		var pitchArray = [
			[59,60,63,64,68,69],
			[60,61,64,65,68,69],
			[59,61,63,66,68,70]
		];


		// test this



		3.do({ |index|

			OSCdef("cafeSaraPads%".format(index).asSymbol,{ |msg|
				var val = msg[1].asInteger;
				var randArray = Array.fill(6,{ [0.5,1,2].choose });

				case
				{ val == 1 }{
					synths[index] = Synth(\cafeSaraPads,[
						\freq,[49,53,52][index].midicps,
						\rootGain,0.1,
						\harms,pitchArray[index].midicps * randArray,
						\sigGain,0,
						\atk,2.rrand(4.0),
						\verbBus,mixerDict['verbSend'],
						\outBus,mixerDict['oskarSynthOut']
					]).map(
						\verbAmp,synthBus.subBus(0),
						\amp,synthBus.subBus(1)
					);

					ClickCue(out: mixerDict['clickAll']).play;
				}
				{ val == 0 }{
					synths[index].set(
						\rls,4.rrand(8.0),
						\curve,4,
						\gate,0
					)
				}

			},"/cafeSaraPads/%".format(index).asSymbol)
		});

		['verbAmp', 'amp'].do({ |key,index|

			OSCdef("oskarMain%".format(key).asSymbol,{ |msg|

				synthBus.subBus(index).set(msg[1])

			},"/cafeSaraPadsVerbAmp/%".format(index).asSymbol);
		});


		"%: oscDefs loaded".format(this).postln;
	}

	*loadData {
		var tripleCountIn = [
			ClickConCat(1, ClickRest(60,3.0896551724138),Click(145,2,repeats: 2),Click(145,1,2,4)).out_( /*outs['clickOskar']*/ ),
			ClickConCat(1, Click(75,2,repeats: 2),Click(75,1,repeats: 4)).out_( /*outs['clickTorfinn']*/ ),
			ClickConCat(1, ClickRest(60,1.8530783156962),Click(60/0.56836521053797,2,repeats: 2),Click(60/0.56836521053797,1,2,4)).out_( /*outs['clickMike']*/ ),
		];
		var oskarTime = ClickConCat(2,
			ClickEnv([145,100],4,2),
			ClickEnv([100,75],4,2),
			ClickEnv([75,120],4,2),
			ClickEnv([120,145],4,2)
		).out_( /*outs['clickOskar']*/ );
		var torfinnTime = ClickConCat(2,
			ClickEnv([75,120],4),
			ClickEnv([120,145],4),
			ClickEnv([145,100],4,curve:1.01.neg),
			ClickEnv([100,75],4,curve: 2)
		).out_( /*outs['clickTorfinn']*/ );
		var mikeTime = Click(60/0.56836521053797,4,2,8, /*out: outs['clickMike']*/ );

		data = [
			'introLoop' -> (
				countIn: ClickCue(75,cueKey: 'cafeSara', /*out: outs['clickAll']*/ ),
				click:   ClickConCat(1,
					Click(60/0.56836521053797,2,repeats: 2),
					Click(60/0.56836521053797,1,2,4),
					ClickLoop(60/0.56836521053797,4,2,4,'introLoop')
				).out_( /*outs['clickMike']*/ ),
				kemper:  YAWNKemper('cafeSara','introLoop').makePattern,
			),
			'intro' -> (
				countIn: ClickConCat(1,Click(60/0.56836521053797,4),Click(60/0.56836521053797,4,2)).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,
					Click(60/0.56836521053797,4,2,2, /*out: outs['clickMike']*/ ),
					ClickConCat(1,ClickCue(60/0.56836521053797,2,2,2),ClickCue(60/0.56836521053797,1,2,4),Click(60/0.56836521053797,4,2,4) ).out_( /*outs['clickAll']*/ )
				),
				kemper:  YAWNKemper('cafeSara', 'intro').makePattern,
			),
			'aPlusBreak' -> (
				countIn: tripleCountIn,
				click:   [
					ClickConCat(1, oskarTime,   oskarTime,   ClickCue(60/0.56836521053797,1,2) ).out_( /*outs['clickOskar']*/ ),
					ClickConCat(1, torfinnTime, torfinnTime, ClickCue(60/0.56836521053797,1,2) ).out_( /*outs['clickTorfinn']*/ ),
					ClickConCat(1, mikeTime,    mikeTime,    ClickCue(60/0.56836521053797,1,2) ).out_( /*outs['clickMike']*/ )
				],
				kemper:  YAWNKemper('cafeSara', 'aPlusBreak').makePattern,
				bTracks: [
					YAWNPB('cafeSara', 'aPlusBreak0', 'bass').makePattern,
					YAWNPB('cafeSara', 'aPlusBreak1', 'bass').makePattern( 0.56836521053797 * 32 ),
				],
			),
			'aAgain' -> (
				countIn: tripleCountIn
				click:   [
					oskarTime,
					torfinnTime,
					mikeTime
				],
				kemper:  YAWNKemper('cafeSara', 'aAgain').makePattern,
				bTracks: YAWNPB('cafeSara', 'aAgain','bass').makePattern,
			),
			'cRiff' -> (
				countIn: tripleCountIn
				click:   [
					oskarTime,
					torfinnTime,
					mikeTime
				],
				kemper:  YAWNKemper('cafeSara', 'cRiff').makePattern,
				bTracks: YAWNPB('cafeSara', 'cRiff','bass').makePattern,
			),
			'aLast' -> (
				countIn: tripleCountIn,
				click:   [
					oskarTime,
					torfinnTime,
					mikeTime
				],
				kemper:  YAWNKemper('cafeSara', 'aLast').makePattern,
				bTracks: YAWNPB('cafeSara', 'aLast','bass').makePattern,
			),
			'break' -> (
				countIn: ClickConCat(1, Click(60/0.56836521053797,2,repeats: 2), Click(60/0.56836521053797,1,repeats: 4)).out_( /*outs['clickAll']*/ ),
				click:   Click(60/0.56836521053797,4, /*out: outs['clickAll']*/ ),
				kemper:  YAWNKemper('cafeSara', 'break').makePattern,
				bTracks: YAWNPB('cafeSara', 'break','bass').makePattern,
			),
			'bSection' -> (
				countIn: [
					ClickConCat(1, ClickRest(60,3.0896551724138), Click(145,2,repeats: 2), Click(145,1,2,4)).out_( /*outs['clickOskar']*/ ),
					ClickConCat(1, Click(75,2,repeats: 2), Click(75,1,repeats: 4)).out_( /*[ outs['clickTorfinn'], outs['clickMike'] ]*/ ),
				],
				click:   [
					ClickConCat(6, ClickEnv([145,100],4,2), ClickEnv([100,75],4,2), ClickEnv([75,120],4,2), ClickEnv([120,145],4,2)).out_( /*outs['clickOskar']*/ ),
					ClickConCat(6, ClickEnv([75,120],4), ClickEnv([120,145],4), ClickEnv([145,100],4,curve:1.01.neg), ClickEnv([100,75],4,curve: 2)).out_( /*[ outs['clickTorfinn'], outs['clickMike'] ]*/ ),
				],
				kemper:  YAWNKemper('cafeSara', 'bSection').makePattern,
				bTracks: YAWNPB('cafeSara', 'bSection','bass').makePattern,
			),
			'harmonyCount' -> (
				click:   ClickConCat(1,Click(145,2,repeats: 2),Click(145,1,2,4)).out_( /*outs['clickAll']*/ ),
			),
			'harmony' -> (
				click:   ClickConCat(1,
					ClickConCat(6,
						ClickEnv([145,100],4,2),
						ClickEnv([100,75],4,2),
						ClickEnv([75,120],4,2),
						ClickEnv([120,145],4,2)
					),
					ClickEnvCue([145,130],2,2)
				).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('cafeSara', 'harmony').makePattern,
				bTracks: YAWNPB('cafeSara', 'harmony', 'bass').makePattern,
			),
			'thrash' -> (
				countIn: ClickConCat(1, Click(90,2,repeats: 2), Click(90,1,repeats: 4)).out_( /*outs['clickAll']*/ ),
				click:   Click(90,4,repeats: 8, /*out: outs['clickAll']*/ ),
				kemper:  YAWNKemper('cafeSara', 'thrash').makePattern,
				bTracks: YAWNPB('cafeSara', 'thrash', 'bass').makePattern,
			),
			'rit' -> (
				countIn: ClickConCat(1,Click(90,2,repeats: 2),Click(90,1,repeats: 4)).out_( /*outs['clickAll']*/ ),
				click:   [
					ClickConCat(1, Click(90,4,repeats: 2), ClickEnv([90,85],4), ClickEnv([85,76],3), Click(76,4,1,3), Click(76,3,1)).out_(/*[ outs['clickTorfinn'], outs['clickMike'] ]*/),
					ClickConCat(1, Click(90,4,repeats: 2), ClickEnv([90,85],4), ClickEnv([85,76],3), Click(76,4,2,3), Click(76,3,2)).out_( /*outs['clickOskar']*/ )
				],
				kemper:  YAWNKemper('cafeSara', 'rit').makePattern,
				bTracks: YAWNPB('cafeSara', 'thrash', 'rit').makePattern,
			),
			'outro' -> (
				countIn: ClickConCat(1,Click(76,2,2,2),Click(76,1,2,4)).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,ClickEnv([75,120],4,2),ClickEnv([120,145],4,2),ClickEnv([145,100],4,2),ClickEnv([100,75],4,2)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('cafeSara', 'outro').makePattern,
				bTracks: YAWNPB('cafeSara', 'outro', 'rit').makePattern,
			)
		];

		"%: data loaded".format(this).postln;
	}

}
