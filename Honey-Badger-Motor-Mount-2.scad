$fn=100;

// Parameters
motor_diameter=8.5;
extra_room = 0.1;
wall_thickness = 1.5;
arm_thickness = 1.5;
total_length=28;
screw_hole_diameter = 2.2;
holder_height=8;
bracing_lines = 1; // set to 0 to disable
bump_size=0.4;
bump_offset = 30; // degrees 

// Pre-calculated values
large_end_inner_diameter = motor_diameter + extra_room;
small_end_radius = screw_hole_diameter/2 + wall_thickness;
large_end_radius = large_end_inner_diameter/2 + wall_thickness;
holder_diameter = large_end_inner_diameter + 2*wall_thickness;
arm_length = total_length-(small_end_radius+large_end_radius);


difference() {
    union() {
        // Large end cylinder
        cylinder(h=holder_height, d=holder_diameter);
        //translate([0,0,holder_height]) sphere(d=holder_diameter);

        
        // Small end cylinder
        translate([0,arm_length,0])
            cylinder(h=arm_thickness, d=screw_hole_diameter + 2*wall_thickness);
        
        linear_extrude(height=arm_thickness) 
            polygon(points= [[holder_diameter/2,0], 
                            [-(holder_diameter/2),0],
                            [-small_end_radius,arm_length],
                            [small_end_radius,arm_length]]);

        // Arm support wedge
        translate([arm_thickness,(holder_diameter-wall_thickness)/2,arm_thickness]) rotate([0,-90,0]) 
            linear_extrude(height=2*arm_thickness)
            polygon([[0,0], [arm_length/3,0], [0,arm_length/3]]);
        
    }

    // Cut off the bottom in a nice flat cup
    // translate([0,0,holder_height+holder_diameter/2-wall_thickness]) cylinder(d=holder_diameter, wall_thickness);

    // Chamfer the opening
    // NOTE: Not sure about this translate either
    translate([0,0,-(wall_thickness/2)])
        cylinder(r2=0, r1=large_end_radius, h=large_end_radius);

    // Cutout the motor hole
    translate([0,0,0])
        cylinder(h=holder_height, d=large_end_inner_diameter);
    //translate([0,0,holder_height-arm_thickness])
        sphere(d=large_end_inner_diameter);
    
    // Cutout the screw hole
    translate([0,arm_length,-1]) 
        cylinder(h=arm_thickness*4, d=screw_hole_diameter);
    
    // Cut out the expansion slot
    translate([-(wall_thickness/2), -(large_end_radius+wall_thickness), 0]) 
        cube([wall_thickness, motor_diameter, holder_height+large_end_radius]);

    // Cut out the wire pass-thru slot
    translate([-(wall_thickness/2), motor_diameter/2, /*-wall_thickness*/]) 
        cube([wall_thickness, wall_thickness*0.75, holder_height]);

    //translate([0, (holder_diameter+arm_length-motor_diameter)/3, 0]) cylinder(h=arm_thickness, d=motor_diameter/1.5);
    //translate([0, (holder_diameter+arm_length-motor_diameter)/2, 0]) cylinder(h=arm_thickness, d=motor_diameter/2);

}

// "Feet"
// translate([0,wall_thickness,holder_height+holder_diameter/2-wall_thickness+1]) cylinder(h=2, d=2, center=true);

// Holder "bumps"
translate([(large_end_inner_diameter/2) * cos(270-bump_offset), (large_end_inner_diameter/2) * sin(270-bump_offset),wall_thickness]) sphere(bump_size);
translate([(large_end_inner_diameter/2) * cos(270+bump_offset), (large_end_inner_diameter/2) * sin(270+bump_offset),wall_thickness]) sphere(bump_size);
