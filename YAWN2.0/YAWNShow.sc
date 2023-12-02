YAWNShowNew {

	var <cueList;

	*new {
		^super.new.init
	}

	init {
		cueList = IdentityDictionary();
		// maybe  this is structured like:
	/*	[
			'chaosCount' -> (
				pattern: songPattern,
				guiMsg: { Server.sendMsg("/display/gui/module/","thisModule") }
			)
		]*/


		// YAWNKemper.initMIDI("UM-ONE", "UM-ONE")
		// YAWNDMXIS.initVST
		// load songs, pbs, etc.

	}

	*loadSoundCheck {}

	addCue { |cueKey, songPattern|

		// make sure songPattern is a pattern here...

		cueList = cueList.put(cueKey.asSymbol -> songPattern);              // do I want to do this??


		OSCdef((cueKey ++ UniqueID.next).asSymbol,{ |msg|

			case
			{ msg == 1 }{ songPattern.play }
			{ msg == 0 }{ songPattern.stop }

		},'/addressGoesHere')
	}

	addLoopCue { |cueKey|

		OSCdef(cueKey.asSymbol,{ |msg|

			case
			{ msg == 1 }{ [Click, YAWNDMXIS, YAWNKemper].do({|i| i.loopCues[cueKey] = false }) }
			{ msg == 0 }{ [Click, YAWNDMXIS, YAWNKemper].do({|i| i.loopCues[cueKey] = true  }) }

		},'/addressGoesHere')
	}


}

// Is YAWNSet obsolete? Maybe it's just YAWNShow.setlist?

// maybe it's an YAWNShow.addCue('startShow',{}), YAWNShow.addCue(Cement.cueFrom('count','aSection'),[])
// can I autobuild a gui too?!?!?!


// YAWNShow gets a mixer - right?
// mixer channels get routed to hardware outputs (actually, Dante I/O) defined at startup
// or is this necessary? maybe pre-production removes the need for decent bus processing?

// I think each song should load the necessary ClickCue audio files at init instead of having them in the Click repository


// april 2023, for example
// y = YAWNShow()
//
// y.addCue( Show.cueFrom('welcomeVoice','welcomeVoice') ) // need to make this class...
// // blast stuff here...
// y.addCue( Chaos.cueFrom('count','elevenLast',true) )
// y.addLoopCue( 'elevenLoopOne' )
// y.addLoopCue( 'elevenLoopTwo' )
// y.addCue( Chaos.cueFrom('bomb','bomb') )
// y.addCue( Chaos.cueFrom('countAgain','outro') )
//
//
//
// y.addCue( Show.cueFrom('welcomeVoice','welcomeVoice') ) // need to make this class...
//
