
// start here!
~yawn.free

s.options.device = "default"

(
~yawn = YAWNShow(
	// setList
	[\cement,\chaos,\lachrymator,\tokamak],

	// inputs
	['gitarIn' -> [0,1], 'ohIn' -> [2,3] ],

	// lights
	true,

	// kemper
	["OCTA-CAPTURE", "MIDI" ], // concert
	// ["IAC Driver", "Bus 1"],       // laptop
	// ["Pro40", "MIDI"],             // faxe

	// outputs
	['masterOut' -> 0, 'clickOut' -> 2, 'trackOut' -> 3],

	// UI
	\lemur,
)
);

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
