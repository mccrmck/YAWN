///////////////////////////////////////////////// YAWN SynthDefs: numberTwo /////////////////////////////////////////////////
(
SynthDef(\shiftDelay,{
	var sig = In.ar(\inBus.kr,1);
	var mute = \mute.kr;
	var local = LocalIn.ar(2);
	sig = DelayC.ar((sig * (1-mute)) + local,1.5,LFNoise1.ar(\speed.kr(0).linlin(0,1,0.05,7)!2).range(0.2,\delay.kr(0).linlin(0,1,0.3,1.5)));
	LocalOut.ar(sig.reverse * Select.kr(mute,[0.75,1]));
	sig = LeakDC.ar(sig);
	sig = Splay.ar(sig,1,\amp.kr(1));
	Out.ar(\outBus.kr,sig);
}).add;
)

