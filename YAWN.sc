YAWNShow {

	var <>setList;
	var <lights, <songArray, <clickAmp;

	*new { |setList, clickOut, ui = \lemur|                                       // must pass some arrays here: hardware ins/outs
		^super.newCopyArgs(setList.asArray).init(clickOut,ui);
	}

	init { |clickOut,controller|
		var server = Server.default;

		server.waitForBoot({

			lights = DMXIS();       // right??!?!?

			clickAmp = Bus.control(server,1).set(0.5);                            // eventually get this on the \db.spec system!!

			songArray = setList.collect({ |item, index|
				YAWNSong(item.asSymbol);
			});

			songArray.do({ |song|                                                 // a bunch of stuff will probably happen here evenutally, no? changing DMX channels, for example?

				song.clicks.deepDo(3,{ |click|
					click.amp = { clickAmp.getSynchronous };
					click.out = clickOut;
				});

			});

			//load buffers, busses, etc.

		});

		/*
		make a bunch of <>Dictionaries?

		inHardware = Dictionary(); // adding an input adds a bus to the dictionary?
		outHardware = Dictionary();

		cues = Dictionary(); //maybe this isn't necessary if the Click class can store the cues in an instance??
		busses = Dictionary(); // reverb/master added automatically
		groups = Dictionary(); ??
		OSCdefs = Dictionary() ???
		*/

		switch(controller,
			{ \lemur },{ this.loadLemurInterface(setList) },
			{ \touchOSC },{ "touchOSC functionality not implemented yet".warn },
			{ \scGUI },{ "scGUI not implemented yet".warn }
		);
	}

	loadLemurInterface { |songNames|
		// "% does this shit work?".format(songNames).postln;

		// lemur.sendMsg('/main/setList/init',*songNames);
		// .scd file w/ relevant OSCdefs
	}

	// load synths for live processing/general performance page?


	// addToSetList { |index,item| // maybe udpates the setlist and creates a YAWNShow(newSetList)?}

}

YAWNSong { 	// each song needs to carry information about what it needs: allocated buffers? control/audio busses? Faders/knobs/gui stuff etc?

	classvar songPaths;
	var <songName, sections, <data, <pbTracks;

	*initClass {
		var path = Platform.userExtensionDir +/+ "YAWN" +/+ "Songs";

		songPaths = IdentityDictionary();

		PathName(path).entries.do({ |folderPath| songPaths.put(folderPath.folderName.asSymbol,folderPath.fullPath) });
	}

	*new { |name|
		^super.newCopyArgs(name).init;
	}

	init {

		if(songPaths[songName].notNil,{

			data = File.readAllString(songPaths[songName]  ++ "%Data.scd".format(songName)).interpret;


			// this can't happen unless the server is booted!!!

			pbTracks = PathName(songPaths[songName] ++ "%Tracks".format(songName)).entries.collect({ |entry| // consider putting bufs into a Dictionary also? Or how do I plan to call them?

				Buffer.read(Server.default,entry.fullPath); // make server a variable? Will it be used elsewhere?

			});


			// there needs to be accesible dictionaries for busses, .asr synths, parameters, etc.


			// collect cues into dictionary somewhere - maybe using regexp? Or better cue names in the data...or they get passed into the data and collected here?

			// load synthDefs
			File.readAllString(songPaths[songName]  ++ "%SynthDefs.scd".format(songName)).interpret;

			// load oscDefs....or does this depend on the interface argument in YAWNShow???

		},{
			"Song folder does not exist".warn;
		});
	}

	*catalogue {
		this.songPaths.keysDo(_.postln);
	}

	sections {
		var sectArray =	data.collect({ |section| section['name'] });
		^sectArray
	}

	clicks {
		var clickArray = data.collect({ |section| section['click'] });
		^clickArray
	}

	cueFrom { |from = \intro, to = \outro, click = true, lights = true, countIn = false| // eventually add bTracks = true, kemper = true, osv.
		var fromIndex = this.sections.indexOf(from);
		var toIndex = this.sections.indexOf(to);
		var countInArray, cuedArray = [];
		var cuedPat;

		// does countIn work? Must test....
		if(countIn and: { this.clicks[fromIndex].flat.first.isKindOf(Click) },{   // maybe I don't need this second condition when I figure out solutions for \rit3, \elevenRiff etc.
			var bpm = this.clicks[fromIndex].flat.first.bpm;

			countInArray = Psym(                  // must add outputs for this click as well!! Can these be passed through YAWNShow?
				Pseq([
					Click(bpm,2,repeats: 2),
					Click(bpm,1,repeats: 4)
				].flat.clickKeys)
			);
		},{
			countInArray = Pbind(
				\dur,Pseq([0],1),
				\note, Rest()
			);
		});

		if( click,{
			var clickArray = [];

			for(fromIndex,toIndex,{ |index|

				clickArray = clickArray ++ data[index]['click'];
			});

			clickArray = Psym( Pseq(clickArray.clickKeys) );

			cuedArray = cuedArray.add(clickArray)
		});

		if( lights,{
			var lightArray = [];

			for(fromIndex,toIndex,{ |index|
				var sectionLights = data[index]['lights'];
				var sectionArray = sectionLights.collect({ |lightCue, lightIndex|

					switch(lightIndex,
						0,{ DMXIS.makePat(data[index]['name']) },
						1,{ /* audio reactive loader here */ }                            // next step!
					);
				});

				lightArray = lightArray.add(sectionArray);
			});

			lightArray = lightArray.collect(_.unbubble);

			lightArray = Pseq(lightArray);

			cuedArray = cuedArray.add(lightArray)
		});

		/*
		if( lights,{
		var lightArray = [];
		for(fromIndex,toIndex,{ |index|
		var lightPdef = DMXIS.makePat(data[index]['name']);
		lightArray = lightArray ++ lightPdef;
		});
		lightArray = Pseq(lightArray);
		cuedArray = cuedArray.add(lightArray)
		});
		*/

		cuedPat = Pdef("%Master".format(songName).asSymbol, // eventually copy playback, MIDI, etc. patterns into similiar arrays
			Pseq([
				countInArray,
				Ppar(cuedArray)
			])
		);

		^cuedPat;
	}

	loadOSCdefs { |address|  // or device? Not sure how different the OSCFuncs will be if we use Lemur instead of TouchOSC

	}
}

// all sliders should read from busses, mapped/scaled appropriately... everything needs to be normalized!!


// YAWNShow(
// 	[\cement,\numberOne,\numberTwo,\numberFour], //setList
// 	[\torfinnGitar -> [0,1],\bassTrigger -> 2, \snare -> 3], // HWinputs
// 	[\masterOut -> 0,\click -> 2], // HWoutputs
// \lemur, // interface/UI
// )

