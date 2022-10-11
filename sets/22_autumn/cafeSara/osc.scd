///////////////////////////////////////////////// YAWN OSC: cafe Sara /////////////////////////////////////////////////

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