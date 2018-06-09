// Inspiration HoolyHoo Bracket

// Notes


$fn=64;

// LCD Dimensions
// H
// W
// D

// DMG Case Internal Dimensions

// Mounting Post Dimensions
// H
PostH=12;
// Base Diameter
PostD1=5;
// Top Diameter
PostD2=4;
// Hole Diameter
PostHoleD=1;

// Mounting Post Offsets

// Rib Cutout Offset




// DMG Button Dimensions
// H
ButtonH=6;
// R
ButtonR=4;

// DMG Button Flag
// H
FlagH=2;
// W
FlagW=1.5;
// D
FlagD=2.5;

//Reference Part
//import("HoolyHoo-SNES-SAIO.stl");

//dmgbutton();
mountingpost(5,5);

//Button
module dmgbutton(x,y) {
translate([x,y,0])    
    union() {
        cylinder(h=ButtonH, r=ButtonR); 
        translate([-ButtonR,0,FlagH/2])
            cube([FlagD,FlagW,FlagH], center=true);
            translate([ButtonR,0,FlagH/2])
            cube([FlagD,FlagW,FlagH], center=true);
    }
}

//Mounting Post
module mountingpost(x,y) {
translate([x,y,0])    
    difference() {
        cylinder(h=PostH, d1=PostD1, d2=PostD2);
        cylinder(h=PostH, d=PostHoleD);
    }
}