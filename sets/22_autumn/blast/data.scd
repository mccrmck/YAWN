///////////////////////////////////////////////// YAWN Data: chaos /////////////////////////////////////////////////
{ |songInstance|
	// var cueKeys = [];
	var pathToDMXMIDI = songInstance.path +/+ "dmxMIDI/";
	var pathToKemperMIDI = songInstance.path +/+ "kemperMIDI/";

	var ambience = songInstance.pbTracks['ambience'];
	var bass     = songInstance.pbTracks['bass'];
	var gtrs     = songInstance.pbTracks['gtrs'];
	var perc     = songInstance.pbTracks['perc'];
	var synths   = songInstance.pbTracks['synths'];

	var outs = YAWNShow.outDict;

	[
		(
			name:    'blastApart1',
			countIn: [[ ]],
			click:   [[

				// must move all the count ins early...
				ClickConCat(1,
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190,1),ClickRest(190,4,3),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190,3),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190,3),ClickRest(190,4,2),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190 * 2,5),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190 * 2,1),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190,3),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190,3),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190 * 2,6),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190,3),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190 * 2,1),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190,6),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190 * 2,5)
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190 * 2,3),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190 * 2,7),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190 * 2,3),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190,4),
					ClickCue(190,4,cueKey: 'four'),
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ ],
			bTracks: [ ],
		),(
			name:    'blastB',
			countIn: [[ ]],
			click:   [[
				ClickConCat(1,
					ClickCue(190,4),
					Click(190,4,repeats: 7),
					ClickCue(190,4),
					Click(190,4,repeats: 2),
					ClickCue(190,4),
					Click(190,4,repeats: 5),
					ClickCue(190,4,cueKey: 'five')
				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ ],
			bTracks: [ ],
		),(
			name:    'blastApart3',
			countIn: [[	ClickCue(190,4,cueKey: 'five',out: outs['clickAll']) ]],
			click:   [[
				ClickConCat(1,

					Click(190,5),Click(190),
					ClickCue(190,4,cueKey: 'five'),

					Click(190,5),Click(190),
					ClickRest(190,2), ClickRest(190,4,2),
					ClickCue(190,4,cueKey: 'five'),

					Click(190,5),Click(190),
					ClickCue(190,4,cueKey: 'five'),

					Click(190,5),Click(190),
					ClickCue(190,4,cueKey: 'three'),

					Click(190,3),Click(190),
					ClickRest(190 * 2,3),
					ClickCue(190,4,cueKey: 'five'),

					Click(190,5),Click(190),
					ClickRest(190 * 2,5),
					ClickCue(190,4,cueKey: 'three'),

					Click(190,3),Click(190),
					ClickRest(190,3),
					ClickCue(190,4,cueKey: 'three'),

					Click(190,3),Click(190),
					ClickRest(190,2),
					ClickCue(190,4,cueKey: 'three'),

					Click(190,3),Click(190),
					ClickRest(190 * 2,3),ClickRest(190,4),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190,2),ClickRest(190,4),
					ClickCue(190,4,cueKey: 'four'),

					Click(190,4),Click(190),
					ClickRest(190,2),ClickRest(190,4),

				).out_( outs['clickAll'] )
			]],
			lights:  [ ],
			kemper:  [ ],
			bTracks: [ ],
		)

	]
}




























