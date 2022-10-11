

SynthDef(\cafeSaraPads,{
	var freq = \freq.kr(440);
	var root = SinOsc.ar(freq,mul: \rootGain.kr(1).linlin(0,1,1,8)).tanh;
	var sig = SinOsc.ar(freq * (2..8), mul: \sigGain.kr(0)).tanh;

	sig = Splay.ar(sig);
	sig = sig + root;
	sig = HPFSides.ar(sig,180);
	sig = sig * Env.asr(\atk.kr(4),1,\rls.kr(4),\curve.kr(4)).ar(2,\gate.kr(0));
	Out.ar(\outBus.kr(0),sig)
}).add;