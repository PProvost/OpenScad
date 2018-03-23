// Use 625ZZ bearings and a smooth GT2 pulley like http://www.thingiverse.com/thing:651552
// M5 screw with spacer for the bearing
// M5 screw with t-nuts for extrusion

$fn = 60;
thickness = 5;

difference() {
  union() {
    // fillet
    translate([0,22,thickness])
      rotate([45,0,0])
      cube ([28,5,5], center=true);
    
    // wrap the extrusion
    translate([0,35,10])
      cube([28,28,20], center=true);

    // main arm
    difference() {
        translate([0,-60,thickness/2])
          cylinder(d=175,h=thickness, center=true);
        translate([0,-96,thickness/2])
          cylinder(d=200,h=thickness+0.1, center=true);
        translate([86,-28,0])
          cylinder(d=100,h=thickness*2.1, center=true);
        translate([-86,-28,0])
          cylinder(d=100,h=thickness*2.1, center=true);
      }

      // right circle
      translate([-50,0,thickness/2]) cylinder(d=25, h=thickness, center=true);
        
      // left circle
      translate([50,0,thickness/2]) cylinder(d=25, h=thickness, center=true);
  }
  
  // cutout right and left bearing screw holes
  translate([-50,0,thickness/2]) {
    cylinder(d=5.25, h=50, center=true);
  }
  translate([50,0,thickness/2]) {
    cylinder(d=5.25, h=50, center=true);
  }

  // cutout the extrusion and screw mounting holes
  translate([0,35,10]) {
    rotate([0,90,0]) cylinder(d=5.2, h=50, center=true);
    translate([0,5,0]) cube([20,30,100], center=true);
  }
}
