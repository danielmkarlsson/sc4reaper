s.boot

(
SynthDef.new (\sine, {
	arg freq=440, atk=0.005, rel=0.3, amp=1, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0,1,0], [atk, rel], [1, -1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar (0, sig);
}).add;
)


// might be a little loud so don't have headphones on when you run this code.
(
p = Pbind (
	\instrument, \sine,
	\dur, Pwhite (20, 25, inf),
	\freq, Pexprand (40, 555, inf).trace,
	\atk, Pwhite (20.0, 25.0, inf),
	\rel, Pwhite (20.0, 30.0, inf),
	\amp, Pwhite (2.0, 8, inf),
	\pan, Pwhite (-0.0, 0.0, inf)    // Mono
).play;
)

p.stop;