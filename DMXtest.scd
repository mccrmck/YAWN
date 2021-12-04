(
SynthDef(\dmx,{
	var sig = VSTPlugin.ar(sig,numOut: 1);
	Out.ar(\outBus.kr(0),sig)
}).add
)

~dmx = VSTPluginController(Synth(\dmx, [\outBus, 0])).open("DMXIS-Inst.vst");

~dmx.editor
~dmx.gui
~dmx.info.printPresets
// make a function to load all presets for each song (with better names) -> preset folder
~dmx.savePreset("/Users/mikemccormick/Downloads/01 hvit bak.prt")
~dmx.loadPreset("_Users_mikemccormick_Downloads_01 hvit bak.prt")

~dmx.savePreset("/Users/mikemccormick/Downloads/Yawn/01 Cement/02 blackout.prt")


VSTPlugin.plugins['DMXIS-Inst.vst'].presets.do(_.postln)

VSTPlugin.plugins['DMXIS-Inst.vst'].midiInput

(
Routine({

	500.do({ |i|
		~dmx.set(20,i.lincurve(0,499,0,1,10));
		~dmx.set(21,i.lincurve(0,499,0,1,-2));
		~dmx.set(22,i.lincurve(0,499,0,1,3));
		~dmx.set(23,i.lincurve(0,499,0,1,4));
		0.005.rand.wait;
	})
}).play
)

100.collect({ |i| i.lincurve(0,99,0,1,10)}).plot


x = SimpleMIDIFile.read("/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/cement/cementLightMIDI/Cement part 1 New version.mid").timeMode_(\seconds)

a = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/cement/cementLightMIDI/Cement part 1 New version.mid"
a.extension == "mid"

// [ trackNumber, absTime, type, channel, val1, val2 ]
x.midiEvents.do(_.postln)
y = x.midiEvents.reject({|i| i[2] == \noteOff})

// deltaTimes
~times = y.collect({ |i| i[1]}).differentiate.drop(1);
~times.do(_.postln)

// preset numbers
~preset = y.collect({ |i| i[4]})
~map = [~times,~preset].flop
~map.do(_.postln)


x.midiEvents[0]

// \noteOn, chan 16 (15 in SC), midinote == 0, velocity == 80

x.metaEvents.do(_.postln;)

Pbind(
	\dur,Pseq(~times,1),
	\freq, Pseq(~preset,1),
	\legato,0.05,
).play


~dmx.getProgramData({ arg data; d = data;});
~dmx.setProgramData

~dmx.info.printPrograms

(
Pdef(\lights,
	Pbind(
		\type,\vst_set,
		\vst,~dmx,
		\params,[\Preset],
		\dur,Pseq(~times,1),
		\Preset,Pseq(~preset,1),
	)
)
)

~preset.size
~times.size
Pdef(\lights).play
Pdef(\lights).stop


y = x.midiEvents.collect({|i,j| i[1]})
y.differentiate


~dmx.synth.set(\index,2,\val,0)
80/255


~dmx.midi.allNotesOff(0)
~dmx.midi.noteOn(15,1,80)
~dmx.midi.noteOn(15,0,80)



a = YAWNSong(\cement)
a.sections

a.clicks


(
Pdef(\test,
	Ppar([
		Pdef(\lights),
		Psym(
			Pseq(a.playFrom('count_off','b_section',false).clickKeys,1)
		)
	])
).play
)

Pdef(\test).stop

(
SynthDef(\fourImproAmp,{
	var sig = SoundIn.ar(\inBus.kr(0));
	var amp = Amplitude.kr(sig,);

	amp = LagUD.kr(amp,0.8,1.0);

	SendReply.kr(Impulse.kr(12),'/fourImproLight',[amp])
}).add;
)

x = Synth(\fourImproAmp,[\inBus,2])
x.free
DMXIS.free

(
OSCdef(\dmx0,{ |msg, time, addr, recvPort|
	var val = msg[3];
	// val = val.explin(0.001,1,0,1.0);
	// val.postln;

	a.set(\11,val); //which value


},'/fourImproLight')
)

OSCdef.freeAll

s.options.device = "Saffire"


Pdef(uniqueKey,
	Pbind(
		\type,\vst_set,
		\vst,vst,
		\params,[ \Preset ],
		\dur,Pwhile({ cue }, Pseq( times, 1 )),
		\Preset,Pseq( presets, 1 ),
	)
);


(
var pathToDMXMIDI = "/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/dmxMIDI/";
DMXIS.loadFromMIDI('fourBeginning',pathToDMXMIDI ++ "beginning.mid")
)

d = DMXIS.cues['fourBeginning']['times']
e = DMXIS.cues['fourSynthBuildup']['pattern']

.stop
['times']
['pattern']

t = a.songArray[3].data[3]['click'].clickKeys
q = a.songArray[3].data[4]['click'].clickKeys

b = DMXIS.makePat('fourBeginning')
a.stop
DMXIS.setPreset(4)

[ 630.42222, 636.760245 ].differentiate.rotate(1)



Pdef(\test,
	Ppar([
		Pseq([d,e]),
		Psym(Pseq(t++q))
	])
)

Psym(Pseq(t))

Pdef(\test).stop


y = SimpleMIDIFile.read("/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/numberFour/dmxMIDI/count.mid")
			.timeMode_(\seconds)
			.midiEvents
.reject({ |event| event[2] == \noteOff });

y.do(_.postln)

y.last[1]

y.last[1] - y[y.size-2][1]

[0,2,3].size
[0].drop(1)






