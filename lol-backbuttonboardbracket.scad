$fn=32;

// DMG Rear Body Dimensions
// Above Battery Compartment

// Width measured 58mm 
OuterW=57.5;
// W
LatchW=19;
// Detpth measured .7mm
latchz=1;

//Silicone thickness
silz=2.3;
//Sil diameter
sild=16;

//side post -y from notch bottom
py=5;
// post diameter
pd=5; //measured 4mm, oversizing.

module post_removal() {
    for(x=[-OuterW/2-2:OuterW+4:OuterW/2+2]) {
        translate([x,0,0])
        cylinder(d=pd,h=ExtD+silz);
    }
}


module lil_peg() {
for(i=[-DualButtonSep/2+sild/2:DualButtonSep-sild:DualButtonSep/2-sild/2]) {
    translate([i,0,ExtD])
    cylinder(d=2,h=silz);
}
}
//sil_cut();
module sil_cut() {
for(i=[-DualButtonSep/2:DualButtonSep:DualButtonSep/2]) {
    translate([i,0,ExtD])
    cylinder(d=sild,h=silz);
}

for(i=[-DualButtonSep/2+sild/2:DualButtonSep-sild:DualButtonSep/2-sild/2]) {
    translate([i,0,ExtD])
    cylinder(d=6,h=silz);
}
}

module side_supports(){
    hull() {
        translate([OuterW/2-supd/2,-supd/2-.5,ExtD]){
    translate([0,NotchH/2-2,0])
    cylinder(d=supd, h=silz);
    translate([0,-NotchH/2+2,0])
    cylinder(d=supd, h=silz);
        }
    }
    hull() {
        translate([-OuterW/2+supd/2,-supd/2-.5,ExtD]){
    translate([0,NotchH/2-2,0])
    cylinder(d=supd, h=silz);
    translate([0,-NotchH/2+2,0])
    cylinder(d=supd, h=silz);
        }
    }

}

// H measured at 11.8mm
NotchH=11.5;
// Thickness measured 2.2mm
notchy=2;

// DMG Button Dimensions
// H
ButtonH=10;
// R
ButtonR=5.8;

// DMG Button Flag
// H
FlagH=ButtonH;
// W
FlagW=2.7;
// D
FlagD=5.5;

supd=1.2;

// Button Extension
// H
ExtH=14;
// W
ExtW=29.5;
// D
ExtD=3+1.8;
// Lip
ExtLip=6;

DualButtonSep=39;
//
//translate([-8.5-OuterW/2,18.1,-2])
//rotate([90,0,0])
//import("gbz_KiteBracket.stl");

module backbracketbody2d() {
    difference() {
    union(){
        translate([-OuterW/2,-NotchH/2,0])
        square([OuterW,NotchH]);
        translate([-48/2,NotchH/2])
        square([48,notchy]);
    }
    translate([-LatchW/2,-NotchH/2])
    square([LatchW, 3.75]);
    }
}

module backbracketbody() {
linear_extrude(height=ExtD+silz) offset(-2) offset(2) offset(2) offset(-2)backbracketbody2d();
}

//rotate([0,180,0])
final_part();
module final_part() {
    lil_peg();
    difference(){
    union() {
    //translate([-OuterW/2,-ExtH/2,0])
    //linear_extrude(height=ExtD) offset(2) offset(-2) square([OuterW,ExtH]);

    translate([0,-1,0])
    backbracketbody();
//    side_supports();

//    translate([0,2.75,ExtD])
    //#cube([LatchW, ExtH, latchz], center=true);
//    cheese(LatchW, ExtH-2.75, silz, 2);

//    translate([DualButtonSep/2,7.5,ExtD])    
//    cylinder(d=1.8, h=2.4);
//    translate([-DualButtonSep/2,7.5,ExtD])    
//    cylinder(d=1.8, h=2.4);
    }

    //translate([OuterW/2-10,0,0])
    translate([DualButtonSep/2,0,0])
    rotate([0,0,-30])
    dmgbutton();

    translate([-DualButtonSep/2,0,0])
    rotate([0,0,30])
    dmgbutton();
    post_removal();
    sil_cut();
    //translate([0,0,latchz/2])
    //cube([LatchW, ExtH, latchz], center=true);
    translate([0,-2.5,0])
    cheese(LatchW, ExtH, latchz*3, 2);

    //screw hole
    translate([0,1,4])
    cylinder(d=1.8,h=ExtD+silz);
    }
}

//Button
module dmgbutton(x,y) {
translate([x,y,0])    
    union() {
        cylinder(h=ButtonH, r=ButtonR); 
        translate([-ButtonR,0,FlagH/2+.4])
            cube([FlagD,FlagW,FlagH], center=true);
            translate([ButtonR,0,FlagH/2+.4])
            cube([FlagD,FlagW,FlagH], center=true);
    }
}

module cheese(x,y,z,r) {
linear_extrude(height=z) offset(-r) offset(r) offset(r) offset(-r)
    square([x,y], center=true);
}