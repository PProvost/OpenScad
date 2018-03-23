$fn=128;
height=11.5;
thickness=1.5;
inner_diam=10;

difference() {
translate([0,0,height/2]) cylinder(h=height, d=inner_diam+2*thickness, center=true);

translate([0,0,height/2 + thickness]) cylinder(h=height-thickness, d=inner_diam, center=true);
}