///////////////////////////////////////////////// YAWN SynthDefs: numberOne /////////////////////////////////////////////////
(
SynthDef(\fftFreeze,{
	var frames = 2048;
	var sig = In.ar(\inBus.kr,1);
	var trig = \trig.kr;
	sig = FFT(LocalBuf(frames),sig);
	sig = PV_Freeze(sig,trig);
	sig = IFFT(sig);
	sig = Pan2.ar(sig * trig,TRand.kr(-1.0,1.0,trig),\amp.kr(1));
	Out.ar(\outBus.kr,sig);
}).add;

SynthDef(\brokenRecord,{
	var sig = In.ar(\inBus.kr,1);
	var trig = \trig.kr;
	var gate = Env.sine(0.2).kr(gate:trig);
	var rand = TRand.kr(0.01,0.6,trig);                 // consider making this a TChoose w/ an array of times that fit the tempo
	sig = CombC.ar(sig * gate,0.6,rand,Select.kr(trig,[0,inf]));
	sig = Pan2.ar(sig,TRand.kr(-1.0,1.0,trig),\amp.kr(1));
	Out.ar(\outBus.kr,sig);
}).add;

// this sucker needs to change - the whole intro needs to be something different, in fact....
// but at the very least, this should be some sort of looping PlayBuf with a variable windowSize and startPos
SynthDef(\grainz,{
	var bufnum = \bufnum.kr;
	var jitter = \jitter.kr(1).linlin(0,1,0,0.01);
	var trig = Impulse.kr(\trigRate.kr(1));
	var bufDur = BufDur.kr(bufnum);
	var pos = Phasor.ar(0, BufRateScale.kr(bufnum) * \posRate.kr(1) * SampleDur.ir, \start.kr(0) * bufDur, \end.kr(1) * bufDur) + TRand.kr(jitter.neg,jitter,trig);

	var width = \width.kr(1);
	var pan = Demand.kr(trig,0,Drand([width.neg,width],inf));
	var sig = TGrains.ar(2,trig,bufnum,\rate.kr(1),pos.wrap(0,bufDur),\grainDur.kr(0.1),pan,\amp.kr(1));

	sig = Limiter.ar(sig);
	Out.ar(\outBus.kr,sig);
}).add;

SynthDef(\shiftReg,{
	var sr = SampleDur.ir * \sampleRate.kr(1).linlin(0,1,1,12);  // can this be extended?
	var n = \bits.kr(1).linlin(0,1,12,24); // bit resolution... can this be extended?
	var t = Phasor.ar(1,\freq.kr(1).linlin(0,1,0,8) * ((2**n)/sr),0,((2**n)-1));  // expand control range?
	var env = Env.asr(releaseTime: 0.01).kr(2,\gate.kr(1));

	t = Select.ar(\counter.kr(0).linlin(0,1,0,6),[   // consider SelectX for maximum chaos! :)

		t*(((t>>64)|(t>>8))&(63&(t>>4))),
		t*(((t>>9)|(t>>13))&(25&(t>>6))),
		t*(((t>>5)|(t>>8)) & 63),
		t*(((t>>11)&(t>>8))&(123&(t>>3))),
		t*(t>>8*((t>>15)|(t>>8))&(20|(t>>19)*5>>t|(t>>3))),
		t*(t>>((t>>9)|(t>>8))&(63&(t>>4))),
		(t>>7|t|t>>6)*10+4*(t&t>>13|t>>6)
	]);

	t = t % (2**(n)); // avoiding number beyond 2**(bit resolution)
	t = t * (0.5**(n-1)) - 1; // scaling to -1, 1
	t = LeakDC.ar(t);
	t = Pan2.ar(t * env,0,\amp.kr(0.3));
	Out.ar(\outBus.kr,t);
}).add;

)