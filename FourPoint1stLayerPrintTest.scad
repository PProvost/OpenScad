
/* [Size] */
size = 85; //[1:500]

circle_diameter = 15; //[1:50]

thickness = 0.2;

module fourPoint1stLayerPrintTest()
{
    rsize = circle_diameter/2;
    xpos= size/2 - rsize;
    ypos = size/2 - rsize;
    
    union() {
        translate([0,ypos,0]){
              cylinder(r=rsize, h=thickness, center = true);
        }
        translate([cos(30)*xpos,-sin(30)*ypos,0]){
              cylinder(r=rsize, h=thickness, center = true);
        }
        translate([-cos(30)*xpos,-sin(30)*ypos,0]){
              cylinder(r=rsize, h=thickness, center = true);
        }
        cylinder(r=rsize, h=thickness, center = true);
        
        translate([0,ypos/2,0]){
              cube([3, size/2, thickness], center = true);
        }
        translate([-cos(30)*xpos/2,-sin(30)*ypos/2,0]){
            rotate([0,0,30])
                cube([size/2, 3, thickness], center = true);
        }
        translate([cos(30)*xpos/2, -sin(30)*ypos/2, 0]){
            rotate([0,0,-30])
                cube([size/2, 3, thickness], center = true);
        }

    }
    
}

fourPoint1stLayerPrintTest();