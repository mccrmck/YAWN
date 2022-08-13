
(
~riffs = PathName("/Users/mikemccormick/Dropbox/Mac/Downloads/bounceShort/").entries.collect({ |entry|
	Buffer.read(s,entry.fullPath)
})
)

(
Routine({

	inf.do{
		var bufnum = ~riffs.choose;
		var bufDur = bufnum.duration;
		{
			var sig = PlayBuf.ar(2,bufnum,BufRateScale.kr(bufnum));
			sig = sig * Env([0,1,1,0],[0.02,bufDur-0.04,0.02]).kr(2);
			sig
		}.play;
		bufDur.postln;
		bufDur.wait;
	}
}).play
)


Click(120,repeats: inf).play


// double helix clicks
b = ClickConCat(2,ClickEnv([145,100],4,2),ClickEnv([100,75],4,2),ClickEnv([75,120],4,2),ClickEnv([120,145],4,2))
c = ClickConCat(2,ClickEnv([75,120],4,2),ClickEnv([120,145],4,2),ClickEnv([145,100],4,2),ClickEnv([100,75],4,2))
d = Click(60/0.570625,4,2,8)
b.duration
c.duration
d.duration

c.play


//
