use <bottom.scad>
use <../wheel.scad>
$fn=100;
motorFix();
!wheelRoom();
 
//bottomA();
//bottomFix();
module bottomA(){   
    _h=2; 
    h1 = 8.4;
    translate([1.5,0,17.1]) {
        
        difference(){
            union(){
                translate([-3,0,0]) cube([14,20,_h],center=true);   
                //translate([10,8,-2]) cube([1,5,3],center=true);
                
                translate([2.5,0,0]) difference(){
                    //RoomInface(_h=3); 
                    translate([-15,0,0]) union(){                
                        translate([5,0,0]) cube([10,4,_h],center=true);
                        cylinder(d2=5,d1=5,h=_h,center=true);                    
                    }
                    translate([-15,0,0]) cube([10,0.6,10],center=true);
                }
            }  
            translate([-2,0,-0.5]) cube([8,10,1],center=true);
            //translate([-3,0,-0.7]) cube([10,20,0.6],center=true);
            translate([-3,8,0]) cube([5,0.6,_h*2],center=true);
            translate([-3,-8,0]) cube([5,0.6,_h*2],center=true);
        }
        /*
        translate([-3.3,0,-9.7]) rotate([0,90,0]) difference(){   
            intersection(){         
                cylinder(d=32,h=h1,center=true);    
                translate([-5.9,0,0]) cube([10,40,h1],center=true);
            }    
            difference(){
                cylinder(d=26.4,h=15,center=true);
                rotate([0,0,20]) translate([0,14,0]) rotate([90,0,0])# cylinder(d=5,h=3,center=true);
                rotate([0,0,-20]) translate([0,-14,0]) rotate([90,0,0])# cylinder(d=5,h=3,center=true);
            }
        }
         */
    }
}
module bottomFix(){
    h=8;
    dh = -1.6;
    th = 71;
    moveY = 15;
    translate([20,0,12])  difference(){
        union(){            
            translate([0,moveY,0]) intersection(){
                cube([25,th,h],center=true);
                translate([0,0,dh]) rotate([90,0,0]) cylinder(d=22,h=th,center=true);
            }
            translate([12.9,0,4.5]) cube([2.8,27,1],center=true);
            translate([-12.9,0,4.5]) cube([2.8,27,1],center=true);
            //#cube([29.2,34,h],center=true);
            difference(){
                intersection(){
                    cube([35,34,h],center=true);
                   translate([0,0,-3.5])  rotate([0,90,0]) cylinder(d=31,h=35,center=true);                    
                }                
                translate([16,0,0]) intersection(){
                    cube([13,27,h+1],center=true);
                    translate([0,0,-3.5]) rotate([0,90,0]) cylinder(d=26.5,h=3.4,center=true);
                }
                translate([-16,0,0]) intersection(){
                    cube([13,27,h+1],center=true);
                    translate([0,0,-3.5]) rotate([0,90,0]) cylinder(d=26.5,h=3.4,center=true);
                }      
                
            }
            //translate([0,0,4]) cube([35,35,2],center=true);
            //translate([0,16.2,0]) cube([35,3,h],center=true);
            //translate([0,-16.2,0]) cube([35,3,h],center=true);
            difference() {                
                intersection(){
                    translate([0,0,-3.5])  rotate([0,90,0]) cylinder(d=10.5,h=35,center=true);
                    cube([50,75,h],center=true);
                }                
                translate([18.8,0,0]) rotate([0,20,0]) cube([5,11,13],center=true);
                mirror([1,0,0]) translate([18.8,0,0]) rotate([0,20,0]) cube([5,11,13],center=true);
            }
        }
         
        intersection(){
            cube([28,25,h+1],center=true);
            translate([0,0,-3.5]) rotate([0,90,0]) cylinder(d=20,h=23,center=true);
        }
     
         
        translate([0,moveY,dh]) union(){
            _battery18650_(_h=66);
            //rotate([90,0,0]) cylinder(d=10.2,h=67,center=true);
           translate([0,40,3])  cube([5,20,1],center=true);
           translate([0,-40,3])  cube([5,20,1],center=true);
        }
    }    
}

module motorFix(){
    difference(){
        union(){
            motorFixBody();        
            translate([40,0,0]) mirror([1,0,0]) motorFixBody();        
            translate([20,0,0]) { 
                minkowski(){
                    cube([52-3,37+7.5,1],center=true);
                    cylinder(d=3,h=1,center=true);
                }    
            }
        } 
        translate([20,0,0])  cube([50,8,20],center=true);
        translate([-2.8,0,0]) cube([7,16,20],center=true);  
        translate([40+2.8,0,0]) cube([7,16,20],center=true);
        
        translate([0,18.5,0]) cylinder(d=7.5,h=20,center=true);
        translate([0,-18.5,0]) cylinder(d=7.5,h=20,center=true);
        translate([40,0,0]){
            translate([0,18.5,0]) cylinder(d=7.5,h=20,center=true);
            translate([0,-18.5,0]) cylinder(d=7.5,h=20,center=true);
        }
    }      
}
module motorFixBody(){
    t1 = 25;
    difference(){
        union(){
            translate([-13,0,7.5]) intersection(){
                cube([17,29,17],center=true);
                translate([0,0,1]) rotate([0,90,0]) cylinder(d=29,h=14,center=true);
            }
            translate([-1.5,0,7.5])  intersection(){
                 
                cube([25,29,17],center=true);
                      
                translate([0,0,1]) rotate([0,90,0]) cylinder(d=26,h=14,center=true);
            }
            translate([-3,0,7.5]) intersection(){
                 difference (){
                    translate([0,0,1.5]) cube([6,29,20],center=true);
                    translate([0,0,1]) {
                        intersection(){
                           translate([0,0,9.5]) cube([25,17,3.2],center=true);
                           rotate([0,90,0]) cylinder(d=25,h=50,center=true);
                        }
                        translate([0,0,9.5]) cube([25,16,3.2],center=true);
                    }
                }
                translate([0,0,1]) rotate([0,90,0]) cylinder(d=29,h=14,center=true);
            }

        } 
        
        translate([0,0,8.5]){
            translate([0,0,0]) rotate([0,90,0]) cylinder(d=11,h=30,center=true);
            translate([-24.3,0,0])  rotate([0,90,0]) motorTemp(_h=25);         
            translate([-20,0,0]){
                difference(){
                    rotate([0,90,0]) cylinder(d=24.8,h=11.5);
                    translate([9.85,0,-12.5]) cube([9.2,40,20],center=true);                    
                    translate([17,0,-10]) RoomInface();                    
                }
                translate([1,0,0])  cube([10,0.6,20],center=true);
            }
        }
    }
    
}
module wheelRoom(){
    h_ = 31;
   difference(){
         translate([-33.5,0,8.5])  rotate([0,90,0]) translate([0,0,22]) intersection(){
            cylinder(d=24.8,h=h_,center=true);
            translate([-10.5,0,0]) cube([5,16.8,h_],center=true);
        }
        translate([-2,4,20]) cube([5,0.5,10],center=true);
        translate([-2,-4,20]) cube([5,0.5,10],center=true);
        translate([-2,0,8])  cube([8,9,20],center=true);
        
    }
    difference(){
        translate([-33.5,0,8.5]) {
            rotate([0,90,0])  showWheelRoom(); 
        }
        translate([-2,0,-4]){
            cube([25,40,20],center=true);
            RoomInface();
        }
        translate([-1.2,0,7]) union(){
            //difference(){
                cube([15,40,29],center=true);
                //rotate([0,90,0]) cube([50,16.8,h_],center=true);
            //}
            
        }
       
    }
}

 