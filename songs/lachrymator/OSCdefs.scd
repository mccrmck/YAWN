///////////////////////////////////////////////// YAWN oscDefs: lachrymator /////////////////////////////////////////////////

({ |lachrymatorInstance|

	var switchSlots = Array.fill(4,{0});
	var clickSlots = Array.fill(5,{0});
	var startClick = lachrymatorInstance.cueFrom('lachCountPart1','lachAsection',true,true,false);
	var jazzClick = lachrymatorInstance.cueFrom('lachTapping','lachJazzBsectionAgain',true,true,false);
	var endClick = lachrymatorInstance.cueFrom('lachCountPart3','lachOutro',true,true,false);
	var tracks = lachrymatorInstance.pbTracks;
	var improFunc = { | bufnum, rate, pan, amp|
		var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum) * rate,doneAction: 2);
		sig = Balance2.ar(sig[0],sig[1],0,amp).tanh;
		sig;
	};


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
						Ndef(\lachrymatorImpro)[10] = nil;
					}
				);
			},
			1,{
				switch(index,
					0,{
						"delay ON".postln;
						Ndef(\lachrymatorImpro,{
							var sig = SoundIn.ar(\inBus.kr(0));
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
						Ndef(\lachrymatorImpro).filter(10,{
							var bufnum = tracks.choose;
							var rate = 0.8.exprand(4) * 1.xrand2.sign;
							var pan = 0.6.rand2;
							var amp = \improAmp.kr(0.5);
							improFunc.value(bufnum, rate, pan, amp);

						});
					}
				);
			}
		);

	},'/lachrymator/synthOnOff/x');

	// improPads
	OSCdef(\lachrymatorImproPads,{ |msg, time,addr, recvPort|

		/*
		what am I doing here?!??!
		*/

	},'/lachrymator/improPads/x');

	// improXY


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
						DMXIS.cues['lachTapping']['lachTap'] = true;
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
						DMXIS.cues['lachTapping']['lachTap'] = false;
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