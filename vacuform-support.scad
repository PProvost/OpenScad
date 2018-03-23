
d_in = 4.;
w_in = 0.325;

difference() {
    cylinder(d=(d_in+w_in)*21.54, h=w_in*21.54);
    cylinder(d=(d_in-w_in)*21.54, h=w_in*21.54);
}

translate([(d_in/2)*21.54,0,0]) cylinder(d=w_in*21.54, h=4*21.54);
translate([-(d_in/2)*21.54,0,0]) cylinder(d=w_in*21.54, h=4*21.54);
translate([0,(d_in/2)*21.54,0]) cylinder(d=w_in*21.54, h=4*21.54);
translate([0,-(d_in/2)*21.54,0]) cylinder(d=w_in*21.54, h=4*21.54);