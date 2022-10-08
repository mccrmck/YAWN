var outs = YAWNShow.outDict;
var testBufs = YAWNShow.sCheckBufs;

['Torfinn','Oskar','Mike'].do({ |key,index|
	var clicks = 0!3;
	var eventKey = ("click" ++ key).asSymbol;
	var outBus = outs[eventKey];

	OSCFunc({ |msg|
		var val = msg[1];

		case
		{ val == 1 }{
			clicks[index] = Click(120,4,repeats: inf, out: outBus).play;
			// "% click: play".format(key).postln
		}
		{ val == 0 }{
			clicks[index].stop;
			// "% click: stop".format(key).postln
		}

	},"/clickTest/%".format(index).asSymbol)

});

['bass','synths','gtrs','perc','ambience','process'].do({ |key,index|
	var loops = 0!6;
	var eventKey = (key ++ "Out").asSymbol;
	var outBus = outs[eventKey];

	if( index == 0, {
		OSCFunc({ |msg|
			var val = msg[1];

			case
			{ val == 1 }{
				loops[index] = Synth(\monoYawnPlayback,[\bufnum,testBufs[key],\loop,1,\outBus,outBus])
			}
			{ val == 0 }{
				loops[index].free;
			}

		},"/outTest/%".format(index).asSymbol)
	},{
		OSCFunc({ |msg|
			var val = msg[1];
			case
			{ val == 1 }{
				loops[index] = Synth(\stereoYawnPlayback,[\bufnum,testBufs[key],\loop,1,\outBus,outBus])
			}
			{ val == 0 }{
				loops[index].free;
			}

		},"/outTest/%".format(index).asSymbol)
	})
});

// something for kempers here evenutally?


// something for lights here evenutally? 