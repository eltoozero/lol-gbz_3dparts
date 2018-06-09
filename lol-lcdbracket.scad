// Inspiration HoolyHoo Bracket

// Notes


$fn=64;

// LCD Dimensions
// H
// W
// D

// DMG Case Internal Dimensions

// Mounting Post Dimensions

// Mounting Post Offsets

// Rib Cutout Offset




// DMG Button Dimensions
// H
ButtonHeight=6;
// R
ButtonRad=4;

// DMG Button Flag
// H
FlagH=2;
// W
FlagW=1.5;
// D
FlagD=2.5;

//Reference Part
//import("HoolyHoo-SNES-SAIO.stl");

dmgbutton();

//Button
module dmgbutton() {
    cylinder(h=ButtonHeight, r=ButtonRad); 
    translate([-ButtonRad,0,FlagH/2])
        cube([FlagD,FlagW,FlagH], center=true);
        translate([ButtonRad,0,FlagH/2])
        cube([FlagD,FlagW,FlagH], center=true);
}