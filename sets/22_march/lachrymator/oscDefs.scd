///////////////////////////////////////////////// YAWN oscDefs: lachrymator /////////////////////////////////////////////////

({ |yawnShow, lachrymatorInstance|

	var switchSlots = Array.fill(4,{0});
	var improSlots  = Array.fill(4,{0});
	var improIndex  = [];
	var clickSlots  = Array.fill(5,{0});

	var startClick  = lachrymatorInstance.cueFrom('lachCountPart1','lachAsection',true,true,true,true);
	var jazzClick   = lachrymatorInstance.cueFrom('lachTapping','lachJazzBsectionAgain',true,true,true,true);
	var endClick    = lachrymatorInstance.cueFrom('lachCountPart3','lachOutro',true,true,true,true);

	var pianoSamps = lachrymatorInstance.pbTracks['impro'];
	var granSamps = lachrymatorInstance.pbTracks['improNew'];

	var improFunc = { | bufnum, rate, pan, amp|
		var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum) * rate,doneAction: 2);
		sig = Balance2.ar(sig[0],sig[1],0,amp).tanh;
		sig;
	};
	var gitar = yawnShow.inputs['gitarIn'];

	// switches

	OSCdef(\lachrymatorSynthOnOff,{ |msg, time,addr, recvPort|
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
						"delay OFF".postln;
						Ndef(\lachrymatorImpro).clear;
					},
					1,{
						"hold OFF".postln;
						Ndef(\lachrymatorImpro).set(\mute,0);
					},
					2,{
						"reverb OFF".postln;
						Ndef(\lachrymatorImpro)[15] = nil;
					},
					3,{
						"impro OFF".postln;
						Ndef(\lachrymatorImpro)[9] = nil;
					}
				);
			},
			1,{
				switch(index,
					0,{
						"delay ON".postln;
						Ndef(\lachrymatorImpro,{
							var sig = SoundIn.ar(gitar);
							var mute = \mute.kr;
							var local = LocalIn.ar(2);
							sig = DelayC.ar((sig * (1-mute)) + local,1.5,LFNoise1.ar(\speed.kr(0).linlin(0,1,0.05,7)!2).range(0.2,\delay.kr(0).linlin(0,1,0.3,1.5)));
							LocalOut.ar(sig.reverse * Select.kr(mute,[0.75,1]));
							sig = LeakDC.ar(sig);
							sig = Splay.ar(sig,1,\amp.kr(1));
						}).play;
					},
					1,{
						"hold ON".postln;
						Ndef(\lachrymatorImpro).set(\mute,1);
					},
					2,{
						"reverb ON".postln;
						Ndef(\lachrymatorImpro).filter(15,{ |in|
							var sig = HPF.ar(in,450);
							sig = FreeVerb.ar(sig,1,1,0.95);
							sig = LPF.ar(sig,2000);
							sig = HPF.ar(sig,450);
						});
					},
					3,{
						"impro ON".postln;
						Ndef(\lachrymatorImpro).filter(9,{ |in|
							var bufnum = pianoSamps.choose;
							var rate = 0.8.exprand(4) * 1.xrand2.sign;
							var pan = 0.6.rand2;
							var amp = \improAmp.kr(0.5);
							var sig = improFunc.value(bufnum, rate, pan, amp);

							sig + in;
						});
					}
				);
			}
		);

	},'/lachrymator/synthOnOff/x');

	OSCdef(\lachrymatorImproLayers,{ |msg, time,addr, recvPort|
		var val,index;

		msg[1..].do({ |item, i|
			item = item.asInteger;
			if(item != improSlots[i],{
				val = item;
				index = i;
			});
		});

		improSlots[index] = val;
		improIndex = index;

		switch(val,
			0,{
				switch(index,
					0,{
						Ndef(\lachrymatorImpro)[10] = nil;
					},
					1,{
						Ndef(\lachrymatorImpro)[11] = nil;
					},
					2,{
						Ndef(\lachrymatorImpro)[12] = nil;
					},
					3,{
						Ndef(\lachrymatorImpro)[13] = nil;
					}
				);
			},
			1,{
				switch(index,
					0,{
						Ndef(\lachrymatorImpro).filter(10,{ |in|
							var bufnum = \bufnum.kr(granSamps[0]);
							var width = \width.kr(0.5);
							var trig = Impulse.kr(\trigRate0.kr(1));
							var pan = TRand.kr(width.neg,width,trig);
							var pos = \pos0.kr(0.5) * BufDur.kr(bufnum) + TRand.kr(0, 0.01, trig);
							var sig = TGrains.ar(2,trig,bufnum,BufRateScale.kr(bufnum) * \rate0.kr(1),pos,\grainDur0.kr(0.1),pan,\amp0.kr(1)).tanh;

							sig + in;
						});
					},
					1,{
						Ndef(\lachrymatorImpro).filter(11,{ |in|
							var bufnum = \bufnum.kr(granSamps[1]);
							var width = \width.kr(0.5);
							var trig = Impulse.kr(\trigRate1.kr(1));
							var pan = TRand.kr(width.neg,width,trig);
							var pos = \pos1.kr(0.5) * BufDur.kr(bufnum) + TRand.kr(0, 0.01, trig);
							var sig = TGrains.ar(2,trig,bufnum,BufRateScale.kr(bufnum) * \rate1.kr(1),pos,\grainDur1.kr(0.1),pan,\amp1.kr(1)).tanh;

							sig + in;
						});
					},
					2,{
						Ndef(\lachrymatorImpro).filter(12,{ |in|
							var bufnum = \bufnum.kr(granSamps[2]);
							var width = \width.kr(0.5);
							var trig = Impulse.kr(\trigRate2.kr(1));
							var pan = TRand.kr(width.neg,width,trig);
							var pos = \pos2.kr(0.5) * BufDur.kr(bufnum) + TRand.kr(0, 0.01, trig);
							var sig = TGrains.ar(2,trig,bufnum,BufRateScale.kr(bufnum) * \rate2.kr(1),pos,\grainDur2.kr(0.1),pan,\amp2.kr(1)).tanh;

							sig + in;
						});
					},
					3,{
						Ndef(\lachrymatorImpro).filter(13,{ |in|
							var bufnum = \bufnum.kr(granSamps[3]);
							var width = \width.kr(0.5);
							var trig = Impulse.kr(\trigRate3.kr(1));
							var pan = TRand.kr(width.neg,width,trig);
							var pos = \pos3.kr(0.5) * BufDur.kr(bufnum) + TRand.kr(0, 0.01, trig);
							var sig = TGrains.ar(2,trig,bufnum,BufRateScale.kr(bufnum) * \rate3.kr(1),pos,\grainDur3.kr(0.1),pan,\amp3.kr(1)).tanh;

							sig + in;
						});
					}
				);
			}
		);

	},'/lachrymator/improLayers/x');

	// improAmps

	OSCdef(\lachrymatorImproAmps,{ |msg, time,addr, recvPort|
		var saxAmp = \db.asSpec.map(msg[1]).dbamp;
		var violinAmp = \db.asSpec.map(msg[2]).dbamp;
		var lightAmp = \db.asSpec.map(msg[3]).dbamp;
		var keysAmp = \db.asSpec.map(msg[4]).dbamp;

		Ndef(\lachrymatorImpro).set(\amp0,saxAmp);
		Ndef(\lachrymatorImpro).set(\amp1,violinAmp);
		Ndef(\lachrymatorImpro).set(\amp2,lightAmp);
		Ndef(\lachrymatorImpro).set(\amp3,keysAmp);

	},'/lachrymator/improAmps/x');


	OSCdef(\lachrymatorImproChoose,{ |msg, time,addr, recvPort|
		var index = msg[1..].indexOf(1.0);
		improIndex = index ? improIndex;

	},'/lachrymator/improAmps/z');

	// improXY

	OSCdef(\lachrymatorImproX,{ |msg, time, addr, recvPort|
		var rate = msg[1];
		var pos  = msg[2];

		switch(improIndex,
			0,{ Ndef(\lachrymatorImpro).set(\rate0,rate.linexp(0,1,0.25,4),\pos0,pos) },
			1,{ Ndef(\lachrymatorImpro).set(\rate1,rate.linexp(0,1,0.25,4),\pos1,pos) },
			2,{ Ndef(\lachrymatorImpro).set(\rate2,rate.linexp(0,1,0.25,4),\pos2,pos) },
			3,{ Ndef(\lachrymatorImpro).set(\rate3,rate.linexp(0,1,0.25,4),\pos3,pos) },
		)

	},'/lachrymator/improXY/x');

	OSCdef(\lachrymatorImproY,{ |msg, time, addr, recvPort|
		var gDur = msg[1];
		var trig = msg[2];

		switch(improIndex,
			0,{ Ndef(\lachrymatorImpro).set(\trigRate0,trig.linlin(0,1,0.5,20),\grainDur0,gDur.linlin(0,1,0.01,1) ) },
			1,{ Ndef(\lachrymatorImpro).set(\trigRate1,trig.linlin(0,1,0.5,20),\grainDur1,gDur.linlin(0,1,0.01,1) ) },
			2,{ Ndef(\lachrymatorImpro).set(\trigRate2,trig.linlin(0,1,0.5,20),\grainDur2,gDur.linlin(0,1,0.01,1) ) },
			3,{ Ndef(\lachrymatorImpro).set(\trigRate3,trig.linlin(0,1,0.5,20),\grainDur3,gDur.linlin(0,1,0.01,1) ) },
		)

	},'/lachrymator/improXY/y');

	// multiSlider - amps
	OSCdef(\lachrymatorSliders,{ |msg, time,addr, recvPort|
		var delayAmp = \db.asSpec.map(msg[1]).dbamp;
		var improAmp = \db.asSpec.map(msg[2]).dbamp;
		var reverbMix = \db.asSpec.map(msg[3]).dbamp;

		Ndef(\lachrymatorImpro).set(\amp,delayAmp);
		Ndef(\lachrymatorImpro).set(\improAmp,improAmp);
		Ndef(\lachrymatorImpro).set(\wet15,reverbMix);

	},'/lachrymator/sliders/x');

	// turn click on & off

	OSCdef(\lachrymatorClick,{ |msg, time,addr, recvPort|
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
						"lachrymator stop".postln;
					},
					1,{
						jazzClick.stop;
						"tapping stop".postln;
					},
					2,{
						"fusion: true".postln;
						Click.loopCues['lachTap'] = true;
						DMXIS.loopCues['lachTap'] = true;
					},
					3,{
						endClick.stop;
						"ending stop".postln;
					}
				);
			},
			1,{
				switch(index,
					0,{
						var secs = 15;
						"lachrymator starting in % seconds".format(secs).postln;
						Routine({
							secs.wait;
							startClick.play;
						}).play
					},
					1,{
						jazzClick.play;
						"tapping start".postln;
					},
					2,{
						"fusion: false".postln;
						Click.loopCues['lachTap'] = false;
						DMXIS.loopCues['lachTap'] = false;
					},
					3,{
						endClick.play;
						"ending start".postln;
					}
				);
			}
		);

	},'/lachrymator/click/x');
})