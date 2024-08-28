use <../wheel.scad>

showBottom();
module showBottom(){
    motorFix();
    !bottomFix();
    wheelRoom();
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

 

module wheelRoom(){
    difference(){
        translate([-33.5,0,8.5]) {
            rotate([0,90,0])  showWheelRoom();
            translate([29,0,9]) difference(){
                cube([5,20,2],center=true);
                cube([10,8,3],center=true);
            }
        }
        translate([-2,0,-4]){
            cube([25,40,20],center=true);
            RoomInface();
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
            //translate([0,-31,7]) cube([30,15,16],center=true);
            }
        }
        /*
            translate([0,0,0]){
            translate([20,-33,12]) # cube([5,3,30],center=true);
            translate([20,0,11]){
                _battery18650_();
                rotate([90,0,0]) cylinder(d=10.2,h=69,center=true);
            }
        
        }
        */
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
    difference(){
        union(){
            translate([-11.25,0,7.5]) intersection(){
                cube([20,29,17],center=true);
                translate([0,0,1]) rotate([0,90,0]) cylinder(d=29,h=17,center=true);
            }
            translate([1,0,7.5]) intersection(){
                cube([25,29,17],center=true);
                translate([0,0,1]) rotate([0,90,0]) cylinder(d=26,h=9,center=true);
            }
             /*
            #translate([-7.25,0,0])  hull(){
                cube([25,27,2],center=true);  
                translate([0,0,15]) cube([25,29,2],center=true);                  
            }
            */
             
        }
        // translate([-7.25,0,17]) cube([25,30,6],center=true);  
        translate([0,0,8.5]){
            translate([0,0,0]) rotate([0,90,0]) cylinder(d=11,h=30,center=true);
            translate([-24.3,0,0])  rotate([0,90,0]) motorTemp(_h=25); 
        
            translate([-19.8,0,0]){
                difference(){
                    rotate([0,90,0]) cylinder(d=24.8,h=14.5);
                    translate([9.85,0,-12.5]) cube([9.2,40,20],center=true);
                    
                    translate([17,0,-10]) RoomInface();
                    
                }
                translate([1,0,0])  cube([10,0.6,20],center=true);
            }
        }
    }
    
    //cube([]);
    
}
module RoomInface(_h=10){

    translate([-15,0,0]){
        translate([5,0,0]) cube([10,4,_h],center=true);
        cylinder(d=5,h=_h,center=true);
    }   
}
module _battery18650_(_h=66){
    rotate([90,0,0]) 
    union(){
        cylinder(d=18.5,h=_h,center=true);
    }
}
    