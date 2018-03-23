pipe_d = 21.7;
base_thick = 5;

$fn=60;

difference() {
  cylinder(d=pipe_d*4, h=base_thick);
  translate([pipe_d,pipe_d,0]) cylinder(d=3.25,h=base_thick+0.2);
  translate([pipe_d,-pipe_d,0]) cylinder(d=3.25,h=base_thick+0.2);
  translate([-pipe_d,pipe_d,0]) cylinder(d=3.25,h=base_thick+0.2);
  translate([-pipe_d,-pipe_d,0]) cylinder(d=3.25,h=base_thick+0.2);
}

// translate([0,0,base_thick-0.1]) 
difference() {
  cylinder(d=pipe_d+4, h=50);
  translate([0,0,-0.1]) cylinder(d=pipe_d, h=50.2);
}

