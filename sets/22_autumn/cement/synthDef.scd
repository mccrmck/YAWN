///////////////////////////////////////////////// YAWN SynthDefs: cement /////////////////////////////////////////////////

SynthDef(\cementGrainer,{
	var bufnum = \bufnum.kr(0), bufFrames = BufFrames.kr(bufnum);
	var trigFreq = \trigFreq.kr(0).linlin(0,1,0,60);
	var jitter = \jitter.kr(0).linlin(0,1,0,0.01), width = 0.8;  // \width.kr(0).linlin(0,1,0,0.3);
	var trigRateOsc = \trigRateOsc.kr(0).linlin(0,1,0,8);
	var trig = Impulse.kr(LFDNoise0.kr(trigRateOsc,trigFreq * \trigFreqDev.kr(0), trigFreq)) + \trig.tr;
	var rateOsc = \rateOsc.kr(0).linlin(0,1,0,5), rate = \rate.kr(0.2).(0,1,0.05,2);
	var bufRate = LFDNoise3.kr(rateOsc,rate * \rateDev.kr(0), rate);
	var pan = Demand.kr(trig,0,Dwhite(width.neg,width,inf));

	var pos = Phasor.ar(0, BufRateScale.kr(bufnum) * \posRate.kr(0.5).linlin(0,1,-0.25,0.25) * SampleDur.ir,\start.kr(0) * bufFrames,\end.kr(1) * bufFrames);

	var sig = GrainBufJ.ar(2,trig,\grainDur.kr(0).linlin(0,1,0.01,2),bufnum,bufRate,pos + TRand.kr(jitter.neg,jitter,trig),1,4,1,pan,\window.kr(-1));

	sig = LPF.ar(sig,16000);
	sig = Decimator.ar(sig,SampleRate.ir * \sRate.kr(1).linlin(0,1,0.01,0.3),\bits.kr(1).linexp(0,1,2,10));

	sig = LeakDC.ar(sig);
	sig = HPFSides.ar(sig,\hpFreq.kr(150));

	sig = (sig * \gain.kr(0).linlin(0,1,1,20) ).clip2;
	sig = Compander.ar(sig,sig,-18.dbamp,1,1/4);

	sig = sig * (1 - \mute.kr(0)) * -6.dbamp;

	Out.ar(\verbBus.kr(), sig * \verbAmp.kr(0).linexp(0,1,0.001,1));
	Out.ar(\out.kr(), sig  * \amp.kr(0).linexp(0,1,0.001,1));
}).add;