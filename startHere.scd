

/*
TO DO
-make new GUI
-integrate dante (look at OJKOS.sc for tips)
-make YAWNShow methods class methods
-noisy instruments?
-fix the YAWNSong.loadData thing!
-add countIns to all the clicks!!
-communicate w/ Oskar, fix the backing tracks! Or maybe just do it mysel in REAPER
-consider replacing the .interpret methods w/ .executeFile

-reconsider YAWNShow/Song structure - do I need a class like YAWNi/o or something?

*/

(
var server = Server.default;
var set = [\cement, \chaos, \lachrymator, \tokamak];

var ins = [
	'torfinnGtr' -> [0,1], 'mikeGtr' -> [2,3],
	'snareTop' -> 4, 'snareBtm' -> 5, // OSV

];

var outs = [
	'processOut' -> 0, 'synthOut' -> 2,
	'addsOut' -> 4, 'leadsOut' -> 6, 'fxOut' -> 8, 'percOut' -> 10,
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


YAWNShow.outDict.keys.dopostln

MIDIClient.init



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
