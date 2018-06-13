//lol speaker retainer
// the 8ohm speaker included with the Circuit Sword has an offset.

$fn=64;

spkinsidedia=29;

spkinsidez=5.6;

ridgeheight=spkinsidez-4.14;

//shallowend=3.4;
shallowend=6.49/2;

speakerdia=28.25;

contactwidth=6;

oz=4;

pegd=4.6;
opegd=7.6;

id=29.05;
od=32;
iz=4;
mz=8.2;

sd=28.5;
sz=6;


final_part();

//intersection(){
//    cube(od);
//final_part();
//}

module final_part(){
difference() {
    main_body();
    
    //bottom cup
    difference() {
    cylinder(d=od, h=iz);
    cylinder(d=id, h=iz);
    }

    //speaker slug
    speaker_slug();

    
    //peg
    translate([id/2+pegd/2,0,0])
    cylinder(d=pegd, h=mz);

    //outer peg
    translate([id/2+pegd/2,0,mz-(mz-sz)])
    #cylinder(d=opegd, h=mz-sz);
    
    //inner cut
    //cylinder(d=sd-4, h=mz);
    
    translate([0,0,2])
    rotate([90,0,135])
    #cylinder(h=od, d=4);

    }    
}

// main block
module main_body() {
    cylinder(d=od, h=mz);
}

module speaker_slug() {
    cylinder(d=id, h=sz-4);
    translate([0,0,sz-6])
    #cylinder(d1=id, d2=sd-6, h=6);    
}
// ugh lets try again
//// cap end
//translate([0,0,-oz+.6])
//color("green") cylinder(d=od, h=oz);
////translate([0,0,.6])
//difference(){
//translate([0,0,.6])
////#color("green") cylinder(d=od, h=3);
//color("purple") cylinder(d1=id-4, d2=id, h=2.4);
//translate([0,0,3])
//#color("purple") cylinder(d=id, h=4);
//    translate([0,0,.6])
//    difference() {
//    cylinder(d=od, h=4);
//    cylinder(d=id, h=4);
//    }
//}




// starting all over, all this crap below is dumb
//cylinder(d=spkinsidedia, h=spkinsidez-ridgeheight);
//
//translate([0,0,-ridgeheight])
//cylinder(d=spkinsidedia-4, h=spkinsidez);

//linear_extrude(height=.6)
//arc(21/2, 4, 300);

//difference(){
//    translate([0,0,-4])
//    cylinder(h=4, d=spkinsidedia);
//    translate([0,0,-4])
//
//    #cylinder(h=4, d1=speakerdia-3, d2=speakerdia);
//}
//
//translate([0,0,-4])
//cylinder(d=spkinsidedia, h=.6);
//
//difference() {
//    //outside rim
//    cylinder(d=spkinsidedia, h=shallowend);
//
//    //inside shape
//    cylinder(d=speakerdia, h=shallowend);
//    
//    translate([-contactwidth/2,0,0])
////    #cube([contactwidth, spkinsidedia, shallowend]);
//hull() {
//translate([-contactwidth,0,shallowend])
//cube([contactwidth*2, spkinsidedia,0.2]);
//translate([-contactwidth/4,0,])
//cube([contactwidth/2, spkinsidedia,0.2]);
//    
//}    
//
//}
//
//module arc(radius, thick, angle){
//	intersection(){
//		union(){
//			rights = floor(angle/90);
//			remain = angle-rights*90;
//			if(angle > 90){
//				for(i = [0:rights-1]){
//					rotate(i*90-(rights-1)*90/2){
//						polygon([[0, 0], [radius+thick, (radius+thick)*tan(90/2)], [radius+thick, -(radius+thick)*tan(90/2)]]);
//					}
//				}
//				rotate(-(rights)*90/2)
//					polygon([[0, 0], [radius+thick, 0], [radius+thick, -(radius+thick)*tan(remain/2)]]);
//				rotate((rights)*90/2)
//					polygon([[0, 0], [radius+thick, (radius+thick)*tan(remain/2)], [radius+thick, 0]]);
//			}else{
//				polygon([[0, 0], [radius+thick, (radius+thick)*tan(angle/2)], [radius+thick, -(radius+thick)*tan(angle/2)]]);
//			}
//		}
//		difference(){
//			circle(radius+thick);
//			circle(radius);
//		}
//	}
//}
//
