
$fn=100;
A();
translate([30,70,-15]) rotate([0,90,0]) !B();

module A(){
difference(){
    union(){
        minkowski(){
            cube([30-3,90,2],center=true);
            cylinder(d=3,h=1,center=true);
        }
        translate([25,41.5,0])  hull(){
            translate([12,0,0]) cylinder(d=10,h=3,center=true);
            translate([-12,0,0]) cylinder(d=10,h=3,center=true);
            
        }
    }
    translate([ 9.5,0,0])hull(){
        translate([0,35,0]) cylinder(d=3.5,h=10,center=true);
        translate([0,-40,0]) cylinder(d=3.5,h=10,center=true);
    }
    translate([-9.5,0,0])hull(){
        translate([0,35,0]) cylinder(d=3.5,h=10,center=true);
        translate([0,-40,0]) cylinder(d=3.5,h=10,center=true);
    }
    translate([25,41.5,0])hull(){
        translate([12.5,0,0]) cylinder(d=3.5,h=10,center=true);
    translate([-12,0,0]) cylinder(d=3.5,h=10,center=true);
        
        
        }
    
}
}
module B(){
    cube([20,60,1],center=true);
    translate([10,30,5]) difference(){
        cube([40,3,11],center=true);
        translate([10,0,0]) rotate([90,0,0]) cylinder(d=3.5,h=10,center=true);
        translate([-10,0,0]) rotate([90,0,0]) cylinder(d=3.5,h=10,center=true);
    }
}
 
 