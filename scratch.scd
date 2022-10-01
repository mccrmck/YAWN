
// double helix clicks
b = ClickConCat(2,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).out_(0).clickArray.collect(_.tempoArray / 2).flat
c = ClickConCat(2,ClickEnv([75,120],4,2),ClickEnv([120,145],4,2),ClickEnv([145,100],4,2),ClickEnv([100,75],4,2)).out_(1).clickArray.collect(_.tempoArray / 2).flat
[b,c].plot
d = Click(60/0.56836521053797,4,2,8)
e = b.duration
b.duration
d.duration

b.play

e = ClickConCat(2,ClickEnv([60/0.570625,120],4,2),ClickEnv([120,145],4,2),ClickEnv([145,100],4,2),ClickEnv([100,75],4,2))

Ppar([b.pattern,c.pattern]).play


Buffer


// export tempo map?
b = ClickConCat(2,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).clickArray.collect(_.tempoArray / 2).flat;
b.dopostln

~time = 0;
c = b.collect({ |tempo,index|
	var delta =  60 /tempo;
	var time = ~time;
	~time = ~time + delta;
	[time,tempo]
});

c.dopostln
c.last[0] + (60/c.last[1])

(
m = SimpleMIDIFile( "~/Desktop/midifiletest.mid" ).init(145);
m.timeMode = \seconds;  // change from default to something useful
)

c.do({ |subArr, index|
	var time = subArr[0];
	var tempo = subArr[1];

	m.addTempo(tempo,time)
})
m.adjustEndOfTrack(0,e)
m.write
m.metaEvents.dopostln;



// riff bank click
c = ['one','oneDan','two','twoDan','three','threeDan','four','fourDan'].collect({ |key,index|
	var beats = (index / 2).floor + 2;

	ClickCue(110,beats.asInteger,cueKey: key).pattern
})


OSCFunc.trace(fals)
// use this to laod the GUI when

OSCdef(\test,{|msg|


	n = NetAddr("127.0.0.1",8080);
	n.sendMsg("/clickUpdate","songs/cement/click.json")

},'/loaded')


// LACHRYMATOR impro -> Oskar's noiz

(
Ndef(\oskarNoise,{
	var sig, freq = \freq.kr(0).linexp(0,1,40,8000);
	var harms = (1..4);
	var mid = VarSaw.ar(freq * harms,harms.reciprocal.reverse,\width.kr(0.5),harms.reciprocal).sum;
	var side = PinkNoise.ar(1,\offset.kr(0).linlin(0,1,0,2)).clip2;
	mid = (mid * \midGain.kr(0).linlin(0,1,1,12)).tanh;

	side = HPF.ar( HPF.ar(side,90),90);
	side = ( side * \sideGain.kr(0).linlin(0,1,1,12) ).fold2;

	sig = MSMatrix.ar([mid * \midAmp.kr(0),side * \sideAmp.kr(1)]);
	sig = (sig * \gain.kr(0).linlin(0,1,1,12));

	sig = RHPF.ar(sig,\hpFreq.kr(0.0).linexp(0,1,20,8000),\hpQ.kr(0).linexp(0,1,1,0.01));
	sig = RLPF.ar(sig,\lpFreq.kr(0.9).linlin(0,1,40,20000),\lpQ.kr(0).linexp(0,1,1,0.01));

	sig = MidEQ.ar(sig,500,1,6);
	sig = LeakDC.ar(sig,0.9);
	sig = sig.tanh;
	sig = Balance2.ar(sig[0],sig[1],0,\amp.kr(0.25) * -9.dbamp);
});
)
OSCFunc.trace(false)

(
/* ================= */

['width','midGain','midAmp'].do({ |key,index|

	OSCdef("oskarMid%".format(index).asSymbol,{ |msg|

		Ndef(\oskarNoise).set(key,msg[1])

	},"/oskarNoiseMid/%".format(index).asSymbol)
});

['offset','sideGain','sideAmp'].do({ |key,index|

	OSCdef("oskarSides%".format(index).asSymbol,{ |msg|

		Ndef(\oskarNoise).set(key,msg[1])

	},"/oskarNoiseSides/%".format(index).asSymbol)
});

['gain','amp'].do({ |key,index|

	OSCdef("oskarMain%".format(index).asSymbol,{ |msg|

		Ndef(\oskarNoise).set(key,msg[1])

	},"/oskarNoiseMain/%".format(index).asSymbol);
});

/* ================= */

OSCdef(\oskarNoisePlay,{ |msg|

	if(msg[1] == 1,{ Ndef(\oskarNoise).play(out: YAWNShow.outDict['processOut']) },{ Ndef(\oskarNoise).stop });

},'/oskarNoisePlay');

OSCdef(\oskarFund,{ |msg|

	Ndef(\oskarNoise).set(\freq,msg[1])

},'/oskarNoiseFund');

OSCdef(\oskarXY,{ |msg|

	Ndef(\oskarNoise).set(\hpFreq,msg[1],\hpQ,msg[2],\lpFreq,msg[3],\lpQ,msg[4])

},'/oskarNoiseFreqQ');
)


// blast

c = ClickConCat(1,ClickCue(190,2,cueKey: 'four'),ClickCue(190,2,cueKey: 'two'),Click(190,4),Click(190),ClickRest(190),Click(190,2),Click(190))
c = ClickConCat(1,ClickCue(190,4,cueKey: 'three'),Click(190,3),Click(190))
c.play

// write an algorithm with a sort of background RM siren that grows and develops gradually

// chaos impro


// snareTop, overheads, torfinnGtr
(

// x/y pads -> onTouch launches synth, y is amp, x is pan

SynthDef(\repeater,{
	var sig = SoundIn.ar(\inBus.kr(0!2)); // make this stereo?
	sig = sig.sum * Env.sine(0.1).ar;
	sig = sig + LocalIn.ar(2);
	sig = DelayC.ar(sig,0.4,\delay.kr(0).linlin(0,1,0.01,0.4));
	sig = sig.clip2;
	LocalOut.ar(sig * \feedB.kr(0.1).linlin(0,1,0.9,1.4));
	sig = sig.tanh;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = Balance2.ar(sig[0],sig[1],\pan.kr(0).linlin(0,1,-0.3,0.3),\amp.kr(0.5));

	Out.ar(\outBus.kr(0),sig)
}).add;

SynthDef(\freeze,{
	var sig = SoundIn.ar(\inBus.kr(0!2)); // make this stereo?
	sig = FFT(LocalBuf(2048),sig.sum);
	sig = PV_Freeze(sig,1);
	sig = IFFT(sig);
	sig = RLPF.ar(sig,\freq.kr(0.5).linexp(0,1,250,8000),\rq.kr(0).linexp(0,1,1.0,0.01));
	sig = sig.tanh;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = Pan2.ar(sig,\pan.kr(0).linlin(0,1,-0.3,0.3),\amp.kr(0.5));
	Out.ar(\outBus.kr(0),sig)

}).add;
);

x = Synth(\repeater,[\inBus,[0,1],\pan,0 ])
x = Synth(\freeze,[\inBus,[0,1],\pan,0 ])
x.free

OSCFunc.trace(false)

(
/*
var ins = YAWNShow.inDict;
var outs = YAWNShow.outDict;
var busses = [
	[ins['snareTop'], ins['snareBot']],
	ins['overheads'],
	ins['torfinnGtr'],
];
*/
var synths = 0!6;

OSCdef(\chaosOnOff,{ |msg|
	var index = msg[1];
	var val = msg[2];

	if(val == 'start',{
		case
		{index < 3}{ synths[index] = Synth(\repeater,[\inBus,[2,2],\outBus,0] ) }
		// {index < 3}{ synths[index] = Synth(\repeater,[\inBus,busses[index % 3],\outBus,outs['processOut']] ) }
		// {index > 2}{ synths[index] = Synth(\freeze,[\inBus, busses[index % 3],\outBus,outs['processOut']] ) }
		{index > 2}{ synths[index] = Synth(\freeze,[\inBus,[2,2],\outBus,0] ) }
	},{
		case
		{index < 3}{ synths[index].set(\gate,0) }
		{index > 2}{ synths[index].set(\gate,0) }
	})

},'/chaos');


6.do({ |index|

	OSCdef("chaosCtrl%".format(index).asSymbol,{ |msg|
		var xVal = msg[1];
		var yVal = msg[2];

		case
		{index < 3}{ synths[index].set(\pan,0,\delay,xVal,\feedB,yVal) }
		{index > 2}{ synths[index].set(\pan,0,\freq,xVal,\rq,yVal) };

	},"/chaosXY/%".format(index).asSymbol);
})

)

s.plotTree


