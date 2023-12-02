

// Mike's tempo
Click(101.053,4,repeats: 4)


// torfinn tempo
a = [ 0, 0.791, 1.469, 2.069, 2.615, 3.094, 3.543, 3.972, 4.389, 4.821, 5.295, 5.795, 6.341, 6.958, 7.724, 8.655, 9.5 ]
a[4,8..].differentiate

[4,3].integrate

b = ClickConCat(1,
	ClickPTC(a[0..4]),
	ClickPTC(a[4..8]),
	ClickPTC(a[8..12]),
	ClickPTC(a[12..16]),
).play;

// end of B
b = ClickConCat(1,
	ClickPTC(a[0..2]),
	ClickPTC(a[0..3]),
	ClickPTC(a[0..10]),
).duration;

// torfinn
(
var times = a;
var tempi = 60/(a.differentiate[1..]);
tempi = tempi ++ tempi[0];
m = SimpleMIDIFile( "~/Desktop/new.mid" ).init0(tempi[0],"4/4");
m.timeMode = \seconds;  // change from default to something useful

times.do({ |time,i|

	[tempi[i],time].postln;
	m.addTempo(tempi[i],time)
});
m.adjustEndOfTrack;
// m.metaEvents.dopostln;
m.write
)


// oksar tempo
c = [ 0, 0.212, 0.434, 0.668, 0.917, 1.182, 1.469, 1.769, 2.069, 2.372, 2.682, 2.999, 3.325, 3.664, 4.017, 4.389, 4.794, 5.295, 5.795, 6.244, 6.623, 6.958, 7.254, 7.519, 7.759, 7.988, 8.214, 8.436, 8.655, 8.87, 9.083, 9.292, 9.5 ]

// oskar end of B
z = (c[0..6].differentiate[1..] ++ c[0..8].differentiate[1..] ++ c[0..17].differentiate[1..]) / 0.9 / 0.9
c.dopostln
d = ClickConCat(1,
	ClickPTC(c[0..8],2),
	ClickPTC(c[8..16],2),
	ClickPTC(c[16..24],2),
	ClickPTC(c[24..32],2),
).tempoArray;

// end of B
d = ClickConCat(1,
	ClickPTC(c[0..6],2),
	ClickPTC(c[0..8],2),
	ClickPTC(c[0..16],2),
	ClickPTC(c[16..17],1).clickFreq_(750),
).duration;


//oskar
(
var times = z.integrate;
// var tempi = 60/(c.differentiate[1..]);
var tempi = 60/z;
tempi = tempi ++ tempi[0];
m = SimpleMIDIFile( "~/Desktop/oskarBLast.mid" ).init0(tempi[0],"4/4");
m.timeMode = \seconds;  // change from default to something useful

times.do({ |time,i|

	[tempi[i],time].postln;
	m.addTempo(tempi[i],time)
});
m.adjustEndOfTrack;
// m.metaEvents.dopostln;
m.write
)


// harmony part
x = ClickConCat(1,
	ClickConCat(4,
		// 4 rounds of this
		ClickEnv([140,100],4,2),
		ClickEnv([100,80],4,2),
		ClickEnv([80,120],4,2),
		ClickEnv([120,140],4,2)
	),

	ClickEnv([142.5,100],4,2),
	ClickEnv([100,77.5],4,2),
	ClickEnv([77.5,120],4,2),
	ClickEnv([120,145],4,2),

	ClickEnv([145,100],4,2),
	ClickEnv([100,75],4,2),
	ClickEnv([75,120],4,2),
	ClickEnv([120,145],4,2),

).exportMIDItempoMap("~/Desktop/harmon.mid",true)

//


a = [ 0, 0.212, 0.434, 0.668, 0.917, 1.182, 1.469, 1.769, 2.069, 2.372, 2.682, 2.999, 3.325, 3.664, 4.017, 4.389, 4.794, 5.295, 5.795, 6.244, 6.623, 6.958, 7.254, 7.519, 7.759, 7.988, 8.214, 8.436, 8.655, 8.874, 9.095 ]
ClickConCat(1,ClickPTC(a,2)).exportMIDItempoMap("~/Desktop/lastBoskar.mid",true)

b = [ 0, 0.791, 1.469, 2.069, 2.615, 3.094, 3.543, 3.972, 4.389, 4.821, 5.295, 5.795, 6.341, 6.958, 7.724, 8.655, 9.095 ]
ClickConCat(1,ClickPTC(b)).exportMIDItempoMap("~/Desktop/test.mid",true)


// transition before fake ending
z = [ 0, 0.173, 0.358, 0.557, 0.771, 1, 1.24, 1.485, 1.735, 1.992, 2.255, 2.527, 2.82, 3.167, 3.528, 3.943, 4.667 ]
ClickPTC(y).tempoArray
ClickConCat(1,ClickPTC(z)).exportMIDItempoMap("~/Desktop/trans.mid",true)