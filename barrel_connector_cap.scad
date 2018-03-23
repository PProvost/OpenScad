inner_diam = 5.45;
inner_len = 11.85;

wall_thickness = 1.6;

$fn = 64;

outer_diam = inner_diam+(2*wall_thickness);

difference() {
    cylinder(d=outer_diam, h=inner_len+wall_thickness, center=true);
    translate([0,0,wall_thickness+0.1]) cylinder(d=inner_diam, h=inner_len+0.1, center=true);
    translate([0,0,inner_len/2 - 0.5]) cylinder(d1=0.1, d2=outer_diam, h=inner_diam, center=true);
}


translate([0,0,-inner_len/2]) 
rotate_extrude(angle=360)
    translate([(inner_diam/2)+wall_thickness, 0, 0])
        circle(d=wall_thickness);