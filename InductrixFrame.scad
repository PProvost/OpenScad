// Easy(ish) to print Inductrix frame
// 2016 by James R O'Keane
// 
// License is CC-BY-NC-ND


wall_thickness = 0.8;
motor_to_motor_spacing = 45;
    
m2m_spacing2 = motor_to_motor_spacing / 2;

motor_mount_height = 5;
motor_mount_inner_diameter = 6.35; // bigger for ABS, smaller for PLA
lower_motor_center_brace = 7;
lower_motor_brace_height = 2.5;

duct_thickness = wall_thickness;
duct_inner_diameter = 33;
duct_height = 9;
duct_angle_height = 2.5;
duct_angle_width = 1;

duct_rad = (duct_inner_diameter+duct_thickness)/2;

brace_height = duct_height - duct_angle_height - wall_thickness*2;
brace_len = (m2m_spacing2 - duct_rad); 

battery_width = 11;
battery_height = 7;
battery_depth = 16;

frame_hole_spacing = 36;
frame_hole_radius = 0.6;

canopy_height = 7;
canopy_width = frame_hole_spacing*0.5;
canopy_depth = frame_hole_spacing + wall_thickness*3;

canopy_peg = false;
canopy_peg_diameter = 1.5;

smoothness = 64;

module motor_mount() {
    $fn = smoothness *2;
    difference() {
        cylinder (h = motor_mount_height, r=(motor_mount_inner_diameter/2)+wall_thickness, 
                  center = true);
        cylinder (h = motor_mount_height+1, r1=motor_mount_inner_diameter/2+0.3, r2=motor_mount_inner_diameter/2, 
                  center = true);
    }
}

module fan_duct() {
    $fn = smoothness*2;
    rad = duct_inner_diameter/2;
    ht = duct_height;
    htc = duct_height - duct_angle_height;
    rc = rad + duct_angle_width;
    t = duct_thickness;
    rotate_extrude() 
        // [Peter Provost] Added 0.25 to the 5th point X to make the shape a little more like
        // NACA 7312 airfoil
        polygon( points=[ [rad,0], [rad,htc], [rc, ht],  
                          [rc+t, ht], [rad+t+0.25,htc-0.5], [rad+t,0]]);
    
    translate( [0, 0, motor_mount_height/2] ) 
        motor_mount();
    
    mm2 = (motor_mount_inner_diameter + wall_thickness)/2;
    duct_brace_len = rad - mm2;
    duct_brace_height = motor_mount_height - wall_thickness*1.5;
    
    for (b = [0:2]) {
        rotate([0, 0, b*120])
            translate( [mm2, -t/2, 0] ) 
                cube([duct_brace_len,t,duct_brace_height]);
    }
}

module frame_brace() {
    $fn = smoothness;
    
    translate([0,0,brace_height/2]) {
        translate([0,0,1.25]) {
            difference() {
                // [Peter Provost] Modified so the cylinder sticks up 2.5mm higher than
                // the brace so you can slide the rubber grommets over the top.
                union() {
                    cylinder (h = brace_height+2.5, r=wall_thickness/1.25+frame_hole_radius, center = true);
                    // [Peter Provost] This helps support the cylinder sticking above 
                    // the brace so it prints better. Cut them off after printing.
                    translate([0,0,2.45]) cube([brace_len, wall_thickness, 2.5], center=true);
                }
                cylinder (h = brace_height+3, r=frame_hole_radius, 
                          center = true);
            }
        }
        
        offset = (brace_len+wall_thickness)/2;
        translate( [offset, 0, 0] )
            cube([brace_len,wall_thickness,brace_height],center=true);
        
        translate( [-offset, 0, 0] )
            cube([brace_len,wall_thickness,brace_height],center=true);
    }
}

module lower_motor_bracket() {
    $fn = smoothness;
    
    translate( [m2m_spacing2, m2m_spacing2, motor_mount_height/2] ) 
        motor_mount();
    translate( [m2m_spacing2, -m2m_spacing2, motor_mount_height/2] ) 
        motor_mount();
    translate( [-m2m_spacing2, -m2m_spacing2, motor_mount_height/2] ) 
        motor_mount();
    translate( [-m2m_spacing2, m2m_spacing2, motor_mount_height/2] ) 
        motor_mount();
    
    translate( [0, 0, lower_motor_brace_height/2] )
        cube([lower_motor_center_brace,lower_motor_center_brace,lower_motor_brace_height],center=true);
    
    diag_len = (motor_to_motor_spacing * 1.414) - 
                motor_mount_inner_diameter - wall_thickness;
    
    translate( [0, 0, lower_motor_brace_height/2] )
        rotate([0, 0, 45])
            cube([diag_len,wall_thickness,lower_motor_brace_height],center=true);
    
    translate( [0, 0, lower_motor_brace_height/2] )
        rotate([0, 0, -45])
            cube([diag_len,wall_thickness,lower_motor_brace_height],center=true);
}

module frame() {
    $fn = smoothness/2;

    translate( [m2m_spacing2, m2m_spacing2, 0] ) 
        mirror([1,0,0]) 
            fan_duct();
    translate( [m2m_spacing2, -m2m_spacing2, 0] ) 
        mirror([1,0,0]) 
            fan_duct();
    translate( [-m2m_spacing2, m2m_spacing2, 0] ) 
        fan_duct();
    translate( [-m2m_spacing2, -m2m_spacing2, 0] ) 
        fan_duct();
    
    fhs2 = frame_hole_spacing/2;
    
    translate( [0, fhs2, 0] ) 
        frame_brace();
    translate( [0, -fhs2, 0] ) 
        frame_brace();
    
    translate( [fhs2, 0, 0] ) 
        rotate([0, 0, 90])
            frame_brace();
    translate( [-fhs2, 0, 0] ) 
        rotate([0, 0, 90])
            frame_brace();

    if (canopy_peg == true) {
        pegOff = fhs2+brace_height;
        pegRad = canopy_peg_diameter/2;
        translate( [pegOff-wall_thickness*2, 0, brace_height-wall_thickness] ) 
            rotate( [0,90,0] )
                cylinder(h = brace_height, r=pegRad, center = true);

        translate( [-pegOff+wall_thickness*2, 0, brace_height-wall_thickness] ) 
            rotate( [0,90,0] )
                cylinder(h = brace_height, r=pegRad, center = true);
    }

    hole = battery_width-wall_thickness*5;
    translate( [0, 0, wall_thickness/2] ) {
        difference() {
            cube([battery_width,frame_hole_spacing+duct_thickness,wall_thickness],center=true);
            translate( [0, battery_width, 0] )
                cube([hole,hole,wall_thickness*2],center=true);
            translate( [0, -battery_width, 0] )
                cube([hole,hole,wall_thickness*2],center=true);
            translate( [0, 0, 0] )
                cube([hole,hole,wall_thickness*2],center=true);
        }
        
        // [Peter Provost] Rubber band clips for battery
        translate([0,battery_width/2,0]) difference() {
            translate([0,0,1]) cube([battery_width+3,2,wall_thickness+2], center=true);
            translate([0,0,1+wall_thickness]) cube([battery_width+1, 3, wall_thickness+2], center=true);
        }
        translate([0,-battery_width/2,0]) difference() {
            translate([0,0,1]) cube([battery_width+3,2,wall_thickness+2], center=true);
            translate([0,0,1+wall_thickness]) cube([battery_width+1, 3, wall_thickness+2], center=true);
        }
        
    }
        
    
}

module battery_clip() {
    
    linear_extrude(height = battery_depth)
        difference() {
            square([battery_width+wall_thickness*2,battery_height+wall_thickness*3],center=true);
            square([battery_width,battery_height+wall_thickness],center=true);
            translate( [0, wall_thickness*2, 0] ) 
                square([battery_width-wall_thickness*4,battery_height],center=true);
        }
}

module canopy() {
    $fn = smoothness * 1.5;
    difference() {
        
        union() {
            resize( [canopy_width, canopy_depth, canopy_height] )
                sphere( frame_hole_spacing );
            translate( [0, -canopy_depth/6, canopy_height/5] )
                resize( [canopy_width/3, canopy_depth/2, canopy_height] )
                    sphere( frame_hole_spacing );
            
            fin = (canopy_depth+canopy_width)*0.45;
            translate([0,0,wall_thickness])
            rotate([90,0,90])
            translate([0,0,-wall_thickness/2])
            linear_extrude(height = wall_thickness)
            polygon( points=[ [0,0], 
                              [fin*0.65,fin], 
                              [fin, fin],  
                              [fin*0.7, 0] ]);
            
            resize( [canopy_depth+wall_thickness, canopy_width*.8, canopy_height/2] )
                sphere( frame_hole_spacing );
            
        }
        translate( [0, 0, -wall_thickness] )
        resize( [canopy_width, canopy_depth, canopy_height] )
            sphere( frame_hole_spacing );
        
        translate( [0, 0, -canopy_height/2] )
        cube( [canopy_depth, canopy_depth, canopy_height], center=true );
        
        fhs2 = frame_hole_spacing/2;
        translate( [fhs2, 0, 0] )
        cylinder (h = canopy_height*2, r=frame_hole_radius, 
                      center = true);
        translate( [-fhs2, 0, 0] )
        cylinder (h = canopy_height*2, r=frame_hole_radius, 
                      center = true);
    }
}

*color("SkyBlue")
   translate([0,0,motor_mount_height+wall_thickness])
   canopy();

color("white")
    frame();

//color("cyan")
 //   translate( [0, 0, -motor_mount_height*3] )      
 //       lower_motor_bracket();

*color("SpringGreen")
   translate( [0, (battery_depth/2), -((battery_height-wall_thickness)/2)] )
    rotate([90, 0, 00])
        battery_clip();
