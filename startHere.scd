
// must make it so that YAWNSong.data[i]['lights'] == nil doesn't create an error


DMXIS.vst.editor

// start here!
~yawn.free
~yawn = YAWNShow([\cement,\chaos,\lachrymator,\tokamak],"Pro40",0);  //change clickOut to 2...this is for testing w/ Sapphire
~yawn = YAWNShow([\cement,\chaos,\lachrymator,\tokamak],"OCTA-CAPTURE",2);  //change clickOut to 2

(
~yawn = YAWNShow(
	[\cement,\chaos,\lachrymator,\tokamak],               // setList
	['gitarIn' -> [0,1], 'bassDIn' -> 2, 'snareIn' -> 3], // inputs
	false,                                                // lights
	["OCTA-CAPTURE"], //["IAC Driver"],                    // kemper
	['masterOut' -> 0, 'clickOut' -> 2, 'trackOut' -> 3], // outputs
	\lemur,                                               // UI
)
);


b = ~yawn.songArray[0].cueFrom('cementRit','cementAsectionLast',true,false,false,true)
b.play

~yawn.songArray[1].pbTracks['impro'].size

p = c[0]
p.play

P// evaluate clickAmp below!!

(
OSCdef(\test,{ |msg, time, addr, recvPort|

	msg.postln

},'/main/masterAmp/z');
)

NetAddr.localAddr
OSCdef(\test).free

s.sendMsg("/n_free",1067)
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
