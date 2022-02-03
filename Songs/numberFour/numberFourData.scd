///////////////////////////////////////////////// YAWN Data: numberFour /////////////////////////////////////////////////

var cueKeys = [\openFour];
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/dmxMIDI/";
var pathToKemperMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/kemperMIDI/";

[
	(
		name: 'fourCount',
		click: [ Click(142,2,repeats: 2), Click(142,1,repeats: 4) ],
		lights:[ DMXIS.makePat('fourCount',pathToDMXMIDI ++ "count.mid") ],
		kemper:[ KemperMIDI.makePat('fourCount',pathToKemperMIDI ++ "count.mid") ]
		),(
		name: 'fourBeginning',
		click: [ Click(142,4,repeats: 125) ],
		lights:[ DMXIS.makePat('fourBeginning',pathToDMXMIDI ++ "beginning.mid") ],
		kemper:[ KemperMIDI.makePat('fourBeginning',pathToKemperMIDI ++ "beginning.mid") ]
	),(
		name: 'fourImproIntro',
		click: [ Click(142,1,repeats: 192) ],
		lights:[ DMXIS.makePat('fourImproIntro',pathToDMXMIDI ++ "impro.mid",cueKeys[0])],    //this needs to change!!!
		kemper:[ KemperMIDI.makePat('fourImproIntro',pathToKemperMIDI ++ "improIntro.mid") ]
	),(
		name: 'fourImproLoop',
		click: [ ClickLoop(142,loopKey: cueKeys[0]) ],
		lights:[ DMXIS.makePat('fourImproLoop',pathToDMXMIDI ++ "impro.mid",cueKeys[0])],
		kemper:[ KemperMIDI.makePat('fourImproLoop',pathToKemperMIDI ++ "improLoop.mid") ]
	),(
		name: 'fourCue',
		click: [ ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4) ],
		lights:[ DMXIS.makePat('fourCue',pathToDMXMIDI ++ "cue.mid")],
		kemper:[ KemperMIDI.makePat('fourCue',pathToKemperMIDI ++ "cue.mid") ]
	),(
		name:'fourBuildup',
		click: [ Click(142,4,repeats: 5), Click(142,2) ],
		lights:[ DMXIS.makePat('fourBuildup',pathToDMXMIDI ++ "buildup.mid") ],
		kemper:[ KemperMIDI.makePat('fourBuildup',pathToKemperMIDI ++ "buildup.mid") ]
	),(
		name: 'fourOutro',
		click: [ Click(142,4,repeats: 57), Click(142,2) ],  // last beat
		lights:[ DMXIS.makePat('fourOutro',pathToDMXMIDI ++ "outro.mid") ],
		kemper:[ KemperMIDI.makePat('fourOutro',pathToKemperMIDI ++ "outro.mid") ]
	)
]

