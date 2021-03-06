(
"killall scsynth".unixCmd;
s.options.numBuffers = 1024 * 64; // increase if you need to load more samples
s.options.memSize = 8192 * 256; // increase if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32; // increase if drop outs and the message "too many nodes"
s.options.sampleRate= 44100;
s.options.numOutputBusChannels = 8; // OUTPUT CHANNELS GO HERE
s.recSampleFormat = "int24";
s.recHeaderFormat="wav";
s.options.numInputBusChannels = 8; // set to hardware input channel size, if necessary
s.latency = 0.1;
MIDIClient.init;
m = MIDIOut.new(0); // Maybe yours is different?
m.latency = 0; // Faster is better so fastest is bestest right?

// scnvim
if (\SCNvim.asClass.notNil) {
    Server.default.doWhenBooted {
        \SCNvim.asClass.updateStatusLine(1, 9670);
    }
};

// A simple triangle wave synth in stereo with panning and a simple low pass filter
s.doWhenBooted{
SynthDef.new(\default, {
arg dur, attack=0.01, release=1.0,
t_gate=1, out, freq=442, cutoff=5500,
rq=1, pan=0.0, amp=0.5;

var env = EnvGen.kr(Env.perc(attack, release), t_gate, timeScale: dur, doneAction: 2);
var sig = DPW3Tri.ar(freq: freq, mul: env);
sig = RLPF.ar(sig, cutoff.clip(20.0, 20000.0), rq.clip(0.0,1.0));
sig = Pan2.ar(sig, pan);
Out.ar(out, sig * amp);
}).add;
};
)