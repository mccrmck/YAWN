
(
~riffs = PathName("/Users/mikemccormick/Dropbox/Mac/Downloads/bounceShort/").entries.collect({ |entry|
	Buffer.read(s,entry.fullPath)
})
)

(
Routine({

	inf.do{
		var bufnum = ~riffs.choose;
		var bufDur = bufnum.duration;
		{
			var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum));
			sig = sig * Env([0,1,1,0],[0.02,bufDur-0.04,0.02]).kr(2);
			sig
		}.play;
		bufDur.postln;
		bufDur.wait;
	}
}).play
)


Click(120,repeats: inf).play


// double helix clicks
b = ClickConCat(2,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2))
c = ClickConCat(2,ClickEnv([75,120],4,2),ClickEnv([120,145],4,2),ClickEnv([145,100],4,2),ClickEnv([100,75],4,2))
d = Click(60/0.570625,4,2,8)
b.duration
c.duration
d.duration

c.play


// riff bank click
c = ['one','oneDan','two','twoDan','three','threeDan','four','fourDan'].collect({ |key,index|
	var beats = (index / 2).floor + 2;

	ClickCue(110,beats.asInteger,cueKey: key).pattern
})


Prand(c,inf).play

// noiz

Ndef(\emptySet,{
	var varT = \lagTime.kr(0);
	var varC = \lagCurve.kr(0);
	var sig, freq = \freq.kr(40);
	var harms = (1..4);
	var mid = VarSaw.ar(freq * harms,harms.reciprocal.reverse,\width.kr(0.5).varlag(varT,varC),harms.reciprocal).sum;
	var side = PinkNoise.ar(1,\offset.kr(0).varlag(varT,varC)).clip2;
	mid = (mid * \midGain.kr(0.5).varlag(varT,varC)).tanh;

	side = LeakDC.ar( HPF.ar( HPF.ar(side,90),90) ) ;
	side = (side * \sideGain.kr(4).varlag(varT,varC)).fold2;

	sig = MSMatrix.ar([mid * \midAmp.kr(1).varlag(varT,varC),side * \sideAmp.kr(1).varlag(varT,varC)]);
	sig = (sig * \gain.kr(4).varlag(varT,varC));

	sig = RHPF.ar(sig,\hpFreq.kr(80).varlag(varT,varC).clip(20,20000),\hpQ.kr(0.1).varlag(varT,varC));
	sig = RLPF.ar(sig,\lpFreq.kr(8000).varlag(varT,varC).clip(20,20000),\lpQ.kr(1).varlag(varT,varC));

	sig = MidEQ.ar(sig,500,1,6);
	sig = sig.tanh;
	sig = Balance2.ar(sig[0],sig[1],\pan.kr(0),\amp.kr(0.25) * -18.dbamp);
}).play;

OSCFunc.trace(false)

OSCdef(\test,{ |msg|
	var vals = msg[1..];

	Ndef(\emptySet).set(
		// 0
		\freq,vals[0].linexp(0,1,40,2000),
		\width,vals[1],
		// 1
		\offset,vals[2].linexp(0,1,0,2),
		\midGain,vals[3].linexp(0,1,1,12),
		// 2
		\sideGain,vals[4].linexp(0,1,1,12),
		\midAmp,vals[5].linexp(0,1,0,1),
		// 3
		\sideAmp,vals[6].linexp(0,1,0,1),
		\gain,vals[7].linexp(0,1,1,12),
		// 4
		\hpFreq,vals[8].linexp(0,1,40,8000),
		\hpQ,vals[9],
		// 5
		\lpFreq,vals[10].linexp(0,1,40,16000),
		\lpQ,vals[11],

	)

},'/yawnNoiseTest')


Ndef(\emptySet).clear
Ndef(\emptySet).set(\lagTime,4,\lagCurve,4)

