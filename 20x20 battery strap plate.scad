$fn = 60;

corner_r = 3.5;
dxy = (27/2)-corner_r;
h=2;
screw_d = 2.5;
slot_dx = dxy-3;
slot_dy = dxy-5.5;

cutout_r = 9;
cutout_dxy = (27/2);

difference() 
{
  hull() {
    translate([dxy,dxy,0]) cylinder(r=corner_r, h=h);
    translate([-dxy,dxy,0]) cylinder(r=corner_r, h=h);
    translate([dxy,-dxy,0]) cylinder(r=corner_r, h=h);
    translate([-dxy,-dxy,0]) cylinder(r=corner_r, h=h);
  }

  // screw holes
  translate([0,0,-0.5]) {
    translate([dxy,dxy]) cylinder(d=screw_d, h=h+1);
    translate([-dxy,dxy]) cylinder(d=screw_d, h=h+1);
    translate([dxy,-dxy]) cylinder(d=screw_d, h=h+1);
    translate([-dxy,-dxy]) cylinder(d=screw_d, h=h+1);

    // screw head cutouts
    translate([0,0,1.5]) {
      translate([cutout_dxy,cutout_dxy]) cylinder(r=cutout_r, h=h+1);
      translate([-cutout_dxy,cutout_dxy]) cylinder(r=cutout_r, h=h+1);
      translate([cutout_dxy,-cutout_dxy]) cylinder(r=cutout_r, h=h+1);
      translate([-cutout_dxy,-cutout_dxy]) cylinder(r=cutout_r, h=h+1);
    }
    

    // slots
    hull() {
      translate([slot_dx,slot_dy]) cylinder(d=screw_d, h=h+1);
      translate([slot_dx,-slot_dy]) cylinder(d=screw_d, h=h+1);
    }

    hull() {
      translate([-slot_dx,slot_dy]) cylinder(d=screw_d, h=h+1);
      translate([-slot_dx,-slot_dy]) cylinder(d=screw_d, h=h+1);
    }
  }
}