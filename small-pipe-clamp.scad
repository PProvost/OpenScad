$fn = 64;

id = 9.75;
h=8;
wall = 4;

difference() {
  union() {
    cylinder(d=id+wall, h=h);
    translate([-wall*1.5,id/3,0]) cube([wall*3,id,h]);
  }
  translate([0,0,-0.1]) cylinder(d=id, h=h+0.2);
  translate([-wall/2,0,-0.1]) cube([wall,id*2, id*2]);
  
  translate([wall*1.5-1.25,wall*3-3,h/2]) rotate([0,-90,0]) {
    cylinder(d=6.25, h=2.55, center=true, $fn=6);
    cylinder(d=3.25,h=2*h);
    translate([0,0,wall*3-1.5]) cylinder(d=5.75, h=2.55, center=true);
 }
}
