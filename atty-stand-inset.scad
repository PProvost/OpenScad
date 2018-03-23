x_count = 2;
y_count = 2;

atty_h = 10;
atty_d = 26.25;

spacing = 2;

pin_d = 7.5;
pin_h = 6;

$fn = 100;

difference() {
  union() {
    cube_x = (x_count * (atty_d+spacing)) + spacing;
    cube_y = (y_count * (atty_d+spacing)) + spacing;
    translate([-1*(atty_d/2+spacing), -1*(atty_d/2+spacing), 0]) {
      minkowski() {
        cube([cube_x, cube_y, pin_h+atty_h]);
        // cylinder(d=4, h=(pin_h+atty_h)/2);
        sphere(d=4);
      }
    }
  }

  for (x=[1:x_count]) 
    for (y=[1:y_count]) {
        dx = (x-1)*(atty_d+spacing);
        dy = (y-1)*(atty_d+spacing);

      // Atty cutouts
      translate([0,0,pin_h+spacing]) {
        translate([dx, dy, 0]) cylinder(d=atty_d, h=atty_h+0.1);
      }
      
      // Pin cutouts
      translate([0,0,spacing]) {
        translate([dx, dy, 0]) cylinder(d=pin_d, h=pin_h+0.1);
      }

      // Bevel
      translate([dx,dy,pin_h+atty_h+spacing+5.5])
        rotate_extrude() 
          translate([atty_d/2-1,0,0])
            rotate([0,0,45])
              square([10,10], center=true);
  }
}

