atty_d = 24;
band_h = 8;
thickness = 1.6;

$fn=64;

difference() {
  cylinder(d=atty_d+thickness, h=band_h);
  cylinder(d=atty_d, h=band_h);
}