///////////////////////////////////////////////// YAWN oscDefs: numberFour /////////////////////////////////////////////////

(
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
		};
		{index == 2}{ /* gtrStutter */ }
		{index == 3}{ /* drumFreeze */ }
		{index == 4}{ /* drumStutter */	}
		{index == 5}{ /* shiftRegister */	};
	})


},'/numberOne/synthSwitches/x');

// intro instrument  XY...multiple balls maybe??


// shiftRegister XY


// multiSlider - amps

OSCdef(\numberOneSynthAmps,{ |msg, time,addr, recvPort|
	var val = msg[1];

	// not sure how this works...is it an array of values?
	// am I passing this to busses, or is everything going to be Ndef.set?? (probably..)

},'/numberOne/amps/x');


// turn click on & off

OSCdef(\numberOneClick,{ |msg, time,addr, recvPort|
	var val = msg[1];

	case
	{val == 0}{ /* start click */ }
	{val == 1}{ /* loop4 cue */	};
	{val == 2}{ /* loop8 cue */ }
	{val == 3}{ /* elevenRiff cue */ }
	{val == 4}{ /* bomb cue */	}
	{val == 5}{ /* outro cue */	};

},'/numberOne/click/x');
)



OSCdef(\numberOneIntroSynthX,{ |msg, time,addr, recvPort|
	var val = msg[1];
	var index = val.floor.round.osv;
	var func = [
		nil, // test that this doesn't remove the whole synth - in that case, can it be replaced with 1
		{ |sig| Decimator.ar(sig, SampleRate.ir * \xArg.kr(1).linlin(0,1,0.01,0.6),24 * \yArg.kr(1).linlin(0,1,0.05,0.3)) },
		{ |sig| RLPF.ar(sig,\xArg.kr(1,0.1).linlin(0,1,500,5000),\yArg.kr(1).linlin(0,1,0.001,1),4).tanh },
		{ |sig| sig * SinOsc.ar(\xArg.kr(1).linlin(0,1,20,5000) * SinOsc.kr(\yArg.kr(0).linlin(0,1,0.1,12))) },
		{ |sig| CombC.ar(sig,0.1,\xArg.kr(0.5).range(0,1,0.002,0.03),\yArg.kr(0).linlin(0,1,0.2,1))},
		{ |sig| PV_RectComb(FFT(LocalBuf(512.dup),sig),\xArg.kr(0.5).linlin(0,1,8,12),\yArg.kr(0).linlin(0,1,0.3,0.8)) },
		{ |sig| PV_BrickWall(PV_Freeze(FFT(LocalBuf(512.dup),sig),\yArg.kr(0.5).linlin(0,1,-0.5,0.1)),\xArg.kr(0.5).linlin(0,1,-0.9,0.1)) }
	];

	Ndef(\oneIntro).filter(1,func[index]);

	// Ndef(\oneIntro).set(\xArg,val);

},'/numberOne/introSynth/x')


OSCdef(\numberOneIntroSynthY,{ |msg, time,addr, recvPort|
	var val = msg[1];


	Ndef(\oneIntro).set(\yArg,val);

},'/numberOne/introSynth/y')

