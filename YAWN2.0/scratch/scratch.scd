
// export tempo map?
a = ClickConCat(2,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2)).clickArray.collect(_.tempoArray / 2).flat;
b = ClickConCat(2,ClickEnv([75,120],4,2),ClickEnv([120,145],4,2), ClickEnv([145,100],4,2),ClickEnv([100,75],4,2)).clickArray.collect(_.tempoArray / 2).flat;
c = Click(60/0.56836521053797,4,1,4).tempoArray
[a,b].plot

~time = 0;
c = b.collect({ |tempo,index|
	var delta =  60 /tempo;
	var time = ~time;
	~time = ~time + delta;
	[time,tempo]
});

c.dopostln
c.last[0] + (60/c.last[1])

(
m = SimpleMIDIFile( "~/Desktop/midifiletest.mid" ).init0(75);
m.timeMode = \seconds;  // change from default to something useful
)
(
c.do({ |subArr, index|
	var time = subArr[0];
	var tempo = subArr[1];

	m.addTempo(tempo,time)
})
)
m.adjustEndOfTrack(0,0)
m.write
m.metaEvents.dopostln;

//

// riff bank click
c = ['one','oneDan','two','twoDan','three','threeDan','four','fourDan'].collect({ |key,index|
	var beats = (index / 2).floor + 2;

	ClickCue(110,beats.asInteger,cueKey: key).pattern
})

// rewrite ClickEnv to use Env or Pseg internally
// instances of ClickEnv (in OJKOS, under:went, etc.) can use ClickEnvOld, unless I'm really in the mood to fix those scores...

Ndef(\test).clear


(// 11.07.23
Ndef(\test,{
	var sig = SoundIn.ar(0);
	var trig = FluidOnsetSlice.ar(sig,9,threshold: 0.1);
	var pitch = Pitch.kr(LPF.ar(sig,450))[0];
	var pan = pitch > 250;
	// sig = sig + CombC.ar(sig,0.5,[0.4,0.5],2,0.3);
	// sig = sig + AllpassC.ar(sig,0.2,SinOsc.kr(0.1,[0,0.1]).range(0.004,0.005),0.01).tanh;
	// sig = FreqShift.ar(sig,50);
	// sig = sig + CombC.ar(sig,0.2,SinOsc.kr(0.1,[0,pi]).range(0.01,0.02),0.8,0.5).tanh;
	sig = XFade2.ar(sig + FreqShift.ar(sig,pitch / 2),FreqShift.ar(sig,pitch.varlag(5,10.neg) * 2 ),pan * 2 - 1);
	Splay.ar(sig)
}).play
)



(// 18.07.23
Ndef(\test,{
	var sog,in = SoundIn.ar(0);
	var frames = 128;
	var trig = FluidOnsetSlice.ar(in,9,threshold: 0.24) - 0.1;
	var pulse = Impulse.kr(132/60 * 4);
	var pitch = Pitch.kr(LPF.ar(in,450))[0];
	var pan = pitch > 180;
	var sig = FFT(LocalBuf(frames),in);
	trig = ToggleFF.ar(trig);
	sog = PV_Copy(sig,LocalBuf(frames));
	sig = PV_Freeze(sig,1-trig);
	sig = PV_BinScramble(sig,1,0.4,pulse);
	sog = PV_Freeze(sog,trig);
	sog = PV_BinScramble(sog,1,0.4,pulse);
	sig = [IFFT(sig),IFFT(sog)];
	sig = XFade2.ar(in,SelectX.ar(trig,sig.tanh ),pan * 2 - 1);

	Splay.ar(sig)
}).play
)

// fix the key shit in the Click!

// 15.07.24
(
SynthDef(\test,{
    var sig = LFSaw.ar(\freq.kr(440) * [0.5,1]);
    var ffreq = \ffreq.kr(450);
    var sweep = XLine.ar(ffreq,ffreq/8,\dur.kr);
    sig = sig + BrownNoise.ar(\noise.kr(0)!2);
    sig = sig * \gain.kr(1);
    sig = SVF.ar(sig,sweep,\res.kr(0.5),\lowpass.kr(1)).tanh;
    sig = sig * Env.perc(\atk.kr(0.01),\rls.kr(0.2),1,\curve.kr(-4)).ar(2);

    Out.ar(0,sig * \amp.kr(1))
}).add
)

Synth(\test,[\freq,80,\gain,4,\ffreq,350,\res,0.8])
s.meter
s.plotTree
s.scope

(
Pdef(\test,
    Pbind(
        \instrument,\test,
        \dur,Pwrand([0.125,Rest(0.125)],[0.9,0.1],inf),
        \freq,Prand([59,60,62,63],inf).midicps * Pwhite(-0.5,0.5).midiratio,
        \noise,Pseg([0.1,0.4,0.1],[3,7],'sin',inf),
        \gain,Pseg([10,20,10],[5,9],'sin',inf),
        \ffreq,Pseg([250,800,250],[10,12],'sin',inf) * 16,
        \res,Pseg([0.8,0.6,0.8],[5,7],'sin',inf),
        \atk,0.1,
        \rls,0.7 * Pwhite(0.5,1),
        \curve,5.neg,
        \amp,Pseq([
            Pseq([1,1,1,1],12) * Pwhite(0.75,1),
            Pseq([1,0.5,0.5,0.5,0.5],3),
        ],inf) 
        )
).play
)

