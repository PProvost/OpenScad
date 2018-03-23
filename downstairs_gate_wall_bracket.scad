height=30;
cutout_l=30;
cutout_w=22.5;
wall=8;

difference() {
  translate([-(wall/2),0,0]) cube([cutout_l+wall,cutout_w+2*wall,height], center=true);
  translate([1,0,0]) cube([cutout_l+1,cutout_w,height+1], center=true);
  translate([-(cutout_l/2+wall/2-0.25),0,0]) rotate([0,90,0]) cylinder(d=5,h=wall+2,$fn=32, center=true);
  translate([-((cutout_l+1)/2-0.1),0,0]) rotate([0,90,0]) cylinder(d1=5,d2=8,h=wall/4,center=true,$fn=32);}

