$fn=50;

w=50;
l=32;
h=10;
x_offset=-15;
y_offset=6;

difference() {
  translate([-w/2,-l/2,0]) cube([w,l,h]);
  translate([x_offset,y_offset,0]) translate([0,0,-0.1]) cylinder(d=7.75, h=h+0.2);
  
  translate([-31.5/2,-10,0]) {
    translate([0,0,-0.1]) cylinder(d=4, h=h+0.2);
    translate([31.5,0,-0.1]) cylinder(d=4, h=h+0.2);
  }
  
  rotate([0,0,-30]) translate([-50,10,-0.1]) cube([100,100,h+0.2]);
  
  translate([x_offset-2, y_offset,-0.1]) cube([4,12,h/2+0.1]);
}