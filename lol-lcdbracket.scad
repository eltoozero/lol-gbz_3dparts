// Inspiration HoolyHoo Bracket

// Notes


$fn=64;

// LCD Dimensions
// H
LCDH=64;
// W
LCDW=80;
// D
LCDD=4;


// LCD Bracket Outer Dimensions
// H
LCDOuterH=70;
// W
LCDOuterW=83;
// D
LCDOuterD=4.5;

// DMG Case Internal Dimensions

// M2 Bolt Dimensions
// Thickness
BoltT=1.6;
// Diameter
BoltD=4.35;

// Mounting Post Dimensions
// H
PostH=5;
// Base Diameter
PostD1=8;
// Top Diameter
PostD2=5;
// Hole Diameter
PostHoleD=1.5;

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
ButtonR=5.8;

// DMG Button Flag
// H
FlagH=ButtonH;
// W
FlagW=2.7;
// D
FlagD=5.5;

// Button Extension
// H
ExtH=14;
// W
ExtW=30;
// D
ExtD=3;
// Lip
ExtLip=10;

//Reference Part
//translate([70,0,0])
//translate([0,-9.2,0])
//color("green") import("HoolyHoo-SNES-SAIO.stl");

//color("red") dmgbutton(15,-7);
//color("red") dmgbutton(30,-14);

//mountingpost(-5,-5);
main_bracket();


// Mounting Post Offsets
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

//linear_extrude(height=LCDOuterD) offset(3) offset(-3) square([LCDOuterW,LCDOuterH]);


module reliefcut2() {
    module shape() {
        union(){
        translate([(LCDOuterW)/2,LCDOuterH/2-5,0])
            square([LCDOuterW-20,LCDOuterH-30], center=true);
        translate([LCDOuterW/2,LCDOuterH-12,0])
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

module button_bracket() {
//    hull() {
//    for(x=[0:LCDOuterW:LCDOuterW]){
//        for(y=[0:10:10]){
//            translate([x,y,0])
//            cylinder(d=ButtonR,h=ExtD);
//
//        }
//    }
//    }

    difference() {
        union() {
        translate([0,-ExtLip,0])
        linear_extrude(height=ExtD) offset(4) offset(-4) square([LCDOuterW,ExtLip*2]);
        hull() {
        translate([ButtonR,ButtonR,0])
        cylinder(h=ExtD, r=ButtonR);
        
        translate([ButtonR+ExtW,ButtonR,0])
        cylinder(h=ExtD, r=ButtonR);

        translate([ButtonR,ButtonR-ExtH+2.5,0])
        #cylinder(h=ExtD, r=ButtonR);
        
        translate([ButtonR+ExtW,-ExtH-ButtonR,0])
        #cylinder(h=ExtD, r=ButtonR);

        translate([ButtonR+ExtW,-ExtH-ButtonR,0])
        color("orange") 
        cylinder(h=ExtD, r=ButtonR);
        }
    } //end union
    color("red") dmgbutton(15,-7);
    color("red") dmgbutton(30,-14);
    }
}

module main_bracket() {
    difference() {
        //LCD Mount
        union() {
            //cube([LCDOuterW,LCDOuterH,LCDOuterD]);
            linear_extrude(height=LCDOuterD) offset(4) offset(-4) square([LCDOuterW,LCDOuterH]);

            mountingposts();
            button_bracket();
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
        //Relief Cutout
        reliefcut2();
        //Bolt Relief
        boltreliefs();
    }
}

//Mounting Posts
module mountingposts() {
    for(x=[4.5:78.5-4.5:78.5]){
        for(y=[5:55-5:55]){
            mountingpost(x,y);
        }
    }
}

//Mounting Post Bolt Relifs
module boltreliefs() {
    for(x=[4.5:78.5-4.5:78.5]){
        for(y=[5:55-5:55]){
            translate([x,y,LCDD]) {
                cylinder($fn=6,h=BoltT,d=BoltD);
                cylinder(h=PostH, d=PostHoleD);
            }
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
translate([x,y,LCDOuterD])    
    difference() {
        cylinder(h=PostH, d1=PostD1, d2=PostD2);
        cylinder(h=PostH, d=PostHoleD);
    }
}