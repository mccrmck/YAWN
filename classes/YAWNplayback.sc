YAWNPlayback {

	var <bufnum, <outBus, <ampBus;

	*initClass {

		StartUp.add{

			[\monoYawnPlayback, \stereoYawnPlayback].do({ |key, index|
				var channels = index + 1;

				SynthDef(key,{
					var bufnum = \buf.kr();
					var sig = PlayBuf.ar(channels,bufnum,BufRateScale.kr(bufnum),loop: \loop.kr(0),doneAction: 2);
					OffsetOut.ar(\out.kr(0),sig  * \amp.kr(-20.dbamp));
				}).add;
			})
		}
	}

	*makeStereoPat { |bufnum, outBus, amp = 0.1|

		^Pmono(
			\stereoYawnPlayback,
			\buf, Pseq([bufnum]),
			\dur, bufnum.duration,
			\amp, amp,
			\out, outBus
		)
	}

	*makeMonoPat { |bufnum, outBus, amp = 0.1|

		^Pmono(
			\monoYawnPlayback,
			\buf, Pseq([bufnum]),
			\dur, bufnum.duration,
			\amp, amp,
			\out, outBus
		)
	}

	*makeStereoOverlap { |bufnum, outBus, amp = 0.1|

		^Pbind(
			\instrument,\stereoYawnPlayback,
			\buf, Pseq([bufnum]),
			\dur, 0,
			\amp, amp,
			\out, outBus
		)
	}

	*makeMonoOverlap { |bufnum, outBus, amp = 0.1|

		^Pbind(
			\instrument,\monoYawnPlayback,
			\buf, Pseq([bufnum]),
			\dur, 0,
			\amp, amp,
			\out, outBus
		)
	}
}