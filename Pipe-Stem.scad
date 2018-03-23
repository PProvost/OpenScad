$fn=32;

stem_len = 2.25; // inches
stem_len_mm = stem_len * 25.4;
bit_len = 8;
entry_port_len = 7;
insert_510_len = 6;

channel_len = stem_len_mm-bit_len;

show_half_cut = false;
show_nautilus_ring = true;

module bore_primary_channel() {
  // tapered part
  translate([0,0,0]) cylinder(d1=3,d2=2.5, h=channel_len-1.99);
  // expand to bit
  translate([0,0,channel_len-2]) 
    linear_extrude(height=1.01, scale=[2.5,1.25]) circle(d=2.5);
  translate([0,0,channel_len-1]) 
    bit_bore(1.01);
}

// Total height of entry+expansion == 17
module bore_entry_and_expansion() {
  // Entry port
  translate([0,0,-0.5]) cylinder(d=3, h=entry_port_len+1);
  
  // Expansion chamber
  translate([0,0,entry_port_len]) cylinder(d=8, h=6);
  translate([0,0,entry_port_len+6-0.1]) cylinder(d1=8,d2=3, h=4.1);
}

module bore_all() {
  translate([0,0,4]) bore_entry_and_expansion();
  //#translate([0,0,10+entry_port_len]) 
  bore_primary_channel();
  // translate([0,0,channel_len+10+entry_port_len]) bore_bit();
}

module 510_insert() {
  difference() {
    cylinder(d=8.35, h=insert_510_len);
    translate([0,0,1.5]) rotate_extrude() translate([8.35/2,0,0]) circle(d=1);
    translate([0,0,3.5]) rotate_extrude() translate([8.35/2,0,0]) circle(d=1);
  }
}

module bit_bore(h) {
  linear_extrude(height=h)
      scale([2.5,1])
        circle(d=2.5);
}

module bit() {
  // cylinder(d=8,h=bit_len);
  // translate([0,0,bit_len-1.5]) rotate_extrude() translate([4,0,0]) circle(d=3);
  
  // linear_extrude(height=bit_len, scale=[0.75,0.5]) 
  difference() {
    union() {
      linear_extrude(height=bit_len*0.6, scale=1.25)
        scale([0.75,0.5])
          circle(d=12);

      translate([0,0,bit_len*0.6]) 
      linear_extrude(height=bit_len*0.4, scale=0.8)
        scale([0.75,0.5])
          circle(d=15);
    }
    
    translate([0,0,-0.1]) bit_bore(bit_len+0.2);
  }
}

module stem_outer() {
  cylinder(d=14,h=12);
  translate([0,0,12]) linear_extrude(height=stem_len_mm-(12+insert_510_len+bit_len), scale=[9/14,6/14]) circle(d=14);
}

module stem_outer_old() {
  cylinder(d=17,h=12);
  step1_len = (stem_len_mm/3)-(6+12+1);
  translate([0,0,12]) cylinder(d1=17,d2=12, h=step1_len);
  step2_len = (2*stem_len_mm/3)-6;
  translate([0,0,12+step1_len]) 
    linear_extrude(height=step2_len, scale=[0.75,0.5]) circle(d=12);
}

module stem_all() {
  //510_insert();
  translate([0,0,6]) stem_outer();
}

// height measuring stick
// translate([30,0,0]) cylinder(d=3,h=stem_len_mm);

difference() {
  union() {
    translate([0,0,stem_len_mm-(bit_len)]) bit();
    difference() {
      stem_all();
      bore_all();
      translate([0,0,5.99]) cylinder(d=10.15, h=12);
    
    }
          if (show_nautilus_ring==true) {
        translate([0,0,4]) 
        difference() {
          cylinder(d=14, h=2);
          translate([0,0,-0.05]) cylinder(d1=14, d2=10.15, h=2.1);
        }
      }
  }
  if(show_half_cut==true)
    translate([-10,0,-5]) cube([20,20,stem_len_mm+50]);
}

