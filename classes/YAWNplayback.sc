YAWNPlayback {

	var <bufnum, <outBus, <ampBus;

	*initClass {

		StartUp.add{

			SynthDef(\stereoYawnPlayBack,{
				var bufnum = \bufnum.kr();
				var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum),doneAction: 2);
				sig = Balance2.ar(sig[0],sig[1],\pan.kr(0),\amp.kr(0.8));
				OffsetOut.ar(\outBus.kr(0),sig);
			}).add;
		}
	}

	*new {
		^super.new.init;
	}

	init {

		// ??

	}

	makePat { |bufnum, outBus, ampBus|

		^Pbind(
			\instrument, \stereoYawnPlayBack,
			\dur, bufnum.duration,
			\bufnum,bufnum,
			\outBus,outBus,
			\amp,Pfunc({ ampBus.getSynchronous }),
		)
	}


}



