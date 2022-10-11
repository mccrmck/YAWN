///////////////////////////////////////////////// YAWN SynthDefs: cafeSara /////////////////////////////////////////////////

SynthDef(\cafeSaraPads,{
	var freq = \freq.kr(440);
	var harms = \harms.kr(1!6);
	var root = SinOsc.ar(freq * [0.5,1],mul: \rootGain.kr(0).linlin(0,1,1,8)).sum.tanh;
	var sig = SinOsc.ar(harms, mul: \sigGain.kr(0).linlin(0,1,1,8)).tanh;

	sig = sig.scramble * LFNoise2.ar(0.8!harms.size).range(0,0.5);

	sig = sig + RLPF.ar(HPF.ar(BrownNoise.ar(0.1),freq * 2),harms * 4,0.01);
	sig = Splay.ar(sig);
	root = (root * 0.3)!2 * LFNoise2.ar(0.3).range(0.5,1);
	sig = sig + root;
	sig = HPFSides.ar(sig,180);
	sig = sig * Env.asr(\atk.kr(4),1,\rls.kr(4),\curve.kr(2)).ar(2,\gate.kr(1) + Impulse.kr(0));
	Out.ar(\verbBus.kr(0),sig * \verbAmp.kr(0));
	Out.ar(\outBus.kr(0),sig * \amp.kr(0.1))
}).add;