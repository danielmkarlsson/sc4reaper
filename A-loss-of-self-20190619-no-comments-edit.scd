(
s.waitForBoot {
(
SynthDef.new(\sine, {
	arg freq = 440, atk = 0.005, rel = 0.3, amp = 1, pan = 0, gain = 1, modIndex = 2, phaseModIndex = 2,
	lpfFreq =18000, resonance = 0, hold = 6.0, freqDeviation = 0.975, transitionTime = 0.875, resonzQ = 0.1;
	var sig, mod, phasemod, env;
	freq = freq.clip(20, 20000);
	mod = SinOsc.ar(freq/2, 0, Line.ar(0, modIndex, transitionTime) * freq);
	phasemod = SinOsc.ar(freq, 0, phaseModIndex);
	sig = SinOsc.ar(XLine.ar(freqDeviation, freq, atk) + mod, phasemod);
	env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, hold, rel], \sine));
	sig = Pan2.ar(sig, Line.ar(0,pan, transitionTime), amp);
	sig = (sig * 0.8) + (Pluck.ar(sig, PinkNoise.ar(), 0.25, freq.reciprocal, 64.0, 0.5) * 0.4);
	sig = RLPF.ar(sig, lpfFreq.clip(200, 20000), (Line.ar(1.0,resonance, resonance, atk)).clip(0.1, 1.0) ) * env;
	sig = tanh(Line.ar(0.001, gain, transitionTime) * sig);
	sig = (sig * 0.75) + (Resonz.ar(sig, freq, resonzQ) * 1.125);
	sig = sig * AmpCompA.kr(freq,12.978271799373);
	sig = Compander.ar(sig,sig,0.25, 0.33, 1, 0.002, 0.1);
	sig = LeakDC.ar(sig) ;
	sig = HPF.ar( sig, 32 )  ;

		DetectSilence.ar(sig.sum, 0.000001, doneAction:2);
	Out.ar(0, Limiter.ar(sig,0.1));

}).add;
);

(
Pdef(
	\sinepat,
	Pseed(2160,Pbind(
		\instrument, \sine,
		\dur, Pwhite(0.1, 10.0, inf),
        \gain, Pexprand(0.001, 1.5),
		\transitionTime, Prand([0.875,2.0], inf),
		\modIndex, Pwhite(0.00001, 3.0,inf),
		\phaseModIndex, Pwhite(0.00001, 0.1, inf),
		\midinote,Pstutter(Pwhite(2,7)*2,
			    Prand([
                    Pseq([44, 20, 21, 27]),
                    Pseq([32, 20, 39, 40]),
                    Pseq([20, 44, 45, 20, 51]),
                    Pseq([44, 56, 20, 51, 52]),
                    Pseq([32, 44, 51, 20, 28]),
                ], inf)
        ),
		\harmonic, Pexprand(1, 9, inf).round,
		\freqDeviation, Pkey(\harmonic) * (Pkey(\midinote) + Pwhite(-0.25, 0.0, inf)).midicps,
		\atk, Pwhite(15.0, 45.0, inf),
		\hold, Pwhite(4.0, 14.0, inf),
		\rel, Pwhite(30.0, 60.0, inf),
		\amp, Pkey(\harmonic).reciprocal * 0.75,
		\lpfFreq, ((Pkey(\midinote).midicps * Pkey(\harmonic)) * Pwhite(3.0, 9.0,inf)),
		\resonzQ, Pwhite(0.001, 1.0, inf),
		\resonance, Pwhite(0.6, 0.05,inf),
		\pan, Prand([ Pwhite(-1.0, -0.5, 1), Pwhite(0.5, 1.0, 1) ], inf);
	);
)).play;
) ;
}
)
