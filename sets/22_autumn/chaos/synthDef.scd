///////////////////////////////////////////////// YAWN SynthDefs: chaos /////////////////////////////////////////////////

SynthDef(\repeater,{
	var sig = SoundIn.ar(\inBus.kr(0!2)); // make this stereo?
	sig = sig.sum * Env.sine(0.1).ar;
	sig = sig + LocalIn.ar(2);
	sig = DelayC.ar(sig,0.4,\delay.kr(0).linlin(0,1,0.01,0.4));
	sig = sig.clip2;
	LocalOut.ar(sig * \feedB.kr(0.1).linlin(0,1,0.9,1.4));
	sig = sig.tanh * -18.dbamp;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = Balance2.ar(sig[0],sig[1],\pan.kr(0).linlin(0,1,-0.3,0.3),\amp.kr(0.5));
	Out.ar(\outBus.kr(0),sig)
}).add;

SynthDef(\freeze,{
	var sig = SoundIn.ar(\inBus.kr(0!2)); // make this stereo?
	sig = (sig * 12.dbamp).tanh;
	sig = FFT(LocalBuf(2048),sig.sum);
	sig = PV_Freeze(sig,1);
	sig = PV_BrickWall(sig,\wipe.kr(0).linlin(0,1,-1,-0.001));
	sig = IFFT(sig);
	sig = sig.tanh * -12.dbamp;
	sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
	sig = Pan2.ar(sig,\pan.kr(0).linlin(0,1,-0.3,0.3),\amp.kr(0.5));
	Out.ar(\outBus.kr(0),sig)
}).add;

