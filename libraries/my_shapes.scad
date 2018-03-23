$fn = 32;

module rounded_cube(size, corner_radius = 1, center=false) {
    width1 = size[0]/2-corner_radius;
    width2 = size[1]/2-corner_radius;
    width3 = size[2]/2-corner_radius;
    
    trans = center ? [0,0,0] : [size[0]/2,size[1]/2,size[2]/2];
    
    translate(trans)
    hull() {
        translate([width1,width2,width3]) sphere(r=corner_radius);
        translate([width1,width2,-width3]) sphere(r=corner_radius);
        translate([width1,-width2,width3]) sphere(r=corner_radius);
        translate([width1,-width2,-width3]) sphere(r=corner_radius);
        translate([-width1,width2,width3]) sphere(r=corner_radius);
        translate([-width1,width2,-width3]) sphere(r=corner_radius);
        translate([-width1,-width2,width3]) sphere(r=corner_radius);
        translate([-width1,-width2,-width3]) sphere(r=corner_radius);
    }
}

// rounded_cube([5,5,5],1);

// cube([5,5,5],2);
