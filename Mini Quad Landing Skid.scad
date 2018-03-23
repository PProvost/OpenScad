include <my_shapes.scad>

$fn = 64;   // Turn up for final render

// Diameter of skid (same as motor works well)
diameter        = 27;

// Height of skid, wanna stand tall?
height          = 12;

// Diameter of the sphere used for curved bottom of skid
curvature       = 27;

// Motor mounting hole spacing, first dimension
spacing1        = 16;
// Motor mounting hole spacing, second dimension
spacing2        = 19;

// Motor mounting screw size, adjusted for clearance
holesize1       = 6.25;
holesize2        = 3; // [2:M2, 3:M3]

// Additional mounting screw length required to pass through.
length       = 1; // [1:1MM, 2:2MM, 3:3MM, 4:4MM]

holesize2_r      = holesize2/2;
holesize1_r      = holesize1/2;

curvature_r     = curvature/2;
diameter_r      = diameter/2;

// Rotate it for correct printing orientation.
rotate([180, 0, 0]) {
    difference() {
        // Skid body
        intersection() {
            translate([0, 0, curvature_r]) sphere(r=curvature_r);
            cylinder(r=diameter_r, h=height);
        }

        // Mounting holes
        // Screw shafts
        translate([spacing1/2, 0, 0]) cylinder(r=holesize1_r+holesize1_r*0.2, h=height, $fn=20);
        translate([0-spacing1/2, 0, 0]) cylinder(r=holesize1_r+holesize1_r*0.2, h=height, $fn=20);
        translate([0, spacing2/2, 0]) cylinder(r=holesize2_r+holesize2_r*0.2, h=height, $fn=20);
        translate([0, 0-spacing2/2, 0]) cylinder(r=holesize2_r+holesize2_r*0.2, h=height, $fn=20);

        // Style: Cross
        rotate([0, 0, 45]) translate([1.5, 1.5, -2]) rounded_cube([diameter_r, diameter_r, height]);
        rotate([0, 0, -45]) translate([1.5, 1.5, -2]) rounded_cube([diameter_r, diameter_r, height]);
        rotate([0, 0, 135]) translate([1.5, 1.5, -2]) rounded_cube([diameter_r, diameter_r, height]);
        rotate([0, 0, 225]) translate([1.5, 1.5, -2]) rounded_cube([diameter_r, diameter_r, height]);

    }
}
