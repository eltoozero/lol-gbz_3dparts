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

fxo=4;

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
flmhy=8.6+fx/2;
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

//translate([-fx/2+cpuxo,hsy,cz+pz])
//translate([-fx/2,-fy/2,fz/2])
//fan();
//fan_mount_holes();

//final_part();
top_duct_print();
//bottom_plate_print();

module top_duct_print(){
rotate([180,0,0])
top_duct();
}

module bottom_plate_print(){
    difference() {
        final_part();
        fan_cut_block();
        upper_cut_box();
        cartplate_mounts();
        cartplate_mount_holes();
    }
}

module top_duct(){
union() {
        difference() {
            final_part();
            fan_cut_block();
            lower_cut_box();
        //        cartplate_mounts();
        //        cartplate_mount_holes();
        }
            translate([cpuxo+fxo,py+fy/2-fyo,cz+pz+pz])
            //rotate([0,0,-90])
        mirror()    
        fan_mount_holes();


    }
}
//final_part();
module final_part() {
union(){
    duct_base();
    fan_entry();
    duct_bottom_walls();
    duct_corner_wall();
//    translate([cpuxo,py+fy/2-fyo,cz+pz+pz])
//    rotate([0,0,-90])
//    #fan_mount_holes();

    difference() {
    translate([0,0,fz+pz])
        duct_base();
        
        heatsink_cut();
    }
    difference() {
        base_plate();
        cartplate_mounts();
        cartplate_mount_holes();

    }
    }
}



module duct_base() {
difference() {
    duct_outside_body();
    duct_inside_cut();
    //fan body
//    translate([cpuxo-fx/2,hsy,cz])
//    #cube([fx,fy,fz]);
 //   hull_cut();
    }
    //heatsink_cut();
}

//translate([-px/2-hclearance+md/2,hsy/2+md/2-fy/2-dey,pz+cz])
//cube([fx/2,fy/2,fz]);

//fan_entry();
module fan_entry() {
    difference() {
        hull() {
            //fan body outside
            translate([cpuxo+fxo-fx/2,hsy,cz])
            cube([fx,fy,pz*2+fz]);

            //corner outside
            translate([cpuxo+fxo,hsy/2+md/2-dey,cz])
            cylinder(r=fx/2, h=pz*2+fz);
        }
        hull() {
            //fan body inside
            translate([cpuxo+fxo-fx/2+wt,hsy,cz])
            cube([fx-wt*2,fy,pz*2+fz]);

            //corner inside
            translate([cpuxo+fxo,hsy/2+md/2-dey,cz])
            cylinder(r=fx/2-wt, h=pz*2+fz);
        }
        //corner cut
        translate([cpuxo+fxo-fx/2,hsy/2+md/2-dey-fx/8,cz+fz/2+pz])
        cube([fx,fy-wt*2-fx/4,pz*2+fz], center=true);


    }
}

//duct_corner_wall();
module duct_corner_wall() {
translate([cpuxo+fxo-fx/2-fx/4,fy/2,cz])
    difference(){
            cylinder(d=fx/2+wt*2, h=fz+pz*2);
            cylinder(d=fx/2, h=fz+pz*2);
            translate([-fx/4,0,0])
            cube([fx/2,fx/2,fz+pz*2]);
            translate([-fx/2,-fx/4,0])
            cube([fx/2,fx/2,fz+pz*2]);

    }
}

////translate([-(px/2+hclearance+cpuxo),0,0])
////cube([px/2+hclearance+cpuxo,py,cz+pz+2]);
//
//    translate([cpuxo-fx/2-fx/4,0,0])
//    cube([10,10,fz]);
//
//    translate([-hclearance/2+md/4,py/2,cz])
//    translate([-(px+hclearance-md/2)/2,0,0])
//    cube([px+hclearance-md/2, 10, 10]);
//
//    translate([-hclearance/2+md/4-(px+hclearance-md/2)/2,py/2,0])
//    cube([10,10,10]);
//
//    translate([-hclearance/2+md/4-(px+hclearance-md/2)/2,py/2,0])
//    cube([abs(cpuxo-fx/2-fx/4-hclearance/2+md/4-(px+hclearance-md/2)/2),10,10]);


//    //side opening
//    translate([-px/2-hclearance+md/2,hsy/2+md/2-fy/2-dey,pz+cz])
//    //#cube([px/2+cpuxo+hclearance,wt,fz]);
//    #cube([abs(cpuxo-fx/2-fx/4),fy/2,pz+cz]);

//translate([cpuxo-fx/2-fx/4,0,0])
//cube([10,10,10]);

//translate([-px/2-hclearance+md/2,0,0])
//cube([abs(-px/2-hclearance+md/2)-abs(cpuxo-fx/2-fx/4),10,10]);

//duct_bottom_walls();
module duct_bottom_walls() {
    translate([-px/2-hclearance+md/2,fy/2-wt-fx/4,cz])
    //#cylinder(d=fx/2, h=fz);
    cube([abs(-px/2-hclearance+md/2)-abs(cpuxo+fxo-fx/2-fx/4),wt,fz+pz*2]);
    
    translate([-px/2-hclearance+md/2,hsy/2+md/2-dey-fy/2,cz])
    //cylinder(r=fx/2, h=fz);
    cube([px/2+cpuxo+fxo+hclearance,wt,fz+pz*2]);
    
}

module duct_outside_body() {
    color("yellow") hull() {
    
    //side opening
    translate([-px/2-hclearance+md/2,hsy/2+md/2-fy/2-dey,cz])
    cube([px/2+cpuxo+fxo+hclearance,py,pz]);

    //fan body
    translate([cpuxo+fxo-fx/2,py-fyo,cz])
    cube([fx,fy,pz]);

    //corner 
    translate([cpuxo+fxo,hsy/2+md/2-dey,cz])
    cylinder(r=fx/2, h=pz);
    }
}

module duct_inside_cut() {
    color ("green") hull() {
        translate([cpuxo+fxo-fx/2-fx/4,fy/2,cz])
        cylinder(d=fx/2, h=pz);

        translate([-fx+cpuxo+fxo,fy+py,cz])
        cube([fx/2, fy/2, pz]);

        translate([-px,fy/4,cz])
        cube([fx/2, fy/2, pz]);
    }
}

module upper_cut_box(){
    translate([0,fy/2,pz*5+cz+pz])
    cube([px+fx*2,py+fy*2,pz*10], center=true);
}

//lower_cut_box();
module lower_cut_box(){
    translate([0,fy/2,cz/2+pz/2])
    cube([px+fx*2,py+fy*2,cz+pz], center=true);
}

//final_part();
//module final_part() {
//    difference(){
//        union() {
//        base_plate();
////        base_block();
////        shroud_assembly();
//
//        }
//    cartplate_mounts();
//    cartplate_mount_holes();
////    fan_body();
////    heatsink_cut();
////    cut_box();
//    }
//}

//fan_cut_block();
module fan_cut_block() {
    translate([cpuxo+fxo-fx/2,py-fyo,cz])
    cube([fx, fy, fz+pz]);
        
//    translate([cpuxo,py+fy/2-fyo,cz+pz+pz])
//    rotate([0,0,-90])
//    fan_mount_holes(); 
    
    translate([cpuxo+fxo-faxo,py+fy/2-fyo,cz+pz*2])
    #cylinder(d=fad,h=fz*2,center=true);
}

//heatsink cut
module heatsink_cut() {
    translate([cpuxo,hsy/2+md/2,cz+pz])
    cube([hsx,hsy,hsz*2],center=true);
}


//shroud_assembly();
module shroud_assembly() {
    
difference() {
    top_shroud();
    //cartplate_mount_sinks();
    cartplate_mount_holes();
    //fan_mount_holes();
}

}

//translate([-fx/2,(py-fx)-20,pz+cz])
//fan();
module fan() {
    translate([fx/2,fy/2,fz/2])
    color("gray")
    difference() {
    cube([fx,fy,fz], center=true);
    cylinder(d=fad,h=fz,center=true);
    translate([0,fy,2])
    fan_mount_holes();
    }
}

//fan_body();
module fan_body() {
    translate([0,py/2+fy/2,pz+cz+fz/2])

    cube([fx,fy,fz], center=true);
    fan_mount_holes();
}

module fan_mount_holes() {
     //top
    translate([ftmhx-fx/2,ftmhy-fy/2,0])
    cylinder(d=fmhd, h=fz);
    
    //side
    translate([fsmhx-fx/2,fsmhy-fy/2,0])
    cylinder(d=fmhd, h=fz);

    //lower
    translate([flmhx-fx/2,flmhy-fy/2,0])
    cylinder(d=fmhd, h=fz);
//    translate([ftmhx-fx/2,ftmhy/2-fmhd/2,0])
//    cylinder(d=fmhd, h=fz);
//
//    translate([-ftmhx+fx/2,ftmhy/2-fmhd/2,0])
//    cylinder(d=fmhd, h=fz);
//    
//    translate([-fy/2+flmhx,flmhy-fy/2,0])
//    #cylinder(d=fmhd, h=fz);
}

//cartplate_mounts();
module cartplate_mounts() {
    translate([0,md/2,0]) {
        //lower mounts
        for(x=[-lmox/2:lmox:lmox/2])
            translate([x,0,0])
            cylinder(d=md,h=cz);

        //upper left mount
        translate([-lmox/2, ulmoy, 0])
        cylinder(d=md,h=cz);

        //upper left mount
        translate([lmox/2, urmoy, 0])
        cylinder(d=md,h=cz);
    }
}

//cartplate_mount_holes();
module cartplate_mount_holes() {
    translate([0,md/2,0]) {
        //lower mounts
        for(x=[-lmox/2:lmox:lmox/2])
            translate([x,0,0])
            cylinder(d=hd,h=30);

        //upper left mount
        translate([-lmox/2, ulmoy, 0])
        cylinder(d=hd,h=30);

        //upper left mount
        translate([lmox/2, urmoy, 0])
        cylinder(d=hd,h=30);
    }
}

//cartplate_mount_sinks();
module cartplate_mount_sinks() {
    translate([0,md/2,cz+pz]) {
        //lower mounts
        for(x=[-lmox/2:lmox:lmox/2])
            translate([x,0,0])
            cylinder(d=md,h=30);

        //upper left mount
        translate([-lmox/2, ulmoy, 0])
        cylinder(d=md,h=30);

        //upper left mount
        translate([lmox/2, urmoy, 0])
        cylinder(d=md,h=30);
    }
}

//cartplate_mount_braces();
module cartplate_mount_braces() {
    translate([0,md/2,cz+pz]) {
        //lower mounts
        for(x=[-lmox/2:lmox:lmox/2])
            translate([x,0,0])
            cylinder(d=md+wt*2,h=30);

        //upper left mount
        translate([-lmox/2, ulmoy, 0])
        cylinder(d=md+wt*2,h=30);

        //upper left mount
        translate([lmox/2, urmoy, 0])
        cylinder(d=md+wt*2,h=30);
    }
}

//module base_plate() {
////    translate([0,py/2,pz/2+cz])
////    cube([px, py, pz], center=true);
//    translate([-hclearance/2+md/4,py/2,cz])
//    cheese(px+hclearance-md/2, py, pz, md/2);
//}

module base_plate() {
//    translate([0,py/2,pz/2+cz])
//    cube([px, py, pz], center=true);
    translate([0,py/2,cz])
    cheese(px, py, pz, md/2);
}

//top_shroud();
module top_shroud() {
    difference() {
        translate([-hclearance/2-fx/4+md/4,py/2,cz+pz])
        color("orange") cheese(px+hclearance-md/2-fx/2, py, fz+wt, md/2);
        shroud_cut();
    }
}

//shroud_cut();
module shroud_cut() {
hull() {
    translate([-fx*2,wt,cz+pz])
    cube([(px/2+hclearance+md/2-fx/2),py-wt*2,fz]);


    //fan cut
    translate([fx/2-fx/4,(py-fx)-20+fy+wt,cz+pz])
    cylinder(d=fx/2,h=fz);

    //fan cut
    translate([fx/2-fx/4,py-wt-fx/4,cz+pz])
    cylinder(d=fx/2,h=fz);

    //fan cut
    translate([-fx,py-wt-fx/4,cz+pz])
    cylinder(d=fx/2,h=fz);
}
}

//base_block();
module base_block(){
    translate([lmox/2,0,hclearance]) {
    union() {
        rotate([90,0,180])
        intersection() {
        difference(){
                cylinder(h=py, r=hclearance);

                translate([-hclearance,0,0])
                cube([hclearance*2,hclearance*2,py]);

                translate([0,-hclearance,0])
                cube([hclearance*2,hclearance*2,py]);
            }
            rotate([-90,0,0])
            translate([0,-py/2,-hclearance])
            cheese(hclearance*2,py,cz+pz, md/2);
            }
        }
    }
}

module cheese(x,y,z,r) {
linear_extrude(height=z) offset(-r) offset(r) offset(r) offset(-r)
    square([x,y], center=true);
}