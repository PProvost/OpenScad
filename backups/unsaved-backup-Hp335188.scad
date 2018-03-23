use <MCAD/involute_gears.scad>;

clearance = 0.5;
slop = 1.0;
gear_thick = 7;
hub_h = 10;

motor_gear_teeth = 10;
driveshaft_gear_teeth_big = 30;
driveshaft_gear_teeth_small = 10;
final_gear_teeth = 46;

circ_pitch = 270;
press_angle = 22;

function get_pitch_radius(number_of_teeth, circular_pitch) = number_of_teeth * circular_pitch / 360;
// big_pitch_radius = get_pitch_radius(big_teeth, circ_pitch);
// small_pitch_radius = get_pitch_radius(small_teeth, circ_pitch);
// echo("Center to center for motor gears: ", big_pitch_radius + small_pitch_radius, "mm");

translate([0,0,0]) rotate([0,0,360/(2*motor_gear_teeth)]) motor_gear();
translate([30,0,0]) driveshaft_gear();
translate([30,42,2*gear_thick+0.5]) rotate([180,0,180/final_gear_teeth]) final_gear();

module final_gear(bore_d=8.1, hub_d=20) {
  $fn=50;
  gear (
    number_of_teeth = final_gear_teeth,
    circular_pitch = circ_pitch * slop,
    pressure_angle=press_angle,
    gear_thickness = gear_thick,
    rim_thickness = gear_thick,
    hub_thickness = 2*gear_thick+0.5+hub_h,
    hub_diameter = hub_d,
    bore_diameter=bore_d,
    clearance = clearance,
    circles=0, 
    flat=false);

}

module driveshaft_gear(bore=8.1, hub_d=20) {
      translate([0,0,gear_thick]) rotate([180,0,0]) gear (
        number_of_teeth = driveshaft_gear_teeth_big,
        circular_pitch = circ_pitch * slop,
        pressure_angle=press_angle,
        gear_thickness = gear_thick,
        rim_thickness = gear_thick,
        hub_thickness = gear_thick+hub_h,
        hub_diameter = hub_d,
        bore_diameter=bore,
        clearance = clearance,
        circles=0, 
        flat=false,
        $fn=50);
      
    translate([0,0,gear_thick]) gear (
      number_of_teeth = driveshaft_gear_teeth_small,
      circular_pitch = circ_pitch * slop,
      pressure_angle=press_angle,
      gear_thickness = gear_thick+1,
      rim_thickness = gear_thick+1,
      hub_thickness = gear_thick+1,
      hub_diameter = hub_d,
      bore_diameter=bore,
      clearance = clearance,
      circles=0, 
      flat=false,
      $fn=50);
}
module motor_gear() {
  translate([0,0,gear_thick]) rotate([180,0,0])
  difference() {
    gear (
      number_of_teeth = motor_gear_teeth,
      circular_pitch = circ_pitch * slop,
      pressure_angle=press_angle,
      gear_thickness = gear_thick,
      rim_thickness = gear_thick,
      hub_thickness = gear_thick+hub_h,
      hub_diameter = 11,
      bore_diameter=3.15,
      circles=0, $fn=50);
    translate([0,0,gear_thick]) cylinder(d=5.95, h=hub_h+0.1, $fn=32);
  }
}