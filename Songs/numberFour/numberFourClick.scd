
(
a = Click(142,1,1);
b = Click(142,1,2);
c = Click(142,1,4);
d = ClickLoop(142,1,1,~someCue);
e = ClickCue(142,1,4);
f = ClickCue(142,1,2);
g = ClickCue(142,1,1);

/*
could even be shortened?
var tempo;
var clk = [1,2,4].collect({|i| Click(tempo,1,i);});
var cue = [1,2,4].collect({|i| ClickCue(tempo,1,i);});
var loop = ClickLoop(142,1,1,~someCue);

*/


Pdef(\numberFourClick,
	Psym(
		Pseq([
			// count off
			b!2,a!4,

			//beginning
			c!116,

			//ambient solo
			d,

			// cue
			[[c,e]], // or cue is maybe already in a Ppar???
			[[c,e]],
			[b!2,f!2], // is this right? Or do they get flopped
			[a!4,g!4],

			c!5,b,

			//heavy outro
			c!57,
			b // - last beat

		].flatten(1),1)
	)
);
)

