///////////////////////////////////////////////// YAWN OSC: lachrymator /////////////////////////////////////////////////

var clickPats = [
	Pdef(\blastPlusLachrymator,
		Pseq([
			YAWNShow.set.songs[0].cueFrom('blastA05','blastA08',true,true,true,false,true).stop,
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

//granular sample playback, or something else?








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

['gain','amp'].do({ |key,index|

	OSCdef("oskarMain%".format(index).asSymbol,{ |msg|

		Ndef(\oskarSynth).set(key,msg[1])

	},"/oskarNoiseMain/%".format(index).asSymbol);
});

OSCdef(\oskarNoisePlay,{ |msg|

	if(msg[1] == 1,{
		Ndef(\oskarSynth,\oskarNoise).play(out:YAWNShow.outDict['processOut'])
	},{
		Ndef(\oskarSynth).stop
	});

},'/oskarNoisePlay');

OSCdef(\oskarFund,{ |msg|

	Ndef(\oskarSynth).set(\freq,msg[1])

},'/oskarNoiseFund');

OSCdef(\oskarXY,{ |msg|

	Ndef(\oskarSynth).set(\hpFreq,msg[1],\hpQ,msg[2],\lpFreq,msg[3],\lpQ,msg[4])

},'/oskarNoiseFreqQ');