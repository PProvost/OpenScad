use <MCAD/boxes.scad>;

screw_x_cc = 29.5;
screw_y_cc = 56;
hole_size = 3.2;
screw_margin = 4;

front_inset = 10;
back_inset = 10;
plate_h = 3;

camera_angle = 35;

velcro_width = 18;
velcro_thickness = 2.25;

base_size_x = screw_x_cc+hole_size+screw_margin;
base_size_y = (screw_y_cc+hole_size+screw_margin);

difference() {
    $fn = 60;
    union() {
        mount_box();
        translate([screw_x_cc/2,0,0]) roundedBox([hole_size+screw_margin, base_size_y, plate_h], (hole_size+screw_margin)/2, true);
        translate([-screw_x_cc/2,0,0]) roundedBox([hole_size+screw_margin, base_size_y, plate_h], (hole_size+screw_margin)/2, true);
    }
    
    // screw holes
    translate([screw_x_cc/2, screw_y_cc/2, 0]) cylinder(h=plate_h+1, d=hole_size, center=true);
    translate([-screw_x_cc/2, screw_y_cc/2, 0]) cylinder(h=plate_h+1, d=hole_size, center=true);
    translate([screw_x_cc/2, -screw_y_cc/2, 0]) cylinder(h=plate_h+1, d=hole_size, center=true);
    translate([-screw_x_cc/2, -screw_y_cc/2, 0]) cylinder(h=plate_h+1, d=hole_size, center=true);

    // velcro hole
    translate([-(base_size_x+1)/2,0,0])
        rotate([camera_angle,0,0])
            translate([0,1.5,0.5])
                cube([base_size_x+1, velcro_width, velcro_thickness], center=false);
}

module mount_box() {
    difference() {
        translate([0,0,(base_size_x/4)-plate_h/2]) 
            cube([base_size_x, base_size_x,base_size_x/2], true);
        
        translate([-(base_size_x+1)/2,-6,(plate_h/2)+1])
           rotate([camera_angle, 0,0])
                cube([base_size_x+1, base_size_x,base_size_x], false);
        
    }
}