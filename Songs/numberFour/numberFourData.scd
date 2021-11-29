///////////////////////////////////////////////// YAWN Data: numberFour /////////////////////////////////////////////////
(

// fix MIDI file paths

[
	(
		name: 'count_off',
		click: [ Click(142,2,repeats: 2), Click(142,1,repeats: 4) ],
		lights: [DMXIS.loadFromMIDI('count_off',"/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/dmxMIDI/count_off.mid")],
	),(
		name: 'beginning',
		click:[ Click(142,4,repeats: 125) ],
		lights: [DMXIS.loadFromMIDI('beginning',"/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/dmxMIDI/beginning.mid")],

	),(
		name: 'impro',
		click: [ ClickLoop(142,loopKey: \openFour) ],
		lights: [DMXIS.loadFromMIDI('impro',"/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/dmxMIDI/impro.mid")],

	),(
		name: 'cue',
		click: [ ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4) ],
		lights: [ nil ]
	),(
		name:'synthBuildup',
		click: [ Click(142,4,repeats: 5), Click(142,2) ],
		lights: [DMXIS.loadFromMIDI('synthBuildup',"/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/dmxMIDI/synthBuildup.mid")],

	),(
		name: 'outro',
		click: [ Click(142,4,repeats: 57), Click(142,2) ],  // last beat
		lights: [DMXIS.loadFromMIDI('outro',"/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/dmxMIDI/outro.mid")],

	)
]
)