///////////////////////////////////////////////// YAWN SynthDefs: lachrymator /////////////////////////////////////////////////

SynthDef(\mikeSampleGrains,{
	var cDur = ControlDur.ir;
	var bufnum = \bufnum.kr();
	var frames = BufFrames.kr(bufnum);
	var phase = Phasor.ar(0,BufRateScale.kr(bufnum) * \rate.kr(0.5).linexp(0,1,0.5,1.0).neg,\start.kr(0) * frames,\end.kr(1) * frames);
	var sig = BufRd.ar(2,bufnum,phase,1,4);
	var trig = HPZ1.ar(HPZ1.ar(phase).sign);

	sig = sig * Env([1,0,1],[cDur,cDur]).ar(gate:trig);           // consider delaying the sig by cDur so the Env happems at the right time?
	sig = (sig * \gain.kr(0).linlin(0,1,4,20)).tanh * -12.dbamp;
	sig = sig * Env.asr(\atk.kr(0.01),1,\rls.kr(0.01),\curve.kr(4)).ar(2,\gate.kr(1) + Impulse.kr(0));
	Out.ar(\verbBus.kr(),sig * \verbAmp.kr(0).linexp(0,1,0.001,1));
	Out.ar(\outBus.kr(),sig * \amp.kr(0).linexp(0,1,0.001,1) )
}).add;


/*
SynthDef(\percSines, {
	var rq = \rq.kr(0.5).linexp(0,1,0.005,1.0);
	var freq = \freq.kr(0.5).linexp(0,1,300,4800);
	var sig = SinOsc.ar(freq) * BrownNoise.ar(1!2).range(0,1);
	sig = RLPF.ar(sig,freq * 1.5, rq);
	sig = sig * Env.perc(\atk.kr(0.01),\rls.kr(6),1,\curve.kr(-4)).kr(2);
	sig = sig * -3.dbamp;
	Out.ar(\verbBus.kr(),sig * \verbAmp.kr(0));
	Out.ar(\out.kr(0),sig * \amp.kr(0) )
}).add;*/



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
	sig = Balance2.ar(sig[0],sig[1],-9.dbamp);
	Out.ar(\verbBus.kr(0),sig * \verbAmp.kr(0).linexp(0,1,0.001,1));
	Out.ar(\out.kr(0),sig * \amp.kr(0).linexp(0,1,0.001,1))
}).add;