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
hclearance=10.5;
vclearance=15.25;
stackclearance=7.2;

supportplatethickness=vclearance-pcbclearance-stackclearance;
vsupport=(supportplatethickness+hclearance)-vclearance;
echo(supportplatethickness);
echo(vsupport);

//translate([-modew,-10,-vclearance])
//color("blue") cube([modew,modeh,vclearance]);
//
//translate([-modew,modeh-10,-vclearance])
//color("red") cube([10,10,stackclearance]);

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
mbuttw=7;
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
mswd=7.5;
//Offset
mswo=6;

//Connector
//H
mconh=3.2;
//W
mconw=4.4;
//D
mcond=5.4+.5;
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
bx=16;
//Bot Y
by=16;

//base_shape();

final_part();

module final_part() {

    intersection(){
difference() {
    base_shape();
    all_cuts();
    //base_block();
}
        union(){
        over_cut();
        over_cut_low();
        
        }
    }
}

module base_shape() {
    union() {
        base_block();
        #smooth_base();
    }
}

module over_cut(){
    translate([-modeh/2-1,modew/2-1,-supportplatethickness-pcbclearance])
    cheese(modeh+2, modeh, supportplatethickness, 2);
}

module over_cut_low(){
    translate([-hclearance/2,modew/2-1,-(vclearance-supportplatethickness-pcbclearance)-supportplatethickness-pcbclearance])
    cheese(hclearance, modeh, vclearance-supportplatethickness-pcbclearance, 2);
}


module smooth_base() {
    translate([0,0,-supportplatethickness-pcbclearance])
    hull() {
    //top left
    translate([-1,1,supportplatethickness-3.75])
    cylinder(d=2, h=3.75);

    //bottom left
    translate([-1,modeh-1,supportplatethickness-3.75])
    cylinder(d=2, h=3.75);

    //top left inside step
    translate([-1-3,1,0])
    cylinder(d=2, h=supportplatethickness);

    //bottom left inside step
    translate([-1-3,modeh-1,0])
    cylinder(d=2, h=supportplatethickness);


    //bottom left inset
    translate([-1-13,modeh-1,0])
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



module all_cuts() {
    
//    difference() {
//
//    base_block();

    translate([-pegI, pegY, -vclearance]){
        //peg clearance
        cylinder(d=pegD, h=vclearance);
        translate([0,-pegD/2,0])
        //peg extension
        cube([pegD,pegD,vclearance]);
    }
        //mode button cut
        translate([-mbutth,modeh-mbuttd-3,-mbuttd-pcbclearance])
        cube([mbutth,mbuttw,mbuttd]);

        //mode button face cut
        translate([0-1.5,modeh-facecw,-facech-4])
        cube([mbutth/2,facecw+1,facech+4]);

        //power switch
        translate([-msww-mswo,-1,-mswh-pcbclearance])
        cube([msww, mswd+pcbclearance, mswh]);

        //connector
        translate([-mconw-mconox-10,mconoy,-mconh-pcbclearance])
        cube([mconw+10, mcond, mconh+pcbclearance]);
    
        //connector thru
//      translate([-mconw-mconox-10,mconoy,-(vclearance-hclearance+1)])
//        #cube([mconw+10, mcond, vclearance-hclearance+1]);

        //Mounting holes
        translate([-tx,ty,-supportplatethickness])
        cylinder(h=supportplatethickness, d=md);
        translate([-bx,by,-supportplatethickness])
        cylinder(h=supportplatethickness, d=md);

//    } // end difference 
} //end rough part


module base_block(){
    translate([-hclearance,0,-vclearance+hclearance]) {
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
//        translate([hclearance,0,0])
        }
    }
}
        

module cheese(x,y,z,r) {
linear_extrude(height=z) offset(-r) offset(r) offset(r) offset(-r)
    square([x,y], center=true);
}