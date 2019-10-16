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
