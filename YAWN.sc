YAWNShow {


	/*
	YAWN.new(
	[\setlist],
	[\hardWareInputs],
	[\hardWareOutputs],


	)
	*/

	// YAWNShow.addToSetList(0,\numberOne) // becomes .add(index -> name) in Dictionary/IdentityDictionary??

	// <>setlist ?? .setlist prints the songs in order...what does .setlist_() look like?
	/*.setlist_ { |array|

	array.do({ |name, index|
	YAWNShow.addToSetList(index,name)
	})
	}
	*/

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
	classvar <>all;

	*initClass {
		var whatever;

		all = IdentityDictionary.new; // maybe collect song names from folder? But don't load them until called
	}

	*new {}

	// load click
	// load cues into dictionary somewhere
	// load buffers
	// load synths
	// load mapping info
	// load gui info

	// makeClick{ |tempo = 60|}


}

// copy Pdef paradigm:
// YAWNSong.all
//
// YAWNSong.new(\numberOne)
//
//
// Pdef.all
//


// eventual new features/additions that don't exist yet
// add more samples to #2 -> grinding keys? Higher pitched piano harms? Eveything forward/backward?
// can add drum processing to #3 as well...
// #1 intro shouldn't no longer granular - repeating sampler w/ hold, reads args from sliders;
// all sliders should read from busses, mapped/scaled appropriately... everything needs to be normalized!!
// is there a way to have input processing available at all times? Always ready for impro?



// YAWN song folder has a data.scd file which has cues, SynthDefs, etc?







