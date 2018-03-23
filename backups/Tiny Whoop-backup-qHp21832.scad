use <naca4.scad>;

/* These are close to a stock Inductrix:
  motor_d = 6.15;
  duct_r = 17.65;
  duct_h = 10;
  duct_spacing = 23; // center offset from centerline
  screw_spacing = 18; // center offset from centerline
*/

motor_d = 7.15;
duct_r = 21;
duct_h = 10;
duct_spacing = 23; // center offset from centerline
screw_spacing = 18; // center offset from centerline

union() {
    frame();
    four_ducts(duct_r,duct_h,duct_spacing);
}

//full_duct(r=duct_r, h=duct_h);
// stator(6,1,3,6.15);

// Frame
module frame() {
    arm_w = 1.0;
    arm_h = 3.0;
    beam_w = 1.0;
    beam_h = 2.5;
    screw_d = 1.5;
    difference() {
        union() {
            // Arms
            rotate([0,0,45]) translate([0,0,-(arm_h/2)]) cube([35,arm_w,arm_h], center=true);
            rotate([0,0,-45]) translate([0,0,-(arm_h/2)]) cube([35,arm_w,arm_h], center=true);
            // Frame beams
            translate([screw_spacing,0,-(beam_h/2)]) rotate([0,0,90]) cube([18,beam_w,beam_h], center=true);
            translate([-screw_spacing,0,-(beam_h/2)]) rotate([0,0,90]) cube([18,beam_w,beam_h], center=true);
            translate([0,screw_spacing,-(beam_h/2)]) rotate([0,0,0]) cube([18,beam_w,beam_h], center=true);
            translate([0,-screw_spacing,-(beam_h/2)]) rotate([0,0,0]) cube([18,beam_w,beam_h], center=true);
            // Screw hole points
            translate([screw_spacing,0,-(beam_h/2)]) cylinder(d=screw_d+2,h=beam_h,center=true, $fn=32);
            translate([-screw_spacing,0,-(beam_h/2)]) cylinder(d=screw_d+2,h=beam_h,center=true, $fn=32);
            translate([0,screw_spacing,-(beam_h/2)]) cylinder(d=screw_d+2,h=beam_h,center=true, $fn=32);
            translate([0,-screw_spacing,-(beam_h/2)]) cylinder(d=screw_d+2,h=beam_h,center=true, $fn=32);
            // Rubber band pins
            translate([screw_spacing+3, 0, -(beam_h/2)]) rotate([0,90,0]) cylinder(d=1.5, h=3, center=true, $fn=16);
            translate([-(screw_spacing+3), 0, -(beam_h/2)]) rotate([0,90,0]) cylinder(d=1.5, h=3, center=true, $fn=16);
        }
        
        // Round off the beams where they join the ducts
        translate([duct_spacing,duct_spacing,-2])
            cylinder(h=5,r=duct_r-1,center=true, $fn=32);
        translate([duct_spacing,-duct_spacing,-2])
            cylinder(h=5,r=duct_r-1,center=true, $fn=32);
        translate([-duct_spacing,duct_spacing,-2])
            cylinder(h=5,r=duct_r-1,center=true, $fn=32);
        translate([-duct_spacing,-duct_spacing,-2])
            cylinder(h=5,r=duct_r-1,center=true, $fn=32);
        
        // Screw holes
        translate([screw_spacing,0,-2.5]) cylinder(d=screw_d,h=5, center=true, $fn=32);
        translate([-screw_spacing,0,-2.5]) cylinder(d=screw_d,h=5, center=true, $fn=32);
        translate([0,screw_spacing,-2.5]) cylinder(d=screw_d,h=5, center=true, $fn=32);
        translate([0,-screw_spacing,-2.5]) cylinder(d=screw_d,h=5, center=true, $fn=32);
    }
}

module four_ducts(r, h, spacing) {
    // Ducts
    translate([spacing,spacing,0]) rotate([0,0,-45]) full_duct(r,h);
    translate([spacing,-spacing,0]) rotate([0,0,-135]) full_duct(r,h);
    translate([-spacing,spacing,0]) rotate([0,0,45]) full_duct(r,h);
    translate([-spacing,-spacing,0]) rotate([0,0,135]) full_duct(r,h);
}

module full_duct(r=10, h=15) {
    stator_l = r-(motor_d-2);
    rotate([0,0,0/3*360]) stator(stator_l, 1, 2.5, motor_d);
    rotate([0,0,1/3*360]) stator(stator_l, 1, 2.5, motor_d);
    rotate([0,0,2/3*360]) stator(stator_l, 1, 2.5, motor_d);
    motor_mount(motor_d, 8);
    duct(r,h);
}

module stator(l, w, h, hub_d) {
    translate([-w/2, -hub_d/2,-h])
        rotate([90,0,0])
            difference() {
                cube([w,h,l]);
                translate([0,h-0.5,0]) rotate([0,0,45]) cube([w,w,l]);
                translate([1,h-0.5,0]) rotate([0,0,45]) cube([w,w,l]);
            }
}

module motor_mount(id, h) {
    difference() {
    translate([0,0,-h])
        difference() {
            cylinder(d=id+2, h=h, $fn=32);
            cylinder(d=id, h=h,$fn=32);
        }
    translate([0,0,-6]) cube([id+2,1,4], center=true);
    }
}

module duct(r=10, h=12, naca=7312) {
    translate([0,0,h/2])
        rotate_extrude(angle=360, convexity=2, $fn=100)
            translate([r,0,0])
                rotate([0,-180,85])
                    polygon(points = airfoil_data(naca, h, 81)); 
}
















