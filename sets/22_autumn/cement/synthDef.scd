///////////////////////////////////////////////// YAWN SynthDefs: cement /////////////////////////////////////////////////

SynthDef(\cementGrainer,{
	var bufnum = \bufnum.kr(0), bufFrames = BufFrames.kr(bufnum);
	var trigFreq = \trigFreq.kr(1).linlin(0,1,0,60);
	var jitter = \jitter.kr(0).linlin(0,1,0,0.01), width = \width.kr(0).linlin(0,1,0,0.3);
	var trigRateOsc = \trigRateOsc.kr(0).linlin(0,1,0,8);
	var trig = Impulse.kr(LFDNoise0.kr(trigRateOsc,trigFreq * \trigFreqDev.kr(0), trigFreq)) + \trig.tr;
	var rateOsc = \rateOsc.kr(0).linlin(0,1,0,5), rate = \rate.kr(0.5).linlin(0,1,0,2);
	var bufRate = LFDNoise3.kr(rateOsc,rate * \rateDev.kr(0), rate);
	var pan = Demand.kr(trig,0,Dwhite(width.neg,width,inf));

	var pos = Phasor.ar(0, BufRateScale.kr(bufnum) * \posRate.kr(0.5).linlin(0,1,-0.1,0.1) * SampleDur.ir,\start.kr(0) * bufFrames,\end.kr(1) * bufFrames);

	var sig = LPF.ar(
		HPF.ar(
			GrainBufJ.ar(2,trig,\grainDur.kr(0).linlin(0,1,0.01,2),bufnum,bufRate,pos + TRand.kr(jitter.neg,jitter,trig),1,4,1,pan,\window.kr(-1)),
			20
		),
		16000
	);

	var sr = Decimator.ar(sig,SampleRate.ir * \sRate.kr(1).linlin(0,1,0.1,0.3),24 * \bits.kr(1).linlin(0,1,0.2,0.4)); // should I go lower??

	sig = LeakDC.ar(sig);
	sig = HPFSides.ar(sig,\hpFreq.kr(150));

	sig = (sig * \gain.kr(1) ).clip2;
	sig = Compander.ar(sig,sig,-12.dbamp,1,1/4,mul: 6.dbamp);           //improve this!

	sig = sig * (1 - \mute.kr(0));

	// Out.ar(\\verbBus.kr(), sig * \verbAmp.kr(0));
	Out.ar(\out.kr(), sig  * \amp.kr(0));
}).add;
