(
var server = Server.default;
var set = '23_april';

var ins = [
	'kick' -> 0, 'snareTop' -> 1,'snareBot' -> 2, 'snare2' -> 3,
	'rackTom' -> 4, 'floorTom' -> 5, 'overheads' -> [6,7], 'hiHat' -> 8,
	'mikeGtr' -> [12,13], 'torfinnGtr' -> [14,15],
];

var outs = [
	'clickOskar' -> 16, 'clickMike' -> 17, 'clickTorfinn' -> 18, 'clickAll' -> [16,17,18],
	'bassOut' -> 19,
	// the following are stereo
	'gtrsOut' -> 20, 'percOut' -> 22, 'synthsOut' -> 24,
	'ambienceOut' -> 26, 'oskarSynthOut' -> 28, 'processOut' -> 30
];
// var kemper = ["UM-ONE", "UM-ONE"]; // concert
// var kemper = ["Pro40", "MIDI"]; // faxe
var kemper = nil;

var lights = true;

var gui = 'openStageControl';
// var gui = nil;

//server init stuff
server.options.numInputBusChannels = 32;
server.options.numOutputBusChannels = 32;
// server.options.device = "Dante Virtual Soundcard";
// server.options.device = "SQ - Audio";

YAWNShow(set, ins, outs, kemper, lights, gui);
)



s.plotTree
DMXIS.vst.editor
DMXIS.setPreset(0)
s.sendMsg("/n_free",2033)
Safety.enable

// blast or cement part 2
// FAILURE IN SERVER /n_free Node 1144 not found


"ipconfig getifaddr en10".unixCmdGetStdOut.stripWhiteSpace

l = YAWNShow.set.songs[3].cueFrom('chaosElevenLoopOne','chaosElevenLast',true,false,true,true,true).stop
l.play
l.stop

l = YAWNShow.set.songs[2].cueFrom('cementRit','cementAsectionLast',true,true,true,true,true).stop
l.play
l.stop

m =	YAWNShow.set.songs[5].cueFrom('tokamakBreak','tokamakOutro',true,true,true,true,true).stop
m =	YAWNShow.set.songs[5].cueFrom('tokamakPB','tokamakOutro',true,true,true,true,true).stop
m.play
m.stop

n = YAWNShow.set.songs[4].cueFrom('lachJazzAsection','lachOutro',true,true,true,true,true).stop
n.play
n.stop

SoundCheck(32).sweep(0.2)

2.1.frac

12/11

// consider a new .play method for AbstractClick:
play { var player = this.pattern.play; ^player } ?

// coordinate with Torfinn - "neutral" Kemper patch for rehearsals, can we simplify the Kemper midi data? Fewer MIDI files?
// maybe each section doesn't have a kemper MIDI file but rather an agreed upon program change that gets sent from SC, no need to translate from a MIDI file

// make the Click Cue sound library accessible/loadable - and then store the YAWN cues in the YAWN repo and load them into the ClickCue library at init
// oskar needs a separate oscMessage instead of '/yawnLoaded' so that he can reload his interface also...
// Contingencies: give me a pop-out (modal) with Oskar’s interface, give oskar a pop-out with my interface?

// should I just hardcode the Kemper MIDI device port in the YAWNShow classfile? why/why not?


// use this to get the IPs that other devices should find on the network!
j = "ipconfig getifaddr en10".unixCmdGetStdOut.stripWhiteSpace
NetAddr.matchLangIP(j)
NetAddr.localAddr


/*
TO DO
-make a way to test the MIDI sent to the Kempers!!
-the /data files and .loadData method should be changed so that an Array of Events is generated based on the dmxBool and kemperBool...no need to use time/resources loading DMX patterns if we're not even connected
-get a list from Florian/Torfinn/Oskar what they want/need to be able to test in soundcheck so everything can be mapped to single buttons
*/


/*======*/

// amp reactive -> sends MIDI notes
// amp reactive -> gate sends boolean to LFO: close gate means no movement, open gate means movement

Score


