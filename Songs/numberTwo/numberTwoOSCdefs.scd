///////////////////////////////////////////////// YAWN oscDefs: numberFour /////////////////////////////////////////////////

(
var clickSlots = Array.fill(4,{0});
var startClick = ~yawn.songArray[2].cueFrom('twoCountPart1','twoAsection',true,true);
var jazzClick = ~yawn.songArray[2].cueFrom('twoTapping','twoJazzBsectionAgain',true,true);
var endClick = ~yawn.songArray[2].cueFrom('twoCountPart3','twoOutro',true,true);

// switches
/*
OSCdef(\numberTwoSynthOnOff,{ |msg, time,addr, recvPort|
var val = msg[1];

{index == 0}{ /* delay */ }
{index == 1}{ /* capture delay */ }
{index == 2}{ /* reverb */	}
{index == 3}{ /* impro */};

Ndef(\numberTwoImpro,{
var sig = SoundIn.ar(\inBus.kr(0));
var mute = \mute.kr;
var local = LocalIn.ar(2);
sig = DelayC.ar((sig * (1-mute)) + local,1.5,LFNoise1.ar(\speed.kr(0).linlin(0,1,0.05,7)!2).range(0.2,\delay.kr(0).linlin(0,1,0.3,1.5)));
LocalOut.ar(sig.reverse * Select.kr(mute,[0.75,1]));
sig = LeakDC.ar(sig);
sig = Splay.ar(sig,1,\amp.kr(1));
});

Ndef(\numberTwoImpro).set(\mute,1);

Ndef(\numberTwoImpro).filter(1,{})


Ndef(\numberTwoImpro).filter(15,{ |in|
var sig = HPF.ar(in,450);
sig = FreeVerb.ar(sig,1,1,0.95);
sig = LPF.ar(sig,2000);
sig = HPF.ar(sig,450);
});

},'/numberTwo/synthOnOff/x');
*/

// improPads
OSCdef(\numberTwoImproPads,{ |msg, time,addr, recvPort|
	var val = msg[1];

	/*
	what're we doing here?!??!
	*/

},'/numberTwo/improPads/x');

// improXY



// multiSlider - amps
OSCdef(\numberTwoSliders,{ |msg, time,addr, recvPort|
	var val = msg[1];

	/*
	not sure how this works yet
	sliders[0] = captureAmp
	sliders[1] = improAmp
	sliders[2] = reverbMix   Ndef(\numberTwoImpro).set(\mix15,val)
	*/


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
					startClick.play;
					"numberTwo start".postln;
				},
				1,{
					jazzClick.play;
					"tapping start".postln;
				},
				2,{
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


