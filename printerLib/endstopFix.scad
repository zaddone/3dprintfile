$fn = 100;
d1 = 3.5;
x = 30;
y  = 10;
difference(){
    union(){
    hull(){
        translate([0,5,0])cylinder(d=10,h=3,center=false);
        translate([0,10+y*2,0])cylinder(d=10,h=3,center=false);
    }
  
    translate([10,0,4])cylinder(d=9,h=8,center=true);
    translate([-10,0,4])cylinder(d=9,h=8,center=true);
    
    hull(){
        translate([10,0,0])cylinder(d=9,h=3,center=false);
        translate([-10,0,0])cylinder(d=9,h=3,center=false);
    }
    
}
    hull(){
        translate([0,5,0])cylinder(d=d1,h=31,center=false);
        translate([0,10+y*2,0])cylinder(d=d1,h=31,center=false);
    }
 
    translate([10,0,0]) cylinder(d=d1,h=30,center=true);
    translate([-10,0,0])cylinder(d=d1,h=30,center=true);
    
}
 



 
