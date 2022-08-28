

/*
TO DO
-make new GUI
-integrate dante (look at OJKOS.sc for tips)
-make YAWNShow methods class methods
-noisy instruments?
-fix the YAWNSong.loadData thing!
-add countIns to all the clicks!!
-communicate w/ Oskar, fix the backing tracks! Or maybe just do it myself in REAPER
-test light loops!
-make a line check controllable from o-s-c (can use SoundCheck or make something custom)

-maybe .cueFrom shouldn't return Pdefs? If .isPlaying == true they will start playing when this method is called (remember what happened w/ OJKOS!!)

-there are several places with light patterns that have Pseqs in the .data file...are these running in Parrallel? Or why the Pseqs? Surely we can improve upon this somehow...
-the /data files and .loadData method should be changed so that an Array of Events is generated based on the dmxBool and kemperBool...no need to use resources loading DMX patterns if we're not even connected

*/

(
var server = Server.default;
var set = ['cement']; //'chaos', 'lachrymator', 'tokamak'

var ins = [
	'torfinnGtr' -> [0,1], 'mikeGtr' -> [2,3],
	'snareTop' -> 4, 'snareBtm' -> 5, // OSV

];

var outs = [
	'processOut' -> 0, 'synthOut' -> 2,
	'addsOut' -> 4, 'leadsOut' -> 6, 'efxOut' -> 8, 'percOut' -> 10,
	'clickMike' -> 11, 'clickTorfinn' -> 12, 'clickOskar' -> 13, 'clickAll' -> [11,12,13],
];

// var kemper = ["OCTA-CAPTURE", "MIDI" ]; // concert
var kemper = nil; // ["IAC Driver", "Bus 1"];       // laptop
// ["Pro40", "MIDI"];        // faxe

//server init stuff
server.options.numInputBusChannels = 32;
server.options.numOutputBusChannels = 32;
// server.options.device = "Dante Virtual Soundcard";

YAWNShow(set, ins, outs, kemper, false, 'openStageControl');

);


// use this to get the IPs that other devices should find on the network!
j = "ipconfig getifaddr en0".unixCmdGetStdOut.stripWhiteSpace
NetAddr.matchLangIP(j)


//

DMXIS.setPreset(0)
DMXIS()
DMXIS.free
DMXIS.vst.editor

Server.all
Server.default.options.device

s.sendMsg("/n_free",1001)

Server.killAll

// evaluate clickAmp below!!

(
OSCdef(\test,{ |msg, time, addr, recvPort|

	msg.postln

},'/main/masterAmp/z');

)


NetAddr.localAddr
OSCdef(\test).free

s.sendMsg("/n_free",1053)
s.sendMsg("/n_set",1003,\amp,1)

(
// MUST RUN THIS CODE!!

OSCdef(\yawnShowClickAmp,{ |msg, time,addr, recvPort|
	var val = msg[1];
	val = \db.asSpec.map(val).dbamp;

	~yawn.clickAmp.set(val);

},'/main/clickAmp/x');

OSCdef(\yawnShowMasterAmp,{ |msg, time,addr, recvPort|
	var val = msg[1];
	val = \db.asSpec.map(val).dbamp;

},'/main/masterAmp/x');

)
