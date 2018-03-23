$fn=64;

module cutout() {
  difference() {
    hull() {
      translate([0,-5,20]) rotate([-90,0,0]) cylinder(d=4.35, h=30);
      translate([0,-5,10]) rotate([-90,0,0]) cylinder(d=4.35, h=30);
    }

    translate([3.2,-5,19]) rotate([-90,0,0]) cylinder(d=3, h=30);
    translate([-3.2,-5,19]) rotate([-90,0,0]) cylinder(d=3, h=30);
    // translate([-6,0,13.5]) rotate([0,45,0]) cube([2,20,2]);
  }
  
  translate([-5,2.5,19.65]) cube([10,10,10]);
}

difference() {
  union() {
    cube([140,15,5]);
    for(i=[0:6]) {
      translate([20*i+10,0,-5]) hull() {
          translate([0,5,20]) rotate([-90,0,0]) cylinder(d=8, h=5);
          translate([0,5,10]) rotate([-90,0,0]) cylinder(d=8, h=5);
      }
    }
  }

  for(i=[0:6]) {
    translate([20*i+10,0,-1.6]) cutout();
  }
}

