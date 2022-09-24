YAWNPlayback {

	var <bufnum, <outBus, <ampBus;

	*initClass {

		StartUp.add{

			SynthDef(\stereoYawnPlayback,{
				var bufnum = \bufnum.kr();
				var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum),doneAction: 2);
				sig = Balance2.ar(sig[0],sig[1],\pan.kr(0),\amp.kr(1));
				OffsetOut.ar(\outBus.kr(0),sig);
			}).add;

			SynthDef(\monoYawnPlayback,{
				var bufnum = \bufnum.kr();
				var sig = PlayBuf.ar(1,bufnum,BufRateScale.kr(bufnum),doneAction: 2);
				OffsetOut.ar(\outBus.kr(0),sig * \amp.kr(1));
			}).add;
		}
	}

	*makeStereoPat { |bufnum,outBus|
		^Pmono(
			\stereoYawnPlayback,
			\bufnum, Pseq([bufnum]),
			\dur, bufnum.duration,
			\outBus, outBus
		)
	}

	*makeMonoPat { |bufnum,outBus|
		^Pmono(
			\monoYawnPlayback,
			\bufnum, Pseq([bufnum]),
			\dur, bufnum.duration,
			\outBus, outBus
		)
	}
}