///////////////////////////////////////////////// YAWN OSC: chaos /////////////////////////////////////////////////

var ins = YAWNShow.inDict;
var outs = YAWNShow.outDict;
var busses = [
	[ins['snareTop'], ins['snareBot']],
	ins['overheads'],
	ins['torfinnGtr'],
];

var synths = 0!6;


// click

var clickPats = [
	Pseq([
		YAWNShow.set.songs[0].cueFrom('blastAcount','blastC13',true,true,true,false,true).stop,             // fix start/stop points add blast cue
		YAWNShow.set.songs[3].cueFrom('chaosCount','chaosElevenLast',true,true,true,true,true).stop
	]),
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
});


// eleven impro instrument

OSCdef(\chaosOnOff,{ |msg|
	var index = msg[1];
	var val = msg[2];

	if(val == 'start',{
		case
		// {index < 3}{ synths[index] = Synth(\repeater,[\inBus,[2,2],\outBus,0] ) }
		{index < 3}{ synths[index] = Synth(\repeater,[\inBus,busses[index % 3],\outBus,outs['processOut']] ) }
		{index > 2}{ synths[index] = Synth(\freeze,[\inBus, busses[index % 3],\outBus,outs['processOut']] ) }
		// {index > 2}{ synths[index] = Synth(\freeze,[\inBus,[2,2],\outBus,0] ) }
	},{
		case
		{index < 3}{ synths[index].set(\gate,0) }
		{index > 2}{ synths[index].set(\gate,0) }
	})

},'/chaos');

6.do({ |index|

	OSCdef("chaosCtrl%".format(index).asSymbol,{ |msg|
		var xVal = msg[1];
		var yVal = msg[2];

		case
		{index < 3}{ synths[index].set(\delay,xVal,\feedB,yVal) }
		{index > 2}{ synths[index].set(\pan,xVal,\wipe,yVal) };

	},"/chaosXY/%".format(index).asSymbol);
})