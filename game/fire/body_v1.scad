use <../wheel.scad>
$fn=100;

translate([-58,-6,0]) rotate([0,90,0]) showWheelRoom();
difference(){
body();
  //translate([0,0,10])  cube([10,100,120],center=true);
}
//translate([0,20,0]) body_Lock(_dx=40);
module body(_dx=40){

    _mrbY = 40;
    _mrbZ = 25;
    link_Y = 20;
    link_x = 18;
    kh=14;
    translate([0,19.5,-13.8])rotate([0,90,0]) #hull(){
            cylinder(d=1,h=46,center=true);
            translate([0,-0.6,0]) cylinder(d=1,h=46,center=true);
        };
    difference(){
        union(){
            minkowski(){
                cube([_dx+14*2,_mrbY-1,_mrbZ],center=true);
                rotate([90,0,0]) cylinder(d2=3,d1=2.5,h=2,center=true);
            } 
            translate([0,-_mrbY/2-0.5,0])  rotate([0,90,90])  union(){
                //_links();
                translate([0,link_Y,0]){
                    _links(dx=link_x);
                  // translate([-15,0,0])  rotate([0,90,0]) #cylinder(d=6,h=2,center=true);
                }
                translate([0,-link_Y,0]) _links(dx=link_x);
            }
            
        }
 
 
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
        }
        cube([_dx+3,_mrbY+2,15],center=true);

        translate([0,15,0]) {
            translate([_dx/2+2,0,0])   cube([4,_mrbY,21],center=true);
            translate([-(_dx/2+2),0,0])   cube([4,_mrbY,21],center=true);
        }            
            
        translate([-(_dx/2+3.4),-1,0]) _motorRoomBottom_f(_mrbY=_mrbY);
        rotate([0,180,0]) translate([-(_dx/2+3.4),-1,0]) _motorRoomBottom_f(_mrbY=_mrbY );  
       
    }         
    
}
module motor_Lock(){
    
    difference(){
        union(){
        translate([1,1,0]) cube([8,18,19.5],center=true);
       
        }
        translate([0,-17,0]) difference(){
            rotate([90,0,90]) {
                cylinder(d=25,h=20,center=true);
               
            }
             translate([-0.3,12.5,0]) rotate([90,0,0]) cylinder(d=4.8,h=3,center=true);
             
        }
       translate([-0.3,0,10])  cube([1.4,100,1.4],center=true);
        translate([-0.3,0,-10])  cube([1.4,100,1.4],center=true);
        
 
        
      //  translate([1,5,0]) cube([8,12,10],center=true);
    }
    
}

module _motorRoomBottom_f(_mrbMoveX = -4,_mrbY = 50){
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
                     
                }
            }             
 
            translate([-6.5,-10,10]) cube([1,100,1],center=true);
            translate([-6.5,-10,-10]) cube([1,100,1],center=true);
            
            translate([-6.5,-32,0]) rotate([90,0,0]) cylinder(d=4.8,h=2,center=true);
           
        }
        translate([1,4,0])  cube([6,_mrbY+4,25],center=true);
       // translate([1,28,0])  cube([6,_mrbY,30],center=true);
    }
    
}
module body_Lock( _mrbZ = 25,_dx=70){
    
    link_Y = 20;
    link_x = 18;
    difference(){
        union(){
            translate([-13.5-_dx/2,-9,0]) motor_Lock();
            rotate([0,180,0]) translate([-13.5-_dx/2,-9,0]) motor_Lock();
        }        
        translate([0,5,0])  cube([_dx+16*2+4,5,_mrbZ+3],center=true);
    }
    
    
    
    
    difference(){
        union(){
            minkowski(){
                cube([_dx+14*2+4,4,_mrbZ+3],center=true);
                rotate([90,0,0]) cylinder(d=3.5,h=1,center=true);
            }            
            translate([0,2.5,0])  rotate([0,90,-90])  union(){
                //_links();
                translate([0,link_Y,0]) _links(dx=link_x);
                translate([0,-link_Y,0]) _links(dx=link_x);
            }
            
        }
        // translate([0,-2,0]) cube([_dx+20,20,30],center=true);
        // translate([0,-13,0]) body(_dx);
        
        translate([0,-2.2,0]) minkowski(){
            cube([_dx+14*2+0.5,5,_mrbZ-0.5],center=true);
            rotate([90,0,0]) cylinder(d=4,h=1,center=true);
        }         
        //translate([0,-0.5,14.1])  rotate([0,90,0])   linear_extrude(height=6,center=true) _guanDao();
        
        translate([0,-0.5,-14.1]) rotate([0,90,0])hull(){
            cylinder(d=1,h=46,center=true);
            translate([0,-1,0]) cylinder(d=1,h=46,center=true);
        }
        
         
        translate([23,-1.5,-15]) cube([0.5,16,5],center=true);
        translate([-23,-1.5,-15]) cube([0.5,16,5],center=true);
        //translate([17,-1.5,-15]) cube([0.5,16,5],center=true);
        //translate([-17,-1.5,-15]) cube([0.5,16,5],center=true);
        
       // translate([3,-1.5,15]) cube([0.5,16,5],center=true);
       // translate([-3,-1.5,15]) cube([0.5,16,5],center=true);
         
    }
}
module _links( dx = 14){
    out_d = 9.5;
    //l_h = 3.4;
    t_d = 4.8;    
    t_h_ = 26;
    //t_y_ = 12.3;
    
    translate([-8,0,1.5]) rotate([0,-90,0]) difference(){
        union(){
        cyInterface(t_d = t_d,_h = t_h_);
         translate([0,0,6.5]) cylinder(d=6,h=3,center=true);
        }
        translate([-2.5,0,0]) cube([2,6,t_h_*2],center=true);
       
    }
    /*
    difference(){
        //hull(){
        translate([dx,0,0]) union(){
            cylinder(d=out_d,h=2,center=false);
            translate([-out_d/2,0,1]) cube([out_d,out_d,2],center=true);
        }
          //  translate([-dx,0,0]) cylinder(d=out_d,h=2,center=false);
        //}
        translate([dx,0,0]) cylinder(d=5.5,h=5,center=true);
        //translate([-dx,0,0]) cylinder(d=5.5,h=5,center=true);
    }
    */
}
module cyInterface(t_d=4.8,fk=0.8,_h = 36){
    __h = _h/2-1;
    difference(){ 
        union(){
            cylinder(d=t_d,h=_h,center=true);
            translate([0,0,__h]) {
                cylinder(d1=t_d+fk,d2 = t_d,h=2,center=false);
                translate([0,0,-1]) cylinder(d=t_d+fk,h=1,center=false);
                translate([0,0,-3]) cylinder(d2=t_d+fk,d1 = t_d,h=2,center=false);
            }
        }
        translate([0,0,__h]) cube([t_d+2,1,10],center=true);
    }    
}