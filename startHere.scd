
// must make it so that YAWNSong.data[i]['lights'] == nil doesn't create an error


DMXIS.vst.editor

// start here!
~yawn.free
~yawn = YAWNShow([\cement,\chaos,\lachrymator,\tokamak],"Pro40",0);  //change clickOut to 2...this is for testing w/ Sapphire
~yawn = YAWNShow([\cement,\chaos,\lachrymator,\tokamak],"IAC Driver",0);  //change clickOut to 2

~yawn = YAWNShow([\cement,\chaos,\lachrymator,\tokamak],"IAC Driver",0);  //change clickOut to 2

// between fem and fire!
// evaluate clickAmp below!!

(
OSCdef(\test,{ |msg, time, addr, recvPort|

	msg.postln

},'/main/masterAmp/z');
)

NetAddr.localAddr
OSCdef(\test).free

s.sendMsg("/n_free",1051)

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



YAWNShow(,
	[\cement,\numberOne,\numberTwo,\numberFour], //setList
	['kemperMIDIdevice'],
	[\torfinnGitar -> [0,1],\bassTrigger -> 2, \snare -> 3], // HWinputs
	[\masterOut -> 0,\click -> 2, \tracks -> 3], // HWoutputs
	\lemur, // interface/UI
)

