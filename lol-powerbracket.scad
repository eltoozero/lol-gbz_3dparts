//lol here's a power/mode button support

//notes from mvp print:
//-cut entire front face for mode button
//-add 1mm fudge room around parts.
//-add a 1mm z depth to connectors
//-remove 2.2mm from the extension "height".

//notes from mvp2 print:
//-still need 2.2mm extra thickness on support.

$fn=32;

// hclearance left of cartridge area inside shell
// measured 10.75mm

pcbclearance=1.1;
hclearance=11;
vclearance=15.25-pcbclearance-2.2;
stackclearance=7.2;

supportplatethickness=vclearance-stackclearance;

//translate([-modeh,0,0])
//cube([modeh,modew,vclearance-stackclearance]);

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
// no mount
modewnoflag=21;

noflag=true;

//mode button itself
// H
mbutth=4;
// W
mbuttw=6.5;
// D
mbuttd=6;

//face clearance
facecw=10.5;
facech=7;

// Power Switch
//H
mswh=4.6+.5;
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
mcond=5.4+.25;
//X Offset
mconox=13.5;
//Y Offset
mconoy=7.8;

//Mounting holes
md=1.8;
//Top X
tx=23.5;
//Top Y
ty=3.5;
//Bot X
bx=15.5;
//Bot Y
by=16;

final_part();

module final_part() {
    intersection(){
        rough_part();
        over_cut();
    }
}

module over_cut(){
    translate([-modeh/2-1,modew/2,-vclearance])
    cheese(modeh+2, modew, vclearance, 2);
}

module smooth_base() {
    hull() {
    //top left
    translate([-1,1,0])
    cylinder(d=2, h=supportplatethickness);

    //bottom left
    translate([-1,modeh-1,0])
    cylinder(d=2, h=supportplatethickness);

if(noflag) {    
    
//    //bottom left inset
//    translate([-1-12,modeh-1,0])
//    cylinder(d=2, h=supportplatethickness);
//    
//    //top right inset
//    translate([-modewnoflag+2,1,0])
//    #cylinder(d=2, h=supportplatethickness);
//    
} else {
}
    //bottom left inset
    translate([-1-12,modeh-1,0])
    cylinder(d=2, h=supportplatethickness);

    //top right
    //translate([-modew+1,1,0])
    //cylinder(d=2, h=supportplatethickness);

    //top right inset
    translate([-modew+2,1,0])
    cylinder(d=2, h=supportplatethickness);


    //right 1st attempt
    //translate([-modew+1,mswd,0])
    //#cylinder(d=2, h=supportplatethickness);

    // bottom hole outlines
    translate([-bx-1,by-mswd/2+2,0])
    cylinder(d=2, h=supportplatethickness);

    translate([-bx-1,by+mswd/2-2,0])
    cylinder(d=2, h=supportplatethickness);

    // top hole outlines
    translate([-tx-1,ty-mswd/2+2,0])
    cylinder(d=2, h=supportplatethickness);

    translate([-tx-1,ty+mswd/2-2,0])
    cylinder(d=2, h=supportplatethickness);
    }
} //end smooth_base module

module rough_part() {
    difference() {
    base_block();
    translate([-pegI, pegY, -vclearance]){
        cylinder(d=pegD, h=vclearance);
        translate([0,-pegD/2,0])
        cube([pegD,pegD,vclearance]);
    }
        //mode button cut
        translate([-mbutth,modeh-mbuttd-3,-mbuttd])
        cube([mbutth,mbuttw,mbuttd]);

        //mode button face cut
        translate([0-1.5,modeh-facecw,-facech-4])
        cube([mbutth/2,facecw+1,facech+4]);

        //power switch
        translate([-msww-mswo,-1,-mswh])
        cube([msww, mswd+1, mswh]);

        //connector
        translate([-mconw-mconox-10,mconoy,-mconh])
        cube([mconw+10, mcond, mconh]);
    
        //connector thru
//      translate([-mconw-mconox-10,mconoy,-(vclearance-hclearance+1)])
//        #cube([mconw+10, mcond, vclearance-hclearance+1]);

        //Mounting holes
        translate([-tx,ty,-2])
        cylinder(h=2, d=md);
        translate([-bx,by,-2])
        cylinder(h=2, d=md);

    }
} //end rough part

module base_block(){
    translate([-hclearance,0,-supportplatethickness]) {
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
//        translate([-modew+hclearance,0,0])
//        cube([modew, modeh, vclearance-hclearance]);
        translate([hclearance,0,0])
        smooth_base();
        }
    }
}
        

module cheese(x,y,z,r) {
linear_extrude(height=z) offset(-r) offset(r) offset(r) offset(-r)
    square([x,y], center=true);
}