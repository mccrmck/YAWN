YAWNShowNew {

	var <cueList;

	*new {
		^super.new.init
	}

	init { |routingDict ...songList|
		cueList = OrderedIdentitySet();
		// maybe  this is structured like:
        /*	[
            'chaosCount' -> (
                pattern: songPattern,
                guiMsg: { Server.sendMsg("/display/gui/module/","thisModule") }
            )
        ]*/

		// YAWNKemper.initMIDI("UM-ONE", "UM-ONE");
		// YAWNDMXIS.initVST;
		// load songs, pbs, etc.

	}

	*loadSoundCheck {}

	addCue { |cueKey, songPattern|

		// make sure songPattern is a pattern here...
        // make sure cueKey doesn't already exist in cueList (dvs. overWriting another cue)

        if(cueList[cueKey.asSymbol].notNil,{
            cueList = cueList.put(cueKey.asSymbol -> songPattern);              // do I want to do this??

            OSCFunc({ |msg|

                case
                { msg == 1 }{ songPattern.play }
                { msg == 0 }{ songPattern.stop }

            },"/%".format(cueKey).asSymbol)

        },{
            "cueKey: % has already been used in this set".format().warn
        })

    }

	addLoopCue { |cueKey|

		OSCFunc({ |msg|

			case
			{ msg == 1 }{ [Click, YAWNDMXIS, YAWNKemper].do({|i| i.loopCues[cueKey] = false }) }
			{ msg == 0 }{ [Click, YAWNDMXIS, YAWNKemper].do({|i| i.loopCues[cueKey] = true  }) }

		},"/%".format(cueKey).asSymbol)
	}

    *april23 {
        ^"april 2023 baby".postln
    }


}

// maybe it's an YAWNShow.addCue('startShow',{}), YAWNShow.addCue(Cement.cueFrom('count','aSection'),[])
// can I autobuild a gui too?!?!?!


// YAWNShow gets a mixer - right?
// mixer channels get routed to hardware outputs (actually, Dante I/O) defined at startup
// or is this necessary? maybe pre-production removes the need for decent bus processing?

// I think each song should load the necessary ClickCue audio files at init instead of having them in the Click repository

