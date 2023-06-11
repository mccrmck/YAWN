///////////////////////////////////////////////// YAWN OSC: chaos /////////////////////////////////////////////////

var ins = YAWNShow.inDict;
var outs = YAWNShow.outDict;
var busses = [
	[ins['snareTop'], ins['snareBot']],
	ins['overheads'],
	ins['torfinnGtr'],
];

var introBuf = YAWNShow.set.songs[3].pbTracks['voice'][0];
var processSynths = 0!6;
var noiseSynths = 0!2;

// click

var clickPats = [
	Pdef(\chaosOpener,
		Pseq([
			Ppar([
				YAWNPlayback.makeStereoPat(introBuf, outs['processOut'],10.dbamp),
				Pseq([
					ClickRest(60,(introBuf.duration - 2.6666666666667)).pattern, // this is the duration of the blast count in
					YAWNShow.set.songs[0].cueFrom('blastA00','blastA03',true,true,true,true,true).stop
				])
			]),
			YAWNShow.set.songs[3].cueFrom('chaosCount','chaosElevenLast',true,true,true,true,true).stop
		])
	).stop,
	'chaosElevenLoopOne',
	'chaosElevenLoopTwo',
	YAWNShow.set.songs[3].cueFrom('chaosBomb','chaosBomb',true,true,true,true,false).stop,
	YAWNShow.set.songs[3].cueFrom('chaosCountAgain','chaosOutro',true,true,true,true,false).stop
];

clickPats.do({ |pattern, index|

	switch(index,
		1,{
			OSCdef("chaosClick%".format(index).asSymbol,{ |msg|
				var val = msg[1].asInteger;

				case
				{ val == 1 }{ Click.loopCues['chaosElevenLoopOne'] = false; DMXIS.loopCues['chaosElevenLoopOne'] = false }
				{ val == 0 }{ Click.loopCues['chaosElevenLoopOne'] = true; DMXIS.loopCues['chaosElevenLoopOne'] = true }

			},"/chaosClick/%".format(index).asSymbol)
		},
		2,{
			OSCdef("chaosClick%".format(index).asSymbol,{ |msg|
				var val = msg[1].asInteger;

				case
				{ val == 1 }{ Click.loopCues['chaosElevenLoopTwo'] = false; DMXIS.loopCues['chaosElevenLoopTwo'] = false }
				{ val == 0 }{ Click.loopCues['chaosElevenLoopTwo'] = true; DMXIS.loopCues['chaosElevenLoopTwo'] = true }

			},"/chaosClick/%".format(index).asSymbol)
		},{
			OSCdef("chaosClick%".format(index).asSymbol,{ |msg|
				var val = msg[1].asInteger;

				case
				{ val == 1 }{ pattern.play }
				{ val == 0 }{ pattern.stop }

			},"/chaosClick/%".format(index).asSymbol)
		}
	)
});

// eleven impro instrument

OSCdef(\chaosRepsFreezeTouchOnOff,{ |msg|
	var index = msg[1];
	var type = msg[2];
	var value = msg[3].asString.interpret;
	var xVal = value[0];
	var yVal = value[1];

	if(type == 'start',{
		case
		{index < 3}{ processSynths[index] = Synth(\repeater,[\inBus,busses[index % 3],\pan,xVal,\outBus,outs['processOut']] ) }
		{index > 2}{ processSynths[index] = Synth(\freeze,[\inBus, busses[index % 3],\pan,xVal,\outBus,outs['processOut']] ) }
	},{
		case
		{index < 3}{ processSynths[index].set(\gate,0) }
		{index > 2}{ processSynths[index].set(\gate,0) }
	})

},'/chaosRepsFreezeTouch');

6.do({ |index|

	OSCdef("chaosRepsFreezeXY%".format(index).asSymbol,{ |msg|
		var xVal = msg[1];
		var yVal = msg[2];

		case
		{index < 3}{ processSynths[index].set(\delay,xVal,\feedB,yVal) }
		{index > 2}{ processSynths[index].set(\freq,xVal,\rq,yVal) };

	},"/chaosRepsFreeze/%".format(index).asSymbol);
});


// noisyness
OSCdef(\chaosNoiseOnOff,{ |msg|
	var index = msg[1];
	var val = msg[2];

	if(val == 'start',{
		case
		{ index == 0 }{ noiseSynths[index] = Synth(\noiseFilt,[\outBus,outs['processOut']]) }
		{ index == 1 }{ noiseSynths[index] = Synth(\lfNoise,[\outBus,outs['processOut']]) }
	},{
		case
		{ index == 0 }{ noiseSynths[index].set(\gate,0) }
		{ index == 1 }{ noiseSynths[index].set(\gate,0) }
	})

},'/chaosNoiseTouch');

2.do({ |index|

	OSCdef("chaosNoiseXY%".format(index).asSymbol,{ |msg|
		var xVal = msg[1];
		var yVal = msg[2];

		case
		{ index == 0 }{ noiseSynths[index].set(\lpFreq,xVal,\lpQ,yVal) }
		{ index == 1 }{ noiseSynths[index].set(\freq,xVal,\combFreq,yVal) };

	},"/chaosNoise/%".format(index).asSymbol);
});