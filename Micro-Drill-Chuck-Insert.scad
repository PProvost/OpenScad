id=2.5;
gap=0.75;

difference() {
  union() {
    translate([0,0,21]) cylinder(h=5, d1=6.15, d2=id+2, $fn=50);
    cylinder(d=6.15, h=21, $fn=50);
    cylinder(d=7.25, h=6.86, $fn=6);
  }
  
  translate([0,0,6.85]) cylinder(d1=id+1, d2=id, h=20, $fn=50);
  
  translate([-5,-gap/2,10]) cube([10,gap,17]);
  translate([-gap/2,-5,10]) cube([gap,10,17]);
  
  translate([0,0,23.5]) cylinder(d1=0.1, d2=8, h=6, $fn=32);
}