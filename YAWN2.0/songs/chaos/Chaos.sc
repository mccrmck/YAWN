Chaos : YAWNSongNew {

	*loadSynthDefs {
		SynthDef(\repeater,{
			var sig = SoundIn.ar(\inBus.kr(0!2));
			sig = sig.sum * Env.sine(0.1).ar;
			sig = sig + LocalIn.ar(2);
			sig = DelayC.ar(sig,0.2,\delay.kr(0).linexp(0,1,0.01,0.15));
			sig = sig.fold2;
			LocalOut.ar(sig * \feedB.kr(0.1).linlin(0,1,0.99,1.4));                              // consider inverting the feedback coefficient?
			sig = sig.tanh * -10.dbamp;
			sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
			sig = Balance2.ar(sig[0],sig[1],\pan.kr(0).linlin(0,1,-0.3,0.3), \amp.kr(0.5));
			Out.ar(\outBus.kr(0),sig)
		}).add;

		SynthDef(\freeze,{
			var sig = SoundIn.ar(\inBus.kr(0!2)); // make this stereo?
			sig = (sig * 12.dbamp).tanh;
			sig = FFT(LocalBuf(4096),sig.sum);
			sig = PV_Freeze(sig,1);
			sig = IFFT(sig);
			sig = RLPF.ar(sig,\freq.kr(0).linexp(0,1,100,8000),\rq.kr(0).linlin(0,1,1,0.01),\rq.kr(0).linlin(0,1,1,4));
			sig = sig.tanh * -4.dbamp * \rq.kr(0).linlin(0,1,1,0.5);
			sig = BHiShelf.ar(sig,6000,1,-3);
			sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
			sig = Pan2.ar(sig,\pan.kr(0).linlin(0,1,-0.3,0.3),\amp.kr(0.5));
			Out.ar(\outBus.kr(0),sig)
		}).add;

		SynthDef(\noiseFilt,{
			var sig = BrownNoise.ar(1!2);
			sig = RLPF.ar(sig,\lpFreq.kr(0).linexp(0,1,100,8000),\lpQ.kr(0).linlin(0,1,1,0.01),\lpQ.kr(0).linlin(0,1,1,4));
			sig = sig.tanh;
			sig = (sig + 0.4).wrap2;
			sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
			sig = LeakDC.ar(sig) * -14.dbamp;
			sig = Rotate2.ar(sig[0],sig[1],\pan.kr(0)) * \amp.kr(1);
			Out.ar(\outBus.kr(0),sig);
		}).add;

		SynthDef(\lfNoise,{
			var sig = LFNoise0.ar(\freq.kr(440).linexp(0,1,8,8000)!2);
			sig = CombC.ar(sig,0.2,\combFreq.kr(40,0.2).linexp(0,1,40,4000).reciprocal,Rand(0.1,10)).fold2;
			sig = sig * Env.asr(0.01,1,0.1,0).ar(2,\gate.kr(1) + Impulse.kr(0));
			sig = LeakDC.ar(sig) * -15.dbamp;
			sig = Rotate2.ar(sig[0],sig[1],\pan.kr(0)) * \amp.kr(1);
			Out.ar(\outBus.kr(0),sig);
		}).add;

		"%: synthDefs loaded".format(this).postln;
	}

	*loadOscDefs {


		"%: oscDefs loaded".format(this).postln;
	}

	*loadData {

		data = [
			'count' -> (
				countIn: ClickCue(75, cueKey: 'chaos', /*out: outs['clickAll']*/ ),
				click:   ClickConCat(1, Click(160,2,repeats: 2), Click(160,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('Chaos','count').makePattern,
			),
			'gitDrums' -> (
				countIn: ClickConCat(1, Click(160,2,repeats: 2), Click(160,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,
					Click(160,4,repeats: 8 * 3), Click(160,4,repeats: 6),
					ClickCue(160,2,repeats: 2), ClickCue(160,1,repeats: 4),
					Click(160,4,repeats: 2)
				).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('Chaos','gitDrums').makePattern,
			),
			'newTempo' -> (
				click:   Click(120,4, /* out: outs['clickAll'] */),
				kemper:  YAWNKemper('Chaos','newTempo').makePattern,
			),
			'aSection' -> (
				click:   ClickConCat(2,
					Click(120,4,repeats: 5),Click(120,3),
					Click(120,4,repeats: 2),Click(120,2),
					Click(120,4,repeats: 2),Click(120,3)
				).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('Chaos','aSection').makePattern,
				bTracks: [
					YAWNPB('Chaos','aSection','ambience').makeOverlapPattern,
					YAWNPB('Chaos','aSection','bass').makePattern,
					YAWNPB('Chaos','aSection','perc').makePattern,
				]
			),
			'elevenFirst' -> (
				countIn: ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1, ClickMan([1,4/3,1] * 100,1,8), Click(200,4)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('Chaos','elevenFirst').makePattern,                             // check this
				bTracks: [
					YAWNPB('Chaos','elevenFirst','bass').makePattern,
					YAWNPB('Chaos','elevenFirst','gtrs').makePattern,
					YAWNPB('Chaos','elevenFirst','perc').makePattern,
				]
			),
			'elevenLoopOne' -> (
				countIn: ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCatLoop('elevenLoopOne', ClickMan([1,4/3,1] * 100,1,8), Click(200,4)).out_( /*outs['clickAll']*/ ),
			),
			'elevenLoopTwo' -> (
				countIn: ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCatLoop('elevenLoopTwo', ClickMan([1,4/3,1] * 100,1,8), Click(200,4)).out_( /*outs['clickAll']*/ ),
			),
			'elevenLast' -> (
				countIn: ClickConCat(1, Click(200,2,repeats: 2), Click(200,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,
					ClickMan([1,4/3,1] * 100,repeats: 4),
					ClickManCue([1,4/3,1] * 100,repeats: 4),
					ClickCue(200,repeats: 4),
					Click(120,3)
				).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('Chaos','elevenLast').makePattern,
				bTracks: [
					YAWNPB('Chaos','elevenLast','ambience').makeOverlapPattern,
					YAWNPB('Chaos','elevenLast0','perc').makeOverlapPattern( 9.3 ),
					YAWNPB('Chaos','elevenLast1','perc').makeOverlapPattern( 15.9 ),
				]
			),
			'bomb' -> (
				click:   ClickConCat(1, Click(120,4), Click(120,3),Click(120)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('Chaos','bomb').makePattern,
				bTracks: [
					YAWNPB('Chaos','bomb','bass').makePattern( 3.5 ),
					YAWNPB('Chaos','bomb','perc').makePattern,
					YAWNPB('Chaos','bomb0','synths').makePattern( 2 ),
					YAWNPB('Chaos','bomb0','synths').makePattern( 3.5 ),
				]
			),
			'countAgain' -> (
				click:   ClickConCat(1,ClickRest(120,4),ClickCue(120,2,repeats: 2), ClickCue(120,1,repeats: 4), Click(120,3)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('Chaos','countAgain').makePattern,
				bTracks: YAWNPB('Chaos','countAgain','perc').makeOverlapPattern,
			),
			'aSectionAgain' -> (
				countIn: ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(2, Click(120,4,repeats: 5),Click(120,3),Click(120,4,repeats: 2),Click(120,2),Click(120,4,repeats: 2),Click(120,3)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('Chaos','aSectionAgain').makePattern,
				bTracks: [
					YAWNPB('Chaos','aSectionAgain','bass').makePattern,
					YAWNPB('Chaos','aSectionAgain','ambience').makeOverlapPattern,
					YAWNPB('Chaos','aSectionAgain','perc').makePattern( 38.5 ),
				]
			),
			'outro' -> (
				countIn: ClickConCat(1, Click(120,2,repeats: 2), Click(120,1,repeats: 4)).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1, Click(120,4,repeats: 15), ClickMan([120,120,180]), Click(120,4,repeats: 3)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('Chaos','outro').makePattern,
				bTracks: [
					YAWNPB('Chaos','outro','bass').makePattern,
					YAWNPB('Chaos','outro','perc').makePattern( 20 ),
				]
			);

			"%: data loaded".format(this).postln;
		]
	}
}
