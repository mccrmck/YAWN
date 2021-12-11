///////////////////////////////////////////////// YAWN Data: numberFour /////////////////////////////////////////////////

var cueKeys = [\openFour];
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/dmxMIDI/";
var mikeGitIn = 4; // ?????

[
	(
		name: 'fourCount',
		click: [ Click(142,2,repeats: 2), Click(142,1,repeats: 4) ],
		lights:[ DMXIS.makePat('fourCount',pathToDMXMIDI ++ "count.mid") ],
	),(
		name: 'fourBeginning',
		click: [ Click(142,4,repeats: 125) ],
		lights:[ DMXIS.makePat('fourBeginning',pathToDMXMIDI ++ "beginning.mid") ],
	),(
		name: 'fourImpro',
		click: [ ClickLoop(142,loopKey: cueKeys[0]) ],
		lights:[ DMXIS.makePat('fourImpro',pathToDMXMIDI ++ "impro.mid",cueKeys[0])],
	),(
		name: 'fourCue',
		click: [ ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4) ],
		lights:[ DMXIS.makePat('fourCue',pathToDMXMIDI ++ "cue.mid")],
	),(
		name:'fourBuildup',
		click: [ Click(142,4,repeats: 5), Click(142,2) ],
		lights:[ DMXIS.makePat('fourBuildup',pathToDMXMIDI ++ "buildup.mid") ],
	),(
		name: 'fourOutro',
		click: [ Click(142,4,repeats: 57), Click(142,2) ],  // last beat
		lights:[ DMXIS.makePat('fourOutro',pathToDMXMIDI ++ "outro.mid") ],
	)
]