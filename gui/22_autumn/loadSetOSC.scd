///////////////////////////////////////////////// YAWN GUI: 22_autumn /////////////////////////////////////////////////

var local = NetAddr("127.0.0.1",8080);

OSCdef(\loadGUI,{ |msg|

	if(msg[1],{
		local.sendMsg("/setList","22_autumn/setList.json");
		local.sendMsg("/clickUpdate","22_autumn/chaos/click.json");
		local.sendMsg("/mikeUpdate","22_autumn/chaos/impro.json");
		local.sendMsg("/oskarUpdate","22_autumn/lachrymator/oskarNoise.json")

	},{
		"GUI failed to load".postln
	})

},'/yawnLoaded');

OSCdef(\setList,{ |msg|
	var index = msg[1].asInteger;

	case
	{ index == 0 }{
		local.sendMsg("/clickUpdate","22_autumn/chaos/click.json");
		local.sendMsg("/mikeUpdate","22_autumn/chaos/impro.json");
		local.sendMsg("/oskarUpdate","22_autumn/lachrymator/oskarNoise.json");
	}
	{ index == 1 }{
		local.sendMsg("/clickUpdate","22_autumn/lachrymator/click.json");
		local.sendMsg("/mikeUpdate","22_autumn/lachrymator/main.json");
		local.sendMsg("/oskarUpdate","22_autumn/lachrymator/oskarNoise.json");
	}
	{ index == 2 }{
		local.sendMsg("/clickUpdate","22_autumn/cafeSara/click.json");
		local.sendMsg("/mikeUpdate","22_autumn/cafeSara/improSynth.json");
		local.sendMsg("/oskarUpdate","22_autumn/cafeSara/improSynth.json");
	}
	{ index == 3 }{
		local.sendMsg("/clickUpdate","22_autumn/cement/click.json");
		local.sendMsg("/mikeUpdate","22_autumn/cement/mikeNoise.json");
		local.sendMsg("/oskarUpdate","22_autumn/lachrymator/oskarNoise.json");
	}
	{ index == 4 }{
		local.sendMsg("/clickUpdate","22_autumn/tokamak/click.json");
		local.sendMsg("/mikeUpdate","22_autumn/cement/mikeNoise.json");
		local.sendMsg("/oskarUpdate","22_autumn/lachrymator/oskarNoise.json");
	}
},'/22_autumn');