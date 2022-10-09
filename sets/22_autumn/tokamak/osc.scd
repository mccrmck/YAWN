///////////////////////////////////////////////// YAWN OSC: tokamak /////////////////////////////////////////////////

var clickPats = [
	YAWNShow.set.songs[5].cueFrom('tokamakPB','tokamakOutro',true,true,true,true,true).stop,
	'tokamakLoop'
];

clickPats.do({ |pattern, index|

	switch(index,
		1,{
			OSCdef("tokamakClick%".format(index).asSymbol,{ |msg|
				var val = msg[1].asInteger;

				case
				{ val == 1 }{ Click.loopCues['tokamakLoop'] = false }
				{ val == 0 }{ Click.loopCues['tokamakLoop'] = true }

			},"/tokamakClick/%".format(index).asSymbol)
		},
		{
			OSCdef("tokamakClick%".format(index).asSymbol,{ |msg|
				var val = msg[1].asInteger;

				case
				{ val == 1 }{ pattern.play }
				{ val == 0 }{ pattern.stop }

			},"/tokamakClick/%".format(index).asSymbol)
		}
	)
});