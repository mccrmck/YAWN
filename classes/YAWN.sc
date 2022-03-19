YAWNShow {

	var <>setList, <inputs, <kemperMIDI, <outputs;
	var <songArray, <clickAmp;
	var <gitarIn, <bassDIn, <snareIn;
	var <masterOut, <clickOut, <trackOut;

	*new { |setList, inputs, lights, kemperMIDIDevice, outputs, ui = \lemur|      // this needs to ouput a bunch of booleans that get passed to the .cueFrom method

		^super.newCopyArgs(setList.asArray, inputs.asDict, kemperMIDIDevice.asArray, outputs.asDict).init(lights,ui);
	}

	init { |lights, controller|
		var server = Server.default;
		// var cond = CondVar();

		server.waitForBoot({

			if(lights,{ DMXIS() });    // needs to be set to preset !

			server.sync;

			if(kemperMIDI.notNil,{ KemperMIDI(kemperMIDI[0],kemperMIDI[1]) }); // right???!?!?!

			server.sync;

			clickAmp = Bus.control(server,1).set(0.5);

			songArray = setList.collect({ |item|
				YAWNSong( item.asSymbol );
			});
			0.postln; server.sync;

			songArray.do({ |song| song.loadPBtracks(server) });
			1.postln; server.sync;

			songArray.do({ |song| song.loadData(this) });   // this takes a long time and need to use a Condition...this is the worst one I think!
			2.postln; server.sync;

			songArray.do({ |song|                           // and this too!

				song.clicks.deepDo(3,{ |click|                 // this can change - click[0] == first channel, click[1] == second channel, etc.
					click.amp = { clickAmp.getSynchronous };
					click.out = outputs['clickOut'];           // can later make this a conditional: if(clickOut.size > 1,{do some fancy routing shit})
				})

			});

			3.postln; server.sync;

			switch(controller,
				{ \lemur },{ this.loadLemurInterface(this, songArray) },
				{ \touchOSC },{ "touchOSC functionality not implemented yet".warn },
				{ \scGUI },{ "scGUI not implemented yet".warn }
			);
			4.postln;

			"YAWNShow: % ready!".format(setList).postln;
		});
	}

	loadLemurInterface { |show, songArray|

		songArray.do({ |song|
			var songPath = song.path;
			File.readAllString(songPath +/+ "OSCdefs.scd").interpret.value(show, song);
		})

		// lemur.sendMsg('/main/setList/init',*songNames); // this should be a method that inits the master controls and updates the interface
	}

	// addToSetList { |index,item| // maybe udpates the setlist and creates a YAWNShow(newSetList)?}

	free { DMXIS.free } // must be more here, right???

}

/* ========================================== */

YAWNSong {

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

	loadData { |yawnShow|
		// var cond = CondVar();

		// fork {
		var file = File.readAllString(path +/+ "data.scd").interpret;
		data = file.value( yawnShow, this );
		// cond.wait({ data.notNil });
		// };

		^this
	}

	loadPBtracks { |server|
		pbTracks = IdentityDictionary();
		PathName(path +/+ "tracks").entries.do({ |entry|
			var key = entry.folderName.asSymbol;
			var folder = entry.entries.collect({ |track|
				Buffer.read(server,track.fullPath)
			});

			pbTracks.put(key,folder)

		});

		^this
	}

	sections {
		if(data.isNil,{ this.loadData });                           // this is a problem - cannot be called without passing in a |yawnShow|
		^data.collect({ |section| section['name'] });
	}

	clicks {
		if(data.isNil,{ this.loadData });                          // this is a problem - cannot be called without passing in a |yawnShow|
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