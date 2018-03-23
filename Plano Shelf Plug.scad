$fn=64;

difference() {
  cylinder(d=41, h=36);
  translate([0,0,-1]) cylinder(d=39,h=36);
  translate([0,0,34/2]) cube([2, 50, 35], center=true);
}

translate([0,0,36]) cylinder(d=46, h=4);