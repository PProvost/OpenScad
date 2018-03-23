////////////////////////////////////////////////////////////////////////////////////
//
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM~
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM~
// MMM                                                     MMM~
// MMM.ZMMMMMMMMMMMMMMMMMMMMMMMMMMMM~.?MMMMM$MMMMMMM=MMMMM.NMM~
// MMM.ZMMMMMMMMMMMMMMMMMMMMMMMMMMMMM +MMMMM$MMMMMMM=MMMMM.NMM~
// MMM.ZMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:?MMMMM$MMMMMMM=MMMMM NMM~
// MMM.ZMMDDMMMMDDMMMMMMMMMMMMMMMMMMMM+MMMMM$MMMMMMM=MMMMM.NMM~
// MMM.ZMM. MMMM. OMM. MMMM....MMMMMMM, ZM~....MMMM..OM$.. NMM~
// MMM.ZMM. MMMM..OMM..MMMM.. .MMMMMMMM.ZM~.  .NMMMN.MM..  NMM~
// MMM..,,..MMMM..:=:..MMMM.. .MM.MMMMM.ZM~.  ..MMMMZMZ..  NMM~
// MMM.     MMMM.    ..MMMM.. .MM.MMMMMMZM~.    MMMMMM..   NMM~
// MMM.     MMMM.    ..MMMM.. .MM ,MMMMMOM~.   ..MMMM$     NMM~
// MMM.    .MMMM.    ..MMMM.. .MM..MMMMMMM~.    .MMMM..    NMM~
// MMM.   . MMMM. . ...MMMM. ..MM .:MMMMMM~.  .. MMMM....  NMM~
// MMM.   NMMMMMMM  .MMMMMMMMMMMMMM.MMMMMM~.   MMMMMMMM..  NMM~
// MMM.   NMMMMMMM. .MMMMMMMMMMMMMM.=MMMMM~.   MMMMMMMM..  NMM~
// MMM.  .DMMMMMMM. .MMMMMMMMMMMMMM..MMMMM~.  .MMMMMMMM..  NMM~
// MMM.  .=???????...+????????????? .~????,.  .????????..  NMM~
// MMM.        .   .    .    .  ......      ..  ..         NMM~
// MMM.MMMM~MMM?MMMMMMMM~MMMMM..,MMMI.....MMMM...MMMMMMMM. NMM~
// MMM.MMMM~MMM?MMMMMMMM~MMMMM.:MMMMM$...MMMMMM..MMMMMMMM8.NMM~
// MMM.MMMM~MMM?MMMMMMMM~MMMMM.MMMMMMM..?MMMMMM8.MMMMMMMMM.NMM~
// MMM.MMMM~MMM+MMMMMMMM~MMMMM,MMM$MMM$ MMMMDMMM MMMMMMMMM.NMM~
// MMM..MMM.MMM.MD  =MM...MM7.ZMMN.~MMM.MMM..MMM,.NMM..ZMM:NMM~
// MMM..MMM,MMM~M?. =MM...MM7.MMM= .MMM.MMM .OMM7.NMM..MMM:NMM~
// MMM..IMMNMMMMM,  =MMMMMMM7.MMM,..MMM,MMM..+MMD NMMMMMMM.NMM~
// MMM..,MMMMMMMM.. =MMMMMMM7 MMM. .MMM:MMN. ~MMN NMMMMMMM.NMM~
// MMM...MMMMMMMM.  =MMMMMMM7.MMM,..MMM,MMM. +MMO.NMMMMMM,.NMM~
// MMM. .MMM$MMMN.. =MM...MM7 MMM+..MMM.MMM..OMM?.NMM .... NMM~
// MMM. .MMM:$MMI...~MM...MM7.IMMM.:MMM.MMM..MMM,.NMM...   NMM~
// MMM. .$MM.:MM,..MMMMM~MMMMM.MMMMMMM$.NMMMMMMM.MMMMM,.   NMM~
// MMM.  :MM .MM.  MMMMM~MMMMM.MMMMMMM..,MMMMMMD.MMMMM.    NMM~
// MMM.  .MM..MM.. MMMMM~MMMMM..MMMMMO...NMMMMM..MMMMM.    NMM~
// MMM.  .M7..NM...MMMMM~MMMMM...MMM7.  ..IMMM...MMMMM,    NMM~
// MMM .  ..   .   .. .      .  ......    ... .       .   .NMM~
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM~
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM~
//
////////////////////////////////////////////////////////////////////////////////////
// File:        Tiny Whoop.scad
//
// Description: A Blade Inductric / Tiny Whoop frame replacement that is
//              relatively easy to print (no supports) and lightweight (as much
//              as possible. With configuration tweaks, it can be used to generate
//              frames for different sizes of motors, props, FC, etc.
//
//              It uses a NACA7312 airfoil for the ducts, but you can use another 
//              NACA code to achieve different things (e.g. 7310 is thinner
//              and therefore lighter. You can explore other airfoil profiles
//              and learn about how NACA 4-digit codes work here:
//              http://airfoiltools.com/airfoil/naca4digit
//
//              Recommended to print in ABS as it is 20% lighter than PLA and takes
//              a crash better. Also you don't need 100% infill and can drop it down
//              to 0-25% to reduce weight. Note that if you set wall_thickness
//              correctly (see below) there should only be infill in the fatter
//              parts of the duct.
//
// Author:      Peter Provost <peter@provost.org>
// License:     CC-BY-NC
//
// Notes:       Inspired by (and with some code from) Mr_Disintigrator's
//              Inductrix frame available here:
//              http://www.thingiverse.com/thing:1831805
//
//              Depends on naca4.scad availble here:
//              http://www.thingiverse.com/thing:900137/#files
//
////////////////////////////////////////////////////////////////////////////////////
//
// Configurable Parameters:
//
// motor_d = 6.35;         For 6mm motors (my printer... adjust as needed) 
// motor_d = 7.35;         For 7mm motors (same comment)
// 
// duct_r = 18.5;         This is not inside diameter. Because of the airfoil, it
//                         is more like outside diameter. 18.5 seems about right for
//                         stock Inductrix props on my printer using ABS. Adjust as needed for
//                         other prop choices, printers and materials.
// 
// duct_h = 10;            10mm is pretty good for this and reasonably close to the stock
//                         Inductrix. If you want the props to sit up a bit, reduce to
//                         8mm or so.
// 
// duct_spacing = 22.5;    This is offset of the duct center from the centerline of the
//                         frame, not M2M measurements. 22.5 is pretty close for the 
//                         stock Inductrix.
//                    
// screw_spacing = 18;     This is the offset of the screw center from the centerline.
//                         18mm is pretty close to the stock Inductrix.
//                     
// wall_thickness = 0.8;   Set this to 2x your nozzle diameter to avoid most of 
//                         the infill and reduce weight as much as possible. See the
//                         notes above about the NACA duct when thinking about
//                         weight.
//
////////////////////////////////////////////////////////////////////////////////////

use <naca4.scad>;



// 6mm "Inductrix" clone for 30mm props
//    - should be plug-n-play for stock or compatible parts
/*
motor_d = 6.35;
motor_mount_h = 5;
duct_r = 18.5;
duct_h = 10;
duct_spacing = 22.5;
screw_spacing = 18;
screw_r = 0.7;
screw_peg_extra_h = 3;
wall_thickness = 0.8;
battery_width = 11;
battery_height = 7;
naca_code = 7312;
smoothness = 64;
extra_beam = false;
split = false;
*/


// 7mm duct quad with 40mm props (I use cut down banggood triblades) 
motor_d = 7.35;
motor_mount_h = 5;
duct_r = 22.75;
duct_h = 10;
duct_spacing = 25.5;
duct_cutout_margin = 1.1;
screw_spacing = 19.0;
screw_r = 0.6;
screw_peg_extra_h = 5;
wall_thickness = 0.8;
battery_width = 11;
battery_height = 7;
naca_code = 7312;
smoothness = 64;
extra_beam = false;
split = false;

// 8.5mm duct quad with 48mm props (eg. banggood triblades) and an Inductrix size  FC
/*
motor_d = 8.75;
motor_mount_h = 5;
duct_r = 27.5;
duct_h = 12;
duct_spacing = 30;
duct_cutout_margin = 1.1;
screw_spacing = 18;
screw_r = 1.0;
screw_peg_extra_h = 5;
wall_thickness = 0.8;
battery_width = 11;
battery_height = 7;
naca_code = 7312;
smoothness = 64;
extra_beam = true;
split = false;
*/

// 8.5mm duct quad with 48mm props (eg. banggood triblades) and a Scisky/F3EvoBrushed size FC
/*
motor_d = 8.75;
motor_mount_h = 5;
duct_r = 26.5;
duct_h = 12;
duct_spacing = 31;
duct_cutout_margin = 1.25;
screw_spacing = 18.5;
screw_r = 1;
screw_peg_extra_h = 6;
wall_thickness = 0.8;
battery_width = 11;
battery_height = 7;
naca_code = 7312;
smoothness = 64;
extra_beam = true;
split = true;
*/

////////////////////////////////////////////////////////////////////////////////////
// The whole thing
union() {
    difference() {
        union() {
            frame();
            four_ducts(duct_r,duct_h,duct_spacing);
        }
        if (split == true) {
            union() {
                $fn = 32;
                peg_h = screw_peg_extra_h+(duct_h/2)+1;
                translate([50,0,50-0.1]) cube([100,200,100], center=true);
                translate([0,-duct_spacing,duct_h/4]) cylinder(d=wall_thickness*1.5, h=duct_h/2+1, center=true);

            }
        }
    }
    if (split == true) {
        $fn = 32;
        translate([0,duct_spacing,0]) cylinder(d=wall_thickness*1.5, h=duct_h/2);
        translate([0,-screw_spacing,0]) cylinder(r=screw_r*1.01, h=wall_thickness*2);
        translate([-wall_thickness/2,0,wall_thickness/2]) cube([wall_thickness, (screw_spacing*2)-(screw_r*2), wall_thickness], center=true);
    }
}

// A plate that mounts to the Inductrix
* color("Blue") flight_controller_plate();

// Micro Scisky FC board
* color("Red") 
    translate([0,0,1+wall_thickness])
        cube([20,33,2], center=true);

module flight_controller_plate() {
    $fn = 32;
    h = 1.25;
    difference() {
        rotate([0,0,45]) translate([0,0,motor_mount_h+(h/2)]) cube([32,32,h], center=true);
        
        translate([duct_spacing, duct_spacing, 0]) duct_cutout(r=duct_r+0.25);
        translate([duct_spacing, -duct_spacing, 0])  duct_cutout(r=duct_r+0.25);
        translate([-duct_spacing, duct_spacing, 0])  duct_cutout(r=duct_r+0.25);
        translate([-duct_spacing, -duct_spacing, 0])  duct_cutout(r=duct_r+0.25);

        translate([screw_spacing,0,motor_mount_h+(h/2)]) cylinder(r=screw_r + wall_thickness + 0.15, h=h+1, center=true);
        translate([-screw_spacing,0,motor_mount_h+(h/2)]) cylinder(r=screw_r + wall_thickness + 0.15, h=duct_h, center=true);
        translate([0, screw_spacing,motor_mount_h+(h/2)]) cylinder(r=screw_r + wall_thickness + 0.15, h=duct_h, center=true);
        translate([0, -screw_spacing,motor_mount_h+(h/2)]) cylinder(r=screw_r + wall_thickness + 0.15, h=duct_h, center=true);
        
        translate([0,0,motor_mount_h+(h/2)]) 
            difference() {
                rotate([0,0,45]) cube([19,19,4], center=true);
                cube([30,2.5,2.5], center=true);
                cube([2.5,30,2.5], center=true);
            }
        }
}

////////////////////////////////////////////////////////////////////////////////////
// Helper modules below here
module frame() {
    frame_hole_spacing = screw_spacing * 2;
    hole = battery_width-wall_thickness*5;
    $fn = 32;

    frame_width = 2*screw_spacing;

    translate([0,0,duct_h/4]) {
        difference() {
            union() {
                difference() {
                    cube([frame_width+wall_thickness, frame_width+wall_thickness, duct_h/2], center=true);
                    cube([frame_width-wall_thickness, frame_width-wall_thickness, 1+duct_h/2], center=true);
                }
                
                if( extra_beam == true ) {
                    difference() {
                        cube([(2*duct_spacing)+wall_thickness, (2*duct_spacing)+wall_thickness, duct_h/2], center=true);
                        cube([(2*duct_spacing)-wall_thickness, (2*duct_spacing)-wall_thickness, 1+duct_h/2], center=true);
                    }
                    translate([duct_spacing,0,0]) cylinder(d=wall_thickness*3, h=duct_h/2, center=true);
                    translate([-duct_spacing,0,0]) cylinder(d=wall_thickness*3, h=duct_h/2, center=true);
                    
                    if (split == true) {
                        translate([0,duct_spacing,0]) cylinder(d=wall_thickness*4, h=duct_h/2, center=true);
                        translate([0,-duct_spacing,0]) cylinder(d=wall_thickness*4, h=duct_h/2, center=true);
                    } else {
                        translate([0,duct_spacing,0]) cylinder(d=wall_thickness*3, h=duct_h/2, center=true);
                        translate([0,-duct_spacing,0]) cylinder(d=wall_thickness*3, h=duct_h/2, center=true);
                    }
                }
                translate([0,0,(-duct_h/4)+(wall_thickness/2)]) battery_plate();
            }
            
            // Cut the corners
            translate([duct_spacing, duct_spacing, 0]) duct_cutout(r=duct_r-duct_cutout_margin);
            translate([duct_spacing, -duct_spacing, 0])  duct_cutout(r=duct_r-duct_cutout_margin);
            translate([-duct_spacing, duct_spacing, 0])  duct_cutout(r=duct_r-duct_cutout_margin);
            translate([-duct_spacing, -duct_spacing, 0])  duct_cutout(r=duct_r-duct_cutout_margin);
            
            // Cut the screw holes through (TODO: redundant)
            translate([screw_spacing,0,screw_peg_extra_h/2])
                cylinder(r=screw_r, h=(duct_h/2)+screw_peg_extra_h+1, center=true);
            translate([-screw_spacing,0,screw_peg_extra_h/2]) 
                cylinder(r=screw_r, h=(duct_h/2)+screw_peg_extra_h+1, center=true);
            translate([0, screw_spacing,screw_peg_extra_h/2])
                cylinder(r=screw_r, h=(duct_h/2)+screw_peg_extra_h+1, center=true);
            translate([0, -screw_spacing,screw_peg_extra_h/2])
                cylinder(r=screw_r, h=(duct_h/2)+screw_peg_extra_h+1, center=true);
        }
        
        translate([screw_spacing,0,screw_peg_extra_h/2]) screw_peg();
        translate([-screw_spacing,0,screw_peg_extra_h/2]) screw_peg();
        translate([0, screw_spacing,screw_peg_extra_h/2]) screw_peg();
        translate([0, -screw_spacing,screw_peg_extra_h/2]) screw_peg();
        
    }
}

module duct_cutout(r=duct_r-1) {
    cylinder(r=r, h=2*duct_h, center=true, $fn=smoothness*2);  
}

module screw_peg() {
    $fn = smoothness;
    difference() {
        cylinder(r=screw_r+wall_thickness, h=screw_peg_extra_h+(duct_h/2), center=true);
        cylinder(r=screw_r, h=screw_peg_extra_h+(duct_h/2)+1, center=true);
    }
}

module four_ducts(r, h, spacing) {
    // Ducts
    translate([spacing,spacing,0]) rotate([0,0,-45]) full_duct(r,h);
    translate([spacing,-spacing,0]) rotate([0,0,-135]) full_duct(r,h);
    translate([-spacing,spacing,0]) rotate([0,0,45]) full_duct(r,h);
    translate([-spacing,-spacing,0]) rotate([0,0,135]) full_duct(r,h);
}

module battery_plate() {
    frame_hole_spacing = screw_spacing * 2;
    hole_w = battery_width-wall_thickness*5;
    hole_l = ((2*screw_spacing)-(10*wall_thickness)) / 3;
    difference() {
        cube([battery_width,frame_hole_spacing+wall_thickness,wall_thickness],center=true);
        translate( [0, hole_l+(2*wall_thickness), 0] )
            cube([hole_w,hole_l,wall_thickness*2],center=true);
        translate( [0, -(hole_l+(2*wall_thickness)), 0] )
            cube([hole_w,hole_l,wall_thickness*2],center=true);
        translate( [0, 0, 0] )
            cube([hole_w,hole_l,wall_thickness*2],center=true);
    }
    
    // Rubber band clips
    translate([(1.5*wall_thickness)+(battery_width/2),0,0]) {
        cube([3*wall_thickness, 2*wall_thickness, wall_thickness], center=true);
        translate([2*wall_thickness, 0, 0])
            cube([2*wall_thickness,4*wall_thickness,wall_thickness], center=true);
    }
    rotate([0,0,180]) translate([(1.5*wall_thickness)+(battery_width/2),0,0]) {
        cube([3*wall_thickness, 2*wall_thickness, wall_thickness], center=true);
        translate([2*wall_thickness, 0, 0])
            cube([2*wall_thickness,4*wall_thickness,wall_thickness], center=true);
    }
    
    /*
    translate([0,battery_width/2,0]) difference() {
        translate([0,0,1]) cube([battery_width,2,wall_thickness+2], center=true);
        translate([0,0,1+wall_thickness]) cube([battery_width-3, 3, wall_thickness+2], center=true);
    }
    translate([0,-battery_width/2,0]) difference() {
        translate([0,0,1]) cube([battery_width,2,wall_thickness+2], center=true);
        translate([0,0,1+wall_thickness]) cube([battery_width-3, 3, wall_thickness+2], center=true);
    }
    */
}

module full_duct(r, h) {
    stator_l = r-(floor(motor_d)-2)+0.25;
    stator_h = motor_mount_h - wall_thickness*1.5;
    
    difference() {
        union() {
            intersection() {
                translate([0,0,stator_h]) {
                    rotate([0,0,0/3*360]) stator(stator_l, wall_thickness, stator_h, motor_d);
                    rotate([0,0,1/3*360]) stator(stator_l, wall_thickness, stator_h, motor_d);
                    rotate([0,0,2/3*360]) stator(stator_l, wall_thickness, stator_h, motor_d);
                }
                translate([0,0,duct_h/2]) duct_cutout();
            }
            
            translate([0,0,motor_mount_h/2]) motor_mount(motor_d, motor_mount_h);
            translate([0,0,h]) duct(r,h);
        }
        
        translate([0,0,-3]) cylinder(r=r*1.5, h=3);
    }
}

module stator(l, w, h, hub_d) {
    translate([-w/2, -hub_d/2,-h])
        rotate([90,0,0])
            cube([w,h,l]);
}

module motor_mount(id, h) {
    difference() {
        cylinder(d=id+(2*wall_thickness), h=h, center=true, $fn=smoothness*2);
        cylinder(d=id, h=h+1, center=true, $fn=smoothness*2);
    }
}

module duct(r, h, naca=naca_code, extra_h=2.5) {
    rotate_extrude(angle=360, convexity=2, $fn=smoothness*2)
        translate([r,0,0])
            rotate([0,-180,85])
                polygon(points = airfoil_data(naca, h+extra_h, 81)); 
}

