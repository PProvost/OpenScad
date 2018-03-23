height = 9;
inner_diameter = 5;
wall_thickness = 1;
$fs = 0.5;
   
difference() {
   cylinder (h=height, d=inner_diameter + 2*wall_thickness, center=true);
   cylinder (h=height, d=inner_diameter, center=true);
}