///////////////////////////////////////////////// YAWN oscDefs: numberFour /////////////////////////////////////////////////

(
var clickSlots = Array.fill(2,{0});
var startClick = ~yawn.songArray[3].cueFrom('fourCount','fourOutro',true,true);
// var startClick = YAWNSong('numberFour').cueFrom('fourCount','fourOutro',true,true); // must test!

// bitCrusher on & off

OSCdef(\numberFourBitCrush,{ |msg, time,addr, recvPort|
	var val = msg[1].asInteger;

	case
	{val == 0}{
		Ndef(\numberFourBitCrush).clear;
	}
	{val == 1}{
		Ndef(\numberFourBitCrush,{
			var sig = SoundIn.ar(\inBus.kr(0));
			sig = Decimator.ar(sig,SampleRate.ir * \sRate.kr(1), 24 * \bits.kr(1));
			sig = Pan2.ar(Limiter.ar(sig),\pan.kr(0),\amp.kr(0.8));
		}).play
	};

},'/numberFour/bitCrush/x');

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
		Ndef(\numberFourBow).clear;
	}
	{val == 1}{
		Routine({
			"bowing in 10 seconds".postln;
			5.wait;
			Ndef(\numberFourBow,\stereoShowPlayBack).set(\bufnum,~yawn.songArray[3].pbTracks[0]).play
		}).play
	};

},'/numberFour/bowVoice/x');

// outro voice amp

OSCdef(\numberFourBowVoiceAmp,{ |msg, time,addr, recvPort|
	var val = msg[1];
	val = \db.asSpec.map(val).dbamp;

	Ndef(\numberFourBow).set(\amp,val)

},'/numberFour/bowVoiceAmp/x');

OSCdef(\numberFourClick,{ |msg, time,addr, recvPort|    //this can be optimized with a Changed function, shouldn't need to iterate!
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
					"numberFour stop".postln;
				},
				1,{
					"openFour: true".postln;
					Click.loopCues[\openFour] = true;
					DMXIS.cues['fourImpro']['openFour'] = true;
				}
			);
		},
		1,{
			switch(index,
				0,{
					startClick.play;
					"numberFour start".postln;
				},
				1,{
					"openFour: false".postln;
					Click.loopCues[\openFour] = false;
					DMXIS.cues['fourImpro']['openFour'] = false;
				}
			);
		}
	);

},'/numberFour/click/x');
)