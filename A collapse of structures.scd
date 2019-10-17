s.boot
s.meter

s.record(numChannels: 8);

(
SynthDef(\phaseMod, {
	|
	sustain, gate=1, pan, amp = 0.1, lforate = 1, lfodepth = 1, sinrate = 1, sindepth = 1, out = 0,
	freq=440,
	fb,
	hr4,hr3,hr2,hr1
	mi4,mi3,mi2,
	e1,e2,e3,e4,
	c1,c2,c3,c4,
	dt
	|
	var env4,env3,env2,env1,sound,modComp;
	env4 = EnvGen.ar(Env.perc(e4,0.05,curve:c4),gate,timeScale:sustain);
	env3 = EnvGen.ar(Env.perc(e3,0.05,curve:c3),gate,timeScale:sustain);
	env2 = EnvGen.ar(Env.perc(e2,0.05,curve:c2),gate,timeScale:sustain);
	env1 = EnvGen.ar(Env.perc(e1,0.05,curve:c1),gate,timeScale:sustain,doneAction:2);
	modComp = freq.explin(20,20000,1,0.01);
	sound = SinOscFB.ar(freq*hr4,fb*modComp,mi4*modComp) * env4;
	sound = SinOsc.ar(freq*hr3,sound+[0,pi/2],mi3*modComp) * env3;
	sound = SinOsc.ar(freq*hr2,sound,mi2*modComp) * env2;
	sound = SinOsc.ar(freq*hr1+[dt.neg,dt],sound) * env1;
	sound = sound * AmpCompA.kr(freq,17.323914436055);
	sound = (sound * amp)*LFNoise1.ar(lforate).range(lfodepth,1);
	//sound =  PanAz.ar(8, sound, 0.4, 1, 2, 0.5);
	//sound = sound*SinOsc.ar(sinrate).range(sindepth,1);
	Out.ar(out, Limiter.ar(sound,1));
}).add;

SynthDef(\sum, {|

	inBus,atk,sus,dcy
	|
	var sound, env;
	env = EnvGen.ar(Env.linen(atk,sus,dcy,curve:'sin'),doneAction:2);
	sound = In.ar(inBus, 8);
	//sound = sound*SinOsc.ar(SinOsc.ar(0.02).range(lfoLo,lfoHi)).range(sindepth,1);
	sound = sound * env;
	Out.ar(0,sound)
}).add;
)

(
t = Tuning.et12;
Routine{
	999.do{
		var atk,sus,dcy,dur;
		atk = rrand(100,200);
		sus = rrand(0,50);
		dcy = rrand(100,200);
		dur = atk+sus+dcy;
		dur.postln ;

x = Synth.tail(s,\sum,[inBus: 50, atk: atk,sus: sus,dcy: dcy]);
		( dur * 1.1).wait
	}
}.play;

Pdef(
	\phaseModpat,
	Pseed(1379, Pbind(
		\instrument, \phaseMod,
		\hr1, Pstutter(19, Pxshuf((1..4),inf)),
		\hr2, Pstutter(29, Pxshuf((1..4),inf)),
		\hr3, Pstutter(8, Pxshuf((1..4),inf)),
		\hr4, Pstutter(17, Pxshuf((1..4),inf)),
		\mi1, Pstutter(6, Pxshuf((1..4),inf)),
		\mi2, Pstutter(15, Pxshuf((1..4),inf)),
		\mi3, Pstutter(4, Pxshuf((1..4),inf)),
		\mi4, Pstutter(13, Pxshuf((1..4),inf)),
		\fb, Pstutter(12, Pexprand(0.00000000001, 0.125)),
		\e1, Pstutter(4, Pexprand(6.8, 7.4)),
		\e2, Pstutter(15, Pexprand(6.8, 7.4)),
		\e3, Pstutter(6, Pexprand(6.8, 7.4)),
		\e4, Pstutter(27, Pexprand(6.8, 7.4)),
		\c1, Pstutter(9, Prand([-1,-2,-3,-4], inf)),
		\c2, Pstutter(11, Prand([-1,-2,-3,-4], inf)),
		\c3, Pstutter(13, Prand([-1,-2,-3,-4], inf)),
		\c4, Pstutter(15, Prand([-1,-2,-3,-4], inf)),
		\sustain, 1,
		\dur, Pexprand(0.0001, 5.0, inf),
		\scale, Pstutter(Pwhite(25, 159, inf),
			Pxshuf([
				Scale.lydianMinor(t),
				Scale.locrian(t),
				Scale.majorPentatonic(t),
				Scale.romanianMinor(t),
				Scale.mixolydian(t),
				Scale.superLocrian(t)
		],inf)),
		\root, Pstutter(125, Pwrand([1, 7],[1, 1/16].normalizeSum, inf)),
		\octave, Pstutter(Pwhite(26, 51, inf), Pwrand([1,2,3,4,5,6],[1/32,1/16,1/4,1/2,1/8,1/64].normalizeSum, inf)),
		\degree, Pstutter(Pwhite(27, 169, inf), Pxshuf([0,1,2,3,4,6,7,8,10], inf)),
		//\pan, Prand([ Pwhite(-1.0, -0.25, 1), Pwhite(0.25, 1.0, 1) ], inf),
		//\pan, Prand([0,2,4,6,8,10,12,14], inf),
		\lforate, 0.3,
		\lfodepth, 0,
		//\out, Pser([0, 2, 4, 6, 8],inf)
		\out, 50 + Pser([
			0, 1, 2, 3, 4, 5, 6, 7, 8
		],inf)
	);
)).play;
);

