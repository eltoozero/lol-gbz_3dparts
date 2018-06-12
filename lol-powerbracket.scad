//lol here's a power/mode button support

$fn=32;

// hclearance left of cartridge area inside shell
// measured 10.75mm
hclearance=10;

//mode board
// H
modeh=24;

rotate([90,0,0])
difference(){
    cylinder(h=modeh, r=hclearance/2);

    translate([-hclearance/2,0,0])
    cube([hclearance,hclearance/2,modeh]);

    translate([0,-hclearance/2,0])
    cube([hclearance/2,hclearance,modeh]);
}