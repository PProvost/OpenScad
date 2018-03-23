// brushed motor cap

motor_d = 6.5; // Leave some space for printer variance, e.g. 0.25-0.5mm
cap_h = 4;
wall_thickness = 0.5;

union() {
    difference() {
        cylinder(d=motor_d+(2*wall_thickness), h=cap_h, center=true, $fn=50);
        translate([0,0,wall_thickness/2])
            cylinder(d=motor_d, h=cap_h-wall_thickness, center=true, $fn=50);
        translate([0,0,wall_thickness+motor_d/2]) sphere(d=motor_d+2*wall_thickness, $fn=60);
        translate([0,0,wall_thickness]) cube([motor_d*2,1,cap_h], center=true);
    }
    
    translate([0,0,-1.55]) 
        difference() {
            sphere(d=1.25, h=1, center=true, $fn=32);
            translate([0,0,-0.5]) cylinder(d=1.25, h=1, center=true, $fn=32);
        }
        
}