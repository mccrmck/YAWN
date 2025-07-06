Cement : YAWNSongNew {

	*loadSynthDefs {
		SynthDef(\cementGrainer,{
			var bufnum = \bufnum.kr(0), bufFrames = BufFrames.kr(bufnum);
			var trigFreq = \trigFreq.kr(0).linlin(0,1,0,60);
			var jitter = \jitter.kr(0).linlin(0,1,0,0.01), width = 0.8;  // \width.kr(0).linlin(0,1,0,0.3);
			var trigRateOsc = \trigRateOsc.kr(0).linlin(0,1,0,8);
			var trig = Impulse.kr(LFDNoise0.kr(trigRateOsc,trigFreq * \trigFreqDev.kr(0), trigFreq)) + \trig.tr;
			var rateOsc = \rateOsc.kr(0).linlin(0,1,0,5), rate = \rate.kr(0.2).(0,1,0.05,2);
            var bufRate = LFDNoise3.kr(rateOsc,rate * \rateDev.kr(0), rate);
            var pan = Demand.kr(trig,0,Dwhite(width.neg,width,inf));

            var pos = Phasor.ar(
                DC.ar(0), 
                BufRateScale.kr(bufnum) * \posRate.kr(0.5).linlin(0,1,-0.25,0.25) * SampleDur.ir,
                \start.kr(0) * bufFrames,
                \end.kr(1) * bufFrames
            );

            var sig = GrainBufJ.ar(
                2, trig, \grainDur.kr(0).linlin(0,1,0.01,2), bufnum, 
                bufRate, pos + TRand.kr(jitter.neg,jitter,trig),
                1, 4, 1, pan, \window.kr(-1)
            );

            sig = LPF.ar(sig,16000);
            sig = Decimator.ar(
                sig,
                SampleRate.ir * \sRate.kr(1).linlin(0,1,0.01,0.3),
                \bits.kr(1).linexp(0,1,2,10)
            );

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
            var noise0 = SelectX.ar(
                val[11].linlin(0,1,0,2), [
                    LFNoise0.ar(val[12].linlin(0,1,0.2,10)),
                    LFNoise1.ar(val[13].linlin(0,1,0.2,10)),
                    LFNoise2.ar(val[14].linlin(0,1,0.2,10))
                ]
            );
            var noise1 = SelectX.ar(
                val[15].linlin(0,1,0,2),[
                    LFNoise0.ar(val[16].linlin(0,1,0.2,10)),
                    LFNoise1.ar(val[17].linlin(0,1,0.2,10)),
                    LFNoise2.ar(val[18].linlin(0,1,0.2,10))
                ]
            );
            var sig, sigL, sigR;

            var local = LocalIn.ar(2);

            sigL = VarSaw.ar(
                osc.linexp(-1,1,20,10000) * local[0].linlin(-1,1,0.01,200) + 
                ( val[19].linexp(0,1,80,2000) * noise0.range(1,val[20].linlin(0,1,2,10)) ),
                width:local[1].linlin(-1,1,0.01,0.8),
                mul: val[21]
            );
            sigL = RLPF.ar(sigL,val[22].linexp(0,1,20,20000),val[23].linlin(0,1,2.sqrt,0.01)).tanh;
            sigL = sigL + CombC.ar(sigL,0.25,val[24].linexp(0,1,0.01,0.25).lag(0.01),val[25]);

            sigR = VarSaw.ar(
                osc.linexp(-1,1,20,10000) * local[1].linlin(-1,1,0.01,200) + 
                ( val[26].linexp(0,1,80,2000) * noise1.range(1,val[27].linlin(0,1,2,10)) ),
                width:local[0].linlin(-1,1,0.01,0.8),
                mul: val[28]
            );
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
		}).add;

		"%: synthDefs loaded".format(this).postln;
	}

	*loadOscDefs {

		//

		"%: oscDefs loaded".format(this).postln;
	}

	*loadData {
		var countIn = ClickConCat(1, Click(170,2,repeats: 2), Click(170,1,repeats: 4) ).out_( mixerDict['clickAll'] );
		var mainRiff = ClickConCat(1,
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
			Click(170,7), Click(170,6), Click(170,5), Click(170,4,repeats: 2)
		).out_( mixerDict['clickAll'] );

		data = [
			'count' -> (
				click:  ClickConCat(1,Click(160,2,repeats: 2), Click(160,1,repeats: 4) ).out_( mixerDict['clickAll'] ),
				lights: YAWNDMXIS.presetChange(0, 0),
				kemper: YAWNKemper('Cement', 'count').makePattern,
			),
			'intro' -> (
				click: ClickConCat(1,
					Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
					Click(160,7), Click(160,6), Click(160,5), Click(160,4), Click(160,3),
					Click(160,7), Click(160,6), Click(160,5), Click(160,4,repeats: 2)
				).out_( mixerDict['clickAll'] ),
				lights:  YAWNDMXIS('Cement', 'intro').makePattern,
				kemper:  YAWNKemper('Cement','intro').makePattern,
				bTracks: [
					YAWNPB('Cement', 'intro', 'gtrs').makePattern,
					YAWNPB('Cement', 'intro', 'perc').makePattern,
				]
			),
			'aSection' -> (
				countIn: countIn,
				click:   mainRiff,
				lights:  YAWNDMXIS('Cement', 'aSection').makePattern,
				kemper:  YAWNKemper('Cement','aSection').makePattern,
				bTracks: [
					YAWNPB('Cement', 'aSection', 'bass').makePattern,
					YAWNPB('Cement', 'aSection', 'perc').makePattern,
					YAWNPB('Cement', 'aSection', 'synths').makePattern,
					YAWNPB('Cement', 'aSection0','ambience').makePattern( (60/170) * 25 ),      // these should probably be consolidated, no?
					YAWNPB('Cement', 'aSection1','ambience').makePattern( (60/170) * 63 ),      // these should probably be consolidated, no?
				]
			),
			'melody' -> (
				countIn: countIn,
				click:   mainRiff,
				lights:  YAWNDMXIS('Cement','melody').makePattern,
				kemper:  YAWNKemper('Cement','melody').makePattern,
				bTracks: [
					YAWNPB('Cement', 'melody', 'bass').makePattern,
					YAWNPB('Cement', 'melody', 'gtrs').makePattern,
					YAWNPB('Cement', 'melody', 'perc').makePattern,
					YAWNPB('Cement', 'melody0','synths').makePattern,                        // these should probably be consolidated, no?
					YAWNPB('Cement', 'melody1','synths').makeOverlapPattern,                 // these should probably be consolidated, no?
				]
			),
			'bSection' -> (
				countIn: countIn,
				click:   ClickConCat(1,Click(170,4,repeats: 14), Click(170,3) ).out_( mixerDict['clickAll'] ),
				lights:  Pseq([ YAWNDMXIS('Cement','bSection').makePattern, YAWNDMXIS.presetChange(0,3) ]),
				kemper:  YAWNKemper('Cement','bSection').makePattern,
				bTracks: [
					YAWNPB('Cement', 'bSection','bass').makePattern,
					YAWNPB('Cement', 'bSection','synths').makePattern,
					YAWNPB('Cement', 'bSection','bass').makePattern( (60/170) * 58.5 ),  // this is the sendoff glissando to the impro...
					YAWNPB('Cement', 'bSection','perc').makePattern( (60/170) * 58.5 ),
				]
			),
			'countAgain' -> (
				click:   ClickConCat(1, ClickCue(160,2,cueKey: 'cement'),Click(160,2), Click(160,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				lights:  YAWNDMXIS.presetChange(0,0),
				kemper:  YAWNKemper('Cement','countAgain').makePattern,
			),
			'bSectionAgain' ->(
				countIn: countIn,
				click:   ClickConCat(1,
					Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
					Click(170,4,repeats: 10), Click(170,2), Click(170,4,repeats: 5), Click(170,5), Click(170 * 2,3),
				).out_( mixerDict['clickAll'] ),
				lights:  YAWNDMXIS('Cement','bSectionAgain').makePattern,
				kemper:  YAWNKemper('Cement','bSectionAgain').makePattern,
				bTracks: [
					YAWNPB('Cement', 'bSectionAgain', 'bass').makePattern,
					YAWNPB('Cement', 'bSectionAgain', 'perc').makePattern,
					YAWNPB('Cement', 'bSectionAgain0','ambience').makeOverlapPattern,                        // these should probably be consolidated, no?
					YAWNPB('Cement', 'bSectionAgain1','ambience').makeOverlapPattern( (60/170) * 68.5 ),     // these should probably be consolidated, no?
					YAWNPB('Cement', 'bSectionAgain', 'synths').makeOverlapPattern,
				]
			),
			'solo' -> (
				countIn: countIn,
				click:   ClickConCat(4,
					Click(170,4,repeats: 10), Click(170,2),
					Click(170,4,repeats: 5), Click(170,5),
					Click(170 * 2,3)
				).out_( mixerDict['clickAll'] ),
				lights:  YAWNDMXIS('Cement','solo').makePattern,
				kemper:  YAWNKemper('Cement','solo').makePattern,
				bTracks: [
					YAWNPB('Cement', 'solo', 'perc').makePattern,
					YAWNPB('Cement', 'solo', 'ambience').makePattern( (60/170) * 114.5 ),
					YAWNPB('Cement', 'solo', 'bass').makePattern( (60/170) * 137 ),
					YAWNPB('Cement', 'solo', 'gtrs').makePattern( (60/170) * 137 ),
					YAWNPB('Cement', 'solo', 'synths').makePattern( (60/170) * 137 ),
				]
			),
			'quint' -> (
				countIn: ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( mixerDict['clickAll']),
				click:   [
					ClickConCat(3, Click(160,4,repeats: 3), ClickRest(160,4)).out_( mixerDict['clickAll'] ),  // should these be -3.dbamp?
					ClickConCat(3, Click(200,5,repeats: 3), Click(160,4)).out_( mixerDict['clickAll'] )
				],
				lights:  YAWNDMXIS('Cement','quint').makePattern,
				kemper:  YAWNKemper('Cement','quint').makePattern,
				bTracks: [
					YAWNPB('Cement', 'quint', 'bass').makePattern,
					YAWNPB('Cement', 'quint', 'perc').makePattern,
					YAWNPB('Cement', 'quint', 'synths').makePattern,
				]
			),
			'rit' -> (
				countIn: ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( mixerDict['clickAll'] ),
				click:   ClickConCat(1,(1.0,1.08..2.12).collect({ |i| Click(200 / i) }), Click(170 * 2,3) ).out_( mixerDict['clickAll'] ),
				lights:  YAWNDMXIS('Cement','rit').makePattern,
				kemper:  YAWNKemper('Cement','rit').makePattern( 60/6.384 ),
				bTracks: [
					YAWNPB('Cement', 'rit', 'bass').makePattern,
					YAWNPB('Cement', 'rit', 'perc').makePattern,
					YAWNPB('Cement', 'rit', 'synths').makePattern,
				]
			),
			'aSectionLast' -> (
				countIn: countIn,
				click:  ClickConCat(1,
					mainRiff,
					Click(170,7), Click(170,6), Click(170,5), Click(170,4), Click(170,3),
				).out_( mixerDict['clickAll']),
				lights:  YAWNDMXIS('Cement','aSectionLast').makePattern,
				kemper:  YAWNKemper('Cement','aSectionLast').makePattern,
				bTracks: [
					YAWNPB('Cement', 'aSectionLast', 'bass').makePattern,
					YAWNPB('Cement', 'aSectionLast', 'perc').makePattern,
					YAWNPB('Cement', 'aSectionLast0','gtrs').makePattern,
					YAWNPB('Cement', 'aSectionLast1','gtrs').makePattern( (60/170) * 76 ),
					YAWNPB('Cement', 'aSectionLast0','synths').makePattern,
					YAWNPB('Cement', 'aSectionLast1','synths').makePattern,
				]
			)
		];

		"%: data loaded".format(this).postln;
	}
}
