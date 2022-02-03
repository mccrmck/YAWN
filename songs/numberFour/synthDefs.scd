///////////////////////////////////////////////// YAWN SynthDefs: numberFour /////////////////////////////////////////////////
(
SynthDef(\bitz, {
	var sig = In.ar(\inBus.kr,1);
	sig = Decimator.ar(sig,SampleRate.ir * \rate.kr(1), 24 * \bits.kr(1));
	sig = Pan2.ar(Limiter.ar(sig),\pan.kr(0),\amp.kr(0.8));
	Out.ar(\outBus.kr,sig);
}).add;
)