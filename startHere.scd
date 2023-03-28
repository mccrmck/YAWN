(
var server = Server.default;
var set = '23_april';

var ins = [
	'kick' -> 0, 'snareTop' -> 1,'snareBot' -> 2, 'hiHat' -> 3,
	'rackTomL' -> 4, 'rackTomR' -> 5, 'floorTom' -> 6,'overheads' -> [7,8],
	'mikeGtr' -> [9,10], 'torfinnGtr' -> [11,12],
];

var outs = [
	'clickOskar' -> 16, 'clickMike' -> 17, 'clickTorfinn' -> 18, 'clickAll' -> [16,17,18],
	'bassOut' -> 19,
	// the following are stereo
	'synthsOut' -> 20, 'gtrsOut' -> 22,'percOut' -> 24,
	'ambienceOut' -> 26, 'processOut' -> 30
];

var kemper = ["UM-ONE", "UM-ONE"]; // concert
// var kemper = ["Pro40", "MIDI"]; // faxe
// var kemper = nil;

var lights = false;
var gui = 'openStageControl';
// var gui = nil;

//server init stuff
server.options.numInputBusChannels = 32;
server.options.numOutputBusChannels = 32;
server.options.device = "Dante Virtual Soundcard";

YAWNShow(set, ins, outs, kemper, lights, gui);
);

s.plotTree
DMXIS.vst.editor
DMXIS.setPreset(0)
s.sendMsg("/n_free",1004)
Safety.disable

ERROR: PluginBridge::pollUIThread: plugin 2 doesn't exist (anymore)


s.sendMsg("/n_free",1029)

"ipconfig getifaddr en0".unixCmdGetStdOut.stripWhiteSpace

l = YAWNShow.set.songs[5].cueFrom('tokamakBreak','tokamakBow',true,true,true,true,true).stop
l.play
l.stop

m =	YAWNShow.set.songs[2].cueFrom('cementCount','cementBsection',true,true,true,true,true).stop
m.play
m.stop


// consider a new .play method for AbstractClick:
play { var player = this.pattern.play; ^player } ?

// is it possible/useful to remove keys from DMXIS and Kemper methods?
// Do I need to access their data in a dictionary, or was that basically just for debugging?

// consider a new Kemper paradigm -> MIDI connection is made upon YAWNShow startup through a KemperDevice class (or whatever)
// and then each Kemper pattern is an instance of a different class - no need for events with loads of entries, just use instance <> methods?
// can/should something similar be done with DMXIS also?
// if I need to access everything by key, I can create KemperDef and DMXISDef for consistency's sake
// make the Click Cue sound library accessible - and then store the YAWN cues in the YAWN repo and load them into the ClickCue library at init
// make blast siren
// oskar needs a separate oscMessage instead of '/yawnLoaded' so that he can reload his interface also...
// Contingencies: give me a pop-out (modal) with Oskar’s interface, give oskar a pop-out with my interface?


// use this to get the IPs that other devices should find on the network!
j = "ipconfig getifaddr en0".unixCmdGetStdOut.stripWhiteSpace
NetAddr.matchLangIP(j)



/*
TO DO
-make a way to test the MIDI sent to the Kempers!!
-the /data files and .loadData method should be changed so that an Array of Events is generated based on the dmxBool and kemperBool...no need to use rtime/esources loading DMX patterns if we're not even connected
-get a list from Florian/Torfinn/Oskar what they want/need to be able to test in soundcheck so everything can be mapped to single buttons

*/


/*======*/

// amp reactive -> sends MIDI notes
// amp reactive -> gate sends boolean to LFO: close gate means no movement, open gate means movement




