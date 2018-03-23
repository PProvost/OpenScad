$fn=64;


difference() {
  union() {
    cylinder(d=45, h=8);
    translate([-(45/2),0,0])
      cube([45,65,8]);
  }
  
  translate([0,0,-1]) 
      cylinder(d=6.5, h=10);
  
  translate([-15,58,-1])
  {
    translate([0,0,7.75]) cylinder(d=8.5, h=2);
    cylinder(d=4,h=10);
  }

  translate([15,58,-1])
  {
    translate([0,0,7.75]) cylinder(d=8.5, h=2);
    cylinder(d=4,h=10);
  }

  translate([-15,28,-1])
  {
    translate([0,0,7.75]) cylinder(d=8.5, h=2);
    cylinder(d=4,h=10);
  }

  translate([15,28,-1])
  {
    translate([0,0,7.75]) cylinder(d=8.5, h=2);
    cylinder(d=4,h=10);
  }
}

  
