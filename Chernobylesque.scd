(
play{
	var doAmount, atk, sus, dcy, env, sig, filterFreqs ;
	atk = 20 ;
	sus = 40 ;
	dcy = 20 ;
	doAmount = 3 ;
	env = EnvGen.ar(Env.linen(atk, sus, dcy, curve: 'sin'), doneAction: 2) ;

	sig = WhiteNoise.ar(0.2)*Decay2.ar(Dust.ar(200), 0.0000001, 0.0001) ;

	filterFreqs = Array.fill(doAmount, {exprand(32, 1600)}) ;

	sig = Splay.ar(
		Ringz.ar(
			sig,
			filterFreqs,
			rrand(1, 16))/filterFreqs.size
	) ;

	sig = Limiter.ar(LPF.ar(sig*1.5, 13000)*env)
}
) ;

(
play{
	var doAmount, atk, sus, dcy, env, sig, filterFreqs ;
	atk = 3 ;
	sus = 30 ;
	dcy = 10 ;
	doAmount = 25 ;
	env = EnvGen.ar(Env.linen(atk, sus, dcy, curve: 'sin'), doneAction: 2) ;

	// source1 - dust:
	sig = Pan2.ar(Dust.ar(7), LFNoise1.ar(0.1));

	// source2 - vit brus med kort envelope (0.1):
	//sig = WhiteNoise.ar(0.4)*Decay2.ar(Dust.ar(3), 0.001, 0.1) ;

	// an array with frequencies:
	filterFreqs = Array.fill(doAmount, {rrand(140, 10000)}) ;

	// filterbank:
	sig = Splay.ar(
		Ringz.ar(
			sig,
			filterFreqs,
			// decaytime
			rrand(0.01, 0.1))/filterFreqs.size
	) ;

	sig = Limiter.ar(LPF.ar(sig*1.5, 13000)*env)
}
) ;

(
play{
	var doAmount, atk, sus, dcy, env, sig, filterFreqs ;
	atk = 3 ;
	sus = 30 ;
	dcy = 10 ;
	doAmount = 25 ;
	env = EnvGen.ar(Env.linen(atk, sus, dcy, curve: 'sin'), doneAction: 2) ;

	// source1 - dust:
	//sig = Pan2.ar(Dust.ar(7), LFNoise1.ar(0.1));

	// source2 - white noise w/ short envelope (0.1):
	//sig = WhiteNoise.ar(0.4)*Decay2.ar(Dust.ar(3), 0.001, 0.1) ;

	// source3 - white noise w/ short envelope(0.1), periodic:
	sig = WhiteNoise.ar(0.4)*Decay2.ar(Impulse.ar(rrand(1, 7)), 0.0001, 0.01) ;


	// an array of freqencies:
	filterFreqs = Array.fill(doAmount, {rrand(14, 1000)}) ;

	// filterbank:
	sig = Splay.ar(
		Ringz.ar(
			sig,
			filterFreqs,
			// decaytime is also equal to filterWidth proly. Divides w/ size of array to get amp below 1.
			rrand(0.0001, 0.1))/filterFreqs.size
	) ;

	sig = Limiter.ar(LPF.ar(sig*1.5, rrand(1000, 17000))*env)
}
) ;
