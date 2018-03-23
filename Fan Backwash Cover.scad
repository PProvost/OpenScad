//
// Derived from "Ormerod fan inlet duct"
//      http://www.thingiverse.com/thing:441099/#files
//
// Customized by http://www.thingiverse.com/PeterProvost
//

cube_length = 30;
cube_width = 30;
cube_height = 6;
wall = 0;
skirt = 2;
overlap = 1;
screw_hole = 3.15;
countersink = false; // set to false for no countersink

// Blades
numblades = 7;
blade_angle = 35;

screw_spacing = cube_width * 0.8; // 50mm->40mm, 40mm->32mm, 30mm->24mm
screw_translate_factor = (cube_width - screw_spacing)/2;

module aerofoil()
{
	radius = 1.3;
  	thickness = .15;
  	angle = asin(0.5/radius);

  	translate([sin(angle) * radius,-cos(angle)*radius,0]){
		union(){
			intersection(){
				difference(){
					circle(r = radius + thickness / 2, $fn = 100);
					circle(r = radius - thickness / 2, $fn = 100);
				}
				scale([2*radius,2*radius,2*radius])
					polygon([[0,0],[-sin(angle),cos(angle)],[sin(angle),cos(angle)]]);

			}
			translate([-sin(angle) * radius,cos(angle)*radius,0])
				circle(r=thickness / 2,$fn=20);
			translate([sin(angle) * radius,cos(angle)*radius,0])
				circle(r=thickness / 2,$fn=20);
      }
   }
}

module foil()
{
	ratio = 1.8;
		translate([-2,-cube_width/2,1])
			rotate([-6,blade_angle,0])
				rotate([-90,0,0])
					linear_extrude(height = cube_width/2,twist = -blade_angle/2, scale = 0.5)
						scale([cube_height *ratio,cube_height *ratio,0])
							aerofoil();
}

module blades()
{
   translate([cube_width/2, cube_length/2, 0]) {
      difference(){
         union(){
            intersection(){
               cylinder(h=cube_height,r=cube_width/2-0.5,$fn=20);
               union(){
                  for ( x = [0 : numblades -1] ){
                     rotate([180,0, x * 360 / numblades]){
                        foil();
                     }
                  }
               }
            }
            #cylinder(h=cube_height,d=cube_width/2+1,$fn=20);
         }
           // translate([0,0,1.5]) cylinder(h= cube_height,d=cube_width/2,$fn=20);
         translate([0,0,1])
            resize([cube_width/2, cube_width/2, cube_height])
                sphere(d=cube_width/2, $fn=48);
      }
   }
}

module screw_hole()
{
    if (countersink) {
        translate([0, 0, -1]) cylinder(2, screw_hole, screw_hole, $fn=20);
        translate([0, 0, 1]) cylinder(1.75, screw_hole, screw_hole/2, $fn=20);
    }
	translate([0, 0, -1]) cylinder(cube_height + 2, screw_hole/2, screw_hole/2, $fn=20);
}


module fan_backwash_plate() {
   difference() {
      translate([-wall,-wall,0])
			cube([cube_length + 2*wall, cube_width + 2*wall, cube_height + skirt]);
      translate([cube_length/2,cube_width/2,-10])
			cylinder(20,cube_length/2-1,cube_length/2-1, $fn=50);

      translate([-.30,-.30,cube_height])
         cube([cube_length + .6,cube_width + .6, cube_height + skirt + overlap]);

      //holes at bottom
      union() {
          translate([screw_translate_factor, screw_translate_factor, 0]) screw_hole();
          translate([screw_translate_factor, cube_width-screw_translate_factor, 0]) screw_hole();
          translate([cube_length-screw_translate_factor, screw_translate_factor, 0]) screw_hole();
          translate([cube_length-screw_translate_factor, cube_width-screw_translate_factor, 0]) screw_hole();
      }
   } // difference
} // module

union() {
   fan_backwash_plate();
	blades(); 
}

