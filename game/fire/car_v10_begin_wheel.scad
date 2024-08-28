use <car_v10_lib.scad>

$fn=100;
translate([0,0,-80]) cube([1,400,10],center=true);
 //rotate([10,0,0]) translate([0,-114,5]) rotate([0,180,180])  begin_wheel1();
 
 translate([0,-114,-15]) rotate([0,180,180])  begin_wheel();
 
module begin_wheel(){
    rotate([10,0,0]) translate([22,-14,0])  ting();
    //rotate([10,0,0]) wheel_fix();
    translate([0,20,11]){ 
        wheel_body();
    translate([0,18,30])    rotate([0,90,0])   wheel_base();
    }
}


module ting(){
    difference(){
        union(){
        cyInterfaceBig(_h=24);
        translate([0,0,-12])  cylinder(d=7,h=2);
        }
        translate([3,0,0]) cube([2,10,40],center=true);
    }
    
}
module wheel_fix(){
    difference(){
        union(){
            translate([0,-10,0]) cube([60,20,6],center=true);
            hull(){
               translate([0,0,0]) cube([60,5,6],center=true);
               rotate([-10,0,0])  translate([0,20,6]) cylinder(d=20,h=8,center=true);
            }
        }
         translate([0,-10,-6]) cube([60,120,6],center=true);
        translate([0,-16,0]) cube([30,20,17],center=true);
        translate([22,-14,0])  cylinder(d=5.8,h=20,center=true);
        translate([-22,-14,0])  cylinder(d=5.8,h=20,center=true);
        translate([0,20,0]) cylinder(d=11,h=17,center=true);
    }
    
}
module wheel_base(){
    difference(){
    cylinder(d=35,h=5,center=true);
     cylinder(d=6.5,h=50,center=true);
    }
}
module wheel_body(){
    difference(){
        union(){
            hull(){
                cylinder(d=15,h=5);
                
                translate([0,10,24])  intersection(){
                    cylinder(d=28,h=10);
                    cube([15,50,20],center=true);
                }
            }
           translate([0,0,-8]) rotate([180,0,0]) cyInterfaceBig(t_d=10.5,_h=28);
          //#  cylinder(d=9,h=10,center=true);
        }
        translate([0,15,28])  scale([1.2,1.2,1.2]) rotate([0,90,0])  union(){
            cylinder(d=35,h=6,center=true);
             cylinder(d=5,h=50,center=true);
            cube([20,50,6],center=true);
        }
    }
    
}
