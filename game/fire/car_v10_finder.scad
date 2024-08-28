use <car_v10_battery.scad>
use <car_v10_motor_room.scad>

$fn=100;
_r = 65;
_h=30;
my=30;

translate([0,-12,-26.6])  batteryBody();
finderFixDown();
mirror([0,1,0]) finderFixDown();
!finderFix();
 
module finderFix(){
    outx = -50;
    outy = 20;
    translate([-30,0,5]){
        translate([5,0,0]) cube([10,49.5,6],center=true);
        difference(){        
            cylinder(d=49.5,h=6,center=true);
            translate([20,0,0]) cube([40,49.5,7],center=true);
        }
        translate([-5,14,-1.5]) difference(){
            hull(){        
                cylinder(d=20,h=3,center=true);
                translate([outx,outy,0]) cylinder(d=20,h=3,center=true);
            }
            translate([outx,outy,0]) cylinder(d=3.5,h=10,center=true);
            //translate([-30,0,0]) cylinder(d=3.5,h=10,center=true);
        }
    }
    /*
    #union(){
        translate([0,0,0]) cube([8,13,22],center=true);
        translate([-15,0,0])  rotate([0,0,0]) {
            translate([0,3.5,0])   cylinder(d=5.5,h=20,center=true);
            translate([0,-3.5,0])  cylinder(d=5.5,h=20,center=true);
        }
    }
    */
    
}
module finderFixDown(){
    
    difference(){
        translate([0,30,5])  difference(){
            translate([0,-10,0]) cube([60,30,15],center=true);
            translate([0,-20,2])  cube([32,20,14],center=true);
            translate([0,15,5])  cube([32,70,10],center=true);            
        }
        //#fire();        
        
        difference(){
            translate([0,10,5])  cube([80,30,6.4],center=true);    
            //translate([0,my+160,32]) cylinder(d=_r*4-1,h=70,center=true);
            cube([39.6,200,40],center=true);
            
            translate([0,0,32]) union(){                
                translate([-24,0,-30])  cube([1.8,300,1.6],center=true);
                translate([-27,0,-24])  cube([1.8,300,1.6],center=true);
                
                translate([24,0,-30])  cube([1.8,300,1.6],center=true);
                translate([27,0,-24])  cube([1.8,300,1.6],center=true);
            }
        }
        
        translate([12,12,0]) cylinder(d=5.4,h=20,center=true);
        translate([-12,12,0]) cylinder(d=5.4,h=20,center=true);
    }
    
}
 