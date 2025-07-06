///////////////////////////////////////////////// YAWN SynthDefs: chaos /////////////////////////////////////////////////

SynthDef(\repeater,{
	var sig = SoundIn.ar(\inBus.kr(0!2));
	sig = sig.sum * Env.sine(0.1).ar;
	sig = sig + LocalIn.ar(2);
	sig = DelayC.ar(sig,0.2,\delay.kr(0).linexp(0,1,0.01,0.15));
	sig = sig.fold2;
	LocalOut.ar(sig * \feedB.kr(0.1).linlin(0,1,0.99,1.4));                              // consider inverting the feedback coefficient?
	sig = sig.tanh * -10.dbamp;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = Balance2.ar(sig[0],sig[1],\pan.kr(0).linlin(0,1,-0.3,0.3), \amp.kr(0.5));
	Out.ar(\outBus.kr(0),sig)
}).add;

SynthDef(\freeze,{
	var sig = SoundIn.ar(\inBus.kr(0!2)); // make this stereo?
	sig = (sig * 12.dbamp).tanh;
	sig = FFT(LocalBuf(4096),sig.sum);
	sig = PV_Freeze(sig,1);
	sig = IFFT(sig);
	sig = RLPF.ar(sig,\freq.kr(0).linexp(0,1,100,8000),\rq.kr(0).linlin(0,1,1,0.01),\rq.kr(0).linlin(0,1,1,4));
	sig = sig.tanh * -4.dbamp * \rq.kr(0).linlin(0,1,1,0.5);
	sig = BHiShelf.ar(sig,6000,1,-3);
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = Pan2.ar(sig,\pan.kr(0).linlin(0,1,-0.3,0.3),\amp.kr(0.5));
	Out.ar(\outBus.kr(0),sig)
}).add;

//

SynthDef(\noiseFilt,{
	var sig = BrownNoise.ar(1!2);
	sig = RLPF.ar(sig,\lpFreq.kr(0).linexp(0,1,100,8000),\lpQ.kr(0).linlin(0,1,1,0.01),\lpQ.kr(0).linlin(0,1,1,4));
	sig = sig.tanh;
	sig = (sig + 0.4).wrap2;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = LeakDC.ar(sig) * -14.dbamp;
	sig = Rotate2.ar(sig[0],sig[1],\pan.kr(0)) * \amp.kr(1);
	Out.ar(\outBus.kr(0),sig);
}).add;

SynthDef(\lfNoise,{
	var sig = LFNoise0.ar(\freq.kr(440).linexp(0,1,8,8000)!2);
	sig = CombC.ar(sig,0.2,\combFreq.kr(40,0.2).linexp(0,1,40,4000).reciprocal,Rand(0.1,10)).fold2;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = LeakDC.ar(sig) * -15.dbamp;
	sig = Rotate2.ar(sig[0],sig[1],\pan.kr(0)) * \amp.kr(1);
	Out.ar(\outBus.kr(0),sig);
}).add;
