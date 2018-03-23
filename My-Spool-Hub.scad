
// Main parameters

hub_d = 54.75;  // Diameter of hub. Depending on your printer, you may need to add or subtract a bit (e.g. 53.5 or 54.5 for a 54mm hole)

// For my printer:
//   Inland spools (54mm): hub_d = 54.75

hub_h = 12;  // Height of hub. 12mm is pretty good for most spools (assuming one on each side.
hole_d = 8.5; // Diameter of axle hole. Leave some room, e.g. >8.25 for 8mm rod.
num_spokes = 7;     // How many spokes? Bare minimum is three, but more are fine

// Other parameters
wall_thickness = 3.5; // Thickness of the walls
hub_lip_h = 2;
hub_lip_r = 2;

$fn = 120; // resolution of circles

// calculated values
step = 360 / num_spokes;

// Outer
difference() {
    union() {
        cylinder(hub_h, d1=hub_d, d2=hub_d * 0.98, true);
        cylinder(hub_lip_h, d=hub_d+2*hub_lip_r, true);
    }

    cylinder(hub_h, d=hub_d - 2*wall_thickness, true);
}


// center
difference() {
    cylinder(hub_h, d=hole_d+2*wall_thickness, true);
    cylinder(hub_h, d=hole_d, true);
}

// spokes
for (i=[0:step:360]) {
    rotate([0,0,i])
    translate([0,hub_d/4+wall_thickness/2,hub_h/2])
        cube([wall_thickness, hub_d/2-2*wall_thickness, hub_h], true);
}