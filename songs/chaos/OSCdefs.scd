///////////////////////////////////////////////// YAWN oscDefs: chaos /////////////////////////////////////////////////

({ |yawnShow, chaosInstance|
	var switchSlots = Array.fill(6,{0});
	var clickSlots = Array.fill(5,{0});
	var startClick = chaosInstance.cueFrom('chaosIntro','chaosElevenLast',true,true,true,true);
	var bombs      = chaosInstance.cueFrom('chaosBomb','chaosBomb',true,true,true,true);
	var endClick   = chaosInstance.cueFrom('chaosCountAgain','chaosOutro',true,true,true,true);

	var introBufs  = chaosInstance.pbTracks['impro'];
	var gitar = yawnShow.inputs['gitarIn'];
	var drums = yawnShow.inputs['ohIn'];

	var filterFuncs = [
		{ |sig| sig },
		{ |sig| Decimator.ar(sig, SampleRate.ir * \xArg.kr(1).linexp(0,1,0.005,0.6),24 * \yArg.kr(1).linexp(0,1,0.05,0.3),\yArg.kr(1).linexp(0,1,-3.dbamp,1)) },
		{ |sig| RLPF.ar(sig,\xArg.kr(1).linlin(0,1,40,3000),\yArg.kr(1).linlin(0,1,0.01,0.5),12).tanh * -18.dbamp },
		{ |sig| sig * SinOsc.ar(\xArg.kr(1).linexp(0,1,250,2500) * SinOsc.ar(\yArg.kr(0).linexp(0,1,0.2,20))) },
		{ |sig| CombC.ar(sig,0.3,\xArg.kr(1).linexp(0,1,0.01,0.3),\yArg.kr(1,0.2).linlin(0,1,0.5,1.5))},    // for some reason changing the decay time zeros the buffer...
		{ |sig| IFFT(PV_RectComb(FFT(LocalBuf(1024!2),sig),\xArg.kr(1).linlin(0,1,8,12),0,\yArg.kr(1).linlin(0,1,0.3,0.8))) },
		{ |sig| IFFT(PV_BrickWall(PV_Freeze(FFT(LocalBuf(2048!2),sig),\yArg.kr(1).linlin(0,1,-0.1,0.3)),\xArg.kr(1).lincurve(0,1,-0.99,0.14,2.neg))) }
	];

	// on & off Switches
	OSCdef(\chaosSynthSwitches,{ |msg, time, addr, recvPort|
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
						Ndef(\chaosIntro).clear;
					},
					1,{
						"gtrFreeze OFF".postln;
						Ndef(\chaosGtrFreeze).clear;
					},
					2,{
						"gtrStutter OFF".postln;
						Ndef(\chaosGtrStutter).clear;
					},
					3,{
						"drumFreeze OFF".postln;
						Ndef(\chaosDrumFreeze).clear;
					},
					4,{
						"drumStutter OFF".postln;
						Ndef(\chaosDrumStutter).clear;
					},
					5,{
						"shiftRegister OFF".postln;
						Ndef(\shiftRegister).clear(2);
					}
				);
			},
			1,{
				switch(index,
					0,{
						// "intro synth ON".postln;s
						Ndef(\chaosIntro,{
							var bufnum = \bufnum.kr(introBufs.first);
							var frames = BufFrames.kr(bufnum);
							var pos = Phasor.ar(0,BufRateScale.kr(bufnum) * LFDNoise1.ar(LFDNoise3.ar(4).range(4,20)).range(0.5,\range.kr(0).linexp(0,1,1,20)),0,frames);
							var sig = BufRd.ar(2,bufnum,pos);

							Balance2.ar(sig[0],sig[1],\pan.kr(0));

						}).play;

						Ndef(\chaosIntro).filter(20,{|sig| Limiter.ar(sig) * \amp.kr(0.5) * \on.kr(0,0.2) });
					},
					1,{
						// "gtrFreeze ON".postln;
						Ndef(\chaosGtrFreeze,{
							var trig = \trig.kr;
							var frames = TChoose.kr(trig,[512,1024,2048,4096]);
							var sig = SoundIn.ar(gitar);
							sig = FFT(LocalBuf(frames),sig.sum);
							sig = PV_Freeze(sig,trig - 0.5);
							sig = IFFT(sig);
							sig = Pan2.ar(sig * trig,TRand.kr(-0.8,0.8,trig),\amp.kr(1)).tanh;
						}).play
					},
					2,{
						// "gtrStutter ON".postln;
						Ndef(\chaosGtrStutter,{
							var sig = SoundIn.ar(gitar);
							var trig = \trig.kr;
							var gate = Env.sine(0.2).kr(gate: trig);
							var rand = TExpRand.kr(0.008,0.2,trig);
							sig = CombC.ar(sig.sum * gate,0.3,rand,Select.kr(trig,[0,inf]) );
							sig = Pan2.ar(sig,TRand.kr(-0.8,0.8,trig),\amp.kr(1)).tanh;
						}).play
					},
					3,{
						// "drumFreeze ON".postln;
						Ndef(\chaosDrumFreeze,{
							var trig = \trig.kr;
							var frames = TChoose.kr(trig,[512,1024,2048,4096]);
							var sig = SoundIn.ar(drums);
							sig = FFT(LocalBuf(frames),sig.sum);
							sig = PV_Freeze(sig,trig - 0.5);
							sig = IFFT(sig);
							sig = Pan2.ar(sig * trig,TRand.kr(-0.8,0.8,trig),\amp.kr(1)).tanh;
						}).play
					},
					4,{
						// "drumStutter ON".postln;
						Ndef(\chaosDrumStutter,{
							var sig = SoundIn.ar(drums);
							var trig = \trig.kr;
							var gate = Env.sine(0.2).kr(gate: trig);
							var rand = TExpRand.kr(0.008,0.2,trig);
							sig = CombC.ar(sig.sum * gate,0.3,rand,Select.kr(trig,[0,inf]) );
							sig = Pan2.ar(sig,TRand.kr(-0.8,0.8,trig),\amp.kr(1)).tanh;
						}).play
					},
					5,{
						// "shiftRegister ON".postln;
						Ndef(\shiftRegister,{
							var sr = SampleRate.ir / \sRate.kr(0).linexp(0,1,12,24);
							var n = \bits.kr(0).linexp(0,1,12,16);
							var t = Phasor.ar(1,\freq.kr(0).linexp(0,1,0.1,8) * ((2**n)/sr),0,((2**n)-1));

							t = SelectX.ar(\index.kr(0),[

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
							t = LeakDC.ar(t) * -9.dbamp;
							Pan2.ar(t,0, \amp.kr(0.3) * \on.kr(0,0.2) );

						}).play
					}
				);
			}
		);

	},'/chaos/synthSwitches/x');

	OSCdef(\chaosIntroSynthX,{ |msg, time, addr, recvPort|
		var valX = msg[1];
		var range = msg[2];

		Ndef(\chaosIntro).set(\xArg,valX,\range,range);

	},'/chaos/introSynth/x');

	OSCdef(\chaosIntroSynthY,{ |msg, time, addr, recvPort|
		var valY = msg[1];
		var index = msg[2].linlin(0,1,0,6).round.asInteger;

		if(Ndef(\chaosIntro).isPlaying,{
			Ndef(\chaosIntro).filter(1,filterFuncs[index]);
			Ndef(\chaosIntro).set(\yArg,valY);
		});

	},'/chaos/introSynth/y');

	OSCdef(\chaosIntroSynthZ,{ |msg, time, addr, recvPort|
		var trig = msg[1..];
		var bufnum = introBufs.choose;

		if(trig.sum == trig.size,{                                  // could this be better??
			Ndef(\chaosIntro).set(\bufnum,bufnum);
		});

	},'/chaos/introSynth/z');

	// shiftRegister XY

	OSCdef(\chaosShiftRegX,{ |msg, time, addr, recvPort|
		var sRate = msg[1];
		var freq = msg[2];

		Ndef(\shiftRegister).set(\sRate,sRate,\freq,freq);

	},'/chaos/shiftRegister/x');

	OSCdef(\chaosShiftRegY,{ |msg, time, addr, recvPort|
		var bits = msg[1];
		var index = msg[2].linlin(0,1,0,6);

		Ndef(\shiftRegister).set(\bits,bits,\index,index);

	},'/chaos/shiftRegister/y');


	// multiSlider - amps

	OSCdef(\chaosSynthAmps,{ |msg, time,addr, recvPort|
		var introAmp = \db.asSpec.map(msg[1]).dbamp;
		var gtrFreezeAmp = \db.asSpec.map(msg[2]).dbamp;
		var gtrStutterAmp = \db.asSpec.map(msg[3]).dbamp;
		var drmFreezeAmp = \db.asSpec.map(msg[4]).dbamp;
		var drmStutterAmp = \db.asSpec.map(msg[5]).dbamp;
		var shiftRegisterAmp = \db.asSpec.map(msg[6]).dbamp;

		Ndef(\chaosIntro).set(\amp,introAmp);
		Ndef(\chaosGtrFreeze).set(\amp,gtrFreezeAmp);
		Ndef(\chaosGtrStutter).set(\amp,gtrStutterAmp);
		Ndef(\chaosDrumFreeze).set(\amp,drmFreezeAmp);
		Ndef(\chaosDrumStutter).set(\amp,drmStutterAmp);
		Ndef(\shiftRegister).set(\amp,shiftRegisterAmp);

	},'/chaos/amps/x');

	// multiSlider - triggers                                             // must check if this causes problems!!

	OSCdef(\chaosSynthGates,{ |msg, time,addr, recvPort|
		var introOn = msg[1];
		var gtrFreezeTrig  = msg[2];
		var gtrStutterTrig = msg[3];
		var drmFreezeTrig  = msg[4];
		var drmStuttertrig = msg[5];
		var shiftRegOn = msg[6];

		Ndef(\chaosIntro).set(\on,introOn);
		Ndef(\chaosGtrFreeze).set(\trig,gtrFreezeTrig);
		Ndef(\chaosGtrStutter).set(\trig,gtrStutterTrig);
		Ndef(\chaosDrumFreeze).set(\trig,drmFreezeTrig);
		Ndef(\chaosDrumStutter).set(\trig,drmStuttertrig);
		Ndef(\shiftRegister).set(\on,shiftRegOn);

	},'/chaos/amps/z');

	// turn click on & off

	OSCdef(\chaosClick,{ |msg, time, addr, recvPort|
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
						"chaos stop".postln;
					},
					1,{
						"chaosIntroLoop: true".postln;
						Click.loopCues['chaosIntroLoop'] = true;
						DMXIS.loopCues['chaosIntroLoop'] = true;
					},
					2,{
						"chaosElevenLoop: true".postln;
						Click.loopCues['chaosElevenLoop'] = true;
						DMXIS.loopCues['chaosElevenLoop'] = true;
					},
					3,{
						bombs.stop;
						"BOMB reset".postln;
					},
					4,{
						endClick.stop;
						"ending stop".postln;
					}
				);
			},
			1,{
				switch(index,
					0,{
						startClick.play;
						"chaos start".postln;
					},
					1,{
						"chaosIntroLoop: false".postln;
						Click.loopCues['chaosIntroLoop'] = false;
						DMXIS.loopCues['chaosIntroLoop'] = false;
					},
					2,{
						"chaosElevenLoop: false".postln;
						Click.loopCues['chaosElevenLoop'] = false;
						DMXIS.loopCues['chaosElevenLoop'] = false;
					},
					3,{
						bombs.play;
						"BOMB".postln;
					},
					4,{
						endClick.play;
						"ending start".postln;
					}
				);
			}
		);
	},'/chaos/click/x');
})