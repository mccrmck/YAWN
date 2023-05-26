YAWNPlayback {

	var <bufnum, <outBus, <ampBus;

	*initClass {

		StartUp.add{

			SynthDef(\stereoYawnPlayback,{
				var bufnum = \bufnum.kr();
				var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum),loop: \loop.kr(0),doneAction: 2);
				sig = Rotate2.ar(sig[0],sig[1],\pan.kr(0)) * \amp.kr(-20.dbamp);
				OffsetOut.ar(\outBus.kr(0),sig);
			}).add;

			SynthDef(\monoYawnPlayback,{
				var bufnum = \bufnum.kr();
				var sig = PlayBuf.ar(1,bufnum,BufRateScale.kr(bufnum),loop: \loop.kr(0),doneAction: 2);
				OffsetOut.ar(\outBus.kr(0),sig * \amp.kr(-20.dbamp));
			}).add;
		}
	}

	*makeStereoPat { |bufnum, outBus, amp = 1|
		^Pmono(
			\stereoYawnPlayback,
			\bufnum, Pseq([bufnum]),
			\dur, bufnum.duration,
			\amp,-20.dbamp * amp,
			\outBus, outBus
		)
	}

	*makeMonoPat { |bufnum, outBus, amp = 1|
		^Pmono(
			\monoYawnPlayback,
			\bufnum, Pseq([bufnum]),
			\dur, bufnum.duration,
			\amp,-20.dbamp * amp,
			\outBus, outBus
		)
	}

	*makeStereoOverlap { |bufnum, outBus, amp = 1|
		^Pbind(
			\instrument,\stereoYawnPlayback,
			\bufnum, Pseq([bufnum]),
			\dur, 0,
			\amp,-20.dbamp * amp,
			\outBus, outBus
		)
	}

	*makeMonoOverlap { |bufnum, outBus, amp = 1|
		^Pbind(
			\instrument,\monoYawnPlayback,
			\bufnum, Pseq([bufnum]),
			\dur, 0,
			\amp,-20.dbamp * amp,
			\outBus, outBus
		)
	}
}