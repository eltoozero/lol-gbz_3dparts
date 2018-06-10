// Inspiration HoolyHoo Bracket

// Notes


$fn=64;

// LCD Dimensions
// H
LCDH=64;
// W
LCDW=80;
// D
LCDD=3;


// LCD Bracket Outer Dimensions
// H
LCDOuterH=70;
// W
LCDOuterW=83;
// D
LCDOuterD=5;

// DMG Case Internal Dimensions

// Mounting Post Dimensions
// H
PostH=10;
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
RibCutD=LCDOuterD;

// Ribbon Cutout Offsets
//Width
RibbonCutW=42;
//Height
RibbonCutH=1;
//Inset X
RibbonCutIX=LCDOuterW/2-(RibbonCutW/2);
//Inset Y
RibbonCutIY=LCDOuterH-RibbonCutH-2;

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

// Relief Cut


//Reference Part
//translate([0,-9.2,-10])
//import("HoolyHoo-SNES-SAIO.stl");

//dmgbutton(-15,-15);
//mountingpost(-5,-5);

//lower left
//translate([4.5,5,0])
//cylinder(d=1,h=20);
//
////lower right
//translate([78.5,5,0])
//cylinder(d=1,h=20);
//
////upper left
//translate([4.5,55,0])
//cylinder(d=1,h=20);
//
////upper right
//translate([78.5,55,0])
//cylinder(d=1,h=20);


module reliefcut2() {
    module shape() {
        union(){
        translate([(LCDOuterW)/2,LCDOuterH/2-5,0])
            square([LCDOuterW-20,LCDOuterH-30], center=true);
        translate([LCDOuterW/2,LCDOuterH-11,0])
            square([42,20], center=true);
        }
    }
translate([0,0,LCDD])
    linear_extrude(height=LCDOuterD) {
    offset(3) offset(-3) offset(-3) offset(3) shape();
    }
}
//reliefcut();
module reliefcut() {
translate([(LCDOuterW/2)-18,(LCDOuterH/2)-20,LCDD])
hull() {
    for(x=[0:36:36]){
        for(y=[0:60:60]){
            translate([x,y,0])
            cylinder(d=6,h=20);
        }
    }
    }
}


difference() {
    //LCD Mount
    union() {
        cube([LCDOuterW,LCDOuterH,LCDOuterD]);
        mountingposts();
    }
    //Rib Cutout
    translate([LCDOuterW-RibCutI-RibCutW,LCDOuterH-RibCutH,0])
    cube([RibCutW, RibCutH, RibCutD]);
    //Ribbon Cutout
    translate([RibbonCutIX, RibbonCutIY, 0])
    cube([RibbonCutW, RibbonCutH, RibbonCutD]);
    //LCD Cutout
    translate([(LCDOuterW-LCDW)/2, (LCDOuterH-LCDH)/2, 0])
    cube([LCDW, LCDH, LCDD]);
    //Releif Cutout
    reliefcut2();
}


//Mounting Posts
module mountingposts() {
    for(x=[4.5:78.5-4.5:78.5]){
        for(y=[5:55-5:55]){
            mountingpost(x,y);
        }
    }
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