

// YAWNShow(
// 	[\cement,\numberOne,\numberTwo,\numberFour], //setList
// 	[\torfinnGitar -> [0,1],\bassTrigger -> 2, \snare -> 3], // HWinputs
// 	[\masterOut -> 0,\click -> 2], // HWoutputs
// \lemur, // interface/UI
// )


YAWNShow {

	var <>setList;
	var <lights, <kempers, <songArray, <clickAmp;

	*initClass {

		StartUp.add{

			SynthDef(\stereoYawnPlayBack,{
				var bufnum = \bufnum.kr();
				var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum) * \rate.kr(1),doneAction: 2);
				sig = Balance2.ar(sig[0],sig[1],\pan.kr(0),\amp.kr(0.8));
				OffsetOut.ar(\outBus.kr(0),sig);
			}).add;
		}
	}

	*new { |setList, kemperMIDIDevice, clickOut, ui = \lemur|           // must pass some arrays here: hardware ins/outs
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

				song.clicks.deepDo(3,{ |click|
					click.amp = { clickAmp.getSynchronous };
					click.out = clickOut;                             // can later make this a conditional: if(clickOut.size > 1,{do some fancy routing shit})
				});

			});

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

	// load synths for live processing/general performance page?

	// addToSetList { |index,item| // maybe udpates the setlist and creates a YAWNShow(newSetList)?}

	free { DMXIS.free } // must be more here, right???

}

/* === === === === === === === === === === */

YAWNSong { 	// each song needs to carry information about what it needs: allocated buffers? control/audio busses? Faders/knobs/gui stuff etc?

	classvar <songPaths;
	var <songName, sections, <data, <pbTracks;

	*initClass {
		var path = Platform.userExtensionDir +/+ "YAWN" +/+ "songs";

		songPaths = IdentityDictionary();

		PathName(path).entries.do({ |folderPath| songPaths.put(folderPath.folderName.asSymbol,folderPath.fullPath) });
	}

	*new { |name|
		^super.newCopyArgs(name).init;
	}

	init {

		if(songPaths[songName].notNil,{

			data = File.readAllString(songPaths[songName]  ++ "data.scd").interpret;

			// this can't happen unless the server is booted!!!

			pbTracks = PathName(songPaths[songName] ++ "tracks").entries.collect({ |entry|

				Buffer.read(Server.default,entry.fullPath); // make server a variable? Will it be used elsewhere?

			});

			// there needs to be accesible dictionaries for busses, .asr synths, parameters, etc.

			// load synthDefs
			File.readAllString(songPaths[songName]  ++ "synthDefs.scd").interpret;

			// load oscDefs....or does this depend on the interface argument in YAWNShow???

		},{
			"song folder does not exist".warn;
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

	cueFrom { |from = 'intro', to = 'outro', click = true, lights = true, kemper = true, countIn = false| // eventually add bTracks = true, osv.
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

	cueFrom2 { |from = 'intro', to = 'outro', click = true, lights = true, kemper = true, countIn = false| // eventually add bTracks = true, osv.
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

		for(fromIndex,toIndex,{ |index|
			var sectionArray = [];

			if( click,{
				var clkArray = data[index]['click'].deepCollect(3,{ |clk| clk.pattern });
				clkArray = clkArray.collect({ |clk| Pseq(clk) });

				sectionArray = sectionArray.add( Ppar(clkArray) );                        // does this work?
			});

			if( lights,{ sectionArray = sectionArray.add( data[index]['lights'] ) });

			if( kemper,{ sectionArray = sectionArray.add( data[index]['kemper'] ) });

			cuedArray = cuedArray.add( Ppar(sectionArray) );

		});

		^Pdef("%_%|%|%|%|%".format(from, to, click, lights, kemper, countIn).asSymbol,
			Pseq([ countInArray, cuedArray ])
		);
	}
}