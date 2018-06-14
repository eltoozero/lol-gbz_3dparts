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
vclearance=14.25;
stackclearance=7.2;

supportplatethickness=vclearance-pcbclearance-stackclearance;
vsupport=(supportplatethickness+hclearance)-vclearance;
echo(supportplatethickness);
echo(vsupport);

//translate([-modex,-10,-vclearance])
//color("blue") cube([modex,modey,vclearance]);
//
//translate([-modex,modey-10,-vclearance])
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
modey=24;
// W
modex=25.5;
// no mount
modexnoflag=21;

noflag=true;

//mode button itself
// H
mbuttx=4;
// W
mbutty=6.5;
// D
mbuttz=vclearance;

//face clearance
facecw=10.5;
facech=7;

// Power Switch
//H
pswz=5.6;
//W measured 12.69mm
pswx=13;
//D 
pswy=7.5;
//Offset
mswo=6;

//Connector
//H
mconz=3.7;
//W
mconx=4.4;
//D
mcony=5.4+.5;
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

//Back board mount hole

bbmx=9;
bbmy=4;

//Back board ports

usbx=10.2;
usby=14.6;
usbz=6.6;

swconx=4.4;
swcony=8.2;
swconz=3.2;

module usbcut() {
    translate([0,pegY+pegD/2-1,-usbz-pcbclearance])
    cube([usbx,usby,usbz]);
}

module swconcut() {
    translate([0,0,-swconz-pcbclearance-vclearance])
    cube([swconx+hclearance+3, swcony, swconz+vclearance]);
}

module backboard_mount() {
    translate([pegI+bbmx,pegY+bbmy,-vclearance])
    cylinder(d=2,h=vclearance);
}

//base_shape();

final_part();

//post placement
//translate([-hclearance,modey+3,-vclearance-pcbclearance])
//cylinder(d=2, h=vclearance);

module final_part() {

    intersection(){
difference() {
    base_shape();
    all_cuts();
    backboard_mount();
    swconcut();
    usbcut();
    //cheat
    translate([0,pegY+bbmy+3,0])
    swconcut();
    //base_block();
}
//        union(){
//        over_cut();
//        over_cut_low();
//        
//        }
    }
}

module base_shape() {
    union() {
        base_block();
        smooth_base();
        //support_tab();
    }
}

module over_cut(){
    translate([-modey/2-1,modex/2-1,-supportplatethickness-pcbclearance])
    cheese(modey+2, modey, supportplatethickness, 2);
}

module over_cut_low(){
    translate([-hclearance/2,modex/2-1,-(vclearance-supportplatethickness-pcbclearance)-supportplatethickness-pcbclearance])
    cheese(hclearance, modey, vclearance-supportplatethickness-pcbclearance, 2);
}


module smooth_base() {
    translate([0,0,-supportplatethickness-pcbclearance])
    hull() {
        
    //top left
//    translate([1,1,0])
//#    cylinder(d=2, h=supportplatethickness);

    //bottom left
//    translate([1,modey-1,0])
//    cylinder(d=2, h=supportplatethickness);

    //top left inside step
//    translate([-1-3,1,0])
//    cylinder(d=2, h=supportplatethickness);

    //bottom left inside step
    translate([0,pegY+bbmy+2,0])
    cylinder(d=2, h=supportplatethickness);

    //bottom left inset
    translate([pegI+bbmx,pegY+bbmy,0])
    cylinder(d=2, h=supportplatethickness);

    //bottom left inset
    translate([pegI+bbmx+2,pegY+bbmy+2,0])
    cylinder(d=2, h=supportplatethickness);

    translate([pegI+bbmx+2,swcony+1,0])
    cylinder(d=2, h=supportplatethickness);

    translate([0,swcony+1,0])
    #cylinder(d=2, h=supportplatethickness);

    //top right
    //translate([-modex+1,1,0])
    //cylinder(d=2, h=supportplatethickness);

    //top right new
//    translate([pegI+bbmx+2,1,0])
//    cylinder(d=2, h=supportplatethickness);
//    
    //top right inset
//    translate([-modex+2,1,0])
//    cylinder(d=2, h=supportplatethickness);


    //right 1st attempt
    //translate([-modex+1,pswy,0])
    //#cylinder(d=2, h=supportplatethickness);

    // bottom hole outlines
//    translate([-bx-1,by-pswy/2+2,0])
//    cylinder(d=2, h=supportplatethickness);
//
//    translate([-bx-1,by+pswy/2-2,0])
//    cylinder(d=2, h=supportplatethickness);

    // top hole outlines
//    translate([-tx-1,ty-pswy/2+2,0])
//    cylinder(d=2, h=supportplatethickness);
//
//    translate([-tx-1,ty+pswy/2-2,0])
//    cylinder(d=2, h=supportplatethickness);
        
    //bottom left
//    translate([-1,modey+3,supportplatethickness-3.75])
//    cylinder(d=2, h=3.75);
    //bottom left inside step
//    translate([-1-3,modey+3,0])
//    cylinder(d=2, h=supportplatethickness);

    }
} //end smooth_base module

module support_tab(){
    translate([0,0,-pcbclearance-supportplatethickness-1.2])
    hull() {
        //tab support
        translate([-hclearance,modey+3,0])
        cylinder(d=4, h=1.2);
        
        //bottom left
        translate([-1,modey-1,0])
        cylinder(d=2, h=1.2);
        
        //bottom left inset
        translate([-1-13,modey-1,0])
        cylinder(d=2, h=1.2);
    }
}

module all_cuts() {
    
//    difference() {
//
//    base_block();

    translate([pegI, pegY, -vclearance]){
        //peg clearance
        cylinder(d=pegD, h=vclearance);
        translate([-pegD,-pegD/2,0])
        //peg extension
        cube([pegD,pegD,vclearance]);
    }
        //mode button cut
//        translate([-mbuttx,modey-mbutty-3,-mbuttz-pcbclearance])
//        cube([mbuttx,mbutty,mbuttz]);

        //mode button face cut
        translate([0-1.5,modey-facecw,-facech-4])
        cube([mbuttx/2,facecw+1,facech+4]);

        //power switch
//        translate([-pswx-mswo,-1,-pswz-pcbclearance])
//        cube([pswx, pswy+pcbclearance, pswz]);

        //connector
//        translate([-mconx-mconox-10,mconoy,-mconz-pcbclearance])
//        cube([mconx+10, mcony, mconz+pcbclearance]);
    
        //connector thru
//      translate([-mconx-mconox-10,mconoy,-(vclearance-hclearance+1)])
//        #cube([mconx+10, mcony, vclearance-hclearance+1]);

        //Mounting holes
//        translate([-tx,ty,-supportplatethickness])
//        cylinder(h=supportplatethickness, d=md);
//        translate([-bx,by,-supportplatethickness])
//        cylinder(h=supportplatethickness, d=md);

        //post placement
        translate([-hclearance,modey+3,-vclearance-pcbclearance])
        cylinder(d=1.8, h=vclearance);

//    } // end difference 
} //end rough part


module base_block(){
    translate([hclearance,0,-vclearance+hclearance]) {
    union() {
        rotate([90,0,180])
        difference(){
            cylinder(h=modey, r=hclearance);

            translate([-hclearance,0,0])
            cube([hclearance*2,hclearance*2,modey]);

            translate([-hclearance*2,-hclearance,0])
            cube([hclearance*2,hclearance*2,modey]);
        }
        
        //base plate
//        translate([-modex+hclearance,0,0])
//        cube([modex, modey, vclearance-hclearance]);
//        translate([hclearance,0,0])
        }
    }
}
        

module cheese(x,y,z,r) {
linear_extrude(height=z) offset(-r) offset(r) offset(r) offset(-r)
    square([x,y], center=true);
}