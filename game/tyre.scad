$fn=100;
k = 22 * PI /3;
ki = 360/k;
rotate_extrude() translate([20,0]) square([2,10]);
rotate_extrude() translate([19.8,0]) square([2,1]);
translate([0,0,9]) rotate_extrude() translate([19.8,0]) square([2,1]);

for(i=[0:1:k-1]) rotate([0,0,ki*i]) translate([22,0,5]) cube([2,3,10],center=true);