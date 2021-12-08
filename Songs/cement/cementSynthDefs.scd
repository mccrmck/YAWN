///////////////////////////////////////////////// YAWN SynthDefs: cement /////////////////////////////////////////////////
(
SynthDef(\morph,{
	var voices = 10;
	var freq = { 500.exprand(1500.0) }!voices;
	var sig = In.ar(\inBus.kr,1);

	sig = sig * LFNoise2.kr(0.5).range(0.5,1);

	sig = RLPF.ar(sig,freq * LFNoise2.kr({0.5.exprand(10.0)}!voices).range(0.5,2.0),0.08);
	sig = (sig * \gain.kr(1)).clip2;
	sig = AllpassC.ar(sig,0.02,0.02,0.5);
	sig = Splay.ar(sig,1);
	sig = FreeVerb2.ar(sig[0],sig[1],0.5,1,1,\amp.kr(0.5) * SinOsc.kr(LFNoise2.kr(1!2).range(2.0,8.0)).abs);
	Out.ar(\outBus.kr,sig);
}).add;
)

// this is absolute trash, needs to be scrapped and replaced