$fn=100;

// Parameters
motor_diameter=7;
extra_room = 0.25;
wall_thickness = 1.5;
arm_thickness = 1.5;
total_length=27;
screw_hole_diameter = 2;
holder_height=15;
bracing_lines = 1; // set to 0 to disable

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
        
        // Small end cylinder
        translate([0,arm_length,0])
            cylinder(h=arm_thickness, d=screw_hole_diameter + 2*wall_thickness);
        
        if (bracing_lines == 1) {
            difference() {
                // Arm polygon
                linear_extrude(height=arm_thickness*1.5) 
                    polygon(points= [[holder_diameter/2,0], 
                                    [-(holder_diameter/2),0],
                                    [-small_end_radius,arm_length],
                                    [small_end_radius,arm_length]]);
                
                // Cutout the arm polygon to make bracing lines
                translate([0,0,arm_thickness])
                    linear_extrude(height=arm_thickness*2) 
                        polygon(points= [[holder_diameter/2-arm_thickness/2,0], 
                                    [-(holder_diameter/2-arm_thickness/2),0],
                                    [-(small_end_radius-arm_thickness/2),arm_length-arm_thickness],
                                    [small_end_radius-arm_thickness/2,arm_length-arm_thickness]]);
                
                // Cleanup the ends so they don't block the screw hole
                translate([0, arm_length-arm_thickness, arm_thickness+small_end_radius])
                    cube([3*small_end_radius, small_end_radius+arm_thickness/2, 2*small_end_radius], center=true);
                
                // Chamfer the edge of the brace by the screw hole
                // NOTE: This translate isn't quite right, but it seems to work
                translate([0,arm_length-(small_end_radius+arm_thickness/3),arm_thickness+sqrt(pow(3*small_end_radius,2)/2)]) rotate([45,0,0]) cube(3*small_end_radius, center=true);
                
            }
        } else {
            linear_extrude(height=arm_thickness) 
                polygon(points= [[holder_diameter/2,0], 
                                [-(holder_diameter/2),0],
                                [-small_end_radius,arm_length],
                                [small_end_radius,arm_length]]);
        }
    }

    // Chamfer the top
    // NOTE: Not sure about this translate either
    translate([0,0,holder_height - large_end_radius + (wall_thickness/2)]) cylinder(r1=0, r2=large_end_radius, h=large_end_radius);

    // Cutout the motor hole
    translate([0,0,arm_thickness])
        cylinder(h=20, d=large_end_inner_diameter + extra_room);
    
    // Cutout the screw hole
    translate([0,arm_length,-1]) 
        cylinder(h=arm_thickness*4, d=screw_hole_diameter);
    
    // Cut out the expansion slot
    translate([-(wall_thickness/2), large_end_radius/2, arm_thickness]) 
        cube([wall_thickness, wall_thickness*2, holder_height]);

}
