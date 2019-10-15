~netAddr = NetAddr("127.0.0.1", 8000);

(
    var calcRatio = {arg ratio=1;
        var x = 0.008518020;
        var y = 22030;
        var z = 20;
        ((((x * y) + z) * ratio) - z) / y;
    };

    Pdef(\oscSend, Pbind(
        \type, \rest,
        \ratios, Pseq([
            [1/1, 6/5, 3/2, 9/5],
            [1/1, 4/3, 3/2, 5/3],
            [1/1, 6/5, 8/5, 9/5],
            [1/1, 5/4, 3/2, 2/1],
        ], inf),
        \send, Pfunc {|event|
            event.ratios.do {|ratio, i|
                var value = calcRatio.(ratio);
                var addr = "/fl%/frq".format(i+1);
                ~netAddr.sendMsg(addr, value);
            };
        },
        \dur, 8,
    )).play;
)

~netAddr.disconnect;