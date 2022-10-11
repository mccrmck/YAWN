///////////////////////////////////////////////// YAWN OSC: cement /////////////////////////////////////////////////

var clickPats = [
	YAWNShow.set.songs[2].cueFrom('cementCount','cementBsection',true,true,true,true,true).stop,
	// Mike Støy Solo
	Pdef(\blastPlusCement,
		Pseq([
			YAWNShow.set.songs[0].cueFrom('blastA00','blastC12',true,true,true,false,true).stop,
			YAWNShow.set.songs[2].cueFrom('cementCountAgain','cementAsectionLast',true,true,true,true,false).stop
		])
	).stop
];

clickPats.do({ |pattern, index|

	OSCdef("cementClick%".format(index).asSymbol,{ |msg|
		var val = msg[1].asInteger;

		case
		{ val == 1 }{ pattern.play }
		{ val == 0 }{ pattern.stop }

	},"/cementClick/%".format(index).asSymbol)

});


// cementGrainer oscDefs








