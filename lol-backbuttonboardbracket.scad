// DMG Rear Body Dimensions
// Above Battery Compartment

// Width measured 58.5mm 
OuterW=58;
// W
LatchW=19;
// Detpth measured .7mm
LatchD=1;

// H measured at 11.8mm
NotchH=11.5;
// Thickness measured 2.2mm
NotchT=2.4;

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
ExtW=29.5;
// D
ExtD=3;
// Lip
ExtLip=6;


dmgbutton();

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