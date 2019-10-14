(
MIDIClient.init;
m = MIDIOut(0);
)

(
~maxduration = 6;
~minduration = 2;
~maxpause = 0.5;
~minpause = 0.125;
Routine {
	var dur, hold, p, dt, n;
	loop {
		dur = rrand(~minduration,~maxduration);
		hold = rrand(~minpause,~maxpause);
		p = Env.sine(dur,127);
		dt = 0.05; //here be dragons
		n = dur/dt;
		m.control(0,1,rrand(0, 127).asStream.next);
		m.control(0,2,rrand(0, 127).asStream.next);
		m.control(0,3,rrand(0, 127).asStream.next);
		n.do {|i|
			m.control(0,0,p.at(i/n * dur));

			dt.wait;
		};
		hold.wait;
	}

}.play
)