Lachrymator : YAWNSongNew {

	*loadSynthDefs {
		SynthDef(\mikeSampleGrains,{
			var cDur = ControlDur.ir;
			var bufnum = \bufnum.kr();
			var frames = BufFrames.kr(bufnum);
			var phase = Phasor.ar(0,BufRateScale.kr(bufnum) * \rate.kr(0.5).linexp(0,1,0.5,1.0).neg,\start.kr(0) * frames,\end.kr(1) * frames);
			var sig = BufRd.ar(2,bufnum,phase,1,4);
			var trig = HPZ1.ar(HPZ1.ar(phase).sign);

			sig = sig * Env([1,0,1],[cDur,cDur]).ar(gate:trig);           // consider delaying the sig by cDur so the Env happems at the right time?
			sig = (sig * \gain.kr(0).linlin(0,1,4,20)).tanh * -12.dbamp;
			sig = sig * Env.asr(\atk.kr(0.01),1,\rls.kr(0.01),\curve.kr(4)).ar(2,\gate.kr(1) + Impulse.kr(0));
			Out.ar(\verbBus.kr(),sig * \verbAmp.kr(0).linexp(0,1,0.001,1));
			Out.ar(\outBus.kr(),sig * \amp.kr(0).linexp(0,1,0.001,1) )
		}).add;

		SynthDef(\oskarNoise,{
			var sig, freq = \freq.kr(0).linexp(0,1,40,400);
			var harms = (1..4);
			var mid = VarSaw.ar(freq * harms,harms.reciprocal.reverse,\width.kr(0),harms.reciprocal).sum;
			var side = PinkNoise.ar(1,\offset.kr(0).linlin(0,1,0,2)).clip2;
			mid = (mid * \midGain.kr(0).linlin(0,1,1,12)).tanh;

			side = HPF.ar( HPF.ar(side,90),90);
			side = ( side * \sideGain.kr(0).linlin(0,1,1,12) ).fold2;

			sig = MSMatrix.ar([mid * \midAmp.kr(0),side * \sideAmp.kr(0)]);
			sig = (sig * \gain.kr(0).linlin(0,1,1,12));

			sig = RHPF.ar(sig,\hpFreq.kr(0).linexp(0,1,20,8000),\hpQ.kr(0).linexp(0,1,1,0.01));
			sig = RLPF.ar(sig,\lpFreq.kr(1).linexp(0,1,40,20000),\lpQ.kr(0).linexp(0,1,1,0.01));

			sig = MidEQ.ar(sig,500,1,6);
			sig = LeakDC.ar(sig,0.9);
			sig = sig.tanh;
			sig = Rotate2.ar(sig[0],sig[1]);
			Out.ar(\verbBus.kr(0),sig * \verbAmp.kr(0).linexp(0,1,0.001,1));
			Out.ar(\out.kr(0),sig * \amp.kr(0).linexp(0,1,0.001,1))
		}).add;

		"%: synthDefs loaded".format(this).postln;
	}

	*loadOscDefs {

		"%: oscDefs loaded".format(this).postln;

	}


	*loadData {

		data = [
			'countPart1' -> (
				countIn: ClickCue(70,cueKey: 'lachrymator', /*out: outs['clickAll']*/ ),
				click:   ClickConCat(1, Click(240,2,repeats: 2), Click(240,1,repeats: 4) ).out_( /*outs['clickAll'] */),
				kemper:  YAWNKemper('lachrymator','countPart1').makePattern,
			),
			'aSection' ->(
				click: ClickConCat(1,
					ClickConCat(7, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(6, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(7, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(11,Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(5, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(5, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(9, Click(240,4), Click(300,4)), ClickCue(240,4), ClickCue(300,1,repeats: 4),
					ClickConCat(25,Click(240,4), Click(300,4))  //transition to impro                                     // this doesn't need to be so long...
				).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('lachrymator','aSection').makePattern,
				bTracks: [
					YAWNPB('lachrymator','aSection', 'bass').makePattern,
					YAWNPB('lachrymator','aSection', 'gtrs').makePattern,
					YAWNPB('lachrymator','aSection', 'perc').makePattern,
					YAWNPB('lachrymator','aSection0','synths').makePattern( 14.4 ),
					YAWNPB('lachrymator','aSection1','synths').makePattern( 66.6 ),
					YAWNPB('lachrymator','aSection2','synths').makePattern( 14.4 ), // vocal tracks
					YAWNPB('lachrymator','aSection3','synths').makePattern( 66.6 ), // vocal tracks
					YAWNPB('lachrymator','aSection', 'ambience').makePattern( 97.2 ),
				]
			),
			'tapping' -> (
				click:   ClickConCat(1,Click(120,4,repeats: 16 ),ClickCue(120,4,1,2),ClickCue(120,2,1,2),ClickCue(120,1,1,4)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('lachrymator','tapping').makePattern
				bTracks: [
					YAWNPB('lachrymator','tapping','ambience').makePattern(24),
					YAWNPB('lachrymator','tapping','perc').makePattern(24),
					YAWNPB('lachrymator','tapping','synths').makePattern(37),
				]
			),
			'jazzIntro' -> (
				countIn: ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,
					Click(120,3,repeats: 2), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),Click(120,3),
					Click(120,3,repeats: 2), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),Click(120,3)
				).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('lachrymator','jazzIntro').makePattern,
				// bTracks: YAWNPB('lachrymator','jazzIntro','bass').makePattern
			),
			'jazzAsection' -> (
				countIn: ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,
					Click(120,3,repeats: 2), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),
					Click(120,3,repeats: 3), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),
					Click(120,3)
				).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('lachrymator','jazzAsection').makePattern,
				// bTracks: YAWNPB('lachrymator','jazzAsection','bass').makePattern
			),
			'jazzBsection' -> (
				countIn: ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   Click(120,3,repeats: 16, /*out: outs['clickAll']*/ ),
				kemper:  YAWNKemper('lachrymator','jazzBsection').makePattern,
				// bTracks: YAWNPB('lachrymator','jazzAsection','bass').makePattern
			),
			'jazzAsectionAgain' -> (
				countIn: ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,
					Click(120,3,repeats: 2), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),
					Click(120,3,repeats: 3), Click(120,5),
					Click(120,3,repeats: 2), Click(120,4),
					Click(120,3)
				).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('lachrymator','jazzAsectionAgain').makePattern,
				bTracks: [
					YAWNPB('lachrymator','jazzAsectionAgain','ambience').makePattern(9),
					YAWNPB('lachrymator','jazzAsectionAgain','bass').makePattern
				]
			),
			'jazzBsectionAgain' -> (
				countIn: ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1, Click(120,3,repeats: 15), Click(120,2)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('lachrymator','jazzBsectionAgain').makePattern,
				bTracks: [
					// YAWNPB('lachrymator','jazzBsectionAgain','bass').makePattern
					YAWNPB('lachrymator','jazzBsectionAgainLast','bass').makePattern(22.75)
				]
			),
			'countPart3' -> (
				click:   ClickConCat(1, ClickRest(60,5.588), Click(340,5), Click(340,4), Click(340,5), Click(340,4)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('lachrymator','countPart3').makePattern( 5.588 ),
				bTracks: YAWNPB('lachrymator','countPart3','ambience').makePattern,
			),
			'aSectionNine' -> (
				countIn: ClickConCat(2, Click(340,5), Click(340,4)).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,
					ClickConCat(3, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,1, repeats: 5), Click(340,4),
					ClickConCat(4, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),

					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,5), ClickCue(340,1,repeats: 4),
					ClickConCat(5, Click(340,5), Click(340,4)), ClickCue(340,1,repeats: 5), Click(340,4),
					ClickConCat(3, Click(340,5), Click(340,4)),	Click(170,4,repeats: 2)
				).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('lachrymator','aSectionNine').makePattern,
				bTracks: [
					YAWNPB('lachrymator','aSectionNine', 'perc').makeOverlapPattern,
					YAWNPB('lachrymator','aSectionNine0','synths').makeOverlapPattern( (60/340) * 35 ),
					YAWNPB('lachrymator','aSectionNine0','ambience').makeOverlapPattern( (60/340) * 35 ),
					YAWNPB('lachrymator','aSectionNine', 'bass').makePattern( (60/340) * 142.5 ),
					YAWNPB('lachrymator','aSectionNine1','stynths').makePattern( (60/340) * 243 ),
					YAWNPB('lachrymator','aSectionNine1','ambience').makePattern( (60/340) * 416 ),
				]
			),
			'outro' -> (
				countIn: ClickConCat(1, Click(240,2,repeats: 2), Click(240,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,
					ClickConCat(5, Click(240,4), Click(300,4)),
					Array.geom(12,300,0.95).collect({ |item, index|

						case
						{index < 10 }{ [Click(item * 0.8,4), Click(item,4)] }
						{index == 10}{ [Click(item * 0.8,4), ClickCue(item,4)] }
						{index > 10 }{ [ClickCue(item * 0.8,4), ClickCue(item,4)] }
					}).flat,
					ClickCue()
				).out_( /*outs['clickAll'] */),
				bTracks: [
					YAWNPB('lachrymator','outro', 'ambience').makePattern,
					YAWNPB('lachrymator','outro', 'bass').makePattern,
					YAWNPB('lachrymator','outro', 'gtrs').makePattern,
				]
			)
		];

		"%: data loaded".format(this).postln;
	}
}
