///////////////////////////////////////////////// YAWN GUI: 23_april /////////////////////////////////////////////////

var local = NetAddr("127.0.0.1",8080);

OSCdef(\loadGUI,{ |msg|

	if(msg[1],{
		local.sendMsg("/setList","23_april/setList.json");
		local.sendMsg("/clickUpdate","23_april/chaos/click.json");
		local.sendMsg("/mikeUpdate","23_april/chaos/impro.json");
		local.sendMsg("/oskarUpdate","23_april/lachrymator/oskarNoise.json")

	},{
		"GUI failed to load".postln
	})

},'/yawnLoaded');

OSCdef(\setList,{ |msg|
	var index = msg[1].asInteger;

	case
	{ index == 0 }{
		local.sendMsg("/clickUpdate","23_april/chaos/click.json");
		local.sendMsg("/mikeUpdate","23_april/chaos/impro.json");
		local.sendMsg("/oskarUpdate","23_april/lachrymator/oskarNoise.json");
	}
	{ index == 1 }{
		local.sendMsg("/clickUpdate","23_april/lachrymator/click.json");
		local.sendMsg("/mikeUpdate","23_april/lachrymator/sampler.json");
		local.sendMsg("/oskarUpdate","23_april/lachrymator/oskarNoise.json");
	}
	{ index == 2 }{
		local.sendMsg("/clickUpdate","23_april/cafeSara/click.json");
		local.sendMsg("/mikeUpdate","23_april/cafeSara/improSynth.json");
		local.sendMsg("/oskarUpdate","23_april/cafeSara/improSynth.json");
	}
	{ index == 3 }{
		local.sendMsg("/clickUpdate","23_april/cement/click.json");
		local.sendMsg("/mikeUpdate","23_april/cement/mikeNoise0.json");                 // here
		local.sendMsg("/oskarUpdate","23_april/lachrymator/oskarNoise.json");
	}
	{ index == 4 }{
		local.sendMsg("/clickUpdate","23_april/tokamak/click.json");
		local.sendMsg("/mikeUpdate","23_april/cement/mikeNoise.json");
		local.sendMsg("/oskarUpdate","23_april/lachrymator/oskarNoise.json");
	}
},'/23_april');