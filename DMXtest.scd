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



// this motherfucker works!
~dmx.set(\Preset,0.01)
//

x = SimpleMIDIFile.read("/Users/mikemccormick/Library/Application Support/SuperCollider/Extensions/YAWN/Songs/cement/cementLightMIDI/Cement part 1 New version.mid").timeMode_(\seconds)

// [ trackNumber, absTime, type, channel, val1, val2 ]
x.midiEvents.do(_.postln)
y = x.midiEvents.reject({|i| i[2] == \noteOff})

// deltaTimes
~times = y.collect({ |i| i[1]}).differentiate;
~times = ~times.drop(1);
~times.do(_.postln)

// preset numbers
~preset = y.collect({ |i| i[4]/100})
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





60/160 /4

~dmx.set(16,80)


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



// number of outputs - is that an issue? more than one?!?!?
// preset path -> move presets to the right place? Check VSTPluginDesc helpfile

// check .addPreset method




a = YAWNSong(\cement)
a.sections

a.clicks

Click

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
SynthDef(\dmxImpro,{
	var sig = SoundIn.ar(\inBus.kr(0));
	// var amp = Amplitude.kr(sig);
	// sig = FFT(LocalBuf(4096),sig);
	// sig = SpecFlatness.kr(sig);
	var pitch = Pitch.kr(sig,maxFreq: 2500,median: 10,ampThreshold: 0.1,);

	SendReply.kr(Impulse.kr(8),'/lights',[pitch[0]])

}).add;
)

x = Synth(\dmxImpro,[\inBus,5])
x.free

OSCdef(\dmx0,{ |msg, time, addr, recvPort|
	var val = msg[3];
	val = val.cpsmidi.round;
	// val.postln;

	case
	{val == 78}{
		~dmx.set(\32,1);
		~dmx.set(\33,0);
		~dmx.set(\34,0);
		~dmx.set(\35,0);
	}
	{val == 80}{
		~dmx.set(\32,0);
		~dmx.set(\33,1);
		~dmx.set(\34,0);
		~dmx.set(\35,0);
	}

},'/lights')


~dmx.set(\Preset,0.01)

~dmx.set(\1,0.2)



Quarks.gui


