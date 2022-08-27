YAWNShow {

	classvar <>setList, <inDict, <outDict, <kemperMIDI;

	*new { |setList, inputs, outputs, kemperMIDIDevice, dmxBool = false, gui = 'openStageControl'|      // this needs to ouput a bunch of booleans that get passed to the .cueFrom method

		^super.new.init(setList.asArray, inputs.asDict, outputs.asDict, kemperMIDIDevice, dmxBool, gui);
	}

	init { |set, ins, outs, kemperMIDIDevice, dmxBool, controller|
		var server = Server.default; // CondVar here or?

		setList = set;
		inDict = ins;
		outDict = outs;
		kemperMIDI = kemperMIDIDevice.asArray;

		server.waitForBoot({

			// allocate buffers, busses...anything else?


			if(dmxBool,{ DMXIS() });    // needs to be set to preset !

			server.sync;

			if(kemperMIDIDevice.notNil,{ KemperMIDI(kemperMIDI[0],kemperMIDI[1]) }); // right???!?!?!

			server.sync;

			// launch gui
			// this.loadOpenStageControl;

			"YAWNShow - INIT".postln;
		});
	}

	loadOpenStageControl {
		var unixString = "open /Applications/open-stage-control.app --args " ++
		"--send 127.0.0.1:57120 " ++
		// "--read-only " ++
		"--load '/Users/mikemccormick/Library/Application\ Support/SuperCollider/Extensions/YAWN/gui/main.json'";
		// returns pid, can use that to evenutally stop process on GUI close?
		^unixString.unixCmd;
	}

	loadLemurInterface { |show, songArray|

		songArray.do({ |song|
			var songPath = song.path;
			File.readAllString(songPath +/+ "OSCdefs.scd").interpret.value(show, song);
		})

		// lemur.sendMsg('/main/setList/init',*songNames); // this should be a method that inits the master controls and updates the interface
	}

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

	loadData {
		var dataPath = path +/+ "data.scd";

		data = thisProcess.interpreter.executeFile(dataPath).value(this);

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
		var countInArray = [], cuedArray = [];

		if(countIn,{
			var bpm = this.clicks[fromIndex].flat.first.bpm;

			countInArray = Pseq([ Click(bpm,2,repeats: 2).pattern, Click(bpm,1,repeats: 4).pattern ]);   // must add outputs for these clicks as well!!
		},{
			countInArray = Pbind(
				\dur, Pseq([0],1),
				\note, Rest(0.1)
			)
		});

		// to test:
		/*
		if( countIn,{
		if(data[fromIndex]['countIn'].flat.size > 0, {
		var count = data[fromIndex]['countIn'].deepCollect(2,{ |clk| clk.pattern });
		count = count.collect({ |clk| Pseq(clk) });
		countInArray = countInArray.add( Ppar( count ) );
		})
		});
		*/

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
			Pseq( countInArray ++ cuedArray )
		);
	}
}