///////////////////////////////////////////////// YAWN oscDefs: cement /////////////////////////////////////////////////

({ |yawnShow, cementInstance|
	var clickSlots = Array.fill(2,{0});
	var startClick = cementInstance.cueFrom('cementCount','cementAsectionLast',true,false,true,true);
	var gitar = yawnShow.inputs['gitarIn'];


	// turn morph on & off

	OSCdef(\cementMorphOnOff,{ |msg, time,addr, recvPort|
		var val = msg[1];

		case
		{val == 0}{ Ndef(\cementMorph).stop }
		{val == 1}{
			Ndef(\cementMorph,{
				var voices = 10;
				var freq = { 500.exprand(1500.0) }!voices;
				var sig = SoundIn.ar(gitar).sum;

				sig = sig * LFNoise2.kr(0.5).range(0.5,1);

				sig = RLPF.ar(sig,freq * LFNoise2.kr({0.5.exprand(10.0)}!voices).range(0.5,2.0),0.08);
				sig = (sig * \gain.kr(1).linlin(0,1,1,8)).clip2;
				sig = AllpassC.ar(sig,0.02,0.02,0.5);
				sig = Splay.ar(sig,1);
				sig = FreeVerb2.ar(sig[0],sig[1],0.5,1,1,\amp.kr(0.5) * SinOsc.kr(LFNoise2.kr(1!2).range(2.0,8.0)).abs);
			}).play
		};

	},'/cement/morphOnOff/x');

	// morph amp

	OSCdef(\cementMorphAmp,{ |msg, time,addr, recvPort|
		var amp = msg[1];
		var gain = msg[2];
		amp = \db.asSpec.map(amp).dbamp;
		gain = \db.asSpec.map(gain).dbamp;

		Ndef(\cementMorph).set(\amp,amp,\gain,gain);

	},'/cement/morphAmp/x');

	// turn click on & off

	OSCdef(\cementClick,{ |msg, time,addr, recvPort|
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
						"cement stop".postln;
					},
					1,{
						"openCement: true".postln;
						Click.loopCues['cementLoop'] = true;
						DMXIS.loopCues['cementLoop'] = true;
					}
				);
			},
			1,{
				switch(index,
					0,{
						startClick.play;
						"cement start".postln;
					},
					1,{
						"openCement: false".postln;
						Click.loopCues['cementLoop'] = false;
						DMXIS.loopCues['cementLoop'] = false;
					}
				);
			}
		);
	},'/cement/click/x');
})