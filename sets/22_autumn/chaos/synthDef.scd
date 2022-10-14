///////////////////////////////////////////////// YAWN SynthDefs: chaos /////////////////////////////////////////////////

SynthDef(\repeater,{
	var sig = SoundIn.ar(\inBus.kr(0!2)); // make this stereo?
	sig = sig.sum * Env.sine(0.1).ar;
	sig = sig + LocalIn.ar(2);
	sig = DelayC.ar(sig,0.4,\delay.kr(0).linlin(0,1,0.01,0.4));
	sig = sig.clip2;
	LocalOut.ar(sig * \feedB.kr(0.1).linlin(0,1,0.95,1.4));
	sig = sig.tanh * -12.dbamp;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = Balance2.ar(sig[0],sig[1],\pan.kr(0).linlin(0,1,-0.3,0.3),\amp.kr(0.5));
	Out.ar(\outBus.kr(0),sig)
}).add;

SynthDef(\freeze,{
	var sig = SoundIn.ar(\inBus.kr(0!2)); // make this stereo?
	sig = (sig * 12.dbamp).tanh;
	sig = FFT(LocalBuf(4096),sig.sum);
	sig = PV_Freeze(sig,1);
	sig = PV_BrickWall(sig,\wipe.kr(0).linlin(0,1,-1,-0.001));
	sig = IFFT(sig);
	sig = sig.tanh * -3.dbamp;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = Pan2.ar(sig,\pan.kr(0).linlin(0,1,-0.3,0.3),\amp.kr(0.5));
	Out.ar(\outBus.kr(0),sig)
}).add;

SynthDef(\noiseFilt,{
	var sig = BrownNoise.ar(1!2);
	sig = RLPF.ar(sig,\lpFreq.kr(0).linexp(0,1,100,8000),\lpQ.kr(0).linlin(0,1,1,0.01));
	sig = (sig + 1).wrap2;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = LeakDC.ar(sig) * -18.dbamp;
	sig = Balance2.ar(sig[0],sig[1],\pan.kr(0),\amp.kr(1));
	Out.ar(\outBus.kr(0),sig);
}).add;

SynthDef(\lfNoise,{
	var sig = LFDNoise0.ar(\freq.kr(440).linexp(0,1,4,4000)!2);
	sig = CombC.ar(sig,0.2,\combFreq.kr(40).linexp(0,1,80,4000).reciprocal,1).fold2;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = LeakDC.ar(sig) * -15.dbamp;
	sig = Balance2.ar(sig[0],sig[1],\pan.kr(0),\amp.kr(1));
	Out.ar(\outBus.kr(0),sig);
}).add;
