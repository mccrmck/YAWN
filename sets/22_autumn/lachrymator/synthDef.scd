///////////////////////////////////////////////// YAWN SynthDefs: lachrymator /////////////////////////////////////////////////

SynthDef(\oskarNoise,{
	var sig, freq = \freq.kr(0).linexp(0,1,40,400);
	var harms = (1..4);
	var mid = VarSaw.ar(freq * harms,harms.reciprocal.reverse,\width.kr(0),harms.reciprocal).sum;
	var side = PinkNoise.ar(1,\offset.kr(0).linlin(0,1,0,2)).clip2;
	mid = (mid * \midGain.kr(0).linlin(0,1,1,12)).tanh;

	side = HPF.ar( HPF.ar(side,90),90);
	side = ( side * \sideGain.kr(0).linlin(0,1,1,12) ).fold2;

	sig = MSMatrix.ar([mid * \midAmp.kr(0),side * \sideAmp.kr(0)]);
	sig = (sig * \gain.kr(0).linlin(0,1,1,12));

	sig = RHPF.ar(sig,\hpFreq.kr(0).linexp(0,1,20,8000),\hpQ.kr(0).linexp(0,1,1,0.01));
	sig = RLPF.ar(sig,\lpFreq.kr(1).linexp(0,1,40,20000),\lpQ.kr(0).linexp(0,1,1,0.01));

	sig = MidEQ.ar(sig,500,1,6);
	sig = LeakDC.ar(sig,0.9);
	sig = sig.tanh;
	sig = Balance2.ar(sig[0],sig[1],0,\amp.kr(0) * -9.dbamp);
	Out.ar(\out.kr(0),sig)
}).add;