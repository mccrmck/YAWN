///////////////////////////////////////////////// YAWN OSC: cafe Sara /////////////////////////////////////////////////

var synths = 0!3;
var synthBus = Bus.control(Server.default,2).set([0.3,0.4]);

var clickPats = [
	YAWNShow.set.songs[1].cueFrom('cafeSaraIntroLoop','cafeSaraBsection',true,true,true,true,true).stop,
	'cafeSaraIntro',
	YAWNShow.set.songs[1].cueFrom('cafeSaraHarmonyCount','cafeSaraOutro',true,true,true,true,false).stop
];

clickPats.do({ |pattern, index|

	switch(index,
		1,{
			OSCdef("cafeSaraClick%".format(index).asSymbol,{ |msg|
				var val = msg[1].asInteger;

				case
				{ val == 1 }{ Click.loopCues['cafeSaraIntro'] = false }
				{ val == 0 }{ Click.loopCues['cafeSaraIntro'] = true }

			},"/cafeSaraClick/%".format(index).asSymbol)
		},
		{
			OSCdef("cafeSaraClick%".format(index).asSymbol,{ |msg|
				var val = msg[1].asInteger;

				case
				{ val == 1 }{ pattern.play }
				{ val == 0 }{ pattern.stop }

			},"/cafeSaraClick/%".format(index).asSymbol)
		}
	)
});

// oskar's synth pads

3.do({ |index|

	OSCdef("cafeSaraPads%".format(index).asSymbol,{ |msg|
		var val = msg[1].asInteger;
		var pitchArray = [
			[59,60,63,64,68,69],
			[60,61,64,65,68,69],
			[59,61,63,66,68,70]
		];
		var randArray = Array.fill(6,{ [0.5,1,2].choose });

		case
		{ val == 1 }{
			synths[index] = Synth(\cafeSaraPads,[
				\freq,[49,53,52][index].midicps,
				\rootGain,0.1,
				\harms,pitchArray[index].midicps * randArray,
				\sigGain,0,
				\atk,4.rrand(6.0),
				\verbBus,YAWNShow.verbBus,
				\outBus,YAWNShow.outDict['processOut']
			]).map(
				\verbAmp,synthBus.subBus(0),
				\amp,synthBus.subBus(1)
			)
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

[ 'verbAmp','amp'].do({ |key,index|

	OSCdef("oskarMain%".format(key).asSymbol,{ |msg|

		synthBus.subBus(index).set(msg[1])

	},"/cafeSaraPadsVerbAmp/%".format(index).asSymbol);
});