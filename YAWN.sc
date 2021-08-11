YAWNShow {

	var <>setList;

	*new { |set|
		^super.newCopyArgs(set).init;
	}

	init {

		setList.collect({ |item,index|
			YAWNSong(item.asSymbol);
		});
		/*
		make a bunch of <>Dictionaries?

		inHardware = Dictionary(); // adding an input adds a bus to the dictionary?
		outHardware = Dictionary();

		cues = Dictionary(); //maybe this isn't necessary if the Click class can store the cues in an instance??
		busses = Dictionary(); // reverb/master added automatically
		groups = Dictionary(); ??
		buffers = Dictionary(); ??
		guiFuncs = Dictionary(); // might need a couple of these, not sure how that's going to work yet...

		*/


		// addToSetList { |index,item| // maybe udpates the setlist and creates a YAWNShow(newSetList)?}
	}

	// load MIDI controller functions
	// YAWNShow.gui

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

YAWNSong {

	classvar <all;
	var <songName, sections, <mastArray, <pbTracks;

	*initClass {
		var path = Platform.userExtensionDir +/+ "YAWN" +/+ "Songs";

		all = IdentityDictionary();

		PathName(path).entries.do({ |entry| all.put(entry.folderName.asSymbol,entry)});

		StartUp.add{

			SynthDef(\stereoBGPBSynth,{
				var bufnum = \bufnum.kr;
				var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum),doneAction: 2);
				sig = Balance2.ar(sig[0],sig[1],\pan.kr(0),\amp.kr(1));
				OffsetOut.ar(\outBus.kr(0),sig);
			}).add;
		}
	}

	*new { |name|
		^super.newCopyArgs(name).init;
	}

	init {

		if(all[songName].notNil,{

			mastArray = File.readAllString(all[songName].fullPath  ++ "%Data.scd".format(songName)).interpret;    // consider separating these into different files? Click

			pbTracks = PathName(all[songName].fullPath  ++ "%Tracks".format(songName)).entries.collect({ |entry| // consider putting bufs into a Dictionary also? Necessary?

				Buffer.read(Server.default,entry.fullPath);

			});

			// allocate/evaluate a bunch of shit
			// collect cues into dictionary somewhere - maybe using regexp? Or just better cue names in the mastArray...
			// load synths

			// make a function that .flops everything that needs to run in the same Pdef?
			// MasterPdef.include(\click,\trackPlayback,\dmx,\kemperPatches, \anything else?)

		})

	}

	sections {
		var sectArray =	mastArray.collect({|section| section['name']});
		^sectArray
	}

	clicks {
		var clickArray = mastArray.collect({|section| section['click']});
		^clickArray
	}

	playFrom { |from = \intro, to = \outro, countIn = true| // if this works, I can remove count-ins from every Data file!
		var fromInd = this.sections.indexOf(from);
		var toInd = this.sections.indexOf(to);
		var click = [];

		for(fromInd,toInd,{ |index|

			click = click ++ mastArray[index]['click'];
		});

		if(countIn and: {this.clicks[fromInd].flat.first.isKindOf(Click)},{   // maybe I don't need this second condition when I figure out solutions for \rit3, etc.
			var bpm = this.clicks[fromInd].flat.first.bpm;

			click = [Click(bpm,2,repeats: 2), Click(bpm,1,repeats: 4)] ++ click;
		},{
			click
		});

		/*
		eventually copy playback, MIDI, DMX, etc. patterns into similiar arrays

		*/

		^click; //eventually will be a master Pdef, Pspawner, Routine, etc.
	}

}

// eventual new features/additions that don't exist yet...DMX integration? track playback? Can everything just run from the master Pdef?
// #1 intro should no longer be granular - repeating sampler w/ hold, reads args from sliders;
// all sliders should read from busses, mapped/scaled appropriately... everything needs to be normalized!!
// is there a way to have input processing available at all times? Always ready for impro?


// YAWNShow(
// 	[\cement,\numberOne,\numberTwo,\numberFour], //setList
// 	[\torfinnGitar -> [0,1],\bassTrigger -> 2, \snare -> 3], // HWinputs
// 	[\masterOut -> 0,\click -> 2], // HWoutputs
// )



// YAWNInstrument {
// 	maybe? could have hardware input busses, EQ/compression settings, etc.
//
// }

