use <MCAD/involute_gears.scad>;

$fn = 100;

gear(
  number_of_teeth = 32,
  circular_pitch = 280,
  rim_thickness=10,
  gear_thickness = 7.5,
  hub_thickness=10,
  hub_diameter= 10,
  bore_diameter = 2.3,
  circles = 8
  );