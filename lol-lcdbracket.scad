// Inspiration HoolyHoo Bracket

// Notes


$fn=64;

// LCD Bracket Outer Dimensions
// H
LCDH=70;
// W
LCDW=83;
// D
LCDD=5;

// DMG Case Internal Dimensions

// Mounting Post Dimensions
// H
PostH=9;
// Base Diameter
PostD1=7;
// Top Diameter
PostD2=5;
// Hole Diameter
PostHoleD=1.5;

// Mounting Post Offsets

// Rib Cutout Offset
//Inset
RibCutI=4;
//Width
RibCutW=14;
//Height
RibCutH=3;
//Depth
RibCutD=LCDD;

// Ribbon Cutout Offsets
//Inset
RibbonCutI=4;
//Width
RibbonCutW=14;
//Height
RibbonCutH=3;
//Depth
RibbonCutD=LCDD;



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
translate([0,-9,-5])
import("HoolyHoo-SNES-SAIO.stl");

dmgbutton(-15,-15);
mountingpost(-5,-5);

difference() {
    //LCD Mount
    cube([LCDW,LCDH,LCDD]);
    //Rib Cutout
    translate([LCDW-RibCutI-RibCutW,LCDH-RibCutH,0])
    cube([RibCutW, RibCutH, RibCutD]);
}

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