tray_h = 10;
tray_w = 25;
tray_l = 35;

hex_circumcribed_d = 7.25; // in mm. Increase if too tight
spacing = 1;

module bit_hole() {
//   translate([0,0,tray_h-8]) 
//     linear_extrude(height=tray_h) 
        rotate([0,0,90])
          circle(d=hex_circumcribed_d, $fn=6);
}

for(x=[0:hex_circumcribed_d+spacing:tray_w])
  for (y=[0:hex_circumcribed_d+spacing:tray_l])
    translate([x,y,0]) {
      echo(x,y);
      bit_hole();
    }
 