//lol-bbbbsupport

$fn=16;

//button board bracket clearance
bbcz=6.4;

//slot clearance
slcz=8.2;





// Mounting Posts Case
// Diameter
cmd=7.6;
// Height
cmz=13.3;
// OffsetY
cmoy=2.7;
// OffsetX
cmox=74;
// Hole Diameter
cmhd=1.8;

// Mounting Posts PCB
// Diameter
pmd=4.2;
// Height
pmz=13.3;
// OffsetY
pmoy=-4;
// OffsetX
pmox=62;
// Hole Diameter
pmhd=1.2;


//Post Y Distance 
//12.6 - 4.2/2 - 7.6/2
//12.6 - 2.1 - 3.8
//12.6 - 5.9
// 6.7

// Width measured 58.5mm 
OuterW=58;
// W
LatchW=19;
// Detpth measured .7mm
LatchD=1;
NotchW=53;
NotchX=OuterW-NotchW;

latchcx=14;

// H measured at 11.8mm
notchh=11.5;
// Thickness measured 2.2mm
notcht=2.4;
notchy=3.75;

// Other Parameters
//main thickness
pt=2;

//post offset y
poy=6.7;

//overall y dimension
oy=17;

translate([0,3,0])
mounting_posts();
translate([0,0,0])
import("lol-backbuttonboardbracket.stl");

module connector_cut() {
    hull() {
    translate([cmox/2+10,0,0])
    cylinder(d=2,h=pmz+pt);
    translate([cmox/2-1,0,0])
    #cylinder(d=2,h=pmz+pt);
    translate([cmox/2-notchh/2-1,-notchh,0])
    #cylinder(d=2,h=pmz+pt);
    translate([cmox/2+10,-notchh,0])
    cylinder(d=2,h=pmz+pt);
    }
}


module notch_cut2() {
    translate([0,-notchy*2,slcz])
    #cheese(LatchW,3.75*2,pt,2);

}
//notch cut
//notch_cut();
module notch_cut(){
    hull(){
    
    translate([0,-oy/2+notchy/2,0]){
        translate([-latchcx/2,0,0])
        cylinder(d=notchy, h=pmz);
        translate([latchcx/2,0,0])
        cylinder(d=notchy, h=pmz);
    }
    translate([0,-oy/2-notchy/2,0]){
        translate([-LatchW/2,0,0])
        cylinder(d=notchy, h=pmz);
        translate([LatchW/2,0,0])
        cylinder(d=notchy, h=pmz);
    }

    }
}

module screw_cut(){
cylinder(d=1.8, h=pmz);
//    hull(){
//    
//    translate([0,-oy/2+notchy/2+4,0]){
//        translate([-latchcx/2+4,0,0])
//        cylinder(d=notchy, h=pmz);
//        translate([latchcx/2-4,0,0])
//        cylinder(d=notchy, h=pmz);
//    }
//    translate([0,-oy/2-notchy/2+4,0]){
//        translate([-LatchW/2+4,0,0])
//        cylinder(d=notchy, h=pmz);
//        translate([LatchW/2-4,0,0])
//        cylinder(d=notchy, h=pmz);
//    }
//
//    }
}


//mounting post stand ins
module mounting_posts() {
    //PCB Mount posts
    //left
    translate([-pmox/2, pmoy, 0])
    cylinder(d=pmd, h=pmz);
    //right
    translate([pmox/2, pmoy, 0])
    cylinder(d=pmd, h=pmz);

    //Case Mount posts
    //left
    translate([-cmox/2, cmoy, 0])
    cylinder(d=cmd, h=cmz);
    //right
    translate([cmox/2, cmoy, 0])
    cylinder(d=cmd, h=cmz);
}

//mounting_holes();
module mounting_holes() {
    //PCB Mount posts
    //left
    translate([-pmox/2, pmoy, 0])
    cylinder(d=pmhd, h=pmz+pt);
    //right
    translate([pmox/2, pmoy, 0])
    cylinder(d=pmhd, h=pmz+pt);

    //Case Mount posts
    //left
    translate([-cmox/2, cmoy, 0])
    cylinder(d=cmhd, h=cmz+pt);
    //right
    translate([cmox/2, cmoy, 0])
    cylinder(d=cmhd, h=cmz+pt);
}

translate([0,1,0])
final_part();
module final_part() {
difference() {
    base_bracket();
    notch_cut2();
translate([0,-1,0])
    screw_cut();
    translate([0,2,0])
    mounting_holes();
    connector_cut();
mirror() connector_cut();
    
    
}
}
//base_bracket();
module base_bracket() {
union() {
    left_side();
    right_side();
    bottom_part();
    top_left();
    top_right();

}
}

//bottom part
module bottom_part() {
    hull() {
        //bottom right
        node(pmox/2-pmd-NotchX,0,pt/2+slcz);
        //bottom left
        node(-pmox/2+pmd+NotchX,0,pt/2+slcz);
    }
}

//left side part
module left_side(){
    hull() {
    //top inside left
    node(-pmox/2+pmd+NotchX/2,0,pmz+pt/2);
    //bottom left
    node(-pmox/2+pmd+NotchX,0,pt/2+slcz);
    }
}

//right side part
module right_side(){
    hull() {
    //top right
    node(pmox/2-pmd-NotchX/2,0,pmz+pt/2);
    //bottom right
    node(pmox/2-pmd-NotchX,0,pt/2+slcz);
    }
}

module top_left() {
    hull() {
    //top outside left
    node(-cmox/2-cmd/2+1,0, cmz+pt/2);
    //top inside left
    node(-pmox/2+pmd+NotchX/2,0,pmz+pt/2);
    }
}

//translate([0,0,0])
//#hull() {
//    translate([-pmox/2, pmoy, pmz])
//    color("red") cylinder(d=pmd, h=pt);
//
//    translate([-cmox/2, cmoy, cmz])
//    color("red") cylinder(d=cmd, h=pt);
//
//    node(-pmox/2+pmd+NotchX/2,0,pmz+pt/2);
//}

//translate([0,3,0])
//flap_mount();
//mounting_holes();
module mounting_holes() {
    //PCB Mount posts
    //left
    translate([-pmox/2, pmoy, 0])
    cylinder(d=pmhd, h=pmz+pt);
    //right
    translate([pmox/2, pmoy, 0])
    cylinder(d=pmhd, h=pmz+pt);

    //Case Mount posts
    //left
    translate([-cmox/2, cmoy, 0])
    cylinder(d=cmhd, h=cmz+pt);
    //right
    translate([cmox/2, cmoy, 0])
    cylinder(d=cmhd, h=cmz+pt);
}

module flap_left() {
    hull() {
        //pcb
        //left
        translate([-pmox/2, pmoy+3, pmz])
        cylinder(d=pmd, h=pt);
        //angle
        translate([-pmox/2, -oy/2+pmd/2+1, pmz])
        #cylinder(d=pmd, h=pt);
        
        //case
        //left
        translate([-cmox/2, cmoy+3, pmz])
        cylinder(d=cmd, h=pt);
        //top inside left
        node(-pmox/2+pmd+NotchX/2,1,pmz+pt/2);
    }
}
module top_right() {
    hull() {
    //top outside left
    node(cmox/2+cmd/2-1,0, cmz+pt/2);
    //top inside left
    node(pmox/2-pmd-NotchX/2,0,pmz+pt/2);
    }
}

module node(x,y,z) {
    translate([x,y,z]){
        rotate([90,0,0])
        translate([0,0,-oy/2])
        cylinder(h=oy, d=pt);
        } // end translate wrapper
}

module cheese(x,y,z,r) {
linear_extrude(height=z) offset(-r) offset(r) offset(r) offset(-r)
    square([x,y], center=true);
}