///////////////////////////////////////////////// YAWN SynthDefs: chaos /////////////////////////////////////////////////

SynthDef(\repeater,{
	var sig = SoundIn.ar(\inBus.kr(0!2));
	sig = sig.sum * Env.sine(0.1).ar;
	sig = sig + LocalIn.ar(2);
	sig = DelayC.ar(sig,0.2,\delay.kr(0).linexp(0,1,0.01,0.2));
	sig = sig.clip2;
	LocalOut.ar(sig * \feedB.kr(0.1).linlin(0,1,0.99,1.4));                              // consider inverting the feedback coefficient?
	sig = sig.tanh * -12.dbamp;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = Rotate2.ar(sig[0],sig[1],\pan.kr(0).linlin(0,1,-0.3,0.3)) * \amp.kr(0.5);
	Out.ar(\outBus.kr(0),sig)
}).add;

SynthDef(\freeze,{
	var sig = SoundIn.ar(\inBus.kr(0!2)); // make this stereo?
	sig = (sig * 12.dbamp).tanh;
	sig = FFT(LocalBuf(1024),sig.sum);
	sig = PV_Freeze(sig,1);
	sig = IFFT(sig);
	sig = BPF.ar(sig,\freq.kr(0).linexp(0,1,200,10000),\rq.kr(0).linlin(0,1,1,0.01));
	sig = sig.tanh * -4.dbamp;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = Pan2.ar(sig,\pan.kr(0).linlin(0,1,-0.3,0.3),\amp.kr(0.5));
	Out.ar(\outBus.kr(0),sig)
}).add;

//

SynthDef(\noiseFilt,{
	var sig = BrownNoise.ar(1!2);
	sig = RLPF.ar(sig,\lpFreq.kr(0).linexp(0,1,100,8000),\lpQ.kr(0).linlin(0,1,1,0.01));
	sig = (sig + 1).wrap2;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = LeakDC.ar(sig) * -16.dbamp;
	sig = Rotate2.ar(sig[0],sig[1],\pan.kr(0)) * \amp.kr(1);
	Out.ar(\outBus.kr(0),sig);
}).add;

SynthDef(\lfNoise,{
	var sig = LFDNoise0.ar(\freq.kr(440).linexp(0,1,4,4000)!2);
	sig = CombC.ar(sig,0.2,\combFreq.kr(40).linexp(0,1,80,4000).reciprocal,1).fold2;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = LeakDC.ar(sig) * -15.dbamp;
	sig = Rotate2.ar(sig[0],sig[1],\pan.kr(0)) * \amp.kr(1);
	Out.ar(\outBus.kr(0),sig);
}).add;
