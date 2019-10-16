(
HID.findAvailable; // find the HIDs
HID.postAvailable; // eval and look here for your HID ID in the post window
~myhid = HID.open( 61440, 3 ); // your numbers will be different
n = NetAddr("127.0.0.1", 8000); // open this port so we can send OSC

(
~buttonAOn=false ;
~buttonA = HIDFunc.element( { |...args|
	if(~buttonAOn == false, {
		//args.postln;
		n.sendMsg("grainSize", exprand(0.1,1.0)); // these things happen when the A button is pressed
		n.sendMsg("grainTime", exprand(0.1,1.0));
		n.sendMsg("grainOctave", rrand(0.0,1.0));
		n.sendMsg("grainReversal", rrand(0.0,1.0));
		n.sendMsg("grainFeedback", 1-exprand(0.01,1.0));
		n.sendMsg("grainDensity", 1-exprand(0.01,1.0));
		~buttonAOn=true
	}, {
		~buttonAOn=false ;
	})  ;
}, 3 )
);

(
// Button B:
~buttonBOn=false ;
~buttonB = HIDFunc.element( { |...args|
	if(~buttonBOn == false, {
		//args.postln;
		n.sendMsg("0FreqA", rrand(0.0,1.0)); // these things happen when the B button is pressed
		n.sendMsg("0FreqB", rrand(0.0,1.0));
		n.sendMsg("0Amp", rrand(0.0,1.0));
		n.sendMsg("0Fx", [0.0,0.05,0.075,0.1,0.15,0.175,0.2,0.225,0.26,0.35,0.38,0.41,0.44,0.48,0.51,0.55,0.59,0.62,0.65,0.69,0.72,0.75,0.78,0.81].choose);
		n.sendMsg("0Value", rrand(0.0,1.0));
		n.sendMsg("1FreqA", rrand(0.0,1.0));
		n.sendMsg("1FreqB", rrand(0.0,1.0));
		n.sendMsg("1Amp", rrand(0.0,1.0));
		n.sendMsg("1Fx", [0.0,0.05,0.075,0.1,0.15,0.175,0.2,0.225,0.26,0.35,0.38,0.41,0.44,0.48,0.51,0.55,0.59,0.62,0.65,0.69,0.72,0.75,0.78,0.81].choose);
		n.sendMsg("1Value", rrand(0.0,1.0));
		n.sendMsg("2FreqA", rrand(0.0,1.0));
		n.sendMsg("2FreqB", rrand(0.0,1.0));
		n.sendMsg("2Amp", rrand(0.0,1.0));
		n.sendMsg("2Fx", [0.0,0.05,0.075,0.1,0.15,0.175,0.2,0.225,0.26,0.35,0.38,0.41,0.44,0.48,0.51,0.55,0.59,0.62,0.65,0.69,0.72,0.75,0.78,0.81].choose);
		n.sendMsg("2Value", rrand(0.0,1.0));
		n.sendMsg("3FreqA", rrand(0.0,1.0));
		n.sendMsg("3FreqB", rrand(0.0,1.0));
		n.sendMsg("3Amp", rrand(0.0,1.0));
		n.sendMsg("3Fx", [0.0,0.05,0.075,0.1,0.15,0.175,0.2,0.225,0.26,0.35,0.38,0.41,0.44,0.48,0.51,0.55,0.59,0.62,0.65,0.69,0.72,0.75,0.78,0.81].choose);
		n.sendMsg("3Value", rrand(0.0,1.0));
        n.sendMsg("4FreqA", rrand(0.0,1.0));
		n.sendMsg("4FreqB", rrand(0.0,1.0));
		n.sendMsg("4Amp", rrand(0.0,1.0));
		n.sendMsg("4Fx", [0.0,0.05,0.075,0.1,0.15,0.175,0.2,0.225,0.26,0.35,0.38,0.41,0.44,0.48,0.51,0.55,0.59,0.62,0.65,0.69,0.72,0.75,0.78,0.81].choose);
		n.sendMsg("4Value", rrand(0.0,1.0));
        n.sendMsg("5FreqA", rrand(0.0,1.0));
		n.sendMsg("5FreqB", rrand(0.0,1.0));
		n.sendMsg("5Amp", rrand(0.0,1.0));
		n.sendMsg("5Fx", [0.0,0.05,0.075,0.1,0.15,0.175,0.2,0.225,0.26,0.35,0.38,0.41,0.44,0.48,0.51,0.55,0.59,0.62,0.65,0.69,0.72,0.75,0.78,0.81].choose);
		n.sendMsg("5Value", rrand(0.0,1.0));
        n.sendMsg("6FreqA", rrand(0.0,1.0));
		n.sendMsg("6FreqB", rrand(0.0,1.0));
		n.sendMsg("6Amp", rrand(0.0,1.0));
		n.sendMsg("6Fx", [0.0,0.05,0.075,0.1,0.15,0.175,0.2,0.225,0.26,0.35,0.38,0.41,0.44,0.48,0.51,0.55,0.59,0.62,0.65,0.69,0.72,0.75,0.78,0.81].choose);
		n.sendMsg("6Value", rrand(0.0,1.0));
        n.sendMsg("7FreqA", rrand(0.0,1.0));
		n.sendMsg("7FreqB", rrand(0.0,1.0));
		n.sendMsg("7Amp", rrand(0.0,1.0));
		n.sendMsg("7Fx", [0.0,0.05,0.075,0.1,0.15,0.175,0.2,0.225,0.26,0.35,0.38,0.41,0.44,0.48,0.51,0.55,0.59,0.62,0.65,0.69,0.72,0.75,0.78,0.81].choose);
		n.sendMsg("7Value", rrand(0.0,1.0));

        ~buttonBOn=true
	}, {
		~buttonBOn=false ;
	});
}, 2 )
);
)

~buttonA.free;
~buttonB.free;
