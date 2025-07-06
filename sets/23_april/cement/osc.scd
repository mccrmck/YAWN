///////////////////////////////////////////////// YAWN OSC: cement /////////////////////////////////////////////////

var grainBuf = YAWNShow.set.songs[2].pbTracks['impro'][0];
var grainWin = Buffer.sendCollection(Server.default, Env.perc(0.01,0.99,1,-4).discretize);
var middleBuf = YAWNShow.set.songs[2].pbTracks['voice'][0];


// new args, added for eksamenskonsert
var server = Server.default;
var folder = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/LisaColetteBysheim/neural/models/";
var numArgs = 33;
var inDataSet = FluidDataSet(server);
var outDataSet = FluidDataSet(server);
var inValsBuf = Buffer.alloc(server,2);
var outValsBuf = Buffer.loadCollection(server,{rrand(0.0,1.0)} ! numArgs);
var nn = PathName(folder).entries.collect({ |file,index|
	var mlp = FluidMLPRegressor(server,);
	mlp.read(file.fullPath);
});
var mlpIndex = 0;
var macroXY = [0,0];
var microXY = [0,0];
var xyOffset = [0,0];
var gui = NetAddr("localhost",8080);
var ampBus = Bus.control(server,1);
var verbAmpBus = Bus.control(server,1);
var synth;

//

var clickPats = [
	Pdef(\cementOpener,
		Ppar([
			YAWNPlayback.makeStereoPat(middleBuf, YAWNShow.outDict['processOut'],10.dbamp),
			Pseq([
				ClickRest(60,(middleBuf.duration - 3.8) ).pattern, // this is the duration of the cement count in
				YAWNShow.set.songs[2].cueFrom('cementCount','cementBsection',true,true,true,true,true).stop,
			])
		]),
	).stop,
	// Mike Støy Solo
	Pdef(\blastPlusCement,
		Pseq([
			YAWNShow.set.songs[0].cueFrom('blastA00','blastC12',true,true,true,true,true).stop,
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

OSCdef(\mikeNoiseGdurTfreq,{ |msg|
	var grainDur = msg[1];
	var trigFreq = msg[2];

	Ndef(\mikeNoiseSynth).set(\grainDur,grainDur,\trigFreq,trigFreq)

},'mikeNoiseGdurTfreq');

OSCdef(\mikeNoiseMute,{ |msg|

	if(msg[1] == 1,{
		Ndef(\mikeNoiseSynth).set(\mute,1)
	},{
		Ndef(\mikeNoiseSynth).set(\mute,0)
	});

},'mikeNoiseMute');

OSCdef(\mikeNoiseTrig,{ |msg|

	Ndef(\mikeNoiseSynth).set(\trig,1)

},'mikeNoiseTrig');

OSCdef(\mikeNoiseBufRange,{ |msg|
	var start = msg[1];
	var end = msg[2];

	Ndef(\mikeNoiseSynth).set(\start,start,\end,end)

},'mikeNoiseBufRange');

OSCdef(\mikeNoiseSrateBits,{ |msg|
	var sRate = msg[1];
	var bits = msg[2];

	Ndef(\mikeNoiseSynth).set(\sRate,sRate,\bits,bits)

},'mikeNoiseSrateBits');

// second "column"

OSCdef(\mikeNoisePlay,{ |msg|

	if(msg[1] == 1,{
		fork{
			Ndef(\mikeNoiseSynth,\cementGrainer)
			.set(\bufnum,grainBuf,\window,grainWin,\verbBus,YAWNShow.verbBus)
			.play(out:YAWNShow.outDict['processOut']);
			0.1.wait;
			Ndef(\mikeNoiseSynth).group.moveToHead(YAWNShow.headGroup)
		}
	},{
		Ndef(\mikeNoiseSynth).end
	});

},'mikeNoisePlay');

['jitter','posRate','rate','verbAmp','gain','amp'].do({ |key,index|

	OSCdef("mikeNoiseVertFaders%".format(index).asSymbol,{ |msg|

		Ndef(\mikeNoiseSynth).set(key,msg[1])

	},"/mikeNoiseVertFaders/%".format(index).asSymbol)
});

['trigRateOsc','trigFreqDev','rateOsc','rateDev'].do({ |key,index|

	OSCdef("mikeNoiseHoriFaders%".format(index).asSymbol,{ |msg|

		Ndef(\mikeNoiseSynth).set(key,msg[1])

	},"/mikeNoiseHoriFaders/%".format(index).asSymbol)
});

// neuralNet Synth

OSCdef(\sliders,{ |msg|
	var val = msg[1..];
	outValsBuf.setn(0,val);

},'/sliders');

OSCdef(\mlpSwitch,{ |msg|
	var val = msg[1];
	mlpIndex = val;
	nn[mlpIndex].predictPoint(inValsBuf,outValsBuf,{

		outValsBuf.getn(0,numArgs,{ |bufVals|
			gui.sendMsg("/sliders",*bufVals)
		});
	});
},'/mlpSwitch');

OSCdef(\xy0,{ |msg|
	var vals;
	var x = msg[1];
	var y = msg[2];

	macroXY = [x,y];
	vals = macroXY + xyOffset;

	inValsBuf.setn(0,vals);
	nn[mlpIndex].predictPoint(inValsBuf,outValsBuf,{

		outValsBuf.getn(0,numArgs,{ |bufVals|
			gui.sendMsg("/sliders",*bufVals)
		});
	});

},'/xy0');

OSCdef(\xy1,{ |msg|
	var vals;
	var x = msg[1];
	var y = msg[2];
	var newCoords = [x,y] / 25;

	xyOffset = newCoords - microXY;
	vals = macroXY + xyOffset;
	inValsBuf.setn(0,vals);
	nn[mlpIndex].predictPoint(inValsBuf,outValsBuf,{

		outValsBuf.getn(0,numArgs,{ |bufVals|
			gui.sendMsg("/sliders",*bufVals)
		});
	});

},'/xy1');

OSCdef(\nnSynthOn,{ |msg|
	var val = msg[1].asInteger;

	case
	{val == 0}{synth.set(\gate,0)}
	{val == 1}{
		synth = Synth(\cementNoise,[\bufnum,outValsBuf,\verbBus,YAWNShow.verbBus,\out,YAWNShow.outDict['processOut']],YAWNShow.headGroup)
		.map(\amp,ampBus,\verbAmp,verbAmpBus);
		gui.sendMsg("/numArgs",numArgs);
		gui.sendMsg("/mlpArray",*(0..(nn.size-1)));
	}

},'/noiseOnOff');

2.do({ |i|
	OSCdef("/nnSynthFaders/%".format(i),{ |msg|
		var val = msg[1];

		[verbAmpBus,ampBus][i].set(val);

	},"/noiseFaders/%".format(i))

});





