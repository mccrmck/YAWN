YAWNShow {

	var <>set;

	*new { |setList|
		^super.new.init(setList);
	}

	init { |setList|

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

		set = setList.collect({ |item,index|
			YAWNSong(item.asSymbol);
		})

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

	*initClass {
		var path = Platform.userExtensionDir +/+ "YAWN" +/+ "Songs";

		all = IdentityDictionary();

		PathName(path).entries.do({ |entry| all.put(entry.folderName.asSymbol,entry)});
	}

	*new { |name|
		var path = all[name]; // looks for a folder in the "Songs" folder, and then:

		// allocate/evaluate a bunch of shit
		// load click w/ section names?
		// load cues into dictionary somewhere
		// load buffers
		// load synths


		// make a function that .flops everything that needs to run in the same Pdef?
		// MasterPdef.include(\click,\trackPlayback,\dmx,\kemperPatch changes (MIDI Pdefs), \anything else?)
		^name
	}


	sections {
		// prints sections: [\intro,\verse1, etc.]
	}

	playClickFrom { |from = \intro, to = \outro| } // ?? is it possible to play the click section by section?

	rehearseFrom {} // maybe this is a better method name than the one above...can therefore include lights, etc.

}

YAWNSong(\cement).click

// eventual new features/additions that don't exist yet...DMX integration? track playback? Can everything just run from the master Pdef?
// #1 intro should no longer be granular - repeating sampler w/ hold, reads args from sliders;
// all sliders should read from busses, mapped/scaled appropriately... everything needs to be normalized!!
// is there a way to have input processing available at all times? Always ready for impro?
// YAWN song folder has a data.scd file which has cues, SynthDefs, etc?

/*

YAWNShow(
[\cement,\numberOne,\numberTwo,\numberFour], //setList
[\torfinnGitar -> [0,1],\bassTrigger -> 2, \snare -> 3], // HWinputs
[\masterOut -> 0,\click -> 2], // HWoutputs

)

*/

// YAWNInstrument {
// 	maybe? could have hardware input busses, EQ/compression settings, etc.
//
// }

