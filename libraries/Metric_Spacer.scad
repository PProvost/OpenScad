include <shapes.scad>

$fn = 50;

spacer_height = 12;        // mm
screw_size = 3.5;     // mm
wall_thickness = 1; // mm (only used if hex=0)
hex = 0;            // If hex = 0 it will be round, otherwise hex
slip = 1;           // If slip = 1 it will add 0.2mm to the hole diameter to make sure it slides over.


difference() {
    // The outer shape
    if (hex == 0 )
        cylinder(h=spacer_height, d=screw_size + 2*wall_thickness);
    else
        translate([0,0,spacer_height/2]) hexagon(screw_size+2.5,spacer_height);
        
    
    // Make the hole
    if (slip == 1)
        cylinder(h=12, d=screw_size+0.2);
    else
        cylinder(h=12, d=screw_size);
}