
$fn=32;

// Spool
// color("gray") translate([0,-35,0]) cylinder(d=70, h=16.5);

translate([0,1.5,0]) {
  translate([-4,0,-2]) cylinder(d=4, h=20);
  translate([4,0,-2]) cylinder(d=4, h=20);

  translate([0,0,-1.25])
  minkowski() {
      hull() {
        translate([-4,0,0]) cylinder(d=8,h=0.5);
        translate([4,0,0]) cylinder(d=8,h=0.5);
      }
      sphere(d=1.5);
    }


  translate([0,0,17.25])
  minkowski() {
      hull() {
        translate([-4,0,0]) cylinder(d=8,h=0.5);
        translate([4,0,0]) cylinder(d=8,h=0.5);
      }
      sphere(d=1.5);
    }
}