// Inspiration HoolyHoo Bracket

// Notes


$fn=64;

BUTTONS=6;

// LCD Dimensions
// H
LCDH=64;
// W
LCDW=77;
// D
LCDD=4;


// LCD Bracket Outer Dimensions
// H
LCDOuterH=70;
// W
LCDOuterW=82;
// D
LCDOuterD=LCDD+1;

// DMG Case Internal Dimensions

// M2 Bolt Dimensions
// Thickness
BoltT=1.6*2;
// Diameter
BoltD=4.5;

// Mounting Post Dimensions
// H
PostH=6.4;
// Base Diameter
PostD1=8;
// Top Diameter
PostD2=6.6;
// Hole Diameter
PostHoleD=1.5;

// Rib Cutout Offset
//Inset
RibCutI=5.25;
//Width
RibCutW=12.5;
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
// D
ExtD=3;
// Lip
ExtLip=6;

Button3=[15, -7];
Button4=[29.5, -14];
Button5=[43.7, -21];
Button6=[37, -35];

module top_mounts_trim() {
translate([0,MountYOffset-6,LCDOuterD])
cube([LCDOuterW,10,10]);
}
//Reference Part
//translate([70,0,0])
//translate([0,-9.2,0])
//color("green") import("HoolyHoo-SNES-SAIO.stl");

main_bracket();


module reliefcut2() {
    module shape() {
        union(){
        translate([(LCDOuterW)/2,LCDOuterH/2,0])
            square([LCDOuterW-18,LCDOuterH-12], center=true);
        translate([LCDOuterW/2-6,LCDOuterH-12,0])
            square([52,20], center=true);
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
    difference() {
    button_bracket_plate();
    if (BUTTONS >= 3) { color("red") dmgbuttonArr(Button3); }
    if (BUTTONS >= 4) { color("red") dmgbuttonArr(Button4); }
    if (BUTTONS >= 5) { color("red") dmgbuttonArr(Button5, 45); }
    if (BUTTONS >= 6) { color("red") dmgbuttonArr(Button6, 45); }
    }
}

module button_bracket_plate() {
    union() {
        translate([0,-ExtLip,0])
        linear_extrude(height=ExtD) offset(4) offset(-4) square([LCDOuterW,ExtLip+10]);
        hull() {
            // top-left
            translate([Button3[0]-FlagW-1,ButtonR,0])
            cylinder(h=ExtD, r=ButtonR);
            
            // top-right
            translate([Button4[0]+FlagW+1,ButtonR,0])
            cylinder(h=ExtD, r=ButtonR);

            // button 3
            translate([Button3[0]-FlagW-1,Button3[1]-1,0])
            cylinder(h=ExtD, r=ButtonR);
            
            // button 4
            translate([Button4[0]-FlagW-1,Button4[1]-1,0])
            cylinder(h=ExtD, r=ButtonR);
            translate([Button4[0]+FlagW+1,Button4[1]-1,0])
            color("orange") 
            cylinder(h=ExtD, r=ButtonR);
        }
        if (BUTTONS > 4) {
            hull() {
                translate([Button5[0],0,0])
                cylinder(h=ExtD, r=ButtonR);
                translate([Button5[0]+ButtonR,0,0])
                cylinder(h=ExtD, r=ButtonR);
                
                translate([Button5[0]+FlagW,Button5[1]+FlagW,0])
                cylinder(h=ExtD, r=ButtonR);
    
                translate([Button6[0]-FlagW-0.5,Button6[1]-FlagW,0])
                cylinder(h=ExtD, r=ButtonR);
                translate([Button6[0]+1,Button6[1]-FlagW,0])
                cylinder(h=ExtD, r=ButtonR);
            }
        }
        
        buttonpost(8,-10.5);
        buttonpost(8+28.5,-10.5);
        /*
        // Need to figure out where exactly these should be positioned.
        if (BUTTONS > 4) {
            buttonpost(8,-10.5);
            buttonpost(8+28.5,-10.5);
        }
        */
    } //end union
}

module buttonpost(x,y) {
    translate([x,y,0])
    cylinder(d=1.8, h=5);
}

module main_bracket() {
    difference() {
        //LCD Mount
        union() {
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
        //boltreliefs();
        #top_mounts_trim();
    }
}

//Mounting Posts
MountXOffset=73.5;
MountYOffset=50;

module mountingposts() {
    for(x=[(LCDOuterW-MountXOffset)/2:MountXOffset:((LCDOuterW-MountXOffset)/2)+MountXOffset]){
        for(y=[5.5:55.5-5.5:55.5]){
            mountingpost(x,y);
        }
    }
}


//Mounting Post Bolt Relifs
module boltreliefs() {
    for(x=[(LCDOuterW-MountXOffset)/2:MountXOffset:((LCDOuterW-MountXOffset)/2)+MountXOffset]){
        for(y=[5.5:55.5-5.5:55.5]){
            translate([x,y,LCDD]) {
                cylinder($fn=6,h=BoltT,d=BoltD);
                cylinder(h=PostH, d=PostHoleD);
            }
        }
    }
}
        

//Button /w array
module dmgbuttonArr(arr, rot=0){
    dmgbutton(arr[0], arr[1], rot);
}


// Button
module dmgbutton(x,y,rot=0) {
translate([x,y,0]) rotate([0,0,rot])   
    union() {
        cylinder(h=ButtonH, r=ButtonR); 
        translate([-ButtonR,0,FlagH/2+.4])
            cube([FlagD,FlagW,FlagH], center=true);
            translate([ButtonR,0,FlagH/2+.4])
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