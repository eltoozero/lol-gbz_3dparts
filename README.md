# Gameboy Zero SCAD 3D prints

This is the SCAD source code for my components for the GBZ project, specifically the Kite's Circuit Sword version.

## Notes on SCAD files
I design stuff in SCAD, so my designs are all naturally "parametric" source code and thus can be iterated and modified using the same CSG logic from which they are produced: numeric translations and rotations, intersections, unions and differences of basic 2d and 3d primitives to produce a final "solid" object STL file which is output to the slicer for production on a 3D printer.

It's not going to help anyone to pull these into normal CAD software and make changes, if you want to "help", learn SCAD and fork the source; witness the [url=https://reprap.org/wiki/Genealogy_/_Archeology_of_the_Greg%27s_Wade%27s_Geared_Extruder]Genealogy of the "Greg's Wade's Geared Extruder"[/url] to see what happens when a quality SCAD design can flourish as source code.

## LCD Bracket
![LCD Bracket Image](/img/lol-lcdbracket.png)
There were some contours that didn't jive with me, and since I'm doing a clear build I desired more control over the final product, this one was pretty easy and only took two prototypes to get a functional part I was satisfied with.
 - Needs the other two buttons added, should be trivial, I only wanted 4 on my build.

## Back Button Bracket
![Back Button Bracket Image](/img/lol-backbuttonboardbracket.png)
I actually emailed Kite for some info on the components the pcb was designed around that wasn't in the wiki, once it was clear it's not really a solved problem how this thing is installed in the case, I got to work. This took maybe a dozen revisions to get right, in the end it functions glue-less using the support bracket that also supports the back board.
 - Needs additional versions for 4-button and tact switch configs, I need reference parts to do this.

## Back Button Support
![Back Button Support Image](/img/lol-bbbbsupport.png)
This one was tricky, and I'm the least satisfied with this design aesthetically, but it prints well and functions for it's purpose, also keeps the entire cartridge slot intact and unmodified.
 - Make it look less crappy.
 - Needs relief for wiring.

## Speaker Cover
![Speaker Cover Image](/img/lol-speakerretainer.png)
Simple, I just didn't like the concept of gluing the speaker, and the tolerances are correct that this just press fits and stays snug once the case is closed.

## Power Board Support
![Power Board Support Image](/img/lol-powerbracket.png)
Different approach than HoolyHoo, single part solution.

## Back Board Support
![Back Board Support Image](/img/lol-backboardbracket.png)
Hadn't seen this one and it's a basic variation of the otherwise much more complicated: Power Board Support.

## Cartridge Plate & Fan Duct
![Fan Duct Image](/img/lol-cartfanductwhole.png)
![Fan Duct Plate Image](/img/lol-cartfanductplate.png)
![Fan Duct Image](/img/lol-cartfanduct.png)
This guy took some thought and effort, and only functions as cleanly as it turned out due to luck, the tolerances are super tight. Kapton or double-sided tape the fan to the support bracket, then use a double stack of 3M VHB to hold the duct in place on the CM3.
 - I'm "exhausted" working on this one.
 - There's probably some optimization potential though.

I'll be selling these parts on eBay and sudomod once I get the extruder upgraded on my "other" 3D printer, these are fine for personal use but please don't sell them unless I'm not, further you are free and encouraged to modify these designs as long as I retain credit and am not artificially restricted from production and sale of designs based on my source code.

