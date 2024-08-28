use <car_v10_lib.scad>
use <car_v10_body_lock.scad>
$fn=80;
//Body_x = 30;
Body_x = 40;
union(){
    body(_dx=Body_x);
    translate([0,20,0]) body_Lock(_dx=Body_x);
}
rotate([0,180,0]) translate([0,-6,14.8]) body_link_B();
translate([0,-6,14.8]) body_link();

module body_link(){
    dx = 12.5+Body_x/2;
    // translate([0,-_mrbY/2+2,_mrbZ/2+2.25])  cube([link_Y*2+3,5,1.5],center=true);
    translate([0,-13,0]) difference(){
        union(){
            hull(){
                translate([20,0,0]) cylinder(d=11,h=1.4,center=true);
                translate([-20,0,0]) cylinder(d=11,h=1.4,center=true);
            }
            translate([0,5,0]) cube([51,10,1.4],center=true);
        }
        translate([20,0,0]) cylinder(d=5.5,h=2,center=true);
        translate([-20,0,0]) cylinder(d=5.5,h=2,center=true);
    }
    hull(){
        translate([dx,0,0]) cylinder(d=7,h=1.4,center=true); 
        translate([-dx,0,0])cylinder(d=7,h=1.4,center=true);
    }
    translate([0,0,-1]){
        translate([dx,0,0]) cylinder(d=7,h=2,center=true);
        translate([-dx,0,0]) cylinder(d=7,h=2,center=true);
        
        translate([dx,0,-2.5]) cylinder(d=3.4,h=5,center=true);
        translate([-dx,0,-2.5]) cylinder(d=3.4,h=5,center=true);
    }
    
}
module body_link_B(){
    dx = 12.5+Body_x/2;
    translate([0,0,1.5]) hull(){
        translate([dx,0,0]) cylinder(d=7,h=1.4,center=true); 
        translate([-dx,0,0])cylinder(d=7,h=1.4,center=true);
    }
    translate([0,0,0]){
        translate([dx,0,0]) cylinder(d=7,h=4,center=true);
        translate([-dx,0,0]) cylinder(d=7,h=4,center=true);
         } 
    translate([0,0,-3.5]){
        translate([dx,0,0]) cylinder(d=3.4,h=5,center=true);
        translate([-dx,0,0]) cylinder(d=3.4,h=5,center=true);
    }
  
    
}
module body(_dx=40){

    _mrbY = 40;
    _mrbZ = 25;
    link_Y = 20;
    link_x = 18;

    
    
    // cube([_dx,_mrbY,_mrbZ],center=true);
    //translate([0,19.5,13.8]) rotate([-15,0,0])   rotate([0,90,0])   linear_extrude(height=6,center=true) _guanDao();
    translate([0,19.5,-13.8])rotate([15,0,0]) difference(){
        rotate([0,90,0])   linear_extrude(height=45.5,center=true) _guanDao();
        cube([34.5,10,10],center=true);
    }
    
   // translate([0,-_mrbY/2+2,_mrbZ/2+2.25])  cube([link_Y*2+3,5,1.5],center=true);
    
    kh=14;
    
    difference(){
        union(){
            minkowski(){
                cube([_dx+14*2,_mrbY-1,_mrbZ],center=true);
                rotate([90,0,0]) cylinder(d2=3,d1=2.5,h=2,center=true);
            } 
            translate([0,-_mrbY/2-0.5,0])  rotate([0,90,90])  union(){
                //_links();
                translate([0,link_Y,0]) _links(dx=link_x);
                translate([0,-link_Y,0]) _links(dx=link_x);
            }
            
        }
        translate([12.5+_dx/2,-6,0]) union(){
            cylinder(d=3.5,h=_mrbZ*2,center=true);
            translate([0,0,kh]) cylinder(d=8,h=3,center=true);
            translate([0,0,-kh]) cylinder(d=8,h=3,center=true);
        }
        translate([-(12.5+_dx/2),-6,0]) union(){
            cylinder(d=3.5,h=_mrbZ*2,center=true);
            translate([0,0,kh]) cylinder(d=8,h=3,center=true);
            translate([0,0,-kh]) cylinder(d=8,h=3,center=true);
            
        }
        /*
        translate([0,19,0]) # difference(){
          //  minkowski(){
          //  cube([_dx+14*2+4,4,_mrbZ+3],center=true);
               // rotate([90,0,0]) cylinder(d=3.5,h=1,center=true);
          //  }
            
            translate([0,0,0]) minkowski(){
                cube([_dx+14*2,1,_mrbZ],center=true);
                rotate([90,0,0]) cylinder(d2=3,d1=1,h=5,center=true);
            } 
        }
        */
        
        rotate([0,90,0])  rotate([0,0,90]) translate([1,0,-10]) union(){
             translate([0,0,-5]) union(){
                cube([_mrbY+1,18,2],center=true);
                cube([_mrbY+1,17,10],center=true);
            }
            translate([0,0,5]) union(){
                cube([_mrbY+1,26.5,2],center=true);
                cube([_mrbY+1,25,10],center=true);
            }
            translate([0,0,15]) union(){
                cube([_mrbY+1,26,2],center=true);
                cube([_mrbY+1,24.5,10],center=true);
            }  
            translate([15,0,25]) union(){
                cube([_mrbY+1,26,2],center=true);
                cube([_mrbY+1,24.5,10],center=true);
            }             
            translate([0,0,25]) union(){
                cube([_mrbY+1,23,2],center=true);
                cube([_mrbY+1,21.5,10],center=true);
            }
           
            /*
            translate([0,0,20]) union(){
                cube([40,18,2],center=true);
                cube([40,17,10],center=true);
            }
            */
        }
        cube([_dx+3,_mrbY+2,15],center=true);

        translate([0,15,0]) {
            translate([_dx/2+2,0,0])   cube([4,_mrbY,21],center=true);
            translate([-(_dx/2+2),0,0])   cube([4,_mrbY,21],center=true);
        }
            
            
        translate([-(_dx/2+3.4),-1,0]) _motorRoomBottom_f(_mrbY=_mrbY);
        rotate([0,180,0]) translate([-(_dx/2+3.4),-1,0]) _motorRoomBottom_f(_mrbY=_mrbY );
            /*
        translate([30,16,0]) difference(){
            cube([8,10,30],center=true);
            
            cube([8,10,23],center=true);
        }
        rotate([0,180,0]) translate([30,16,0]) difference(){
            cube([8,10,30],center=true);
            
            cube([8,10,23],center=true);
        }
          */   
            
            
       
    }         
    
}


module _motorRoomBottom_f(_mrbMoveX = -4,_mrbY = 40){
    translate([_mrbMoveX,0,0]) {
        translate([5,5,0]) cube([20,_mrbY,10],center=true);
        
        translate([0,_mrbY/2-5,0]) difference(){
            translate([-6,0,0]) union(){
                cube([20,_mrbY,20],center=true);
                //cube([1,100,100],center=true);
                translate([0,-20,0]) difference(){
                    rotate([0,90,0])  intersection(){
                          cylinder(d=25.2,h=20,center=true);
                          cube([20,25.5,20],center=true);                                
                    }
                    translate([-4.5+6,0,0]) rotate([0,90,0]) rotate_extrude(angle=360) translate([12.5,0])      _guanDao();
                }
            }             
            translate([-4.5,0,10])  rotate([0,90,0]) rotate([90,0,0])   linear_extrude(height=60,center=true) _guanDao();
            translate([-4.5,0,-10])  rotate([0,90,0]) rotate([90,0,0])   linear_extrude(height=60,center=true) _guanDao();
            
           
        }
        translate([1,4,0])  cube([6,_mrbY+4,25],center=true);
       // translate([1,28,0])  cube([6,_mrbY,30],center=true);
    }
    
}


