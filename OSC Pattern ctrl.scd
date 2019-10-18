n = NetAddr("127.0.0.1", 8000); // open coms
n.sendMsg("/grainSize", exprand(0.01, 1.0)); // good for mapping
n.sendMsg("/grainOctave", [0.0,0.1,0.2,0.3,0.4,0.7,0.8,0.9,1.0].choose);
n.sendMsg("/grainTime", exprand(0.01, 1.0));


(
Pdef(\oscSend1, Pbind(
	\type, \rest,
	\value, Pexprand(0.05, 0.5, inf),
	\send, Pfunc { |e| n.sendMsg("/grainSize" , e[\value] ) },
	\dur, 0.5,
)).play(quant: 1);

Pdef(\oscSend2, Pbind(
	\type, \rest,
	\value, Pxshuf([0.0,0.1,0.2,0.3,0.4,0.7,0.8,0.9,1.0], inf),
	\send, Pfunc { |e| n.sendMsg("/grainOctave" , e[\value] ) },
	\dur, 0.25,
)).play(quant: 1);

Pdef(\oscSend3, Pbind(
	\type, \rest,
	\value, Pexprand(0.01, 0.25, inf),
	\send, Pfunc { |e| n.sendMsg("/grainTime" , e[\value] ) },
	\dur, 1,
)).play(quant: 1);
)

~netAddr.disconnect; // close coms
