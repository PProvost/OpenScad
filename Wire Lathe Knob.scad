use <MCAD/involute_gears.scad>;

Big_teeth=14;
Small_teeth=7;

extra_space = 1; // set to zero for normal fit

function get_pitch_radius(number_of_teeth, circular_pitch) = number_of_teeth * circular_pitch / 360;

big_pitch_radius = get_pitch_radius(Big_teeth, 700);
small_pitch_radius = get_pitch_radius(Small_teeth, 700);

// translate([0,0,-10]) color("red") cylinder(d=46.25, h=10);

module big_gear(bore=8.1) {
  difference() {
    gear (
      number_of_teeth = 21,
      circular_pitch = 360,
      pressure_angle=26,
      gear_thickness = 7,
      rim_thickness = 7,
      hub_thickness = 16,
      hub_diameter = 18,
      bore_diameter=bore,
      circles=0, $fn=50);
    translate([0,0,12]) rotate([0,90,0]) cylinder( d=3.15, h=100, center=true, $fn=50 );
    translate([6.25,0,10]) cube([2.5,5.5,20], center=true);
    translate([-6.25,0,10]) cube([2.5,5.5,20], center=true);
  }
}

module small_gear() {
  difference() {
    gear (
      number_of_teeth = 9,
      circular_pitch = 360,
      pressure_angle=26,
      gear_thickness = 7,
      rim_thickness = 7,
      hub_thickness = 16,
      hub_diameter = 13,
      bore_diameter=3.15,
      circles=0, $fn=50);
    translate([0,0,12]) rotate([0,90,0]) cylinder( d=3.15, h=100, center=true, $fn=50 );
  }
}

big_gear();
translate([31,0,0]) small_gear();
translate([-43,0,0]) big_gear();
translate([-86,0,0]) big_gear(bore=1.5);
translate([-129,0,0]) big_gear(bore=1.5);


// Big Gear
/*
gear (
  number_of_teeth=Big_teeth,
  circular_pitch=700,
  pressure_angle=25,
	gear_thickness = 5,
	rim_thickness = 5,
	hub_thickness = 6,
  bore_diameter=3.25,
	circles=0, $fn=32);

// Small Gear
translate([big_pitch_radius+small_pitch_radius+extra_space,0,0])
difference() {
gear (
  number_of_teeth=Small_teeth,
  circular_pitch=700,
  pressure_angle=25,
	gear_thickness = 5,
	rim_thickness = 5,
	hub_thickness = 6,
  bore_diameter=3.25,
	circles=0, $fn=32);
  
  // translate([0,0,11]) rotate([0,90,0]) cylinder(d=3.15, h=15, center=true, $fn=32);
}
*/

echo("Axle spacing: ", big_pitch_radius+small_pitch_radius);

/*
translate([-10,-20,0])
difference() {
  union() {
    translate([-30,60,0]) cube([100,60,6]);
    translate([66,60,0]) cube([6,60,30]);
  }
  
  translate([0,90,0]) cylinder(d=3.25, h=20, center=true, $fn=32);
  translate([(big_pitch_radius+small_pitch_radius),90,0]) cylinder(d=3.25, h=20, center=true, $fn=32);
}
*/

/*
id=9.9;
h=5;

difference() {
  cylinder(d=id+20, h=h, $fn=12);
  translate([0,0,-0.1]) cylinder(d=id, h=h+0.2, $fn=32);
}
*/