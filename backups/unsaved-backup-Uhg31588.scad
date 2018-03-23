 use <shortcuts.scad>  // see: http://www.thingiverse.com/thing:644830
 use <naca4.scad>

hole = 1;
sf = 0.085;

scale([sf,sf,sf]) difference() {
    union() {
        // Blades
        for (angle=[0:90:360]) {
            rotate([90,40,angle])
            translate([0, 20, 0])
            linear_extrude(height = 175, twist = -25, scale = .4, slices=20)
            translate([-70, 0, 0])
              polygon(points = airfoil_data(4312)); 
        }
        // Hub
        translate([0,0,0]) scale([1,1,1.75]) sphere(d=110, $fn=100);
    }

    // Chop off the bottom
    translate([0,0,-75]) cube([150,150,150], center=true);
    
    // Hollow out the inside
    translate([0,0,0]) scale([1,1,1.75]) sphere(d=90, $fn=100);
    
    // Round the ends
    difference() {
        cylinder(h=200, d=400, center=true);
        cylinder(h=200, d=350, center=true, $fn=100);
    }
}

difference() {
    cylinder(d=hole+1.5, h=7.8, $fn=32);
    cylinder(d=hole, h=7.8, $fn=32);
}

//linear_extrude(height = 100, twist = -20, scale = 0.45, slices=20)
  //polygon(points = airfoil_data(4312)); 
