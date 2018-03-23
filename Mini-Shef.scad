
height=100;
width=160;
thickness=8;

cube([width, height, thickness]);
cube([width,thickness,height]);

translate([thickness,0,0])
rotate([0,-90,0])
linear_extrude(thickness)
polygon( points=[[thickness,thickness],[thickness,90],[90,thickness]]);

translate([width,0,0])
rotate([0,-90,0])
linear_extrude(thickness)
polygon( points=[[thickness,thickness],[thickness,90],[90,thickness]]);