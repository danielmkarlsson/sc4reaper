(
MIDIClient.init;
m = MIDIOut(0);
)

(
~maxduration = 8;
~minduration = 1;
~maxpause = 0.25;
~minpause = 0.125;
Routine {
	var dur, hold, p, dt, n;
	loop {
		dur = rrand(~minduration,~maxduration);
		hold = rrand(~minpause,~maxpause);
		p = Env.sine(dur,127);
		dt = 0.05; //here be dragons
		n = dur/dt;
		m.control(0,1,([0,15,30,45,60,80,100,115,127].choose).asStream.next); // octave
		m.control(0,2,rrand(1, 127).asStream.next); // grain size
		m.control(0,3,exprand(1, 127).asStream.next); // time
		n.do {|i|
			m.control(0,0,p.at(i/n * dur));

			dt.wait;
		};
		hold.wait;
	}

}.play
)