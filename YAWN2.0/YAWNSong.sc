YAWNSongNew {

	classvar <server, <mixerDict;
	classvar <data, <pbTracks;

	*initClass {

		pbTracks = IdentityDictionary();
	}

	*new { |insOuts|
		^super.new.init(insOuts)
	}

	init { |routingDict|          // what else goes here??
		server    = server ? Server.default;  // is this necessary? Are we ever going to run a multi-server setup?
		mixerDict = routingDict;
	}

	*sections { ^data.collect({ |section| section.key }) }

	*loadPBtracks { |action|
		var cond = CondVar();
		var path = this.filenameSymbol.asString.dirname +/+ "tracks/";

		fork{
            PathName(path).entries.do({ |trackFolder|
				var busKey = trackFolder.folderName.asSymbol;
				var bufDict = IdentityDictionary();
				var buffer = trackFolder.entries.do({ |track|
					var trackKey = track.fileNameWithoutExtension.asSymbol;
					var buf = Buffer.read(server,track.fullPath, action: { cond.signalOne });
					cond.wait {	buf.numFrames.notNil };
					bufDict.put( trackKey, buf )
				});
				pbTracks.put(busKey, bufDict)
			});
			"%: pbTracks loaded".format(this).postln;
			action.value
		}
	}

	*loadSynthDefs {}
	*loadOSCdefs {}
	*loadData {}

	// should cueKeys be easier to access? Should they be const vals?!
	// if each YAWNSong instance stores its own keys, it could also be a way to avoid overlapping/clashing keys?

	*cueFrom { |from, to, countIn = false|
		var fromIndex = this.sections.indexOf(from);
		var toIndex = this.sections.indexOf(to);
		var countInArray = [], cuedArray = [];

		if(countIn,{
			if( this.data[fromIndex].value['countIn'].flat.size > 0, {
				var count = data[fromIndex].value['countIn'].asArray.collect({ |clk| clk.pattern });
				countInArray = countInArray.add( Ppar( count ) );
			})
		});

		for(fromIndex,toIndex,{ |index|
			var sectionArray = [];
			var clickArray  = data[index].value['click'].asArray.collect({ |clk| clk.pattern });
			var lightArray  = data[index].value['lights'].asArray;
			var kemperArray = data[index].value['kemper'].asArray;
			var bTrackArray = data[index].value['bTracks'].asArray;

			if(clickArray.size > 0, { sectionArray = sectionArray.add( Ppar( clickArray ) ) });

			if(lightArray.size > 0, { sectionArray = sectionArray.add( Ppar( lightArray ) ) });  // is Ppar necessary here?

			if(kemperArray.size > 0,{ sectionArray = sectionArray.add( Ppar( kemperArray ) ) }); // is Ppar necessary here?

			if(bTrackArray.size > 0,{ sectionArray = sectionArray.add( Ppar( bTrackArray ) ) });

			cuedArray = cuedArray.add( Ppar( sectionArray ) );
		});

		^Pdef("%_%".format(from, to).asSymbol,
			Pseq( countInArray ++ cuedArray )
		);
	}
}
