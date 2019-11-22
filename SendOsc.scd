s.boot
n = NetAddr("127.0.0.1", 8000);

n.sendMsg("/grainSize", 0.013575); // precision
n.sendMsg("/grainDensity", 0.0); // precision


(
n.sendMsg("/grainSize", exprand(0.01, 1.0));
n.sendMsg("/grainTime", exprand(0.01, 1.0));
n.sendMsg("/grainDensity", rrand(0.5, 1.0));
n.sendMsg("/grainFeedback", 1-exprand(0.1, 1.0));
n.sendMsg("/grainOctave", [0.0,0.1,0.2,0.3,0.4,0.7,0.8,0.9,1.0].choose);
n.sendMsg("/filterFreq", [0.0,1.0,1.0].choose);
)

(
t = Task({ { h.sendMsg("/grainSize", exprand(0.01, 1.0)); 0.05.wait;}.loop });
u = Task({ { h.sendMsg("/grainTime", 1-exprand(0.01, 1.0)); 0.059.wait;}.loop });
v = Task({ { h.sendMsg("/grainDensity", rrand(0.5, 1.0)); 0.058.wait;}.loop });
x = Task({ { h.sendMsg("/grainOctave", [0.0,0.1,0.2,0.3,0.4,0.7,0.8,0.9,1.0].choose); 0.057.wait;}.loop });
y = Task({ { h.sendMsg("/grainFeedback", 1-exprand(0.1, 1.0)); 0.051.wait;}.loop });
z = Task({ { h.sendMsg("/filterFreq", [0.0,1.0,1.0].choose); 0.0591.wait;}.loop });
)

(
t.start;
u.start;
v.start;
x.start;
y.start;
z.start;
)

(
t.stop;
u.stop;
v.stop;
x.stop;
y.stop;
z.stop;
)

