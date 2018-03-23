/*
appjaws_duetwifi_and_duex5_enclosure.scad
modified from the original design by deckingman - thank you
function "lookup" provided by enif - thank you
included a choice of the following:-
Duetwifi no fan
Duetwifi 40/50/60/80 external fan mount
Duetwifi 40/50/60/80 internal fan mount
Duetwifi and duex2/5 no fan
Duetwifi and duex2/5 40/50/60/80 external fan mount
Duetwifi and duex2/5 40/50/60/80 internal fan mount
fan guard 40/50/60/ fan widths

select printbox to print enclosure
select printlid to print main enclosure lid
select printlidx5 to print lid for duex5 board
select printguard to true to print grill
select nuttrap for the grill to have nut traps or round head bolts
select expcon to include access to the expansion connector of the duetwifi board

select hardware to view boards and fans in position
select assembled to view the complete enclosure with lid/s

boards are bolted using M4 15mm bolts 
The mounting holes are located to fit to a 20 or 40 mm profile at a right hand corner but can easily be changed.
Note:- print support is needed, especially for the duex5 version
*/

include <MCAD/regular_shapes.scad>;
use <MCAD/boxes.scad>

//functions
function lookup(v,var,lar,i=0) = (var[ i ]==v) ? lar[ i ] : ( i < len ( var ) ? lookup( v, var, lar, i + 1 ) : -1);

//user selection
printbox = tru;//set to true to print enclosure
printlid = tru;//set to true to print main enclosure lid
printlidx5 = tru;//set to true to print lid for duex5 board
printguard = true;//set to true to print grill

assembled = tru;//set to true for assembled item - printbox must be selected
expansion = tru;//set to true to include expansion duex5 or duex2 board
expcon = tru;//set to true for expansion connector opening
hardware = tru;//set tp true to show fan,grill and boards
nuttrap = tru; //set to false for round bolt head on grill
inside = true;//Set to true for fan mounted inside box or false for outside of the box.
withfan = true;//set to false for no fan and extra vents


//user settings
fan_width = 60;			    //input fan outer dimensions
fan_depth = 15;             //input fan depth
fan_blades=7;               //input the number of fan blades

//default settings
base=4;                     //enclosure base thickness
wall=3.0;                   //enclosure wall thickness
airgap=10;                  //space between boards
bsuppwid=10;                //board support width
bsize=[100,123,26];         //board size
bmount=[92,115];            //board mounting holes
boffset=[27,wall+2*airgap]; //board offset (X,Y)
erad=4;                     //enclosure corner radius
ency=125+airgap;            //enclosure length(y)
encx=172;                   //enclosure width(x)
M4_clear=2.2;               //m4 clearance
M3_clear=1.7;               //m3 clearance bolt
M3_head_dia=3.4;            //head diameter
M3_head_ht=2.5;             //m3 head height
M3_nut_trap=3.4;            // m3 nut trap
grill_depth=4;              //fan grill depth
grill_space=10;            //space between grill rings
rings_wid=1.05;             //fan grill rods and rings width
clear=2;                    //extra clearance
tol=0.1;                    //small tolerance
$fn=100;

//calculations
fan_mount_dist = lookup(fan_width, [40,50,60,80], [32,40,50,70]);   //fan mounting hole distance
fan_dist = (withfan == true) ? fan_depth : 5;                       //default space if fan outside
//fan_dist = (if (withfan == true) if (inside == true))? fan_depth : 5;
    
    
fan_pos=[encx/2-bsuppwid,ency/2,-0.1];                              //fan position
fan_rad = fan_width/2-2;		                                    //radius of blades
rings = lookup(fan_width, [40,50,60,80], [4,5,6,8]);                //number of grill rings dependant on fan size


if (printbox == true){ fan_dist = (inside == true) ? fan_dist : 5;  
    if (expansion == true) {
    basex5(); 
     if (hardware == true) { 
     if (withfan == true){          
                if (inside == true){                    
        translate([boffset[0]+bsize[0]/2,wall+fan_depth/2,(airgap+2*bsize[2]+2*wall)/2]) rotate([90,0,0]) color("Silver") fan();
        translate([boffset[0]+bsize[0]/2,fan_depth/2,(airgap+2*bsize[2]+2*wall)/2]) rotate([90,0,0]) color("brown") fanscrews();                  
       translate([boffset[0]+bsize[0]/2,-grill_depth/2,(airgap+2*bsize[2]+2*wall)/2]) rotate([90,0,0]) color("blue") guard();                 
                }
                else {
               // fan_dist = (inside == true) ? fan_dist : 5;    
        translate([boffset[0]+bsize[0]/2,-fan_depth/2,(airgap+2*bsize[2]+2*wall)/2]) rotate([90,0,0]) color("Silver") fan(); 
        translate([boffset[0]+bsize[0]/2,-fan_depth/2,(airgap+2*bsize[2]+2*wall)/2]) rotate([90,0,0]) color("brown") fanscrews();
       translate([boffset[0]+bsize[0]/2,-fan_depth-grill_depth/2,(airgap+2*bsize[2]+2*wall)/2]) rotate([90,0,0]) color("blue") guard(); 
     translate([boffset[0]+wall-(bsize[0]-bmount[0])/2,boffset[1]-airgap+wall+fan_dist+clear,base+bsize[2]+airgap]) color("grey") board();//Duewifi
        translate([boffset[0]+wall-(bsize[0]-bmount[0])/2,boffset[1]-airgap+wall+fan_dist+clear,base]) color("red") boardx5();//Duex5                  
            } } 
       // fan_dist = (inside == true) ? fan_dist : 5; 
        translate([boffset[0]+wall-(bsize[0]-bmount[0])/2,boffset[1]-airgap+wall+fan_dist+clear,base+bsize[2]+airgap]) color("grey") board();//Duewifi
        translate([boffset[0]+wall-(bsize[0]-bmount[0])/2,boffset[1]-airgap+wall+fan_dist+clear,base]) color("red") boardx5();//Duex5
        }
            if (assembled == true) {
            translate ([0,0,airgap+2*bsize[2]+2*wall]) rotate ([0,0,0]) lid();//fitted
            translate ([0,-airgap+wall+1.5,0]) rotate ([0,0,0]) lidx5();//expansion lid fitted  
            }   }
    else {
    base();  
    if (hardware == true) {
        if (withfan == true){
        if (inside == true){
        translate([encx/2-airgap,ency/2+airgap,wall+fan_dist/2]) color("grey") fan();
        translate([encx/2-airgap,ency/2+airgap,wall+fan_dist/2-base]) color("brown") fanscrews();
        translate([encx/2-airgap,ency/2+airgap,-grill_depth/2]) rotate([0,180,0]) color("blue") guard();    
        }
        else {
            translate([encx/2-airgap,ency/2+airgap,-fan_depth/2]) color("lightgrey") fan();
            translate([encx/2-airgap,ency/2+airgap,-fan_depth/2]) color("brown") fanscrews();
            translate([encx/2-airgap,ency/2+airgap,-fan_depth-grill_depth/2]) rotate([0,180,0]) color("blue") guard();
        }   } 
      //fan_dist = (inside == true) ? fan_dist : 5;  
        translate([boffset[0]+wall-(bsize[0]-bmount[0])/2,boffset[1]-wall-clear,base+fan_dist+1+airgap/2]) color("grey") board();//Duewifi
            }      
            
        if (assembled == true) {
        translate ([0,0,fan_dist+airgap/2+bsize[2]+2*wall]) rotate ([0,0,0]) lid();//fitted 
        }   } }         
    else{
        if (printlid == true){
        translate ([encx,0,wall]) rotate ([0,180,0]) lid();//for printing    
            }
        else{
            if (printlidx5 == true){
            translate ([-14,-14,0]) rotate ([0,0,0]) lidx5();//for printing
            }
         else{
          if (printguard == true){
             guard();//for printing
         }   }   }  }
            
module fan() {
    difference() {
    roundedBox([fan_width, fan_width, fan_depth], 2.5, true);
    cylinder(h=fan_depth+1, r=fan_width/2-1, center=true);// Fan cylinder
    for(i = [1: 4])
            rotate([0, 0, i*90])
            translate([fan_mount_dist/2, fan_mount_dist/2, 0])
            rotate([180, 0, 0])
            cylinder(r=M3_clear, h=wall+fan_depth, center=true);//M3 bolt clearance
    }      
    for (i = [0:1:fan_blades-1]) {
      rotate(360.0 / fan_blades * i)
      translate([0,0,-2.5])
      rotate([30,0,0])
      roundedcube(fan_width*0.9/2, 40 / fan_blades, 1,1);// Fan blades
    }   
    cylinder(h=fan_depth/2, r=fan_width*0.2, center=true);// fan inner
}

module fanscrews() {
     for(i = [1: 4])
            rotate([0, 0, i*90])
            translate([fan_mount_dist/2, fan_mount_dist/2, 0])
            rotate([180, 0, 0])
            cylinder(r=M3_clear-0.2, h=3*wall+fan_depth, center=true);//M3 bolt
}

module fan_cutout() {
    cylinder( h=3*wall, r=fan_width/2-1, center=true);//fan hole
	for(i = [1: 4])
		rotate([0, 0, i*90])
		translate([fan_mount_dist/2, fan_mount_dist/2, 0])
		rotate([180, 0, 0])
		cylinder( h=wall+10,r=M3_clear, center=true);//M3 bolt
   // for(i = [1: 4])
	//	rotate([0, 0, i*90])
      //  translate([fan_mount_dist/2, fan_mount_dist/2, -1.6]) hexagon_prism(M3_nut_trap,M3_nut_trap); //Nut Trap        
}
 

module lidx5(){
    fan_dist = (inside == true) ? fan_dist : 5;
    color("lightblue")
    difference (){
        union(){
        translate ([boffset[0]-bsuppwid/2+clear/2,boffset[1]-airgap-1,0]) roundedcube (bsize[0]+bsuppwid-clear,bsize[1]+fan_dist+airgap+1,base/2+tol,erad);
       translate ([boffset[0]+clear/2,boffset[1]-airgap/2-wall/2,base/2]) roundedcube (bsize[0]-clear,bsize[1]+fan_dist+wall/2,wall,erad);   
          } 
       translate ([boffset[0]+clear/2+bsuppwid/2,boffset[1]-airgap/2-clear/2+bsuppwid/2,base/2+tol]) roundedcube (bsize[0]-clear-bsuppwid,bsize[1]+fan_dist+wall/2-bsuppwid,3,erad);    
        translate ([boffset[0]-bsuppwid/2+wall/2,boffset[1]-bsuppwid+wall/2,-2*tol]) cylinder (r1=3.5, r2=1.6, h=2.4);//lid countersunk screw hole fan end
       translate ([boffset[0]-bsuppwid/2+wall/2,ency+boffset[0]/2-bsuppwid+wall+2.5,-2*tol]) cylinder (r1=3.5, r2=1.6, h=2.4);//lid countersunk screw hole vent end
        translate ([boffset[0]+bsize[0]+wall,boffset[1]-bsuppwid+wall/2,-2*tol]) cylinder (r1=3.5, r2=1.6, h=2.4);//lid countersunk screw hole fan end
        translate ([boffset[0]+bsize[0]+wall,ency+boffset[0]/2-bsuppwid+wall+2.5,-2*tol])cylinder (r1=3.5, r2=1.6, h=2.4);//lid countersunk screw hole vent end   
        for (i=[boffset[0]+bsuppwid-wall/2:10:bsize[0]+boffset[0]-wall]){
        translate ([i,ency-boffset[0]/2-fan_dist-bsuppwid-2*wall,-2]) roundedcube (3,35,8,erad/2);      
        }     }     }
  
        
 module basex5(){
     fan_dist = (inside == true) ? fan_dist : 5;
    difference(){
        roundedcube (encx,ency+airgap+fan_dist+clear,airgap+2*bsize[2]+base+wall,erad);
        difference(){
            translate ([wall,wall,base]) roundedcube (encx-2*wall,ency-2*wall+airgap+fan_dist+clear,airgap+2*bsize[2]+base+wall,erad);           
            difference(){  
            translate ([boffset[0]+wall-bsuppwid/2,0,base+bsize[2]]) cube([bmount[0]+bsuppwid,ency+airgap+fan_dist+clear,airgap]); 
            translate ([boffset[0]+wall+bsuppwid/2,wall,base+bsize[2]-tol]) cube([bmount[0]-bsuppwid,ency-2*wall+airgap+fan_dist+clear,airgap+2*tol]); 
            }}     
       translate ([boffset[0],bsuppwid,-tol]) roundedcube (bsize[0],ency+airgap+fan_dist+clear-2*bsuppwid,10,erad);//lid opening  
        translate ([boffset[0]-bsuppwid/2,bsuppwid/2,-tol]) color("grey") roundedcube (bsize[0]+bsuppwid,ency+airgap+fan_dist+clear-bsuppwid,base/2,erad);//lid inset lip 
        translate ([boffset[0]+wall,ency+airgap+fan_dist+clear+tol,base+bsize[2]+airgap]) rotate ([90,0,0]) roundedcube(bmount[0],bsize[2]/2-wall/2,10,erad);//control slot 
        translate ([encx-boffset[0]-2*wall,ency+airgap+fan_dist+clear-10,-1]) cylinder (d=6,h=7);//mounting holes  
       translate ([boffset[0]/2+wall+1,ency+fan_dist+clear,-1]) cylinder (d=6,h=7);//mounting holes   
        translate ([encx-10-wall,boffset[1]-wall,-1]) cylinder (d=6,h=7);//mounting holes
        translate ([encx-10-wall,ency+fan_dist+clear,-1]) cylinder (d=6,h=7);//mounting holes    
        translate ([encx-10-wall,ency/2+fan_dist+wall,-1]) cylinder (d=6,h=7);//mounting holes
       //board mounts M4 clearance
        translate ([boffset[0]+wall,boffset[1]+fan_dist+bmount[1]-1-bmount[1],bsize[2]]) cylinder (r=M4_clear, h=airgap+base+tol);
        translate ([boffset[0]+wall+bmount[0],boffset[1]+fan_dist+bmount[1]-1-bmount[1],bsize[2]]) cylinder (r=M4_clear, h=airgap+base+tol);
        translate ([boffset[0]+wall+bmount[0],boffset[1]+fan_dist+bmount[1]-1,bsize[2]]) cylinder (r=M4_clear, h=airgap+base+tol); 
       translate ([boffset[0]+wall,boffset[1]+fan_dist+bmount[1]-1,bsize[2]]) cylinder (r=M4_clear, h=airgap+base+tol);

       for (i=[boffset[0]-fan_dist/2-wall:24:bsize[1]+airgap+fan_dist]){
            translate ([encx-37,i,-tol]) roundedcube(17,17,base+2*tol,4);//wire slots
    }        
            
        if (expcon == true) {
            translate ([1.5*wall,boffset[1]+fan_dist+airgap,-tol]) roundedcube(boffset[0]/2,bsize[1]-boffset[1]-2*wall,base+2*tol,erad);//cable slots cut off 
                }       
        for (i=[boffset[0]+wall+11:10:bsize[0]+wall+15]){ 
        translate ([i,ency+airgap+fan_dist+clear-2*wall+tol,bsize[2]+airgap]) rotate([0,180,0]) airduct(fan_depth); 
        } 
        translate ([boffset[0]-bsuppwid/2+wall/2,bsuppwid-1,-tol]) cylinder(h=base+2*tol,r=1.35);//lid self tap screw hole fan end
        translate ([boffset[0]-bsuppwid/2+wall/2,bsuppwid-1,-tol]) cylinder (r1=3.5, r2=1.65, h=2.3);//lid countersunk screw hole fan end    
        translate ([boffset[0]-bsuppwid/2+wall/2,ency+boffset[0]/2-bsuppwid,-tol]) cylinder (h=base+2*tol,r=1.35);//lid self tap screw hole vent end
        translate ([boffset[0]-bsuppwid/2+wall/2,ency+boffset[0]/2-bsuppwid,-2*tol]) cylinder (r1=3.5, r2=1.65, h=2.3);//lid countersunk screw hole vent end     
        translate ([boffset[0]+bsize[0]+wall,bsuppwid-1,-tol]) cylinder(h=base+2*tol,r=1.35);//lid self tap screw hole fan end
        translate ([boffset[0]+bsize[0]+wall,bsuppwid-1,-tol]) cylinder (r1=3.5, r2=1.65, h=2.3);//lid countersunk screw hole fan end
        translate ([boffset[0]+bsize[0]+wall,ency+boffset[0]/2-bsuppwid,-tol])cylinder(h=base+2*tol,r=1.35);//lid self tap screw hole vent end
          
        translate ([boffset[0]+bsize[0]+wall,ency+boffset[0]/2-bsuppwid,-2*tol])cylinder (r1=3.5, r2=1.65, h=2.3);//lid countersunk screw hole vent end
     if (withfan == true){        
     translate([boffset[0]+bsize[0]/2,wall/2,(airgap+2*bsize[2]+2*wall)/2]) rotate([-90,0,0]) fan_cutout();
        }else{
          for (i=[boffset[1]+airgap+1:10:bsize[1]+boffset[1]-12]){ 
            translate ([-1,i,airgap+bsize[2]+2*base]) rotate([0,180,-90])airduct(fan_dist);//air vents
            }  
          for (v=[boffset[1]+airgap+1:10:bsize[1]+boffset[1]-12]){ 
            translate ([boffset[0]-bsuppwid,v,airgap+bsize[2]-1]) rotate([0,90,0])cylinder(h=bsuppwid+clear+bsize[0],r=wall);//air vents
            } 
            }
     
        }
        
     difference(){
     translate ([boffset[0]-bsuppwid/2-1,bsuppwid-wall-1,base-tol]) cube([5,6,2]);//screw block
     translate ([boffset[0]-bsuppwid/2+wall/2,bsuppwid-1,-tol]) cylinder(h=base+2+2*tol,r=1.35);
     }
     difference(){
     translate ([boffset[0]-bsuppwid/2-1,ency+boffset[0]/2-bsuppwid-wall,base-tol]) cube([5,6,2]);//screw block
     translate ([boffset[0]-bsuppwid/2+1.5,ency+boffset[0]/2-bsuppwid,-tol]) cylinder (h=base+2+2*tol,r=1.35);
     }   
     difference(){
     translate ([boffset[0]+bsize[0]+0.5,bsuppwid-wall-1,base-tol]) cube([5,6,2]);//screw block
     translate ([boffset[0]+bsize[0]+wall,bsuppwid-1,-tol]) cylinder(h=base+2+2*tol,r=1.35);    
    }
    difference(){
     translate ([boffset[0]+bsize[0]+0.5,ency+boffset[0]/2-bsuppwid-wall,base-tol]) cube([5,6,2]);//screw block
     translate ([boffset[0]+bsize[0]+3,ency+boffset[0]/2-bsuppwid,-tol])cylinder(h=base+2+2*tol,r=1.35);    
    }
        
    difference(){ //maincorner
    translate ([2*wall,2*wall,0]) cylinder (r=5,h=airgap+2*bsize[2]+base+wall/2);
    translate ([2*wall,2*wall,2*bsize[2]+base+wall+tol]) cylinder (r=1.35, h=airgap);
    }  
    difference(){   
    translate ([2*wall,ency+airgap+fan_dist+clear-2*wall,0]) cylinder (r=5,h=airgap+2*bsize[2]+base+wall/2);        
    translate ([2*wall,ency+airgap+fan_dist+clear-2*wall,2*bsize[2]+base+wall+tol]) cylinder (r=1.35, h=airgap);   
    }
    difference(){       
    translate ([encx-2*wall,2*wall,0]) cylinder (r=5,h=airgap+2*bsize[2]+base+wall/2);       
    translate ([encx-2*wall,2*wall,2*bsize[2]+base+wall+tol]) cylinder (r=1.35, h=airgap); 
    }
    difference(){             
    translate ([encx-2*wall,ency+airgap+fan_dist+clear-2*wall,0]) cylinder (r=5,h=airgap+2*bsize[2]+base+wall/2);
    translate ([encx-2*wall,ency+airgap+fan_dist+clear-2*wall,2*bsize[2]+base+wall+tol]) cylinder (r=1.35, h=airgap);
    }   }
               

module base(){
    fan_dist = (inside == true) ? fan_dist : 5;
    difference(){
        roundedcube (encx,ency+airgap,fan_dist+airgap/2+bsize[2]+wall+base,erad);
        difference(){
        translate ([wall,wall,base]) roundedcube (encx-2*wall,ency+airgap-2*wall,fan_dist+airgap/2+bsize[2]+2*wall,erad);           
        difference(){  
        translate ([boffset[0]+wall-bsuppwid/2,0,base]) cube([bmount[0]+bsuppwid,ency+airgap,fan_dist+airgap/2]); 
        translate ([boffset[0]+wall+bsuppwid/2,wall,base]) cube([bmount[0]-bsuppwid,ency+airgap-2*wall,fan_dist+airgap/2+2*tol]); 
        }}
        translate ([boffset[0]+wall,ency+airgap+wall,base+fan_dist+1+airgap/2]) rotate ([90,0,0]) roundedcube(bmount[0],bsize[2]/2-wall/2,10,erad);//control slot
        translate ([encx-28,ency+airgap-10,-1]) cylinder (d=6,h=7);//mounting holes  
        translate ([boffset[0]/2+wall+1,ency+airgap-10,-1]) cylinder (d=6,h=7);//mounting holes   
        translate ([encx-10,boffset[1],-1]) cylinder (d=6,h=7);//mounting holes
        translate ([encx-10,ency-airgap,-1]) cylinder (d=6,h=7);//mounting holes    
        translate ([encx-10,ency/2+airgap,-1]) cylinder (d=6,h=7);//mounting holes 
           //board mounts self tap m4 clearance
        translate ([boffset[0]+wall,boffset[1]-1,fan_dist]) cylinder (r=M4_clear, h=12);
        translate ([boffset[0]+wall+bmount[0],boffset[1]-1,fan_dist]) cylinder (r=M4_clear, h=12);
        translate ([boffset[0]+wall+bmount[0],boffset[1]+bmount[1]-1,fan_dist]) cylinder (r=M4_clear, h=12); 
        translate ([boffset[0]+wall,boffset[1]+bmount[1]-1,fan_dist]) cylinder (r=M4_clear, h=12);

        if (expcon == true) {
            translate ([1.5*wall,boffset[1]+2*wall,-tol]) roundedcube(boffset[0]/2,bsize[1]-boffset[1]-2*wall,base+2*tol,erad);//cable slots cut off 
            } 
        for (i=[boffset[0]-14:24:bsize[1]+airgap-wall]){
            translate ([encx-37,i,-tol]) roundedcube(17,17,base+2*tol,4);//wire slots
            }
            for (i=[boffset[0]+wall+11:10:bsize[0]+wall+10]){ 
            translate ([i,ency+airgap-wall-tol,fan_dist+airgap/2+1]) rotate([0,180,0])airduct(fan_dist);//air vents
            } 
          if (withfan ==true){  
        translate([encx/2-airgap,ency/2+airgap,-0.1])fan_cutout();//fan cutout
             for (v=[boffset[1]+airgap:10:bsize[1]]){ 
            translate ([boffset[0]-wall,v,fan_dist+base/2]) rotate([0,0,-90])roundedcube (3,bsize[0]+2*base+clear,2*airgap,erad/2);//air vents    
             } }else{
              for (i=[boffset[1]+airgap+2*base:10:bsize[1]-base]){
        translate ([i,boffset[0]+base,-2]) roundedcube (3,bsize[0]-wall,8,erad/2);      
        }
          for (v=[boffset[1]+airgap:10:bsize[1]]){ 
            translate ([-wall,v,airgap/2+base]) rotate([0,0,-90])roundedcube (3,bsize[1]+2*base+clear,2*airgap,erad/2);//air vents
            }
         // for (i=[boffset[1]+airgap:10:bsize[1]]){ 
           //# translate ([-1,i,airgap/2+bsize[2]+wall+base]) rotate([0,180,-90])airduct(fan_dist);//air vents
            //}
    //      for (v=[boffset[1]+airgap:10:bsize[1]]){ 
      //      translate ([-wall,v,airgap+base]) rotate([0,90,0])cylinder(h=bsuppwid+clear+bsize[0]+boffset[0],r=base);//air vents
        //    }
            }
          
        }   
        difference(){ //maincorner
        translate ([2*wall,2*wall,0]) cylinder (r=5,h=fan_dist+airgap/2+bsize[2]+base+wall/2);
        translate ([2*wall,2*wall,fan_dist+airgap/2+bsize[2]-wall]) cylinder (r=1.35, h=airgap);
        }  
        difference(){   
        translate ([2*wall,ency+airgap-2*wall,0]) cylinder(r=5,h=fan_dist+airgap/2+bsize[2]+base+wall/2);         
        translate ([2*wall,ency+airgap-2*wall,fan_dist+airgap/2+bsize[2]-wall])cylinder (r=1.35, h=airgap);   
        }
        difference(){       
        translate ([encx-2*wall,2*wall,0])cylinder (r=5,h=fan_dist+airgap/2+bsize[2]+base+wall/2);       
        translate ([encx-2*wall,2*wall,fan_dist+airgap/2+bsize[2]-wall])cylinder (r=1.35, h=airgap); 
        }
        difference(){             
        translate ([encx-2*wall,ency+airgap-2*wall,0]) cylinder (r=5,h=fan_dist+airgap/2+bsize[2]+base+wall/2);
        translate ([encx-2*wall,ency+airgap-2*wall,fan_dist+airgap/2+bsize[2]-wall]) cylinder (r=1.35, h=airgap);
        }   }     

module lid(){
    if (expansion == true) {fan_dist = (inside == true) ? fan_dist : 5;
    difference (){
        union(){
        roundedcube (encx,ency+airgap+fan_dist+clear,base,erad);  
       translate ([wall+0.5,wall+0.5,-wall/2]) color("lightgrey") roundedcube (encx-2*wall-1,ency+airgap+fan_dist+clear-2*wall-1,wall/2,erad);
          }       
    translate ([wall+bsuppwid,wall+bsuppwid,-wall/2-tol]) roundedcube (encx-2*wall-2*bsuppwid,ency+airgap+fan_dist+clear-2*wall-2*bsuppwid,wall,erad);      
    translate ([2*wall,2*wall,-wall]) cylinder (r=M3_clear, h=2*base);    
    translate ([2*wall,2*wall,base/2]) cylinder (r1=M3_clear, r2=4, h=2.5);      
    translate ([2*wall,ency+airgap+fan_dist+clear-2*wall,-wall]) cylinder (r=M3_clear, h=2*base);   
    translate ([2*wall,ency+airgap+fan_dist+clear-2*wall,base/2]) cylinder (r1=M3_clear, r2=4, h=2.5);     
    translate ([encx-2*wall,2*wall,-wall]) cylinder (r=M3_clear, h=2*base);     
    translate ([encx-2*wall,2*wall,base/2]) cylinder (r1=M3_clear, r2=4, h=2.5);      
    translate ([encx-2*wall,ency+airgap+fan_dist+clear-2*wall,-wall]) cylinder (r=M3_clear, h=2*base);
    translate ([encx-2*wall,ency+airgap+fan_dist+clear-2*wall,base/2]) cylinder (r1=M3_clear, r2=4, h=2.5);
        for (i=[boffset[0]+2*wall:10:bsize[0]+boffset[0]-wall]){
        translate ([i,encx/2+fan_dist,-1]) roundedcube (3,35,8,erad/2);  
      }}}
  else{
      difference (){
      union(){
        roundedcube (encx,ency+airgap,base,erad);  
        translate ([wall+1,wall+1,-wall/2]) color("lightgrey") roundedcube (encx-2*wall-2,ency+airgap-2*wall-2,wall/2,erad);
          }      
        translate ([wall+bsuppwid,wall+bsuppwid,-wall/2-tol]) roundedcube (encx-2*wall-2*bsuppwid,ency+airgap-2*wall-2*bsuppwid,wall,erad);      
        translate ([2*wall,2*wall,-wall]) cylinder (r=M3_clear, h=2*base);    
        translate ([2*wall,2*wall,base/2]) cylinder (r1=M3_clear, r2=4, h=2.5);      
        translate ([2*wall,ency+airgap-2*wall,-wall]) cylinder (r=M3_clear, h=2*base);   
        translate ([2*wall,ency+airgap-2*wall,base/2]) cylinder (r1=M3_clear, r2=4, h=2.5);     
        translate ([encx-2*wall,2*wall,-wall]) cylinder (r=M3_clear, h=2*base);     
        translate ([encx-2*wall,2*wall,base/2]) cylinder (r1=M3_clear, r2=4, h=2.5);      
        translate ([encx-2*wall,ency+airgap-2*wall,-wall]) cylinder (r=M3_clear, h=2*base);
        translate ([encx-2*wall,ency+airgap-2*wall,base/2]) cylinder (r1=M3_clear, r2=4, h=2.5);        
    for (i=[boffset[0]+2*wall:10:bsize[0]+boffset[0]-wall]){
    translate ([i,encx/2+airgap-wall,-1]) roundedcube (3,35,8,erad/2);     
    }   }  } }

module airduct(a){    
    translate ([0,0,wall/2]) rotate ([-90,0,0]) cylinder (r=wall, h=2*wall);
    translate ([0,0,a-wall/2]) rotate ([-90,0,0]) cylinder (r=wall, h=2*wall); 
    translate ([-wall,0,wall/2]) cube([2*wall,2*wall,a-wall]);     
}

module wireslots(){
    translate ([0,0,12]) rotate ([-90,0,0]) cylinder (r=7, h=2*base); 
    translate ([-7,0,12.0]) cube([14,2*base,4]);  
    translate ([0,0,16]) rotate ([-90,0,0]) cylinder (r=7, h=2*base);        
}

module board (){
    difference(){
        union(){
        cube ([bsize[0],bsize[1],bsize[2]]);
        translate ([10,bsize[1],1]) cube([16,6,6]);
        }
    translate ([(bsize[0]-bmount[0])/2,(bsize[1]-bmount[1])/2,-1]) cylinder (r=M4_clear, h=bsize[2]+2);    
    translate ([bmount[0]+(bsize[0]-bmount[0])/2,(bsize[1]-bmount[1])/2,-1]) cylinder (r=M4_clear, h=bsize[2]+2);    
    translate ([(bsize[0]-bmount[0])/2,bsize[1]-(bsize[1]-bmount[1])/2,-1]) cylinder (r=M4_clear, h=bsize[2]+2);
    translate ([bmount[0]+(bsize[0]-bmount[0])/2,bsize[1]-(bsize[1]-bmount[1])/2,-1]) cylinder (r=M4_clear, h=bsize[2]+2);
    }   }
    
module boardx5 (){
    difference(){
        cube ([bsize[0],bsize[1],bsize[2]]);
    translate ([(bsize[0]-bmount[0])/2,(bsize[1]-bmount[1])/2,-1]) cylinder (r=M4_clear, h=bsize[2]+2);    
    translate ([bmount[0]+(bsize[0]-bmount[0])/2,(bsize[1]-bmount[1])/2,-1]) cylinder (r=M4_clear, h=bsize[2]+2);    
    translate ([(bsize[0]-bmount[0])/2,bsize[1]-(bsize[1]-bmount[1])/2,-1]) cylinder (r=M4_clear, h=bsize[2]+2);
    translate ([bmount[0]+(bsize[0]-bmount[0])/2,bsize[1]-(bsize[1]-bmount[1])/2,-1]) cylinder (r=M4_clear, h=bsize[2]+2);
    }   }

module guard(){
    
    translate([0,0,-grill_depth/2]) grill();
    surround();
}

module grill_rings(){
  difference(){
    cylinder(r=od/2,h=h);   
      translate([0,0,-0.5])
       cylinder(r=od/2-t,h=h+1);
  } }

module surround(){
	difference() {
        union() {
            hull()
            for(x = [-1, 1])
            for(y = [-1, 1])
                translate([x*(fan_width/2-2), y*(fan_width/2-2), fan_pos+grill_depth])
                cylinder(r=3.5, h=grill_depth, center=true);
            }		
        union() {
        translate([0, 0, 0])
        cylinder(r=fan_width/2-2, h=grill_depth+1, center=true);
        }
        for(i = [1: 4])
            rotate([0, 0, i*90])
            translate([fan_mount_dist/2, fan_mount_dist/2, 0])
            rotate([180, 0, 0])
            cylinder(r=M3_clear, h=wall+grill_depth, center=true);//M3 bolt
        for(i = [1: 4])
		rotate([0, 0, i*90])
        if (nuttrap == true){
        translate([fan_mount_dist/2, fan_mount_dist/2, 0]) hexagon_prism(M3_nut_trap,M3_nut_trap); //Nut Trap 
        }
            else{
        translate([fan_mount_dist/2, fan_mount_dist/2, 0]) cylinder(h=M3_head_ht, r=M3_head_dia); //bolt head
            }    
        }   }    

module grill(){
intersection(){
  rotate([0,0,45])
    union(){
      for ( n = [grill_space:grill_space:fan_width-grill_space+tol] ) {
        if(n==grill_space){
          grill_rings(od=n,t=rings_wid,h=grill_depth);        
        }else{
        grill_rings(od=n,t=rings_wid,h=grill_depth);
        }   } }
    translate([-fan_width/2,-fan_width/2,0])
      cube([fan_width,fan_width,grill_depth]);
    }
for(a=[45,-45,135,-135]){
  rotate([0,0,a])
    translate([grill_space/2-rings_wid,-rings_wid/2,0])
      cube([(fan_width/2-grill_space/2+0.01),rings_wid,grill_depth]);// rods
}   }

module roundedcube(xdim,ydim, zdim, rdim){
    hull(){
    translate ([rdim,rdim,0]) cylinder (r=rdim,h=zdim);
    translate ([xdim-rdim,rdim,0]) cylinder (r=rdim,h=zdim);
    translate ([rdim,ydim-rdim,0]) cylinder (r=rdim,h=zdim); 
    translate ([xdim-rdim,ydim-rdim,0]) cylinder (r=rdim,h=zdim);
    }   }