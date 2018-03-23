// Thin wall open box calibration piece
// Adapted from Coasterman's Calibration set
// Ed Nisley - KE4ZNU - Dec 2011
// Adjust for Slic3r/M2 - March 2013
// Reworked for hull() with correct corner radii - April 2014
 
//-------
//- Extrusion parameters must match reality!
//  None of the fill parameters matter
 
ThreadThick = 0.2;
ThreadWidth = 0.40;
 
Protrusion = 0.1;           // make holes end cleanly
 
function IntegerMultiple(Size,Unit) = Unit * ceil(Size / Unit);
 
//-------
// Dimensions
 
Height = IntegerMultiple(5.0,ThreadThick);
 
WallThick = ThreadWidth;
 
CornerRadius = 2.0;
CornerSides = 4*8;
 
SideLen = 20.0 - 2*CornerRadius;
 
Rotation = 45;
 
//-------
 
module ShowPegGrid(Space = 10.0,Size = 1.0) {
 
  Range = floor(50 / Space);
 
    for (x=[-Range:Range])
      for (y=[-Range:Range])
        translate([x*Space,y*Space,Size/2])
          %cube(Size,center=true);
}
 
//-------
 
ShowPegGrid();
 
rotate(Rotation)
    difference() {
        hull() {
            for (i=[-1,1], j=[-1,1])
                translate([i*SideLen/2,j*SideLen/2,0])
                    cylinder(r=CornerRadius,h=Height,$fn=CornerSides);
        }
        hull() {
            for (i=[-1,1], j=[-1,1])
                translate([i*SideLen/2,j*SideLen/2,-Protrusion])
                    cylinder(r=(CornerRadius - WallThick),h=(Height + 2*Protrusion),$fn=CornerSides);
        }
    }
