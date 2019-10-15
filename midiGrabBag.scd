/*
===========================================================================
Working with MIDI
===========================================================================

It is possible to work with MIDI input and output in SuperCollider.

MIDIIn is used for MIDI input (from controllers, keyboards etc.)
MIDIOut is used for MIDI output (to external synthesizer, DAW:s etc.)
*/



// MIDI Input
// ----------

// 1. Initialize MIDI in sc
MIDIClient.init;

// 2. Connect all MIDI sources
MIDIIn.connectAll;

// 3. Dump all incoming MIDI messages
MIDIFunc.trace(true); // enable dumping
MIDIFunc.trace(false); // disable dumping


// 4. Write a MIDIdef to filter a value from the controller

// Give it a name (in this case 'fader1', you can call it whatever you want)
MIDIdef.cc(\fader1, {|val| val.postln }, 0); // only respond to ccNum 0

// ---- Example ----

// *optional* lower server latency to increase responsivness
s.latency = 0.05;
s.reboot; // need to restart for changes to take effect

(
// Synth to control
x = play {|freq=110, fb=4, cfreq=3000|
    var sig = SinOscFB.ar(freq * [1, 1.01], fb.lag(0.1)); // lag: smooth the incoming values (interpolation)
    sig = RLPF.ar(sig, cfreq.lag(0.1), 0.8);
    Limiter.ar(sig.sanitize) * 0.1;
};

// Control cutoff with fader1
MIDIdef.cc(\fader1, {|val|
    var cfreqVal = val.linexp(0, 127, 55, 10000);
    x.set(\cfreq, cfreqVal);
}, 0); // ccNum to filter

// Control feedback amount with fader2
MIDIdef.cc(\fader2, {|val|
    var fbVal = val.linlin(0, 127, 0.5, 4);
    x.set(\fb, fbVal);
}, 1); // ccNum to filter
)


// MIDI Output
// ----------

// 1. Initialize MIDI in sc
MIDIClient.init;

// 2. Create a new MIDIOut bound to a specific endpoint (the endpoints are listed
// after calling MIDIClient.init)
//
// The IAC Driver bus is part of macOS and can be enabled in the "Audio MIDI Setup.app"
~midiOut = MIDIOut.newByName("IAC Driver", "Bus 1");

// 3. Test by sending a noteOn/noteOff
~midiOut.noteOn(0, 60, 90);
~midiOut.noteOff(0, 60, 90);

// Examples

TempoClock.default.tempo = 60/60;

(
Pbind(
    \type, \midi,
    \midiout, ~midiOut,
    \chan, 0,
    \scale, Scale.minor,
    \mtranspose, Pstep(Pseq([ 0, 2, -1, -2 ], inf), 2, inf),
    \octave, Pstutter(4, Pwhite(4, 7)),
    \degree, Pseq([ 0, 2, 4, 7 ], inf),
    \amp, 0.2,
    \dur, Pseg(Pseq([ 0.05, 0.25 ], inf), Pseq([ 10, 10 ], inf), \sine),
).play(quant: 1);

Pbind(
    \type, \midi,
    \midiout, ~midiOut,
    \midicmd, \control,
    \chan, 0,
    \ctlNum, 14,
    \control, Pexprand(60, 127),
    \dur, 2
).play(quant: 1);

CmdPeriod.doOnce {
    // release any hanging notes
    ~midiOut.allNotesOff(0);
};
)
