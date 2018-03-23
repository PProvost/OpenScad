$fn=32;

module main_body() {
  translate([0,-30,0])
  hull() 
  {
    cylinder(d=5, h=16);
    translate([0,30,0]) cylinder(d=5, h=16);
   // translate([0,35,0]) cylinder(d=5, h=16);
    // translate([48,35,0]) cylinder(d=5, h=16);
    translate([48,30,0]) cylinder(d=5, h=16);
  }
}

difference() {
  // Main body
  main_body();
  translate([3.5,-3.5,-0.1]) scale([0.7,0.7,1.1]) main_body();
}

  // Upper cutout
  hull()
  {
    translate([0,0,0]) cylinder(d=5, h=16);
    translate([0,5,0]) cylinder(d=5, h=16);
  }

  hull()
  {
    translate([48,0,0]) cylinder(d=5, h=16);
    translate([48,5,0]) cylinder(d=5, h=16);
  }

  *hull()
  {
    translate([-20,5,0]) cylinder(d=5, h=16);
    translate([0,5,0]) cylinder(d=5, h=16);
  }
