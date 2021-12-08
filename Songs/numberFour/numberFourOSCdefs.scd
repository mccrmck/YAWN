///////////////////////////////////////////////// YAWN oscDefs: numberFour /////////////////////////////////////////////////

(
// bitCrusher on & off

OSCdef(\numberFourBitCrush,{ |msg, time,addr, recvPort|
	var val = msg[1].asInteger;

	case
	{val == 0}{
		Ndef(\numberFourBitCrush).stop;
	}
	{val == 1}{
		Ndef(\numberFourBitCrush,{
			var sig = SoundIn.ar(\inBus.kr(0));
			sig = Decimator.ar(sig,SampleRate.ir * \sRate.kr(1), 24 * \bits.kr(1));
			sig = Pan2.ar(Limiter.ar(sig),\pan.kr(0),\amp.kr(0.8));
			Out.ar(\outBus.kr,sig);

		}).play
	};

},'/numberFour/bitCrush/x');

// bitCrusher amp

OSCdef(\numberFourBitCrushAmp,{ |msg, time,addr, recvPort|
	var val = msg[1];
	val = \db.asSpec.map(val).dbamp;

	Ndef(\numberFourBitCrush).set(\amp,val)

},'/numberFour/numberFourBitCrushAmp/x');

// bitCrusher sRate & Bits

OSCdef(\numberFourBitCrushBits,{ |msg, time,addr, recvPort|
	var val = msg[1];
		val = val.linexp(0,1,0.05,0.3);

	Ndef(\numberFourBitCrush).set(\bits,val)

},'/numberFour/bitCrushXY/x');

// turn click on & off

OSCdef(\numberFourBitCrushRate,{ |msg, time,addr, recvPort|
	var val = msg[1];
		val = val.linexp(0,1,0.005,0.6);

	Ndef(\numberFourBitCrush).set(\sRate,val)

},'/numberFour/bitCrushXY/y');


// bitCrusher amp

OSCdef(\numberFourBitCrushAmp,{ |msg, time,addr, recvPort|
	var val = msg[1];
	val = \db.asSpec.map(val).dbamp;

	Ndef(\numberFourBitCrush).set(\amp,val)

},'/numberFour/bitCrushAmp/x');

// outro voice on & off

OSCdef(\numberFourBowVoice,{ |msg, time,addr, recvPort|
	var val = msg[1].asInteger;

	case
	{val == 0}{
		Ndef(\numberFourBow).stop;
	}
	{val == 1}{
		Ndef(\numberFourBow,{
			var bufnum = \bufnum.kr();
			var sig = PlayBuf.ar(1,bufnum,BufRateScale.kr(bufnum) * \rate.kr(1),doneAction: 2);
			sig = Pan2.ar(sig,\pan.kr(0),\amp.kr(1))

		}).play
	};

},'/numberFour/bowVoice/x');

// outro voice amp

OSCdef(\numberFourBowVoiceAmp,{ |msg, time,addr, recvPort|
	var val = msg[1];
	val = \db.asSpec.map(val).dbamp;

	Ndef(\numberFourBow).set(\amp,val)

},'/numberFour/bowVoiceAmp/x');

OSCdef(\numberFourClick,{ |msg, time,addr, recvPort|
	var val = msg[1];

	case
	{val == 0}{ /* start click */ }
	{val == 1}{ /* impro cue */	};

},'/numberFour/click/x');
)


