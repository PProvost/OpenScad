inside=15.3/2;
outside=21.6/2;

module tube(r=10, h=10, thickness=2.5, center=false) {

	off = (center==true) ? [0,0,0] :	[0,0,h/2];
	translate(off)	difference(){
		cylinder(r=r, h=h, center=true);
		cylinder(r=r-thickness, h=h+0.04, center=true);
}	}

module tip()
difference(){
	union(){
		tube (r=inside, h=15);
		translate([0,0,15+outside-inside]) 
			cylinder(r2=2, r1=outside, h=20);
		translate([0,0,15]) 
			cylinder(r1=inside, r2=outside, h=outside-inside);
	}
	translate ([0,0,14.95])
		cylinder(r2=0, r1=inside-2.5, h=21);
//	translate([outside,0,10]) cube ([outside+10,50,60], center=true);
}

module pointer()
	difference(){
		union(){
			tip();
			translate([0,0,5.5]) 	rotate([0,-90,0])	cylinder(r=inside,h=30);
			cylinder(r=outside, h=18.3);
		}
		translate([-10,0,-5]) cube([60,20,10.001],center=true);	
	}

module base()
	difference(){
		union(){
			translate([0,0,10]) 	cube([70, 28, 20], center=true);
			translate([0,25,10])	cube([28, 36, 20], center=true);
		}
		translate([outside+8,0,8]){
			rotate([90,0,0])	cylinder(r=2.5,100,center=true);
			for (i= [0:30]){
			rotate([0,i,0]) translate([0,0,-6])	cylinder(r=outside+1,25);
			}	}
		translate([0,25,14]) rotate([0,0,90]){
			rotate([90,0,0])	cylinder(r=2.5,100,center=true);
			for (i= [0:90]){
			rotate([0,i,0]) translate([0,0,-6])	cylinder(r=outside+1,25);
			}	}
		translate([-outside-8,0,8]){
			rotate([90,0,0])	cylinder(r=2.5,100,center=true);
			for (i= [0:30]){
			rotate([0,-i,0]) translate([0,0,-6])	cylinder(r=outside+1,25);
			}
		}
	}

// translate([58,23,0]) pointer();
translate([61,-3,0]) tip();
translate([9,-3,0]) tip();
translate([35,-30,0]) base();



