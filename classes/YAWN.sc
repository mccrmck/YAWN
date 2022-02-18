YAWNShow {

	var <>setList, <inputs, <kemperMIDI, <outputs;
	var <songArray, <clickAmp;

	*new { |setList, inputs, lights, kemperMIDIDevice, outputs, ui = \lemur|      // this needs to ouput a bunch of booleans that get passed to the .cueFrom method

		^super.newCopyArgs(setList.asArray, inputs.asDict,kemperMIDIDevice,outputs.asDict).init(lights,ui);
	}

	init { |lights,controller|
		var server = Server.default;

		server.waitForBoot({

			if(lights,{ DMXIS() });  // right??!?!?

			server.sync;

			if(kemperMIDI.notNil,{ KemperMIDI(kemperMIDI.unbubble.asString) }); // right???!?!?!

			server.sync;

			clickAmp = Bus.control(server,1).set(0.5);        // eventually get this on the \db.spec system!!

			songArray = setList.collect({ |item|
				YAWNSong(item.asSymbol);
			});

			songArray.do({ |song| song.loadPBtracks });
			songArray.do({ |song| song.loadData(song) });

			server.sync;

			songArray.do({ |song|                            // a bunch of stuff will probably happen here evenutally, no? changing DMX channels, for example?

				song.clicks.deepDo(3,{ |click|                   // this can change - click[0] == first channel, click[1] == second channel, etc.
					click.amp = { clickAmp.getSynchronous };
					// click.out = clickOut;                        // can later make this a conditional: if(clickOut.size > 1,{do some fancy routing shit})
				});

			});

			server.sync;

			switch(controller,
				{ \lemur },{ this.loadLemurInterface(songArray) },
				{ \touchOSC },{ "touchOSC functionality not implemented yet".warn },
				{ \scGUI },{ "scGUI not implemented yet".warn }
			);
		});
	}

	loadLemurInterface { |songArray|

		songArray.do({ |song|
			var songPath = song.path;
			File.readAllString(songPath +/+ "OSCdefs.scd").interpret.value(song);
		})

		// lemur.sendMsg('/main/setList/init',*songNames);
	}

	// addToSetList { |index,item| // maybe udpates the setlist and creates a YAWNShow(newSetList)?}

	free { DMXIS.free } // must be more here, right???

}

/* ========================================== */

YAWNSong { 	// each song needs to carry information about what it needs: allocated buffers? control/audio busses? Faders/knobs/gui stuff etc?

	classvar songFolderPath;
	var <songName, <path, <pbTracks, <data;

	*initClass {
		songFolderPath = Platform.userExtensionDir +/+ "YAWN/songs/";    // can this be more robust? check Daniel Mayer's PathName extension!
	}

	*new { |name|
		^super.newCopyArgs(name).init;
	}

	init {
		path = songFolderPath +/+ songName;
		^this
	}

	loadData { |song|                                                                     //modularize this! .loadClicks, .loadLights, etc
		data = File.readAllString(path +/+ "data.scd").interpret.value(song);
		^this
	}

	loadPBtracks { |server|
		server = server ? Server.default;
		pbTracks = IdentityDictionary();
		PathName(path +/+ "tracks").entries.do({ |entry|
			var key = entry.fileNameWithoutExtension;
			pbTracks.put(key.asSymbol,	Buffer.read(server,entry.fullPath) )    // make server a variable? Will it be used elsewhere?
		});
	}

	sections {
		if(data.isNil,{ this.loadData });
		^data.collect({ |section| section['name'] });
	}

	clicks {
		if(data.isNil,{ this.loadData });
		^data.collect({ |section| section['click'] });
	}

	cueFrom { |from = 'intro', to = 'outro', click = true, lights = true, kemper = true, bTracks = true, countIn = false|
		var fromIndex = this.sections.indexOf(from);
		var toIndex = this.sections.indexOf(to);
		var countInArray, cuedArray = [];

		if(countIn,{
			var bpm = this.clicks[fromIndex].flat.first.bpm;

			countInArray = Pseq([ Click(bpm,2,repeats: 2).pattern, Click(bpm,1,repeats: 4).pattern ]);   // must add outputs for these clicks as well!!
		},{
			countInArray = Pbind(
				\dur, Pseq([0],1),
				\note, Rest(0.1)
			)
		});

		for(fromIndex,toIndex,{ |index|
			var sectionArray = [];

			if( click,{
				var clkArray = data[index]['click'].deepCollect(2,{ |clk| clk.pattern });

				clkArray = clkArray.collect({ |clk| Pseq(clk) });

				if(clkArray.size > 0,{
					sectionArray = sectionArray.add( Ppar( clkArray ) );
				});
			});

			if( lights,{
				var lightArray = data[index]['lights'];

				if(lightArray.size > 0,{
					sectionArray = sectionArray.add( Ppar( lightArray ) );
				});
			});

			if( kemper,{
				var kemperArray = data[index]['kemper'];

				if(kemperArray.size > 0,{
					sectionArray = sectionArray.add( Ppar( kemperArray ) );
				});
			});

			if( bTracks,{
				var trackArray = data[index]['bTracks'];

				if(trackArray.size > 0,{
					sectionArray = sectionArray.add( Ppar( trackArray ) );
				});
			});

			cuedArray = cuedArray.add( Ppar( sectionArray ) );
		});

		^Pdef("%_%|%|%|%|%".format(from, to, click, lights, kemper, bTracks, countIn).asSymbol,
			Pseq( [countInArray] ++ cuedArray )
		);
	}
}
