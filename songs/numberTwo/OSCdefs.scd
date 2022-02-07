///////////////////////////////////////////////// YAWN oscDefs: numberTwo /////////////////////////////////////////////////

(
var switchSlots = Array.fill(4,{0});
var clickSlots = Array.fill(4,{0});
// var startClick = ~yawn.songArray[2].cueFrom('twoCountPart1','twoAsection',true,true);
// var jazzClick = ~yawn.songArray[2].cueFrom('twoTapping','twoJazzBsectionAgain',true,true);
// var endClick = ~yawn.songArray[2].cueFrom('twoCountPart3','twoOutro',true,true);
var startClick = YAWNSong('numberTwo').cueFrom('twoCountPart1','twoAsection',true,true);
var jazzClick = YAWNSong('numberTwo').cueFrom('twoTapping','twoJazzBsectionAgain',true,true);
var endClick = YAWNSong('numberTwo').cueFrom('twoCountPart3','twoOutro',true,true);

var improFunc = { | bufnum, rate, pan, amp|
	var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum) * rate,doneAction: 2);
	sig = Balance2.ar(sig[0],sig[1],0,amp);
	sig;
};

// switches

OSCdef(\numberTwoSynthOnOff,{ |msg, time,addr, recvPort|
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
					Ndef(\numberTwoImpro).clear;
				},
				1,{
					"hold OFF".postln;
					Ndef(\numberTwoImpro).set(\mute,0);
				},
				2,{
					"reverb OFF".postln;
					Ndef(\numberTwoImpro)[15] = nil;
				},
				3,{
					"impro OFF".postln;
					Ndef(\numberTwoImpro)[10] = nil;
				}
			);
		},
		1,{
			switch(index,
				0,{
					"delay ON".postln;
					Ndef(\numberTwoImpro,{
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
					Ndef(\numberTwoImpro).set(\mute,1);
				},
				2,{
					"reverb ON".postln;
					Ndef(\numberTwoImpro).filter(15,{ |in|
						var sig = HPF.ar(in,450);
						sig = FreeVerb.ar(sig,1,1,0.95);
						sig = LPF.ar(sig,2000);
						sig = HPF.ar(sig,450);
					});
				},
				3,{
					"impro ON".postln;
					Ndef(\numberTwoImpro).filter(10,{
						var bufnum = ~yawn.songArray[2].pbTracks.choose;
						var rate = 0.8.exprand(4) * 1.xrand2.sign;
						var pan = 0.6.rand2;
						var amp = \improAmp.kr(0.5);
						improFunc.value(bufnum, rate, pan, amp);

					})

				}
			);
		}
	);


},'/numberTwo/synthOnOff/x');

// improPads
OSCdef(\numberTwoImproPads,{ |msg, time,addr, recvPort|

	/*
	what're we doing here?!??!
	*/

},'/numberTwo/improPads/x');

// improXY


// multiSlider - amps
OSCdef(\numberTwoSliders,{ |msg, time,addr, recvPort|
	var delayAmp = \db.asSpec.map(msg[1]).dbamp;
	var improAmp = \db.asSpec.map(msg[2]).dbamp;
	var reverbMix = \db.asSpec.map(msg[3]).dbamp;

	Ndef(\numberTwoImpro).set(\amp,delayAmp);
	Ndef(\numberTwoImpro).set(\improAmp,improAmp);
	Ndef(\numberTwoImpro).set(\wet15,reverbMix);

},'/numberTwo/sliders/x');


// turn click on & off

OSCdef(\numberTwoClick,{ |msg, time,addr, recvPort|
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
					"numberTwo stop".postln;
				},
				1,{
					jazzClick.stop;
					"tapping stop".postln;
				},
				2,{
					"openTwo: true".postln;
					Click.loopCues[\openTwo] = true;
					DMXIS.cues['twoTapping']['openTwo'] = true;
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
					"numberTwo starting in % seconds".format(secs).postln;
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
					"openTwo: false".postln;
					Click.loopCues[\openTwo] = false;
					DMXIS.cues['twoTapping']['openTwo'] = false;
				},
				3,{
					endClick.play;
					"ending start".postln;
				}
			);
		}
	);

},'/numberTwo/click/x');
)
