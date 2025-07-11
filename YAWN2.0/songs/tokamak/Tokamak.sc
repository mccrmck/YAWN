Tokamak : YAWNSongNew {

	*loadOscDefs {

		"%: oscDefs loaded".format(this).postln;
	}

	*loadData {
		data = [
			'playback' -> (
				countIn: ClickCue(75,cueKey: 'tokamak',/*out: outs['clickAll']*/),
				click:   ClickRest(142,4,47,/*out: outs['clickAll']*/),
				bTracks: [
					YAWNPB('tokamak', 'playback', 'ambience').makeOverlapPattern,
					YAWNPB('tokamak', 'playback', 'perc').makePattern
				]
			),
			'count' -> (
				click:   ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				bTracks: YAWNPB('tokamak', 'count', 'perc').makePattern,
			),
			'intro' -> (
				countIn: ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1, Click(142,4,repeats: 6), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('tokamak', 'intro').makePattern,
				bTracks: YAWNPB('tokamak',  'intro', 'perc').makePattern,
			),
			'guitar' -> (
				countIn: ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,Click(142,4,repeats: 46), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('tokamak','guitar').makePattern,
				bTracks: [
					YAWNPB('tokamak', 'guitar', 'perc').makePattern,
					YAWNPB('tokamak', 'guitar', 'synths').makePattern( (60/142) * 64 ),
				]
			),
			'break' -> (
				countIn: ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   Click(142,4,repeats: 4, /*out: outs['clickAll']*/),
				kemper:  YAWNKemper('tokamak','break').makePattern,
				bTracks: YAWNPB('tokamak', 'break', 'perc').makePattern
			),
			'funk' -> (
				countIn: ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   Click(142,4,repeats: 48, /*out: outs['clickAll']*/),
				kemper:  YAWNKemper('tokamak','funk').makePattern,
				bTracks: [
					YAWNPB('tokamak','funk','ambience').makeOverlapPattern,
					YAWNPB('tokamak','funk','bass').makePattern,
					YAWNPB('tokamak','funk','synths').makePattern,
					YAWNPB('tokamak','funk','perc').makePattern,
				]
			),
			'improIntro' -> (
				countIn: ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   Click(142,4,repeats: 16, /*out: outs['clickAll']*/ ),
				kemper:  YAWNKemper('tokamak','improIntro').makePattern,
				bTracks: YAWNPB('tokamak','improIntro','perc').makePattern
			),
			'impro' -> (
				countIn: ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickLoop(142,loopKey: 'tokamakImpro', /*out: outs['clickAll']*/),
				kemper:  YAWNKemper('tokamak','impro').makePattern,
			),
			'cue' -> (
				countIn: ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( /*outs['clickAll'] */),
				click:   ClickConCat(1,Click(142,4),ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4), Click(142,4,repeats: 5)).out_( /*outs['clickAll'] */),
				kemper:  YAWNKemper('tokamak','cue').makePattern(60/142 * 4),
				bTracks: YAWNPB('tokamak','cue','perc').makePattern(60/142 * 20),
			),
			'outro' -> (
				countIn: ClickConCat(1, Click(142,2,repeats: 2), Click(142,1,repeats: 4) ).out_( /*outs['clickAll']*/ ),
				click:   ClickConCat(1,Click(142,4,repeats: 57), Click(142,2)).out_( /*outs['clickAll']*/ ),
				kemper:  YAWNKemper('tokamak','outro').makePattern,
				bTracks: [
					YAWNPB('tokamak','outro','bass').makePattern(60/142 * 16),
					YAWNPB('tokamak','outro','perc').makePattern(60/142 * 16),
					YAWNPB('tokamak','outro','synths').makePattern(60/142 * 16),
				]
			),
		];
	}
}
