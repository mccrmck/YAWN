///////////////////////////////////////////////// YAWN Data: numberFour /////////////////////////////////////////////////

var cueKeys = [\openFour];
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/dmxMIDI/";

[
	(
		name: 'fourCount',
		click: [ Click(142,2,repeats: 2), Click(142,1,repeats: 4) ],
		lights:[ DMXIS.loadFromMIDI('fourCount',pathToDMXMIDI ++ "count.mid") ],
	),(
		name: 'fourBeginning',
		click: [ Click(142,4,repeats: 125) ],
		lights:[ DMXIS.loadFromMIDI('fourBeginning',pathToDMXMIDI ++ "beginning.mid") ],

	),(
		name: 'fourImpro',
		click: [ ClickLoop(142,loopKey: cueKeys[0]) ],
		lights:[ DMXIS.loadFromMIDI('fourImpro',pathToDMXMIDI ++ "impro.mid",cueKeys[0]) ],

	),(
		name: 'fourCue',
		click: [ ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4) ],
		lights:[ DMXIS.loadFromMIDI('fourCue',pathToDMXMIDI ++ "cue.mid") ],
	),(
		name:'fourBuildup',
		click: [ Click(142,4,repeats: 5), Click(142,2) ],
		lights:[ DMXIS.loadFromMIDI('fourBuildup',pathToDMXMIDI ++ "buildup.mid") ],

	),(
		name: 'fourOutro',
		click: [ Click(142,4,repeats: 57), Click(142,2) ],  // last beat
		lights:[ DMXIS.loadFromMIDI('fourOutro',pathToDMXMIDI ++ "outro.mid") ],

	)
]