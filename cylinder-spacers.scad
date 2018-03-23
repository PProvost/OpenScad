// Makes spacers with the given id, od, and h


id = 6;
od = 8;
h = 7;

x_count = 2;
y_count = 2;

$fn = 64;

for(x=[1:x_count]) for(y=[1:y_count]) {
  translate([(x-1)*(od+2),(y-1)*(od+2),h/2])
  difference() {
    cylinder(d=od, h=h, center=true);
    cylinder(d=id, h=h+1, center=true);
  }
}