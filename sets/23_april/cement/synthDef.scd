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

SynthDef(\cementNoise,{
	var bufnum = \bufnum.kr;
	var val = FluidBufToKr.kr(bufnum,0,33);
	var sin = SinOsc.ar(val[1].linexp(0,1,1,12000),mul: val[2]);
	var saw = VarSaw.ar(val[3].linexp(0,1,1,12000),width: val[4], mul: val[5]);
	var square = LFPulse.ar(val[6].linexp(0,1,1,12000),width: val[7], mul: val[8] * 2,add:-1);
	var tri = LFTri.ar(val[9].linexp(0,1,1,12000), mul: val[10]);
	var osc = SelectX.ar(val[0].linlin(0,1,0,3),[sin,saw,square,tri]);
	var noise0 = SelectX.ar(val[11].linlin(0,1,0,2),[LFNoise0.ar(val[12].linlin(0,1,0.2,10)),LFNoise1.ar(val[13].linlin(0,1,0.2,10)),LFNoise2.ar(val[14].linlin(0,1,0.2,10))]);
	var noise1 = SelectX.ar(val[15].linlin(0,1,0,2),[LFNoise0.ar(val[16].linlin(0,1,0.2,10)),LFNoise1.ar(val[17].linlin(0,1,0.2,10)),LFNoise2.ar(val[18].linlin(0,1,0.2,10))]);
	var sig, sigL, sigR;

	var local = LocalIn.ar(2);

	sigL = VarSaw.ar(osc.linexp(-1,1,20,10000) * local[0].linlin(-1,1,0.01,200) + (val[19].linexp(0,1,80,2000) * noise0.range(1,val[20].linlin(0,1,2,10))),width:local[1].linlin(-1,1,0.01,0.8),mul: val[21]);
	sigL = RLPF.ar(sigL,val[22].linexp(0,1,20,20000),val[23].linlin(0,1,2.sqrt,0.01)).tanh;
	sigL = sigL + CombC.ar(sigL,0.25,val[24].linexp(0,1,0.01,0.25).lag(0.01),val[25]);

	sigR = VarSaw.ar(osc.linexp(-1,1,20,10000) * local[1].linlin(-1,1,0.01,200) + (val[26].linexp(0,1,80,2000) * noise1.range(1,val[27].linlin(0,1,2,10))),width:local[0].linlin(-1,1,0.01,0.8),mul: val[28]);
	sigR = RLPF.ar(sigR,val[29].linexp(0,1,20,20000),val[30].linlin(0,1,2.sqrt,0.01)).tanh;
	sigR = sigR + CombC.ar(sigR,0.25,val[31].linlin(0,1,0.01,0.25).lag(0.01),val[32]);

	sig = [sigL,sigR];
	LocalOut.ar(sig);
	sig = LeakDC.ar(sig).tanh * -6.dbamp;
	sig = MSMatrix.ar(sig);
	sig[1] = sig[1] * -3.dbamp;
	sig = MSMatrix.ar(sig);
	sig = sig * Env.asr(\atk.kr(0.01),1,\rls.kr(1),\curve.kr(10)).ar(2,\gate.kr(1));
	Out.ar(\verbBus.kr(), sig * \verbAmp.kr(0).linexp(0,1,0.001,1));
	Out.ar(\out.kr(), sig  * \amp.kr(0).linexp(0,1,0.001,1));
}).add