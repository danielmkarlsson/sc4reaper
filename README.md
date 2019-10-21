# SC4Reaper

Reaper / SuperCollider course for SoundDesign students at Stockholm University of The Arts

This configuration guide presumes that your operating system is Mac OS X Sierra, High Sierra or thereabouts, and that you know the password to the user you are logged in as. Also the course in general presumes that you have never opened neither SuperCollider nor Reaper. The aim of this configuration guide in particular and this course in general is to make you more free in the ways that you can use Reaper which for all intents and purposes is a highly capable DAW, but still, just a DAW. As such it is inherently linear in it's very nature. SuperCollider will allow us to add dainty bells and gleeful bells to the way we work with Reaper.

This is our DAW, it is where we record sound and generally do our work of organizing sound:  
https://Reaper.fm 

This let's us do **_anything and everything that we could ever dream of_**, by writing code. It contains a state of the art synthesis engine which is renowned for it's efficiency and cleanliness. It also contains quite an elegant programming language that has been specifically tailored to our needs, being folks who want to organize sound:  
https://supercollider.github.io 

Running this command in Terminal.app let's us install all kinds of cool apps and things from anywhere we prefer:  
`sudo spctl --master-disable`

This let's us route audio between programs:  
https://github.com/mattingalls/Soundflower 

It is my strongly expressed recomendation that you _never, ever, ever_ listen to the sound output of SuperCollider without first having routed it into Reaper using SoundFlower. Three reasons: The first of which is **safety**. SuperCollider is special in the way that it will let you make yourself deaf if you ask it to make you deaf. Contrastingly Reaper is special in the opposite way. It will never let even a single sample passthrough it that could make you deaf. Reaper will automatically mute it's output before we get into any real trouble. The second reason is **diagnostics**. It is really easy to keep track of what is going on with the input in Reaper. The metering is a lot better than SuperCollider out of the box. The third reason is **organization**. Having access to Reaper's capacitites as a DAW makes making arrangements a lot easier. The task of organising when things should happen is greatly enhanced when we are just getting started using SuperCollider if we have access to Reaper as well. Entirely unique ways of organizing sound within time are possible in SuperCollider, but it is my experience that those ways of organizing sound are a way's way yonder onward on a timeline ahead of us.  

If you have used SoundFlower in the past with a gui then I shoud tell you that this is not that. This is a kernel extension. Long story short: It not only works, it is very trustworthy now.

Every time we feel that we need to start from the beginning learning how to do things in SuperCollider we begin here:  
https://www.youtube.com/watch?v=yRzsOOiJ_p4&list=PLPYzvS8A_rTaNDweXe6PX4CXSGq4iEWYC

If we want, we can also look at the code from the above Fieldsteel videos here:  
https://github.com/elifieldsteel/Supercollider3_tutorials_code/tree/master/full%20video%20scripts

If we find ourselves just wanting to look up a particular thing, the docs are online here:  
https://github.com/elifieldsteel/Supercollider3_tutorials_code/tree/master/full%20video%20scripts

One awesome place has all the best resources and tutorials when we want to dig deeper:  
https://github.com/madskjeldgaard/awesome-supercollider

How to change the default synth in SuperCollider:  
https://www.madskjeldgaard.dk/how-to-change-the-default-synth-in-supercollider/

The modern way to ask ~~strangers~~ other users how to do things in SuperCollider is here:  
https://scsynth.org/

Amazing online gallery of fragments made with SuperCollider:  
https://synthdef.art/function-play/

Two drones of infinite duration:  
http://danielmkarlsson.github.io/

How to git:  
https://c0dereview.github.io/tutorial/2018/01/09/git-part-1/

An FM synth that can be computer controlled:  
http://asb2m10.github.io/dexed/

A safer Benjolin:  
https://gist.github.com/madskjeldgaard/67d286651b574565dedb8bd50b4c25f6

sInstruments:  
https://github.com/redFrik/sInstruments 

Get Git:  
https://git-scm.com/

SoundHack (++bubbler) have modern versions of their freeware plugins here:  
https://www.soundhack.com/freeware/

DtBlkFx are free but sadly going out of style (32 bit plugin):  
https://rekkerd.org/dtblkfx/

DestroyFX are another favourite from the wild, wild west of the naughties:  
http://destroyfx.smartelectronix.com/

Melda plugins are for reals free:  
https://www.meldaproduction.com/MFreeFXBundle

If you give an email, _any email_, to Izotope, they'll give you their Imager:  
https://www.izotope.com/en/products/ozone-imager.html  

I've been doing Ruins in the distance mainly using the tools we've been using in the course. I make a new track every day:   
https://www.danielmkarlsson.com/ruins-in-the-distance/

At the time of writing it is an experimental feature of SuperCollider to run VST plugins _inside_ SuperCollider:  
https://scsynth.org/t/vstplugin-v0-2-test-release/1237

Verdensteatret - HANNAH, a stage performance that utilizes SuperCollider in a multitude of ways:   
https://vimeo.com/243080465

SuperCollider integration for Neovim:  
https://github.com/davidgranstrom/scnvim

EMS is great:   
http://elektronmusikstudion.se/
