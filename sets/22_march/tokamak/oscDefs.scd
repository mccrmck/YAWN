///////////////////////////////////////////////// YAWN oscDefs: tokamak /////////////////////////////////////////////////

({ |yawnShow, tokamakInstance|

	var clickSlots = Array.fill(2,{0});
	var startClick = tokamakInstance.cueFrom('tokamakPB','tokamakOutro',true,true,true,true);
	var bowPat = tokamakInstance.cueFrom('bow','bow',true,true,true,true);
	var gitar = yawnShow.inputs['gitarIn'];
	var drums = yawnShow.inputs['ohIn'];

	// bitCrusher on & off

	OSCdef(\tokamakBitCrush,{ |msg, time,addr, recvPort|
		var val = msg[1].asInteger;

		case
		{val == 0}{
			Ndef(\tokamakBitCrush).clear;
		}
		{val == 1}{
			Ndef(\tokamakBitCrush,{
				var sig = SoundIn.ar(gitar) + SoundIn.ar(drums);
				sig = Decimator.ar(sig,SampleRate.ir * \sRate.kr(1), 24 * \bits.kr(1));
				Limiter.ar(sig) * \amp.kr(0.8);
			}).play
		};

	},'/tokamak/bitCrush/x');

	// bitCrusher sRate & Bits

	OSCdef(\tokamakBitCrushBits,{ |msg, time,addr, recvPort|
		var val = msg[1];
		val = val.linexp(0,1,0.05,0.3);

		Ndef(\tokamakBitCrush).set(\bits,val)

	},'/tokamak/bitCrushXY/x');

	// turn click on & off

	OSCdef(\tokamakBitCrushRate,{ |msg, time,addr, recvPort|
		var val = msg[1];
		val = val.linexp(0,1,0.005,0.6);

		Ndef(\tokamakBitCrush).set(\sRate,val)

	},'/tokamak/bitCrushXY/y');

	// bitCrusher amp

	OSCdef(\tokamakBitCrushAmp,{ |msg, time,addr, recvPort|
		var val = msg[1];
		val = \db.asSpec.map(val).dbamp;

		Ndef(\tokamakBitCrush).set(\amp,val)

	},'/tokamak/bitCrushAmp/x');

	// outro voice on & off

	OSCdef(\tokamakBow,{ |msg, time,addr, recvPort|
		var val = msg[1].asInteger;

		case
		{val == 0}{
			bowPat.stop;
		}
		{val == 1}{
			Routine({
				"bowing in 10 seconds".postln;
				5.wait;
				bowPat.play;
			}).play
		};

	},'/tokamak/bow/x');

	OSCdef(\tokamakClick,{ |msg, time,addr, recvPort|    //this can be optimized with a Changed function, shouldn't need to iterate!
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
						"tokamak stop".postln;
					},
					1,{
						"loop: true".postln;
						Click.loopCues['tokamakLoop'] = true;
						DMXIS.loopCues['tokamakLoop'] = true;
					}
				);
			},
			1,{
				switch(index,
					0,{
						startClick.play;
						"tokamak start".postln;
					},
					1,{
						"loop: false".postln;
						Click.loopCues['tokamakLoop'] = false;
						DMXIS.loopCues['tokamakLoop'] = false;
					}
				);
			}
		);

	},'/tokamak/click/x');
})