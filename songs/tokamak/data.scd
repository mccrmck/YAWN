///////////////////////////////////////////////// YAWN Data: tokamak /////////////////////////////////////////////////

var cueKeys = ['tokamakLoop'];
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/tokamak/dmxMIDI/";
var pathToKemperMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/tokamak/kemperMIDI/";

[
	(
		name:  'tokamakCount',
		click: [[ Click(142,2,repeats: 2), Click(142,1,repeats: 4) ]],
		lights:[ DMXIS.makePat('tokamakCount',pathToDMXMIDI ++ "count.mid") ],
		kemper:[ KemperMIDI.makePat('tokamakCount',pathToKemperMIDI ++ "count.mid") ],
	),(
		name:  'tokamakBeginning',
		click: [[ Click(142,4,repeats: 125) ]],
		lights:[ DMXIS.makePat('tokamakBeginning',pathToDMXMIDI ++ "beginning.mid") ],
		kemper:[ KemperMIDI.makePat('tokamakBeginning',pathToKemperMIDI ++ "beginning.mid") ]
	),(
		name:  'tokamakImproIntro',
		click: [[ Click(142,1,repeats: 192) ]],
		lights:[ DMXIS.makePat('tokamakImproIntro',pathToDMXMIDI ++ "impro.mid")],    //this needs to change!!!
		kemper:[ KemperMIDI.makePat('tokamakImproIntro',pathToKemperMIDI ++ "improIntro.mid") ]
	),(
		name:  'tokamakImproLoop',
		click: [[ ClickLoop(142,loopKey: cueKeys[0]) ]],
		lights:[ DMXIS.makePat('tokamakImproLoop',pathToDMXMIDI ++ "impro.mid",cueKeys[0])],
		kemper:[ KemperMIDI.makePat('tokamakImproLoop',pathToKemperMIDI ++ "improLoop.mid") ]
	),(
		name:  'tokamakCue',
		click: [[ ClickCue(142,4,repeats: 2), ClickCue(142,2,repeats: 2), ClickCue(142,1,repeats: 4) ]],
		lights:[ DMXIS.makePat('tokamakCue',pathToDMXMIDI ++ "cue.mid")],
		kemper:[ KemperMIDI.makePat('tokamakCue',pathToKemperMIDI ++ "cue.mid") ]
	),(
		name:  'tokamakBuildup',
		click: [[ Click(142,4,repeats: 5), Click(142,2) ]],
		lights:[ DMXIS.makePat('tokamakBuildup',pathToDMXMIDI ++ "buildup.mid") ],
		kemper:[ KemperMIDI.makePat('tokamakBuildup',pathToKemperMIDI ++ "buildup.mid") ]
	),(
		name:  'tokamakOutro',
		click: [[ Click(142,4,repeats: 57), Click(142,2) ]],  // last beat
		lights:[ DMXIS.makePat('tokamakOutro',pathToDMXMIDI ++ "outro.mid") ],
		kemper:[ KemperMIDI.makePat('tokamakOutro',pathToKemperMIDI ++ "outro.mid") ]
	)
]