///////////////////////////////////////////////// YAWN OSC: cement /////////////////////////////////////////////////

var grainBuf = YAWNShow.set.songs[2].pbTracks['impro'][0];

var clickPats = [
	YAWNShow.set.songs[2].cueFrom('cementCount','cementBsection',true,true,true,true,true).stop,
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

OSCFunc.trace

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
		Ndef(\mikeNoiseSynth,\cementGrainer).set(\bufnum,grainBuf).play(out:YAWNShow.outDict['processOut']) // set verb bus and shit
	},{
		Ndef(\mikeNoiseSynth).stop
	});

},'mikeNoisePlay');

['jitter','posRate','rate','verbAmp','amp'].do({ |key,index|

	OSCdef("mikeFaders%".format(index).asSymbol,{ |msg|

		Ndef(\mikeNoiseSynth).set(key,msg[1])

	},"/mikeNoiseVertFaders/%".format(index).asSymbol)
});

['trigRateOsc','\trigFreqDev','rateOsc','rateDev'].do({ |key,index|

	OSCdef("mikeFaders%".format(index).asSymbol,{ |msg|

		Ndef(\mikeNoiseSynth).set(key,msg[1])

	},"/mikeNoiseHoriFaders/%".format(index).asSymbol)
});
