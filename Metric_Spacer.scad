$fn = 50;

height = 12;        // mm
screw_size = 3;     // mm
wall_thickness = 2; // mm
hex = 0;            // If hex = 0 it will be round, otherwise hex
slip = 1;           // If slip = 1 it will add 0.2mm to the hole diameter to make sure it slides over.


difference() {
    cylinder(h=12, d=screw_size + 2*wall_thickness);
    if (slip == 1)
        cylinder(h=12, d=screw_size+0.2);
    else
        cylinder(h=12, d=screw_size);
}