// This demonstrates controlling SuperDirt _inside_ SuperCollider.
// You need to have SuperDirt already installed in order for this to work.

SuperDirt.start // Run this line on it's own first to boot SuperDirt,
SuperDirt.default = ~dirt; // Then run this line to get the ~dirt key sequenceable.

// Run the below block to get the sequencer going. 
// It will run in time together with other sequencers because (quant:1).
// Sequencers can be edited and reEvaluated in realtime because Pdef, Pbind killer combo.

(
Pdef(\a,
	Pbind(
		\type, \dirt,
		\s, \bev,
		\dur, Pwrand([1/3,1/5,1/7,1/9,1/11],[1,8,128,64,32].normalizeSum, inf),
		\release, 1/15,
		\cut, 1,
		\begin, Pstutter(128,Pwhite (0.0, 1.0), inf),
		\delay, 1/5,
		\delayfeedback, 0.97,
		\delaytime, 1/127 
        * Pstutter(64,Pwrand([1/2,1,2,4,8,16],[1,2,2,2,3,3].normalizeSum, inf))
        / Pstutter(32,Prand([1,2,2.25,3,3.185,4,4.163,6], inf)),
        \gain, Pstutter(16,Pwrand([1,2,4],[1,8,16].normalizeSum, inf)),
        \pan, Pstutter(8,Pwhite(-0.5,0.5)),
        \speed, 1,
	)
).play(quant:1);
);

(
Pdef(\b,
	Pbind(
		\type, Pwrand([\dirt,\rest],[1,3].normalizeSum, inf),
		\s, \kicklinn,
		\dur, 1/7,
		\cut, Pwrand([1,2],[8,1].normalizeSum,inf),
        \gain, 1.5,
        \hcutoff, 60,
        \release, 0.5,
	)
).play(quant:1);
)

// If you want to stop a sequencer, swap out play for stop and evaluate that block.

// Hows about you add a sequencer that plays a handClap every now and then?
