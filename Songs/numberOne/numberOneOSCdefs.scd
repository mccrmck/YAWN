///////////////////////////////////////////////// YAWN oscDefs: numberFour /////////////////////////////////////////////////

(
var switchSlots = Array.fill(6,{0});
var clickSlots = Array.fill(6,{0});
var startClick = ~yawn.songArray[1].cueFrom('oneGitIntro','oneElevenLast',true,true);     //this will get changed eventually
var bombs = ~yawn.songArray[1].cueFrom('oneBomb','oneBomb',true,true);
var endClick = ~yawn.songArray[1].cueFrom('oneCountPart3','oneOutro',true,true);

// on & off Switches
OSCdef(\numberOneSynthSwitches,{ |msg, time,addr, recvPort|
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
						var trig = \trig.kr(0);        //triggered by z value of

						var bufnum = TChoose.kr(trig,~yawn.songArray[1].pbTracks);
						var frames = BufFrames.kr(bufnum);
						var pos = Phasor.ar(0,BufRateScale.kr(bufnum) * LFDNoise1.ar(LFDNoise3.ar(4).range(4,20)).range(0.5,\range.kr(0).linexp(0,1,1,20)),0,frames);
						var sig = BufRd.ar(2,bufnum,pos);

						Balance2.ar(sig[0],sig[1],\pan.kr(0));

					}).play;

					Ndef(\oneIntro).filter(20,{|sig| sig * \amp.kr(0.5) });
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
						var sr = SampleRate.ir / \sRate.kr(1).linlin(0,1,12,24);  // can this be extended?
						var n = \bits.kr(1).linexp(0,1,12,24); // bit resolution... can this be extended?
						var t = Phasor.ar(1,\freq.kr(1).linlin(0,1,0.001,4) * ((2**n)/sr),0,((2**n)-1));  // expand control range?
						var env = Env.asr().kr(2,\gate.kr(1));

						t = Select.ar(\counter.kr(0),[   // consider SelectX for maximum chaos! :)

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
						t = LPF.ar(t,14000);
						t = LeakDC.ar(t);
						Pan2.ar(t * env,0, \amp.kr(0.3) );

					}).play
				}
			);
		}
	);

},'/numberOne/synthSwitches/x');

// intro instrument  XY...multiple balls maybe??

OSCdef(\numberOneIntroSynthX,{ |msg, time,addr, recvPort|
	var valX = msg[1];
	var range = msg[2];

	Ndef(\oneIntro).set(\xArg,valX,\range,range);

},'/numberOne/introSynth/x');

OSCdef(\numberOneIntroSynthY,{ |msg, time,addr, recvPort|
	var valY = msg[1];
	var index = msg[2].linlin(0,1,0,5).round.asInteger;
	var func = [
		{|sig| sig * 1}, // test that this doesn't remove the whole synth - in that case, can it be replaced with 1
		{ |sig| Decimator.ar(sig, SampleRate.ir * \xArg.kr(1).linlin(0,1,0.01,0.6),24 * \yArg.kr(1).linlin(0,1,0.05,0.3)).clip2(0.8) },
		{ |sig| RLPF.ar(sig,\xArg.kr(1).linlin(0,1,500,5000),\yArg.kr(1).linlin(0,1,0.001,1),4).tanh },
		{ |sig| sig * SinOsc.ar(\xArg.kr(1).linlin(0,1,20,5000) * SinOsc.kr(\yArg.kr(0).linlin(0,1,0.2,12))) },
		{ |sig| CombC.ar(sig,0.1,\xArg.kr(1).range(0,1,0.002,0.03),\yArg.kr(1).linlin(0,1,0.5,1))},
		{ |sig| IFFT(PV_RectComb(FFT(LocalBuf(512),sig.sum),\xArg.kr(1).linlin(0,1,8,12),\yArg.kr(1).linlin(0,1,0.3,0.8)))!2 },
		{ |sig| IFFT(PV_BrickWall(PV_Freeze(FFT(LocalBuf(512),sig.sum),\yArg.kr(1).linlin(0,1,-0.5,0.1)),\xArg.kr(1).linlin(0,1,-0.9,0.1)))!2 }
	];

	Ndef(\oneIntro).filter(1,func[index]);

	Ndef(\oneIntro).set(\yArg,valY);

},'/numberOne/introSynth/y');

OSCdef(\numberOneIntroSynthZ,{ |msg, time,addr, recvPort|
	var trig = msg[2];
	Ndef(\oneIntro).set(\trig,trig);

},'/numberOne/introSynth/z');

// shiftRegister XY

OSCdef(\numberOneShiftRegX,{ |msg, time,addr, recvPort|
	var sRate = msg[1];
	var freq = msg[2];

	Ndef(\shiftRegister).set(\sRate,sRate,\freq,freq);

},'/numberOne/shiftRegister/x');

OSCdef(\numberOneShiftRegY,{ |msg, time,addr, recvPort|
	var bits = msg[1];
	var counter = msg[2].linlin(0,1,0,6).round.asInteger;

	Ndef(\shiftRegister).set(\bits,bits,\freq,counter);

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

OSCdef(\numberOneClick,{ |msg, time,addr, recvPort|
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

