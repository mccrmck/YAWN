///////////////////////////////////////////////// YAWN oscDefs: numberFour /////////////////////////////////////////////////

(
var clickSlots = Array.fill(6,{0});
var startClick = ~yawn.songArray[1].cueFrom('oneDrumCue','oneElevenLast',true,true);     //this will get changed eventually
var bombs = ~yawn.songArray[1].cueFrom('oneBomb','oneBomb',true,true);
var endClick = ~yawn.songArray[1].cueFrom('oneCountPart3','oneOutro',true,true);

// on & off Switches
OSCdef(\numberOneSynthSwitches,{ |msg, time,addr, recvPort|
	var val = msg[1];

	val.do({ |active, index|
		case
		{index == 0}{
			if(active == 1,{
				/* intro synth on */
			},{
				/* intro synth off */
			})
		}
		{index == 1}{
			if(active == 1,{
				/* gtrFreeze on */
			},{
				/* gtrFreeze off */
			})
		}
		{index == 2}{ /* gtrStutter */ }
		{index == 3}{ /* drumFreeze */ }
		{index == 4}{ /* drumStutter */	}
		{index == 5}{ /* shiftRegister */};
	});

},'/numberOne/synthSwitches/x');

// intro instrument  XY...multiple balls maybe??


// shiftRegister XY


// multiSlider - amps

OSCdef(\numberOneSynthAmps,{ |msg, time,addr, recvPort|
	var val = msg[1];

	// not sure how this works...is it an array of values?
	// am I passing this to busses, or is everything going to be Ndef.set?? (probably..)
	// scale with \db.asSpec

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
					Click.loopCues[\openOneFour] = true;
					DMXIS.cues['oneGitIntro']['openOneFour'] = true;
				},
				2,{
					Click.loopCues[\openOneEight] = true;
					DMXIS.cues['oneGitDrums']['openOneEight'] = true;
				},
				3,{
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
					Click.loopCues['openOneFour'] = false;
					DMXIS.cues['oneGitIntro']['openOneFour'] = false;
				},
				2,{
					Click.loopCues[\openOneEight] = false;
					DMXIS.cues['oneGitDrums']['openOneEight'] = false;
				},
				3,{
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

