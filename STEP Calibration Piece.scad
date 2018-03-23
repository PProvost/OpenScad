x_len = 100;
y_len = 100;
z_len = 100;

height = 5;
width = 10;
xy_head_len = 10;

///////////////////////////////////////////////////////////////////////
// Text

// X
translate([0,0,height])
    linear_extrude(height=1)
        translate([x_len-2,1])
            rotate([0,0,90])
                text("X", size=7, font = "Liberation Sans");

// Y
translate([0,0,height])
    linear_extrude(height=1)
        translate([1,y_len - xy_head_len])
            text("Y", size=7, font="Liberation Sans");

// Z
translate([0,0,z_len])
    linear_extrude(height=1)
        translate([1.5,1])
            text("Z", size=7, font="Liberation Sans");
            

// Bars
difference() {
    union() {
        // X
        cube([x_len,width,height]);
        translate([x_len-xy_head_len,-5,0]) cube([xy_head_len,2 * width,height]);
        
        // Y
        cube([width,y_len,height]);
        translate([-5,y_len-xy_head_len,0]) cube([2 * width,xy_head_len,height]);
        
        // Z
        cube([width,width,z_len]);
    }
 }
