
// must make it so that YAWNSong.data[i]['lights'] == nil doesn't create an error


DMXIS.vst.editor

// start here!
~yawn.free
~yawn = YAWNShow([\cement,\chaos,\lachrymator,\tokamak],"Pro40",0);  //change clickOut to 2...this is for testing w/ Sapphire
~yawn = YAWNShow([\cement,\chaos,\lachrymator,\tokamak],"OCTA-CAPTURE",2);  //change clickOut to 2

(
~yawn = YAWNShow(
	[\cement,\chaos,\lachrymator,\tokamak],               // setList
	['gitarIn' -> [0,1], 'ohIn' -> [2,3] ], // inputs
	false,                                                 // lights
	["EXP OCTA-CAPTURE", "MIDI" ],                         // kemper
	// ["IAC Driver", "Bus 1"],                           // kemper
	['masterOut' -> 0, 'clickOut' -> 2, 'trackOut' -> 3], // outputs
	\lemur,                                               // UI
)
);


b = ~yawn.songArray[2].clicks[0][0][0].play
b.play
b.stop

KemperMIDI.cues['tokamakCue']['times']

a = ClickLoop(120,out: 2)
a.stop

a = ~yawn.songArray[0].pbTracks['leads'][0]

a.play


// evaluate clickAmp below!!

(
OSCdef(\test,{ |msg, time, addr, recvPort|

	msg.postln

},'/main/masterAmp/z');
)


KemperMIDI.midiOut

NetAddr.localAddr
OSCdef(\test).free

s.sendMsg("/n_free",1188)
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

~yawn.clickAmp.set(0.3);
DMXIS.setPreset(0);
DMXIS.free

SynthDescLib.global.browse
