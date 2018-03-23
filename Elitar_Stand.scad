$fn=32;


hull() {
  translate([0,6,0]) cylinder(d=4,h=40);
  cylinder(d=4, h=40);
}

hull() {
  cylinder(d=4, h=40);
  translate([42,0,0]) cylinder(d=4, h=40);
}

translate([42,0,0])
hull() {
  cylinder(d=4, h=40);
  rotate([0,0,65]) translate([60,0,0]) cylinder(d=4, h=40);
}

hull() {
  translate([42,0,0]) rotate([0,0,65]) translate([60,0,0]) cylinder(d=4, h=40);
  translate([100,0,0]) cylinder(d=4, h=40);
}

translate([67.25,54.5,0])
rotate([0,0,-30])
  difference() {
    hull() {
      translate([0,0,0]) cylinder(d=4, h=40);
      translate([-6,0,0]) cylinder(d=4, h=40);
    }
    
    // translate([-18.5,2,20]) rotate([-90,0,-30]) cylinder(d=30,h=10);
    
    translate([-7,-5,10])
    rotate([0,0,90]) hull() {
      translate([0,0,20]) rotate([0,90,0]) cylinder(d=8, h=10);
      translate([0,0,0]) rotate([0,90,0]) cylinder(d=8, h=10);
    }
}