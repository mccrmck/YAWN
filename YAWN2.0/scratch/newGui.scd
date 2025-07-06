

(
var scroll = ScrollView(bounds:Rect(0,0,300,300).center_(Window.availableBounds.center));
var canvas = View().background_(Color.red);
var layout;
var i = 0;

var makeBar = { |beats, bpm,col|
    var view = UserView()
    .background_(col.alpha_(0.8))
    .drawFunc_({ |u|
        beats.do{ |i|
            var x = u.bounds.width * (i/beats);
            Pen.color = Color(0.2,0.3,0.4, 1 - (i/beats) );
            Pen.fillRect(Rect(x,0,u.bounds.width/beats,u.bounds.height));
        };

        Pen.stringAtPoint(bpm.asString,2@0,Font.monospace(10),Color.white);
    });

    view.maxWidth_((60/bpm) * beats * view.bounds.width );
    i = i + 1;
    view;
};

var tracks = 4.collect{ HLayout() };

4.do{ |i|
    var col = Color.rand;
    3.do{
        tracks[i]
        .add( makeBar.(3.rrand(8),30.rrand(220),col) )
    }
};

layout = VLayout( *tracks );

canvas.layout = layout;
//10.do { canvas.layout.add( makeBar.(3.rrand(8),30.rrand(220)), ) };
//canvas.layout.add(nil); // stretch remaining empty space

scroll.canvas = canvas;
scroll.front;
i.postln;
)



(
fork{
  loop{
    play{
     Splay.ar(
         {Klank.ar(`[13.rand*(55/4)*(1..8)],Crackle.ar(2,0.005))*LFGauss.ar(9,1/4,0,0,2)}!3
     )
    };
    1.wait;
  }
}
)

s.meter
s.plotTree






(
var win;
var scroll = ScrollView();
var canvas = View();
var time = UserView(scroll).background_(Color.white).minWidth_(10000);
var lastBarX = [0,0,0];
var tempo = 3.collect{ View(scroll).background_(Color.black).layout_( HLayout().margins_(0).spacing_(0) ) };
var track = 3.collect{ View(scroll).background_(Color.rand) };


time.drawFunc_{
    var h = time.bounds.height;
    var w = time.bounds.width;
    var numSecs = 60 * 4;
    var oneSec = w/numSecs;
    Pen.color = Color.black;
    numSecs.do{ |i|
        var x = (i * oneSec);
        Pen.stringInRect("%:%".format(i),Rect(x,0,oneSec,15));
        Pen.moveTo(x@0);
        Pen.lineTo(x@h);
        Pen.moveTo((x + (oneSec/2))@(h/2));
        Pen.lineTo((x + (oneSec/2))@h);
        Pen.moveTo((x + (oneSec/4))@(h * 0.75));
        Pen.lineTo((x + (oneSec/4))@h);
        Pen.moveTo((x + (oneSec * 0.75))@(h * 0.75));
        Pen.lineTo((x + (oneSec * 0.75))@h);

    };
    Pen.moveTo(w@0);
    Pen.lineTo(w@h);
    Pen.stroke;
};

canvas.layout_(
    VLayout(
        time,
        tempo[0],
        tempo[1],
        tempo[2],
        View().maxHeight_(4).background_(Color.black),
        track[0],
        track[1],
        track[2],
    )
);

scroll.canvas = canvas;
//scroll.front;


~addBar = { |tempoIndex, bpm, beats|
    var color = Color.rand;
    var bar = UserView( tempo[tempoIndex] ).drawFunc_({
        beats.do{ |i|
            var width = 60/bpm * (time.bounds.width / 240) * beats;
            var height = tempo[tempoIndex].bounds.height;

            //Pen.color = Color(0.2,0.3,0.4, 1 - (i/beats) );
            Pen.color = color;
            Pen.fillRect(Rect(0,0,width,height));
        };

        Pen.stringAtPoint(bpm.asString,2@0,Font.monospace(10),Color.white);
    });
};

Window("YAWN").layout_( VLayout( HLayout( *{Button()}!4), scroll).margins_(0).spacing_(4) ).front;


)

.asPattern
~addBar.(0,60,1)

"%%:%%".format()

Integer

PV_MagDiv
"14".padLeft(2,"0")

59 % 60
digits

120.asDigits(60)
100.asStringToBase(37,4)
150.asStringToBase(3,5);

b = 2.collect{ |i| 119 % 60 }





(
/////////////////////////////////////////////////////////////////
// DESCRIBE THE MODEL
~controls = (
	amp: 0.8,
	cutoff: 700,
	res: 0.7
);



/////////////////////////////////////////////////////////////////
// DESCRIBE THE UI
// Note that we're not connecting to anything, only creating our controls and layout.
~views = ();
~views.use {
	~parent = View().layout_(
		VLayout(
			~ampView =     NumberBox().scroll_step_(0.05).clipLo_(0).clipHi_(1).fixedWidth_(80),
			~cutoffView =  NumberBox().scroll_step_(50).clipLo_(80).clipHi_(10000).fixedWidth_(80),
			~resView =     NumberBox().scroll_step_(0.1).clipLo_(0.1).clipHi_(1.0).fixedWidth_(80),
		)
	).front;
};


/////////////////////////////////////////////////////////////////
// MAKE A SYNTH
~synth = {
	var freq, trig, sig;
	
	trig = Impulse.ar(8);
	
	freq = Demand.ar( trig, 0, 32 + Dseq([0, 2, 3, 6, 5, 7, 3], inf) + Drand([0, 0, 0, 0, 12], inf));
	
	sig = LFSaw.ar(freq * [0, 0.01, -0.0342, 0.042].midiratio).sum.clip2(1);
	sig = BLowPass.ar( sig, \cutoff.ar(100), \res.ar(1.0),);
	
	sig = ( \amp.ar(1.0) * sig * Env.perc(0.01, TExpRand.ar(0.1, 0.8, trig)).ar(gate:trig));
}.play(args: ~controls.asPairs);


/////////////////////////////////////////////////////////////////
// CONNECT THE UI
~updateViews = {
	~views[\ampView].value      = ~controls[\amp];
	~views[\cutoffView].value   = ~controls[\cutoff];
	~views[\resView].value      = ~controls[\res];
};

~updateControls = {
	~controls[\amp] 			= ~views[\ampView].value;
	~controls[\cutoff] 			= ~views[\cutoffView].value;
	~controls[\res] 			= ~views[\resView].value;

	~controls.changed(\value);
};

~updateSynth = {
	~synth.set(*~controls.asPairs);
};

~controls.addDependant(~updateViews);
~controls.addDependant(~updateSynth);

~views[\parent].onClose({ ~views[\parent].removeDependant(~controls) });
~views[\ampView].action = ~updateControls;
~views[\cutoffView].action = ~updateControls;
~views[\resView].action = ~updateControls;

// Now that everything is connected, fire this to update.
~controls.changed(\value);
)


e = ()
e.addDependant({|...args| args.postln})
e.addDependant({|...args| [args,10].postln})
e.dependants

e.changed(\value,4, "test")
Object.dependantsDictionary.keys.dopostln
Object.dependantsDictionary[e]
update

// PV_freeze with some sort of accumulator? so like, a freezedFrame gets multiplied by a previous freezedFrame, like an FFT integrator...

rigid wood table degree cinnamon away law treat cram labor strike duck

74 * 80

4.rate > 'scalar'

