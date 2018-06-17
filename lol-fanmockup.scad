//lol my idea for a fan duct in the cartridge slot.

$fn=32;

//measurements

//cart lip z
cz=8;

//between case plastic and top of cartridge "notches"
//py=39;

//from bottom of lower peg to cart top lip
py=27-4;

//outside cartridge slot y
mx=61.6;

//px=0; //redefined later.

//cart plate thickness
pz=1.6;

//lower mount offset x
lmox=62;

// upper left mount offset y (from lower)
ulmoy=19;

// upper right mount offset y (from lower)
urmoy=13;

// mount diameter
md=4;

//plate-x
px=lmox+md;

//fan dimensions
fx=30;
fy=30;
fz=3.4;
//aperture
fad=18;
//aperture x offset
faxo=-1;

//fan y offset
fyo=2;

//mount hole dia
fmhd=1.6;

//mount hole coord
//top
ftmhy=27.5;
ftmhx=2.5;

//side
fsmhy=2.5;
fsmhx=2.5;

//lower
flmhy=6.4+fx/2;
flmhx=28.5;

//hold diameter
hd=1.8;

//shroud stuff
//wall thickness
wt=1.2;

//heatsink
hsx=17;
hsy=17;
hsz=6;

//cpu
cpuxo=-3;

//duct extra y
dey=2;

//for other modules
hclearance=8.6;
vclearance=14.25;

fan();
module fan() {
    difference() {
        //fan body
        cube([fx,fy,fz]);
        // fan aperture
        translate([fx/2+faxo,fy/2,0])
        cylinder(d=fad, h=fz);
    fan_mount_holes(); 
    }
}


module fan_mount_holes() {
    //top
    translate([ftmhx,ftmhy,0])
    cylinder(d=fmhd, h=fz);
    
    //side
    translate([fsmhx,fsmhy,0])
    cylinder(d=fmhd, h=fz);

    //lower
    translate([flmhx,flmhy,0])
    cylinder(d=fmhd, h=fz);
    
}