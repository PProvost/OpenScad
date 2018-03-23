// CC-BY-NC - Peter Provost <peter@provost.org>

// translate([0,0,85/2]) 
difference() {
    // Shell
    cube([25*5,25*2,85], center=true);
    // Middle space
    cube([25*5-6,25*2,85-6], center=true);
    // Top holes
    
    for(x=[0:4]) {
        for (y=[0:1]) {
            #translate([-48+24*x,-10+20*y,85/2]) cylinder(d=10, h=10, center=true);
        }
    }
}    

