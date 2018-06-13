//lol speaker retainer
// the 8ohm speaker included with the Circuit Sword has an offset.

$fn=64;

spkinsidedia=29;

spkinsidez=5.6;

ridgeheight=spkinsidez-4.14;

shallowend=3.4;

speakerdia=27;

//cylinder(d=spkinsidedia, h=spkinsidez-ridgeheight);
//
//translate([0,0,-ridgeheight])
//cylinder(d=spkinsidedia-4, h=spkinsidez);

difference() {
    cylinder(d=spkinsidedia, h=shallowend);
    cylinder(d1=speakerdia, d2=speakerdia-2, h=shallowend);
}