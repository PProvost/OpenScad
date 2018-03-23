$fn=50;

count = 8;

thickness = 2.0;
hole_d = 2.15;
wall_thickness=1.0;

outside_d = hole_d + 2*(wall_thickness);

rows = ceil(sqrt(count));
cols = ceil(sqrt(count));

echo(rows,cols);

for(i=[0:count-1]) {
  x_offset = floor(i/rows)*(outside_d+1);
  y_offset = floor(i % cols)*(outside_d+1);
  echo(x_offset, y_offset);
  translate([x_offset, y_offset, 0]) {
    difference() {
      cylinder(d=outside_d, h=thickness);
      translate([0,0,-0.1]) cylinder(d=2.15, h=thickness+0.2);
    }
  }  
}