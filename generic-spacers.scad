
shells = 4;
nozzle = 0.4;

h=1.2;
id=3.4;
od=7.4; //id+(2*shells*nozzle);

$fn = 100;

for(x=[0:3]) for(y=[0:1]) {
  translate([x*(od+1), y*(od+1), 0]) spacer(id, od, h);
}

module spacer(id, od, h, center=false) {
  dz = center ? 0 : h/2;
  translate([0,0,dz])
  difference() {
    cylinder(d=od, h=h, center=true);
    cylinder(d=id, h=h+0.1, center=true);
  }
}
