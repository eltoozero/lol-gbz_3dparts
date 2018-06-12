//lol here's a power/mode button support

$fn=32;

// hclearance left of cartridge area inside shell
// measured 10.75mm
hclearance=10;
vclearance=13.84;

// peg keepout
//D measured 7.58mm
pegD=8;
//Inset measured ~ 4.88mm
pegI=4.5;
//Y
pegY=11;

//mode board
// H
modeh=24;
// W
modew=25.5;

//mode button itself
// H
mbutth=6;
// W
mbuttw=6;
// D
mbuttd=6;

//face clearance
facecw=10.5;
facech=7;

//Switch
//H
mswh=4.6;
//W measured 12.69mm
msww=13;
//D 
mswd=7;
//Offset
mswo=6;

//Connector
//H
mconh=3.2;
//W
mconw=4.4;
//D
mcond=5.4;
//X Offset
mconox=13.5;
//Y Offset
mconoy=7.8;

//Mounting holes
//Top X
tx=23.5;
//Top Y
ty=3.5;
//Bot X
bx=15.5;
//Bot Y
by=16;

//top left
translate([-1,1,0])
cylinder(d=2, h=vclearance-hclearance);

//bottom left
translate([-1,1,0])
cylinder(d=2, h=vclearance-hclearance);

//top right
//translate([-modew+1,1,0])
//cylinder(d=2, h=vclearance-hclearance);

//right 1st attempt
//translate([-modew+1,mswd,0])
//#cylinder(d=2, h=vclearance-hclearance);

// bottom hole outlines
translate([-bx-1,by-mswd/2+2,0])
#cylinder(d=2, h=vclearance-hclearance);

translate([-bx-1,by+mswd/2-2,0])
#cylinder(d=2, h=vclearance-hclearance);

// top hole outlines
translate([-tx-1,ty-mswd/2+2,0])
#cylinder(d=2, h=vclearance-hclearance);

translate([-tx-1,ty+mswd/2-2,0])
#cylinder(d=2, h=vclearance-hclearance);


difference() {
base_block();
translate([-pegI, pegY, -vclearance]){
    cylinder(d=pegD, h=vclearance);
    translate([0,-pegD/2,0])
    cube([pegD,pegD,vclearance]);
}
    //mode button cut
    translate([-mbutth,modeh-mbutth,-mbuttd])
    cube([mbutth,mbuttw,mbuttd]);

    //mode button face cut
    translate([0-1.5,modeh-facecw,-facech-2])
    cube([mbutth/2,facecw+1,facech+2]);

    //power switch
    translate([-msww-mswo,-1,-mswh])
    cube([msww, mswd+1, mswh]);

    //connector
    translate([-mconw-mconox-10,mconoy,-mconh])
    cube([mconw+10, mcond, mconh]);

    //Mounting holes
    translate([-tx,ty,-2])
    #cylinder(h=2, d=1.5);
    translate([-bx,by,-2])
    #cylinder(h=2, d=1.5);

}

module base_block(){
    translate([-hclearance,0,hclearance-vclearance]) {
    union() {
        rotate([90,0,180])
        difference(){
            cylinder(h=modeh, r=hclearance);

            translate([-hclearance,0,0])
            cube([hclearance*2,hclearance*2,modeh]);

            translate([0,-hclearance,0])
            cube([hclearance*2,hclearance*2,modeh]);
        }
        
        //base plate
        translate([-modew+hclearance,0,0])
        cube([modew, modeh, vclearance-hclearance]);
        }
    }
}
        

module cheese(x,y,z,r) {
linear_extrude(height=z) offset(-r) offset(r) offset(r) offset(-r)
    square([x,y], center=true);
}