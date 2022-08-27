YAWNPlayback {

	var <bufnum, <outBus, <ampBus;

	*initClass {

		StartUp.add{

			SynthDef(\stereoYawnPlayBack,{
				var bufnum = \bufnum.kr();
				var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum),doneAction: 2);
				sig = Balance2.ar(sig[0],sig[1],\pan.kr(0),\amp.kr(1));
				OffsetOut.ar(\outBus.kr(0),sig);
			}).add;
		}
	}

	*makePat { |bufnum, outBus|         // what's a convenient way to access this after init if I want to start/stop playback? Does it happen here, or in YAWNShow?

		^Pbind(
			\instrument, \stereoYawnPlayBack,
			\bufnum,Pseq([bufnum],1),
			\outBus,outBus,
		)
	}
}



