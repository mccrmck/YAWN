

// YAWNShow(
// 	[\cement,\numberOne,\numberTwo,\numberFour], //setList
// 	[\torfinnGitar -> [0,1],\bassTrigger -> 2, \snare -> 3], // HWinputs
// 	[\masterOut -> 0,\click -> 2], // HWoutputs
// \lemur, // interface/UI
// )


YAWNShow {

	var <>setList;
	var <lights, <kempers, <songArray, <clickAmp;

	*new { |setList, kemperMIDIDevice, clickOut, ui = \lemur|      // this needs to ouput a bunch of booleans that get passed to the .cueFrom method
		// if(clickOut.notNil,{ click = true, })
		// must pass some arrays here: hardware ins/outs

		^super.newCopyArgs(setList.asArray).init(kemperMIDIDevice, clickOut, ui);
	}

	init { |kemperMIDIDevice, clickOut, controller|
		var server = Server.default;

		server.waitForBoot({

			lights = DMXIS();                                   // right??!?!?

			server.sync;

			kempers = KemperMIDI(kemperMIDIDevice.asString);    // right???!?!?!

			server.sync;

			clickAmp = Bus.control(server,1).set(0.5);        // eventually get this on the \db.spec system!!

			songArray = setList.collect({ |item|
				YAWNSong(item.asSymbol);
			});

			songArray.do({ |song|                            // a bunch of stuff will probably happen here evenutally, no? changing DMX channels, for example?

				// song.loadData;
				// song.loadPBtracks;

				song.clicks.deepDo(3,{ |click|                   // this can change - click[0] == first channel, click[1] == second channel, etc.
					click.amp = { clickAmp.getSynchronous };
					click.out = clickOut;                             // can later make this a conditional: if(clickOut.size > 1,{do some fancy routing shit})
				});

			});

			server.sync;

			switch(controller,
				{ \lemur },{ this.loadLemurInterface(setList) },
				{ \touchOSC },{ "touchOSC functionality not implemented yet".warn },
				{ \scGUI },{ "scGUI not implemented yet".warn }
			);

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


	}

	loadLemurInterface { |setList|

		setList.do({ |songName|
			var path = YAWNSong.songPaths;
			File.readAllString(path[songName]  ++ "OSCdefs.scd").interpret;
		})

		// lemur.sendMsg('/main/setList/init',*songNames);
	}

	// addToSetList { |index,item| // maybe udpates the setlist and creates a YAWNShow(newSetList)?}

	free { DMXIS.free } // must be more here, right???

}

/* ========================================== */

YAWNSong { 	// each song needs to carry information about what it needs: allocated buffers? control/audio busses? Faders/knobs/gui stuff etc?

	classvar <songPaths;
	var <songName, sections, <data, <pbTracks;

	*initClass {
		songPaths = IdentityDictionary();
	}

	*new { |name|
		^super.newCopyArgs(name).init;
	}

	init {
		var key = songName.asSymbol;
		var songPath = PathName( Platform.userExtensionDir +/+ "YAWN/songs/%/".format(key) );
		songPaths.put(key,songPath.fullPath);
		this.loadData;

		pbTracks = IdentityDictionary();
		^this
	}

	loadData {                                                                                   //modularize this! .loadClicks, .loadLights, etc
		^data = File.readAllString(songPaths[songName]  ++ "data.scd").interpret;
	}

	loadPBtracks {
		PathName(songPaths[songName] ++ "tracks").entries.do({ |entry|
			var key = entry.fileNameWithoutExtension;
			pbTracks.put(key.asSymbol,	Buffer.read(Server.default,entry.fullPath) ) // make server a variable? Will it be used elsewhere?

		});
		^pbTracks
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

	cueFrom { |from = 'intro', to = 'outro', click = true, lights = true, kemper = true, bTracks = true, countIn = false|
		var fromIndex = this.sections.indexOf(from);
		var toIndex = this.sections.indexOf(to);
		var countInArray, cuedArray = [];

		if(countIn,{
			var bpm = this.clicks[fromIndex].flat.first.bpm;

			countInArray = Pseq([ Click(bpm,2,repeats: 2).pattern, Click(bpm,1,repeats: 4).pattern ]);  // must add outputs for these clicks as well!!
		},{
			countInArray = Pbind(
				\dur, Pseq([0],1),
				\note, Rest(0.1)
			)
		});

		for(fromIndex,toIndex,{ |index|                                                     // this needs to figure out how to handle empty arrays!
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

		^Pdef("%_%|%|%|%|%".format(from, to, click, lights, kemper, countIn).asSymbol,
			Pseq( [countInArray] ++ cuedArray )
		);
	}

	/*
	cueFromOld { |from = 'intro', to = 'outro', click = true, lights = true, kemper = true, countIn = false| // eventually add bTracks = true, osv.
	var fromIndex = this.sections.indexOf(from);
	var toIndex = this.sections.indexOf(to);
	var countInArray, cuedArray = [];

	if(countIn,{
	var bpm = this.clicks[fromIndex].flat.first.bpm;

	countInArray = Pseq([ Click(bpm,2,repeats: 2).pattern, Click(bpm,1,repeats: 4).pattern ]);  // must add outputs for these clicks as well!!
	},{
	countInArray = Pbind(
	\dur,Pseq([0],1),
	\note, Rest(0.1)
	)
	});

	if(click,{
	var clickArray = [];

	for(fromIndex,toIndex,{ |index|

	clickArray = clickArray ++ data[index]['click'];
	});

	clickArray = clickArray.deepCollect(3,{ |clk| clk.pattern.key });
	clickArray = Psym( Pseq(clickArray) );

	cuedArray = cuedArray.add(clickArray);
	});

	if(lights,{
	var lightArray = [];

	for(fromIndex,toIndex,{ |index|

	lightArray = lightArray.add( data[index]['lights'] );
	});

	lightArray = lightArray.collect(_.unbubble);
	lightArray = Pseq(lightArray);

	cuedArray = cuedArray.add(lightArray);
	});

	if(kemper,{
	var kempArray = [];

	for(fromIndex,toIndex,{ |index|

	kempArray = kempArray.add( data[index]['kemper'] );
	});

	kempArray = kempArray.collect(_.unbubble);
	kempArray = Pseq(kempArray);

	cuedArray = cuedArray.add(kempArray);
	});

	^Pdef("%_%|%|%|%|%".format(from, to, click, lights, kemper, countIn).asSymbol,
	Pseq([
	countInArray,
	Ppar(cuedArray)
	])
	);
	}
	*/
}






