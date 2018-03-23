cell_count = 4; // 3=3S, 4=4S, etc.

$fn=65;

show = "all"; // "all", "body", "jst", "holes", "cutout"

difference() {

    // body
    if (show=="body" || show=="all") {
        translate([0,0,0]) {
            translate([0,-0.5,4.5])
                cube([17.25,9,6], true);
            
            difference() {
                translate([0,4,4.5])
                    scale([1,0.75,1]) cylinder(h=6, d=17.25, center=true);
                translate([0,-17.25/2,4.5])
                    cube([17.25,17.25,6], true);
            }
            
        }
    }

    // JST-XH 5 (4S)
    if (show=="jst" || show=="all") {
        union() {
            translate([0,0,4.25])
                cube([13.8,4.65,8], true);

            translate([0,0.5,0.5])
                cube([15,5,1],true);

            translate([0,-2.5,0.5])    
                cube([10,1,1], true);

            translate([4.75,-2.75,2.5])    
                cube([1.75,1.25,10], true);
                
            translate([-4.75,-2.75,2.5])    
                cube([1.75,1.25,10], true);

        }
    }

    // Wire holes
    if (show=="holes" || show=="all") {
        translate([2.5,6.5,5]) 
            cylinder(d=4.85, h=8, center=true);

        translate([-2.5,6.5,5]) 
            cylinder(d=4.85, h=8, center=true);
    }

    if (show=="cutout" || show=="all") {
        // Cutout
        translate([0,11.5,4.5]) {
            difference() {
                cylinder(d=20,h=8, center=true);
                
                translate([5,-5.5,0])
                    cylinder(d=10,h=8,center=true);
                translate([-5,-5.5,0])
                    cylinder(d=10,h=8,center=true);
                
                translate([0,-5,0])
                    cube([10,10,10], true);


            }
            
            translate([0,-2.5,0])
            scale([1,1.25,1])
            cylinder(d=5,h=8,center=true);
            
            translate([0,0,0])
                cylinder(d=6,h=8,center=true);
            
            /*
            difference() {
                translate([0,-12,0])
                    rotate([0,0,45])
                        cube([12,12,8], true);
                
                translate([0,-2,0])
                    cube([10,5,8], true);
                
                translate([0,-16,0])
                    cube([20,20,8], true);
            }
            */

        }
    }

}


