/*
TO DO
-noisy instruments?
-fix the YAWNSong.loadData thing!
-communicate w/ Oskar, fix the backing tracks! Or maybe just do it myself in REAPER
-test light loops!
-make a line check controllable from o-s-c -> make a sample player that can play back different sounds to indicate each channel
-make a way to test the MIDI sent to the Kempers!!

-maybe .cueFrom shouldn't return Pdefs? If .isPlaying == true they will start playing when this method is called (remember what happened w/ OJKOS!!)

-there are several places with light patterns that have Pseqs in the .data file...are these running in Parallel? Or why the Pseqs? Surely we can improve upon this somehow...
-the /data files and .loadData method should be changed so that an Array of Events is generated based on the dmxBool and kemperBool...no need to use resources loading DMX patterns if we're not even connected

*/

(
var server = Server.default;
var set = 'test';

var ins = [
	'kick' -> 0, 'snareTop' -> 1,'snareBot' -> 2,
	'rackTomL' -> 3, 'rackTomR' -> 4, 'floorTom' -> 5,'overheads' -> [6,7],
	'mikeGtr' -> [8,9], 'torfinnGtr' -> [10,11],
	'hiHat' -> 12
];

var outs = [
	'clickOskar' -> 16, 'clickMike' -> 17, 'clickTorfinn' -> 18, 'clickAll' -> [16,17,18],
	'bassOut' -> 19,
	// the following are stereo
	'synthOut' -> 20, 'gtrsOut' -> 22,'percOut' -> 24,
	'ambienceOut' -> 26, 'processOut' -> 30
];

// var kemper = ["OCTA-CAPTURE", "MIDI" ]; // concert
// var kemper = ["IAC Driver", "Bus 1"];   // laptop
// var kemper = ["Pro40", "MIDI"];         // faxe
var kemper = nil;

var lights = false;

//server init stuff
server.options.numInputBusChannels = 32;
server.options.numOutputBusChannels = 32;
server.options.device = "Dante Virtual Soundcard";

YAWNShow(set, ins, outs, kemper, lights, 'openStageControl');

);

y.data
y = YAWNSong('cement','22_march')
y.songName
y.loadData("done".postln)
b = y.cueFrom('cementIntro','cementIntro',true,false,false,true,false)
b.play

// use this to get the IPs that other devices should find on the network!
j = "ipconfig getifaddr en0".unixCmdGetStdOut.stripWhiteSpace
NetAddr.matchLangIP(j)

n = NetAddr("127.0.0.1",8080)
n.sendMsg("/songFragment","songs/tokamakClick.json")
n.sendMsg("/text","songs/gui.json")


OSCFunc.trace(false)

"echo  \"Hiya! Im sending this from SuperCollider...\" | mail s- \"Totally Not Spam1\" mccormick.mike.r@gmail.com".unixCmd

SoundCheck(32).sweep(0.2)
SoundCheck(32).clear


