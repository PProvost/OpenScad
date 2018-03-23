
motor_d = 6.2;
inside_h = 10;
thickness = 0.8;
cube_w = motor_d + 3*thickness;

difference() {
    rounded_cylinder(d=motor_d+2*thickness, h=inside_h);
    rounded_cylinder(d=motor_d, h=inside_h);

    translate([-cube_w/2,2*thickness,inside_h-2*thickness]) cube([cube_w, cube_w, cube_w]);
}


module rounded_cylinder(d, h) {
    translate([0,0,h]) sphere(d=d, $fn=60);
    cylinder(d=d, h=h, $fn=60);
}