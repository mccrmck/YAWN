///////////////////////////////////////////////// YAWN OSC: cement /////////////////////////////////////////////////

var grainBuf = YAWNShow.set.songs[2].pbTracks['impro'][0];
var grainWin = Buffer.sendCollection(Server.default, Env.perc(0.01,0.99,1,-4).discretize);
var middleBuf = YAWNShow.set.songs[2].pbTracks['voice'][0];

var clickPats = [
	Pdef(\cementOpener,
		Ppar([
			YAWNPlayback.makeStereoPat(middleBuf, YAWNShow.outDict['processOut']),
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



