YAWNShow {

	var <>setList;
	var lights, <songArray;

	*new { |setList, ui = \lemur|                                       // must pass some arrays here: hardware ins/outs
		^super.newCopyArgs(setList.asArray).init(ui);
	}

	init { |controller|

		lights = DMXIS();                                                  // right??!?!?

		songArray = setList.collect({ |item, index|
			YAWNSong(item.asSymbol);
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
		"% does this shit work?".format(songNames).postln;

		// lemur.sendMsg('/main/setList/init',*songNames);
		// .scd file w/ relevant OSCdefs
	}

	// load synths for live processing/general performance page?


	// addToSetList { |index,item| // maybe udpates the setlist and creates a YAWNShow(newSetList)?}

	/*
	{

	setlist.do({ |song|  // maybe this is a Routine w/ Conditions?

	// song.class == YAWNSong

	song.makeClick;
	song.loadBuffers;
	.
	.
	.
	etc.
	})

	}
	*/
}

YAWNSong { 	// each song needs to carry information about what it needs: allocated buffers? control/audio busses? Faders/knobs/gui stuff etc?

	classvar songPaths;
	var <songName, sections, <data, <pbTracks;

	*initClass {
		var path = Platform.userExtensionDir +/+ "YAWN" +/+ "Songs";

		songPaths = IdentityDictionary();

		PathName(path).entries.do({ |folderPath| songPaths.put(folderPath.folderName.asSymbol,folderPath.fullPath) });

		/*StartUp.add{  // does this stay here or move into YAWNShow? This should perhaps only be data unique/related to each song? and then YAWNShow is the 'player'?
			// What's most  practical for rehearsals...what if I want to improvise on one tune, should those synths be loaded as well?

			SynthDef(\stereoBGSynth,{
				var bufnum = \bufnum.kr;
				var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum),doneAction: 2);
				sig = Balance2.ar(sig[0],sig[1],\pan.kr(0),\amp.kr(1));
				OffsetOut.ar(\outBus.kr(0),sig);
			}).add;
		}*/
	}

	*new { |name|
		^super.newCopyArgs(name).init;
	}

	init {

		if(songPaths[songName].notNil,{

			data = File.readAllString(songPaths[songName]  ++ "%Data.scd".format(songName)).interpret; // can pass args with .value(clickOut,clickAmp)!!

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
		var mastPat;

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
				var lightPdef = DMXIS.makePat(data[index]);

				lightArray = lightArray ++ lightPdef;
			});

			cuedArray = cuedArray.add(lightArray)
		});

		mastPat = Pdef("%Master".format(songName).asSymbol, // eventually copy playback, MIDI, etc. patterns into similiar arrays
			Pseq([
				countInArray,
				Ppar(cuedArray)
			],1)
		);

		^mastPat;
	}

	loadOSCdefs { |address|  // or device? Not sure how different the OSCFuncs will be if we use Lemur instead of TouchOSC

	}
}

// must add Click outputs and amp control!!!

// #1 intro should no longer be granular - repeating sampler w/ hold, reads args from sliders;
// all sliders should read from busses, mapped/scaled appropriately... everything needs to be normalized!!


// YAWNShow(
// 	[\cement,\numberOne,\numberTwo,\numberFour], //setList
// 	[\torfinnGitar -> [0,1],\bassTrigger -> 2, \snare -> 3], // HWinputs
// 	[\masterOut -> 0,\click -> 2], // HWoutputs
// \lemur, // interface/UI
// )



// YAWNInstrument {
// 	maybe? could have hardware input busses, EQ/compression settings, etc.
//
// }

