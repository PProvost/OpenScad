
thickness=10;
w=65;
h=80;
cyl_d=68;

difference() {
  cube([w,w,thickness]);
  translate([w/2, w/2-3, cyl_d/2+1]) sphere(d=cyl_d);
}

translate([0,w,0])
rotate([60,0,0])
linear_extrude(height=thickness)
polygon([
  [0,0],
  [w/4,h],
  [3*w/4,h],
  [w,0]
]);

translate([w/2-thickness/2,w-1,0])
rotate([90,0,90])
linear_extrude(height=thickness)
polygon([
  [0,0],
  [34.64,0],
  [34.64,60]
]);

translate([w/4+5,94,68])
sphere(d=10);

translate([3*w/4-5,94,68])
sphere(d=10);