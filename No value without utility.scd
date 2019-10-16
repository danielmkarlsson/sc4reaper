(
// 1: Press Cmd and hold it down and then press A to select all text.
// 2: Press Shift and hold it down and then press Enter to run everything. If you change something then do this again to update.
// No sound? Weird error messages? Scroll down to the bottom and we'll see about getting that sorted out.
s.waitForBoot { // This boots the server for you. Yup, it's swank. Cmd + B boots the server otherwise.
	(
		SynthDef.new(\DFM1ping, { // This synth definition has a bunch of stuff in it that makes this thing sound the way it does. It's The Synthesizer.
			arg freq = 440, atk = 0.005, rel = 0.3, amp = 1, pan = 0, resonance = 0, hold = 6.0, transitionTime = 0.875,
			disintegratorProbability = 0, disintegratorMultiplier =0, ringzAmp = 1, pulseAmp = 0; // Arguments. It's a data type. I guess search for: Arguments in programming
			var sig, env, resonanceEnv ; // Variables. Also a datatype. Computer Science is a thing but nevermind for now ok? Just be aware of Variables existing in the world.
			freq = freq.clip(20, 20000); // .clip because better safe than sorry. SC can get dangerously superLoud otherwise. For realsReals ok.
			env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, hold, rel], \sine)) ; // An envelope for some stuff. Mostly amplitude. It goes up, then holds there, then goes down again.
			resonanceEnv = EnvGen.ar(Env.new([resonance, resonance, resonance, 0.9], [atk, hold, rel], curve: \sine)) ; // An envelope for the resonance.
			sig = DFM1.ar(BrownNoise.ar(1)*Decay.ar(Impulse.ar(0.01),0.1),freq,resonanceEnv) ; // This filter is a special treat. It has character. Get the SC3 plugins now.
			sig = sig + (Ringz.ar(Dust2.ar(freq.range(0.0,0.0009765625)),freq,atk+hold+rel*6,ringzAmp) * 0.00025) ; // Ringz is a ringing filter.
			sig = sig + (DFM1.ar(VarSaw.ar(freq, width: 3.125e-08),freq*5,0)* pulseAmp) ; // A variable saw with a fancy low pass filter after it.
			sig =  Disintegrator.ar(sig, Line.ar(disintegratorProbability.clip(0.0, 1.0), 0, atk), disintegratorMultiplier.clip(0.0, 1.0), 1) * env ; // This makes clicks n pops.
			sig = sig * AmpCompA.kr(freq,17.323914436055); // AmpComp does a kind of compensation that follows your hearing. I found it very useful.
			sig = Pan2.ar(sig, Line.ar(0, pan, transitionTime), amp) ; // Panning.
			sig = (sig * 130) ; // Turn it up a notch ok 'cause otherwise it won't be loud enough.
			sig = LeakDC.ar(sig) ; // This protects against DC offset.
			sig = HPF.ar( sig, 20 )  ; // This is a high pass filter.

			DetectSilence.ar(sig.sum, 0.00001, doneAction: 2) ; // This is intended to release synths when they become silent.
			Out.ar(0, Limiter.ar(sig, 0.1)) ; // Limiter. Just in case you know, 'cause you never can be too cautious with explosives and amplitude.

		}).add;
	);

	s.sync; // This makes sure the synth has been created before we start sequencing it. The order is important.

	t = Tuning.just; //  Intonation is cool. You can have other tunings just so you know.

	( // This part below makes all the things that happen in the music happen. It also controls when these things happen. It's The Sequencer.
		Pdef( // All of these blue ones below that start with P are part of Patterns which is one way of making music in SuperCollider.
			\DFM1pat, // The name of the sequencer can be anything. It's just so we can tell 'em apart in case there's more than one.
			Pseed(2061, Pbind( // Change this number for another permutation of infinite duration that will be the same every time you run it.
				\instrument, \DFM1ping, // The name of the SynthDef (instrument) that will be sequenced.
				\dur, Pexprand(0.01024, 10.0, inf), // The possible total durations. Double click Pexprand, then press Cmd + D. This tells you what stuff is. The help is what it is.
				\transitionTime, Pwhite([8.0,16.0], inf), // This is a time that gets used sometimes in the SynthDef for the time it takes for change to happen in certain parameters.
				\scale, Pstutter(Pwhite(75, 100, inf) , // Sequencing scales. Pseq wrapped in a Pwhite wrapped in a Pstutter. Patterns in patterns in patterns.
					Pseq([
						Scale.harmonicMinor(t),
						Scale.aeolian(t),
						Scale.harmonicMinor(t),
						Scale.harmonicMajor(t)
				],inf)),
				\root, Pwrand([1, 6],[1.0, 0.0625], inf), // Every parameter can have it's own flavour of control. Mix and match features of these Pattern objects to do your thing.
				\octave, Pwrand([1,2,3,4,5,6,7],[0.015625,0.0625,0.125,0.25,1,0.25,0.125].normalizeSum, inf), //  The green ones with \ before them are keys. There are many.
				\degree, Pshufn([0,1,2,3,4,6,7,8,10], inf), // Pshufn works the way I thought that Pshuf would work. Scroll down to bottom for more info. Totally worth installing.
				\atk, Pwhite(0.4, 10.0, inf), // The possible durations of the Attack part of the amplitude envelope.
				\hold, Pwhite(0.5, 6.0, inf), // This is where the Sustain or Hold part of the envelope gets made.
				\rel, Pwhite(4, 10.0, inf), // The release of the envelope goes here.
				\ringzAmp, ((Pkey(\octave)) * Pwhite(0.0, 0.75,inf)), // Ringz likeliness of higher amplitude increases with rising octaves.
				\resonance, Pwhite(0.9988051, 0.999999,inf),// The Q or the resonance of the DFM1 filter.
				\pulseAmp, Pfunc {|event| // A Function within Patterns. This is to control the amplitude and rare occourance of a Pulse (square wave).
					// If octave drops below 6 return 0 probability, else choose a random value.
					(event.octave > 2).if(0, rrand(0.000244140625, 0.00099)); // if, else right? Computer Science stuff. Very handy. Look into it. Anything can go in a function.
				},
				\disintegratorProbability, Pfunc {|event|
					// If octave drops below 6 return 0 probability, else choose a random value.
					(event.octave < 6).if(0, rrand(0.0, [0.003907125, 0.0019535625, 0.00097678125].choose));
				},
				\disintegratorMultiplier, Pfunc {|event|
					// If octave drops below 6 return 0 probability, else choose a random value.
					(event.octave < 6).if(0, rrand(0.0, [0.003907125, 0.0019535625, 0.00097678125].choose));
				},
				\pan, Prand([ Pwhite(-1.0, -0.25, 1), Pwhite(0.25, 1.0, 1) ], inf); // Panning gets its values made in this line.
			);
		)).play;
	);
}
)

/*
The code above contains two things that are not part of the vanilla standard issue of SuperCollider.

• DFM1
• Pshufn

They are both plugins. DFM1 is a filter which has a special character. It is said to have an analog feel but who are we kidding here this is a computer right? No but seriously
though it sounds SuperAmazeBalls great. Especially at very high resonances which is happening a lot up there in the code. DFM1 is in the top part. In The Synthesizer.
The other thing which is special is Pshufn. It takes a list of things and shuffles them. It makes sure all items in the list get chosen once each and then shuffles the list and
starts over. It's similar to Pshuf which is part of vanilla standard issue of SuperCollider. Pshufn works the way that I thought that Pshuf would work but totally doesn't.
Think of this as an opportunity to learn how to install plugins that SuperCollider can make use of. I would argue that this significantly increases SuperCollider's capabilities
both in terms of sounds you can make with it and also the control that you can have over those sounds. You are now on board with this so let's get to it.

The Internet keeps changing so no links. Instead there are search terms for you to put into whatever does Search the best in the future where you are:

SC3plugins Supercollider

Make sure you download the version of the SC3plugins that matches your version of SuperCollider.
When you have that downloaded and unzipped open a program on your mac called:

Terminal

Either use Spotlight or click through in Finder following this path:

Finder > Applications > Utilities > Terminal

You are now filled with dread. Please stay with me. Instructions will be simple and clear. I promise.
In Terminal, paste the following:

defaults write com.apple.finder AppleShowAllFiles YES.

Then press return.
Press and hold down the Alt key, then right click on the Finder icon in the dock and click Relaunch.
Now open a new Finder window and you should be able to see the hidden folder we are looking for.

YourUserNameGoesHere/Library/Application Support/SuperCollider

Great. You are now in the right folder. Now look for a folder called Extensions. If there is no folder called Extensions you make a new folder called Extensions.
Put the whole SC3plugins folder in the Extensions folder. It should look like this when you are done:

YourUserNameGoesHere/Library/Application Support/SuperCollider/Extensions/SC3plugins

Awesome. There are a bunch of other plugins in that folder. Many are real handy I bet.
Now go back to you browser and search for:

miSCellaneous Daniel Mayer

Again, make sure you download the version of the miSCellaneous Program library that matches your version of SuperCollider.
You know where this folder goes after you've unzipped it right?

YourUserNameGoesHere/Library/Application Support/SuperCollider/Extensions/

So just plop it in there. When you are finished it should look like this:

YourUserNameGoesHere/Library/Application Support/SuperCollider/Extensions/miSCellaneous

Cool. Just one more thing to do and then we are all done.
Open SuperCollider.
Click on Language up there a little to the right.
Click on Recompile Class Library.
There is also a nifty shortcommand if you like those:

Shift+Cmd+L

That should be it. Good to go. Run the code.

*/