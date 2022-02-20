///////////////////////////////////////////////// YAWN oscDefs: tokamak /////////////////////////////////////////////////

({ |yawnShow, tokamakInstance|

	var clickSlots = Array.fill(2,{0});
	var startClick = tokamakInstance.cueFrom('tokamakPB','tokamakOutro',true,false,true,true); // must test!
	var bowTrack = tokamakInstance.pbTracks['leads'][0];
	var gitar = yawnShow.inputs['gitarIn'];

	// bitCrusher on & off

	OSCdef(\tokamakBitCrush,{ |msg, time,addr, recvPort|
		var val = msg[1].asInteger;

		case
		{val == 0}{
			Ndef(\tokamakBitCrush).clear;
		}
		{val == 1}{
			Ndef(\tokamakBitCrush,{
				var sig = SoundIn.ar(gitar);
				sig = Decimator.ar(sig.sum,SampleRate.ir * \sRate.kr(1), 24 * \bits.kr(1));
				sig = Pan2.ar(Limiter.ar(sig),\pan.kr(0),\amp.kr(0.8));
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

	OSCdef(\tokamakBowVoice,{ |msg, time,addr, recvPort|
		var val = msg[1].asInteger;

		case
		{val == 0}{
			Ndef(\tokamakBow).clear;
		}
		{val == 1}{
			Routine({
				"bowing in 10 seconds".postln;
				5.wait;
				Ndef(\tokamakBow,\stereoShowPlayBack).set(\bufnum,bowTrack).play
			}).play
		};

	},'/tokamak/bowVoice/x');

	// outro voice amp

	OSCdef(\tokamakBowVoiceAmp,{ |msg, time,addr, recvPort|
		var val = msg[1];
		val = \db.asSpec.map(val).dbamp;

		Ndef(\tokamakBow).set(\amp,val)

	},'/tokamak/bowVoiceAmp/x');

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
						DMXIS.cues['tokamakImproLoop']['tokamakLoop'] = true;
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
						DMXIS.cues['tokamakImproLoop']['tokamakLoop'] = false;
					}
				);
			}
		);

	},'/tokamak/click/x');
})