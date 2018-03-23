$fn=64;

number_of_sticks = 2;
stick_length = 50;

// Note that it prints slower with grooves
snap_grooves = false;

for(i=[1:number_of_sticks]) {

translate([0,i*3.1,0])
difference() {
    rotate([0,90,0]) cylinder(h=stick_length, d=3);

    // Uncomment if you want break off grooves every inch
    
    if (snap_grooves == true) {
    translate([25,0,0])
    rotate([0,90,0])
        rotate_extrude(convexity = 10)
            translate([2, 0, 0])
            circle(r = 1); 
    
    translate([50,0,0])
    rotate([0,90,0])
        rotate_extrude(convexity = 10)
            translate([2, 0, 0])
                circle(r = 1); 
    }
}

}