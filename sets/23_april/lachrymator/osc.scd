///////////////////////////////////////////////// YAWN OSC: lachrymator /////////////////////////////////////////////////

var samples = YAWNShow.set.songs[4].pbTracks['impro'];
var bufSynths = 0!6;
var synthBus = Bus.control(Server.default,2);

var clickPats = [
	Pdef(\blastPlusLachrymator,
		Pseq([
			YAWNShow.set.songs[0].cueFrom('blastA05','blastA08',true,true,true,true,true).stop,
			YAWNShow.set.songs[4].cueFrom('lachCountPart1','lachAsection',true,true,true,true,true).stop
		])
	).stop,
	YAWNShow.set.songs[4].cueFrom('lachTapping','lachJazzBsectionAgain',true,true,true,true,false).stop,
	YAWNShow.set.songs[4].cueFrom('lachCountPart3','lachOutro',true,true,true,true,false).stop,
];

clickPats.do({ |pattern, index|

	OSCdef("lachrymatorClick%".format(index).asSymbol,{ |msg|
		var val = msg[1].asInteger;

		case
		{ val == 1 }{ pattern.play }
		{ val == 0 }{ pattern.stop }

	},"/lachrymatorClick/%".format(index).asSymbol)

});

// mike's instrument

OSCdef(\lachrymatorSampleTouch,{ |msg|
	var index = msg[1];
	var type = msg[2];
	var value = msg[3].asString.interpret;
	var xVal = value[0];
	var yVal = value[1];


	if(type == 'start',{
		bufSynths[index] = Synth(\mikeSampleGrains,[
			\bufnum,samples[index],
			\start,xVal,
			\end,yVal,
			\verbBus,YAWNShow.verbBus,
			\outBus,YAWNShow.outDict['processOut']
		])
		.map(\verbAmp,synthBus.subBus(0),\amp,synthBus.subBus(1))
	},{
		bufSynths[index].set(\gate,0)
	})

},'/lachrymatorSampleTouch');



6.do({ |index|

	OSCdef("lachrymatorSamplerXY%".format(index).asSymbol,{ |msg|
		var xVal = msg[1];
		var yVal = msg[2];

		bufSynths[index].set(\rate,xVal,\gain,yVal)

	},"/lachrymatorSampler/%".format(index).asSymbol);
});

[ 'verbAmp','amp'].do({ |key,index|

	OSCdef("lachrymatorSamplerVerbAmp%".format(key).asSymbol,{ |msg|

		synthBus.subBus(index).set(msg[1])

	},"/lachrymatorSamplerVerbAmp/%".format(index).asSymbol);
});

// oskar's instrument

['width','midGain','midAmp'].do({ |key,index|

	OSCdef("oskarMid%".format(index).asSymbol,{ |msg|

		Ndef(\oskarSynth).set(key,msg[1])

	},"/oskarNoiseMid/%".format(index).asSymbol)
});

['offset','sideGain','sideAmp'].do({ |key,index|

	OSCdef("oskarSides%".format(index).asSymbol,{ |msg|

		Ndef(\oskarSynth).set(key,msg[1])

	},"/oskarNoiseSides/%".format(index).asSymbol)
});

[ 'gain','verbAmp','amp'].do({ |key,index|

	OSCdef("oskarMain%".format(index).asSymbol,{ |msg|

		Ndef(\oskarSynth).set(key,msg[1])

	},"/oskarNoiseMain/%".format(index).asSymbol);
});

OSCdef(\oskarNoisePlay,{ |msg|

	if(msg[1] == 1,{
		fork{
			Ndef(\oskarSynth,\oskarNoise)
			.set(\verbBus,YAWNShow.verbBus)
			.play(out:YAWNShow.outDict['oskarSynthOut']);
			0.1.wait;
			Ndef(\oskarSynth).group.moveToHead(YAWNShow.headGroup)
		}
	},{
		Ndef(\oskarSynth).end
	});

},'/oskarNoisePlay');

OSCdef(\oskarFund,{ |msg|

	Ndef(\oskarSynth).set(\freq,msg[1])

},'/oskarNoiseFund');

OSCdef(\oskarXY,{ |msg|

	Ndef(\oskarSynth).set(\hpFreq,msg[1],\hpQ,msg[2],\lpFreq,msg[3],\lpQ,msg[4])

},'/oskarNoiseFreqQ');