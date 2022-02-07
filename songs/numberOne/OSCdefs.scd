///////////////////////////////////////////////// YAWN oscDefs: numberOne /////////////////////////////////////////////////

(
var switchSlots = Array.fill(6,{0});
var clickSlots = Array.fill(6,{0});
// var startClick = ~yawn.songArray[1].cueFrom('oneGitIntro','oneElevenLast',true,true);
// var bombs = ~yawn.songArray[1].cueFrom('oneBomb','oneBomb',true,true);
// var endClick = ~yawn.songArray[1].cueFrom('oneCountPart3','oneOutro',true,true);
var startClick = YAWNSong('numberOne').cueFrom('oneGitIntro','oneElevenLast',true,true);
var bombs = YAWNSong('numberOne').cueFrom('oneBomb','oneBomb',true,true);
var endClick = YAWNSong('numberOne').cueFrom('oneCountPart3','oneOutro',true,true);

var introBufs = YAWNSong('numberOne').pbTracks;

// on & off Switches
OSCdef(\numberOneSynthSwitches,{ |msg, time, addr, recvPort|
	var val,index;

	msg[1..].do({ |item, i|
		item = item.asInteger;
		if(item != switchSlots[i],{
			val = item;
			index = i;
		});
	});

	switchSlots[index] = val;

	switch(val,
		0,{
			switch(index,
				0,{
					"intro synth OFF".postln;
					Ndef(\oneIntro).clear;
				},
				1,{
					"gtrFreeze OFF".postln;
					Ndef(\oneGtrFreeze).clear;
				},
				2,{
					"gtrStutter OFF".postln;
					Ndef(\oneGtrStutter).clear;
				},
				3,{
					"drumFreeze OFF".postln;
					Ndef(\oneDrumFreeze).clear;
				},
				4,{
					"drumStutter OFF".postln;
					Ndef(\oneDrumStutter).clear;
				},
				5,{
					"shiftRegister OFF".postln;
					Ndef(\shiftRegister).clear;
				}
			);
		},
		1,{
			switch(index,
				0,{
					"intro synth ON".postln;
					Ndef(\oneIntro,{
						var bufnum = \bufnum.kr;
						var frames = BufFrames.kr(bufnum);
						var pos = Phasor.ar(0,BufRateScale.kr(bufnum) * LFDNoise1.ar(LFDNoise3.ar(4).range(4,20)).range(0.5,\range.kr(0).linexp(0,1,1,20)),0,frames);
						var sig = BufRd.ar(2,bufnum,pos);

						Balance2.ar(sig[0],sig[1],\pan.kr(0));

					}).play;

					Ndef(\oneIntro).filter(20,{|sig| Limiter.ar(sig) * \amp.kr(0.5) });
				},
				1,{
					"gtrFreeze ON".postln;
					Ndef(\oneGtrFreeze,{
						var frames = 1024;
						var sig = SoundIn.ar(\inBus.kr(0));
						var trig = 1;
						sig = FFT(LocalBuf(frames),sig);
						sig = PV_Freeze(sig,trig);
						sig = IFFT(sig);
						sig = Pan2.ar(sig * trig,TRand.kr(-1.0,1.0,trig),\amp.kr(1));
					}).play
				},
				2,{
					"gtrStutter ON".postln;
					Ndef(\oneGtrStutter,{
						var sig = SoundIn.ar(\inBus.kr(0));
						var trig = \trig.kr(1);
						var gate = Env.sine(0.2).kr(gate:trig);
						var rand = TRand.kr(0.005,0.15,trig);
						sig = CombC.ar(sig * gate,0.3,rand,Select.kr(trig,[0,inf]));
						sig = Pan2.ar(sig,TRand.kr(-1.0,1.0,trig),\amp.kr(1));
					}).play
				},
				3,{
					"drumFreeze ON".postln;
					Ndef(\oneDrumFreeze,{
						var frames = 1024;
						var sig = SoundIn.ar(\inBus.kr(3));
						var trig = 1;
						sig = FFT(LocalBuf(frames),sig);
						sig = PV_Freeze(sig,trig);
						sig = IFFT(sig);
						sig = Pan2.ar(sig * trig,TRand.kr(-1.0,1.0,trig),\amp.kr(1));
					}).play
				},
				4,{
					"drumStutter ON".postln;
					Ndef(\oneDrumStutter,{
						var sig = SoundIn.ar(\inBus.kr(3));
						var trig = \trig.kr(1);
						var gate = Env.sine(0.2).kr(gate:trig);
						var rand = TRand.kr(0.005,0.15,trig);                 // consider making this a TChoose w/ an array of times that fit the tempo
						sig = CombC.ar(sig * gate,0.3,rand,Select.kr(trig,[0,inf]));
						sig = Pan2.ar(sig,TRand.kr(-1.0,1.0,trig),\amp.kr(1));
					}).play
				},
				5,{
					"shiftRegister ON".postln;
					Ndef(\shiftRegister,{
						var sr = SampleRate.ir / \sRate.kr(0).linexp(0,1,12,24);
						var n = \bits.kr(0).linexp(0,1,12,16);
						var t = Phasor.ar(1,\freq.kr(1).linexp(0,1,0.1,8) * ((2**n)/sr),0,((2**n)-1));

						t = SelectX.ar(\counter.kr(0),[

							t*(((t>>64)|(t>>8))&(63&(t>>4))),
							t*(((t>>9)|(t>>13))&(25&(t>>6))),
							t*(((t>>5)|(t>>8)) & 63),
							t*(((t>>11)&(t>>8))&(123&(t>>3))),
							t*(t>>8*((t>>15)|(t>>8))&(20|(t>>19)*5>>t|(t>>3))),
							t*(t>>((t>>9)|(t>>8))&(63&(t>>4))),
							(t>>7|t|t>>6)*10+4*(t&t>>13|t>>6)
						]);

						t = t % (2**(n)); // avoiding number beyond 2**(bit resolution)
						t = t * (0.5**(n-1)) - 1; // scaling to -1, 1
						t = LPF.ar(t,18000);
						t = LeakDC.ar(t);
						Pan2.ar(t,0, \amp.kr(0.3) );

					}).play
				}
			);
		}
	);

},'/numberOne/synthSwitches/x');

OSCdef(\numberOneIntroSynthX,{ |msg, time, addr, recvPort|
	var valX = msg[1];
	var range = msg[2];

	Ndef(\oneIntro).set(\xArg,valX,\range,range);

},'/numberOne/introSynth/x');

OSCdef(\numberOneIntroSynthY,{ |msg, time, addr, recvPort|
	var valY = msg[1];
	var index = msg[2].linlin(0,1,0,6).round.asInteger;
	var func = [
		{ |sig| sig },
		{ |sig| Decimator.ar(sig, SampleRate.ir * \xArg.kr(1).linexp(0,1,0.01,0.6),24 * \yArg.kr(1).linexp(0,1,0.05,0.3),\yArg.kr(1).linexp(0,1,0.15,1)) },
		{ |sig| RLPF.ar(sig,\xArg.kr(1).linlin(0,1,40,3000),\yArg.kr(1).linlin(0,1,0.01,0.5),12).tanh * -18.dbamp },
		{ |sig| sig * SinOsc.ar(\xArg.kr(1).linexp(0,1,250,2500) * SinOsc.ar(\yArg.kr(0).linexp(0,1,0.2,20))) },
		{ |sig| CombC.ar(sig,0.3,\xArg.kr(1).linexp(0,1,0.01,0.3),\yArg.kr(1,0.2).linlin(0,1,0.5,1.5))},    // for some reason changing the decay time zeros the buffer...
		{ |sig| IFFT(PV_RectComb(FFT(LocalBuf(1024!2),sig),\xArg.kr(1).linlin(0,1,8,12),0,\yArg.kr(1).linlin(0,1,0.3,0.8))) },
		{ |sig| IFFT(PV_BrickWall(PV_Freeze(FFT(LocalBuf(2048!2),sig),\yArg.kr(1).linlin(0,1,-0.1,0.3)),\xArg.kr(1).lincurve(0,1,-0.99,0.14,2.neg))) }
	];

	if(Ndef(\oneIntro).isPlaying,{

		Ndef(\oneIntro).filter(1,func[index]);
		Ndef(\oneIntro).set(\yArg,valY);
	});

},'/numberOne/introSynth/y');

OSCdef(\numberOneIntroSynthZ,{ |msg, time, addr, recvPort|
	var trig = msg[1..];
	var bufnum = introBufs.choose;

	if(trig.sum == trig.size,{                                  // could this be better??
		Ndef(\oneIntro).set(\bufnum,bufnum);
	});

},'/numberOne/introSynth/z');

// shiftRegister XY

OSCdef(\numberOneShiftRegX,{ |msg, time, addr, recvPort|
	var sRate = msg[1];
	var freq = msg[2];

	Ndef(\shiftRegister).set(\sRate,sRate,\freq,freq);

},'/numberOne/shiftRegister/x');

OSCdef(\numberOneShiftRegY,{ |msg, time, addr, recvPort|
	var bits = msg[1];
	// var counter = msg[2].linlin(0,1,0,6).round.asInteger;
	var counter = msg[2].linlin(0,1,0,6);

	Ndef(\shiftRegister).set(\bits,bits,\counter,counter);

},'/numberOne/shiftRegister/y');


// multiSlider - amps

OSCdef(\numberOneSynthAmps,{ |msg, time,addr, recvPort|
	var introAmp = \db.asSpec.map(msg[1]).dbamp;
	var gtrFreezeAmp = \db.asSpec.map(msg[2]).dbamp;
	var gtrStutterAmp = \db.asSpec.map(msg[3]).dbamp;
	var drmFreezeAmp = \db.asSpec.map(msg[4]).dbamp;
	var drmStutterAmp = \db.asSpec.map(msg[5]).dbamp;
	var shiftRegisterAmp = \db.asSpec.map(msg[6]).dbamp;

	Ndef(\oneIntro).set(\amp,introAmp);
	Ndef(\oneGtrFreeze).set(\amp,gtrFreezeAmp);
	Ndef(\oneGtrStutter).set(\amp,gtrStutterAmp);
	Ndef(\oneDrumFreeze).set(\amp,drmFreezeAmp);
	Ndef(\oneDrumStutter).set(\amp,drmStutterAmp);
	Ndef(\shiftRegister).set(\amp,shiftRegisterAmp);

},'/numberOne/amps/x');


// turn click on & off

OSCdef(\numberOneClick,{ |msg, time, addr, recvPort|
	var val,index;

	msg[1..].do({ |item, i|
		item = item.asInteger;
		if(item != clickSlots[i],{
			val = item;
			index = i;
		});
	});

	clickSlots[index] = val;

	switch(val,
		0,{
			switch(index,
				0,{
					startClick.stop;
					"numberOne stop".postln;
				},
				1,{
					"openOneFour: true".postln;
					Click.loopCues[\openOneFour] = true;
					DMXIS.cues['oneGitIntro']['openOneFour'] = true;
				},
				2,{
					"openOneEight: true".postln;
					Click.loopCues[\openOneEight] = true;
					DMXIS.cues['oneGitDrums']['openOneEight'] = true;
				},
				3,{
					"openOneEleven: true".postln;
					Click.loopCues[\openOneEleven] = true;
					DMXIS.cues['oneEleven']['openOneEleven'] = true;
				},
				4,{
					bombs.stop;
					"BOMB reset".postln;
				},
				5,{
					endClick.stop;
					"ending stop".postln;
				}
			);
		},
		1,{
			switch(index,
				0,{
					startClick.play;
					"numberOne start".postln;
				},
				1,{
					"openOneFour: false".postln;
					Click.loopCues['openOneFour'] = false;
					DMXIS.cues['oneGitIntro']['openOneFour'] = false;
				},
				2,{
					"openOneEight: false".postln;
					Click.loopCues[\openOneEight] = false;
					DMXIS.cues['oneGitDrums']['openOneEight'] = false;
				},
				3,{
					"openOneEleven: false".postln;
					Click.loopCues['openOneEleven'] = false;
					DMXIS.cues['oneEleven']['openOneEleven'] = false;
				},
				4,{
					bombs.play;
					"BOMB".postln;
				},
				5,{
					endClick.play;
					"ending start".postln;
				}
			);
		}
	);
},'/numberOne/click/x');
)

