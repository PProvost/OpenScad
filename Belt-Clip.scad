$fn=50;

translate([-3.5,0,0]) cylinder(d=4,h=9);

translate([-5.5,0,0]) cube([3,35,9]);

translate([-0,35,0])
difference() {
  cylinder(d=11, h=9);
  translate([0,0,-0.1]) cylinder(d=5, h=9.2);
  translate([-6,-12,-0.1]) cube([12,12,12.2]);
}

translate([2.5,-3,0]) cube([3,38,9]);

translate([8.5,-3,0]) 
rotate([0,0,180])
difference() {
  cylinder(d=12, h=9);
  translate([0,0,-0.1]) cylinder(d=6, h=9.2);
  translate([-6,-12,-0.1]) cube([12,12,12.2]);
}

translate([11.5,-3,0]) cube([3,10,9]);

translate([12.5,7,0]) cylinder(d=4,h=9);