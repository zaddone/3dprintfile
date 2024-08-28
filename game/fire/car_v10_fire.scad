use <car_v10_battery.scad>
use <car_v10_lib.scad>
use <car_v10_wheel.scad>
use <car_v10_begin_wheel.scad>
use <car_v10_motor_room.scad>
use <car_v10_body.scad>

$fn=100;
_r = 63;
_h=30;
my_=7;
my=0;
rh = 00;

    dy = 13;
fireWorkLongTest();
fireWorkTest();
//ringB(isW = false);
//springTest();
//translate([0,0,-80]) cube([1,400,10],center=true);
rotate([0,0,0]) translate([0,-90,-15]) rotate([0,180,180]) // begin_wheel();
rotate([0,0,0]) union(){
union(){
    translate([0,my,32]) union(){
        fire();
      
        //mirror([1,0,0]) translate([-(_r+15.3),15,-2.5]) rotate([0,90,0]) spring();
        //translate([0,0,-5]) springFix();
  
    }
        
    union(){
        //fireFixDownA();
        
        union(){
            fireFixDownB();
            fireFixDownC();
            fireFixDownD();
        }
        
        !fireWorkTrack();
        fireWorkHread();
        //fireWorkHeadFinder();
 
        //fireFixDownB();
        
        //mirror([1,0,0]) fireFixBT();
        //fireFixBT();
        //translate([0,36,-20]) batteryFixFire();
//translate([0,-52,-20]) rotate([0,0,180]) batteryFixFire();
  
    
     translate([0,my ,-4]){
        rotate([0,0,rh]){
           // translate([0,0,40.4]) ring();
            translate([0,0,34.2]) ring(an=360);
        }
    }
     translate([0,-(98-my_+54),15-4]) {
        // ringB();
        translate([0,-dy,11.5]) rotate([180,0,-90]) !fireWork();
        !fireWorkLong();
        //translate([0,0,11.5]) rotate([180,0,90]) fireWork();
        //translate([0,0,0]) rotate([0,90,0]) motorRoom();
        
        
    }
      }
}

//nail();
union(){
    

 
    //translate([0,-(98-my_),20]) {
        // ringB();
        //translate([0,0,11.5]) rotate([180,0,-90]) fireWork();
        //translate([0,0,11.5]) rotate([180,0,90]) fireWork();
        //translate([0,0,0]) rotate([0,90,0]) motorRoom();
        
        
    //}
    
/*
 union(){
  translate([0,-9,-26.6])  batteryBody();
       rotate([0,0,0]) translate([0,-3,-23-26.6]) {
           body(_dx=40);
               translate([-40/2-27.7,-6,0]) motorRoom();
    rotate([0,180,0]) translate([-40/2-27.7,-6,0]) {
        motorRoom();
        rotate([0,90,0]) ringB();
    }
       }
    }  
    
    */
}

}
module fireWorkTest(){
    
       zr = 0;
    mx = 28.5;
    rotate([0,0,zr]){
    translate([0,0,-2.1]){ 
        difference(){
            union(){
                hull(){
                    cylinder(d=10,h=4,center=true);
                    translate([mx,0,0])  cylinder(d=12,h=4,center=true);
                } 
                translate([mx,0,7])rotate([0,0,90]) cyInterfaceBig(t_d=8,_h=12);
                //translate([0,0,-1.5]) springTest(_h=4);
            }
            //translate([30,0,0])  cylinder(d=11,h=10,center=true);
            //translate([mx,0,0]) cylinder(d=8,h=10,center=true);
            translate([0,0,0]) intersection(){
                cylinder(d=6.5,h=5,center=true);
                cube([4,8,5],center=true);
                 //cylinder(d=4,h=10,center=true);
            }
        }
       // translate([0,0,-2]) # springTest(_h=3);
    }
       // ringB_lib();
     

       // translate([mx,0,1]) rotate([0,0,-zr]) !fireWorkLong();
        //translate([-70,0,5]) fireWorkHread();
    //ringB(isW = false);

    }
}

module fireWorkLongTest(){
    xh=20;
    xlong=57+dy;
    difference(){
        union(){
            //translate([0,5,0])rotate([0,0,90]) cyInterfaceBig(t_d=8,_h=12);

            
            translate([-((xh+xlong)+xh),0,2])union(){ 
               translate([0,0,4]) rotate([0,0,90]) cyInterfaceBig(t_d=8,_h=15);
               translate([0,0,-4])  cylinder(d=10,h=12,center=true); 
            }
            //translate([-((xh+xlong)+10),0,-8.5])  cube([6,30,1],center=true);
            translate([0,0,-9]) difference(){ 
               union(){
                   //translate([0,0,0]) cylinder(d=10,h=4); 
                   
                   hull(){
                       translate([0,0,0]) cylinder(d=12,h=3);
                       translate([-xh,0,0])  cylinder(d=20,h=3,center=false);
                       //translate([-55,0,0])  cylinder(d=20,h=2,center=false);
                   }
                   hull(){
                       
                       translate([-xh,0,0])  cylinder(d=20,h=3,center=false);
                       translate([-(xh+xlong),0,0])  cylinder(d=20,h=3,center=false);
                   }
                   hull(){
                       
                       translate([-(xh+xlong),0,0]) cylinder(d=20,h=3,center=false);
                       translate([-(xh+xlong+xh),0,0]) cylinder(d=10,h=3);
                       //translate([-55,0,0])  cylinder(d=20,h=2,center=false);
                   }
         
                   
               }
               translate([0,0,0]) cylinder(d=8.5,h=4); 
           }
       }
      // rotate([0,0,180])  translate([ -10,-12,-15]) cube([xh*2+20+xlong,4,50]);
   }
  
}

module fireEar(earH=30){

    difference(){
        union(){
            hull(){
                cylinder(d=50,h=earH,center=true);   

                translate([0,20,0]) cube([10,30,earH],center=true); 
            }

            translate([0,-10,0]) cube([50,20,earH],center=true); 
        }
        translate([0,-35,2.5]) cube([41,60,earH],center=true);
        translate([0,-25,-1]) cube([30,60,earH],center=true);
        translate([0,0,-1]) cylinder(d=35,h=earH,center=true);  
        translate([0,0,-12.5])   cylinder(d=41,h=5,center=false);  
        
        //#translate([0,-24,-10]) cube([60,6,5],center=true);

    }            
}
module fireWorkLong(){
    xh=20;
    xlong=57+dy;
    difference(){
        union(){
            translate([0,5,0])rotate([0,0,90]) cyInterfaceBig(t_d=8,_h=12);

            
            translate([-((xh+xlong)+xh),0,2])union(){ 
               translate([0,5,4]) rotate([0,0,90]) cyInterfaceBig(t_d=8,_h=22);
               translate([0,5,-4])  cylinder(d=10,h=12,center=true); 
            }
            //translate([-((xh+xlong)+10),0,-8.5])  cube([6,30,1],center=true);
            translate([0,0,-9]) difference(){ 
               union(){
                   translate([0,5,0]) cylinder(d=10,h=4); 
                   
                   hull(){
                       translate([0,5,0]) cylinder(d=10,h=3);
                       translate([-xh,0,0])  cylinder(d=20,h=3,center=false);
                       //translate([-55,0,0])  cylinder(d=20,h=2,center=false);
                   }
                   hull(){
                       
                       translate([-xh,0,0])  cylinder(d=20,h=3,center=false);
                       translate([-(xh+xlong),0,0])  cylinder(d=20,h=3,center=false);
                   }
                   hull(){
                       
                       translate([-(xh+xlong),0,0]) cylinder(d=20,h=3,center=false);
                       translate([-(xh+xlong+xh),5,0]) cylinder(d=10,h=3);
                       //translate([-55,0,0])  cylinder(d=20,h=2,center=false);
                   }
         
                   
               }
           }
       }
       rotate([0,0,180])  translate([ -10,-12,-15]) cube([xh*2+20+xlong,4,50]);
   }
  
}
module fireWorkHeadFinder(){

      translate([0,-66,17.6])  rotate([90,0,0])  difference(){
          union(){
              hull(){
               cylinder(d=10,h=2,center=true);
              translate([0,-10,0]) cylinder(d=10,h=2,center=true);
              }
              hull(){
                 
                  translate([0,-10,0]) cylinder(d=10,h=2,center=true);
                  translate([0,-15,-1]) cylinder(d1=5,d2=2,h=7,center=false);
                  
              }
              translate([0,-13,-1])hull(){
                  cylinder(d=2,h=2,center=false); 
                 translate([0,-8,0]) cylinder(d=2,h=25,center=false);    
                 translate([0,-17,0])  cylinder(d=2,h=25,center=false);  
              }
          }
          cylinder(d=5.4,h=5,center=true);
      }
    
}
module fireWorkHread(){
    
    translate([0,-80,0]){
       translate([0,4,23]){
        /*
           translate([0,5,-2]) intersection(){
               intersection(){
                   cube([19,15,20],center=true);
                   rotate([25,0,0]) translate([0,-10,0])   cube([20,25,60],center=true);
               }
                rotate([-25,0,0]) translate([0,-11,0])   cube([20,25,60],center=true);
           }
           */
           translate([0,0,0])  hull(){
                
               translate([0,-2,7]) cube([19,1,1],center=true);
                translate([0,2,0]) cube([19,3,1],center=true);
                
                translate([0,0,-7]) cube([19,5,1],center=true);
           }
           /*
           translate([0,6,-5.8]) rotate([-90,90,0]) difference(){
                cyInterfaceBig(_h=10); 
                translate([3,0,0]) cube([2,10,40],center=true);
            }
           */
            
           translate([0,-10.5,2]) difference(){
                cube([19,16,17],center=true);
               cube([15,22,25],center=true);
               translate([0,-3,15]) rotate([45,0,0]) cube([20,41,21],center=true);
           }
       }
      translate([0,2,32]) hull(){
          translate([0,-1,1]) cube([19,1,2],center=true);
          translate([0,1,0]) cube([19,3,0.1],center=true);
          translate([0,-1,-4]) cube([19,1,1],center=true);
      }
        
       //translate([0,0,16]) # cube([25,10,3],center=true);
       translate([0,-4,16.2]) difference(){
           cube([25,21,2],center=true);
           translate([0,-3,0]) cylinder(d=8.5,h=10,center=true);
       }
    }
    
}
module fireWorkTrack(){
    translate([0,-51,13.2]) difference(){
        union(){
            translate([17.5,0,0]) hull(){
               cube([15,90,2],center=true);
               translate([-5,0,6])  cube([5,90,1],center=true);
               //cylinder(d=5,h=1);
            }
            translate([-17.5,0,0]) hull(){
               cube([15,90,2],center=true);
               translate([5,0,6])  cube([5,90,1],center=true);
               //cylinder(d=5,h=1);
            }
            
            translate([23,-35,-10]) rotate([180,0,0]) difference(){
                cyInterfaceBig(_h=20); 
                translate([3,0,0]) cube([2,10,40],center=true);
            }
            translate([-23,-35,-10]) rotate([180,0,180]) difference(){
                cyInterfaceBig(_h=20); 
                translate([3,0,0]) cube([2,10,40],center=true);
            }
             translate([23,20,-10]) rotate([180,0,0]) difference(){
                cyInterfaceBig(_h=20); 
                translate([3,0,0]) cube([2,10,40],center=true);
            }
            translate([-23,20,-10]) rotate([180,0,180]) difference(){
                cyInterfaceBig(_h=20); 
                translate([3,0,0]) cube([2,10,40],center=true);
            }
        }
        translate([0,0,3]) cube([28,100,2.4],center=true);
        /*
        translate([0,0,0]){
            translate([0,-35,0]){
                //translate([23,0,0]) cylinder(d=5.4,h=20,center=true);
                //translate([-23,0,0]) cylinder(d=5.4,h=20,center=true);
            }
            translate([0,20,0]){
                translate([23,0,0]) cylinder(d=5.4,h=20,center=true);
                translate([-23,0,0]) cylinder(d=5.4,h=20,center=true);
            }
        }
        */
    }
    
}
module fireWork(){
 
    zr = 0;
    mx = 28.5;
    rotate([0,0,zr]){
    translate([0,0,-2.1]){ 
        difference(){
            union(){
                hull(){
                    cylinder(d=42,h=3,center=true);
                    translate([mx,0,0.5])  cylinder(d=12,h=4,center=true);
                } 
                //translate([0,0,-1.5]) springTest(_h=4);
            }
            //translate([30,0,0])  cylinder(d=11,h=10,center=true);
            translate([mx,0,0]) cylinder(d=8.5,h=10,center=true);
            translate([0,0,5.5])  cylinder(d=47,h=10,center=true);
        }
       // translate([0,0,-2]) # springTest(_h=3);
    }
        ringB_lib();
     

       // translate([mx,0,1]) rotate([0,0,-zr]) !fireWorkLong();
        //translate([-70,0,5]) fireWorkHread();
    //ringB(isW = false);

    }
}
module ring(r=_r,an=360){    
    color("Green") rotate_extrude(angle=an) translate([r,0,0]) circle(3);  
}
module ring_fix(){
    ang=60;
    //translate([12.2,0,-24]) #battery_fix();
    
 
    
    translate([0,0,-10]) rotate([10,10,0]){ 
        rotate_extrude(angle=ang) translate([_r+4.5,0]) square([5,_h+20]);
        translate([0,0,2]) rotate_extrude(angle=60) translate([_r-5,0]) square([10,30]);
    }
    translate([0,0,0]) rotate([0,0,0]) rotate_extrude(angle=60) translate([39,0]) square([40,3]);
        
    
    
    /*
    rotate([0,0,2])  translate([85,0,_h-1.5])difference(){
        rotate([0,90,0])  cyInterface(_h=15);
        translate([0,0,2.5])  cube([20,10,2],center=true);
    }
    rotate([0,0,48])  translate([85,0,_h-1.5]) difference(){
        rotate([0,90,0])  cyInterface(_h=15);
        translate([0,0,2.5])  cube([20,10,2],center=true);
    }
    */
}
module fireFixDownA(){
    difference(){
        translate([0,30,5])  difference(){
            translate([0,-3,0]) cube([60,44,15],center=true);
            translate([0,-20,2])  cube([32,20,14],center=true);
            translate([0,0,2])  cube([32,30,14],center=true);            
        }
        //#fire();        
        
        difference(){
            translate([0,30,5])  cube([80,70,6.4],center=true);    
            //translate([0,my+160,32]) cylinder(d=_r*4-1,h=70,center=true);
            cube([39.6,200,40],center=true);
            translate([0,75.5,0])  cube([160,60,70],center=true);
            //translate([0,-75,0])  cube([160,60,70],center=true);
            translate([0,0,32]) union(){                
                translate([-24,0,-30])  cube([1.8,300,1.6],center=true);
                translate([-27,0,-24])  cube([1.8,300,1.6],center=true);
                
                translate([24,0,-30])  cube([1.8,300,1.6],center=true);
                translate([27,0,-24])  cube([1.8,300,1.6],center=true);
            }
        }
        
        translate([12,12,0]) cylinder(d=5.4,h=20,center=true);
        translate([-12,12,0]) cylinder(d=5.4,h=20,center=true);
        
        translate([12,36,0]) cylinder(d=5.4,h=20,center=true);
        translate([-12,36,0]) cylinder(d=5.4,h=20,center=true);       
    }
    
}
 
module fireFixDownB(){

    difference(){
        translate([0,-(58-my_),5])  difference(){
            union(){
                cube([60,92,14],center=true);   
                /*
                translate([0,-44,-12.5])# difference(){
                    cube([25,4,13],center=true);   
                    translate([0,0.7,0]) cube([26,1.2,10.2],center=true);
                    translate([0,1,0]) cube([26,3,9],center=true);
                    translate([9.5,0,0]) rotate([-90,0,0]) cylinder(d=3,h=10,center=true);
                    translate([-9.5,0,0]) rotate([-90,0,0]) cylinder(d=3,h=10,center=true);
                }
                */
                //translate([0,-40,0]) cylinder(d=20,h=14);  
                //translate([0,-40,20]) rotate([0,0,90]) cyInterface(_h=40,t_d=10);
                //translate([0,-36,-3]) cube([30,30,21],center=true);
            }
            translate([0,-40,4]) cube([19,20,7],center=true);
            //cube([2.4,82,24],center=true);   
            //translate([0,-49,0]) cube([70,10,100],center=true);
            translate([0,8,2])  cube([32,100,14],center=true);
        
            difference(){
                union(){
                    translate([25,0,0]) cube([20,100,6.4],center=true);
                    translate([-25,0,0]) cube([20,100,6.4],center=true);
                }
            translate([0,0,27]) union(){                
                translate([-24,40,-30])  cube([1.8,20,1.6],center=true);
                translate([-27,40,-24])  cube([1.8,20,1.6],center=true);
                
                translate([24,40,-30])  cube([1.8,20,1.6],center=true);
                translate([27,40,-24])  cube([1.8,20,1.6],center=true);
            }
            translate([0,-32,27]) union(){                
                translate([-24,0,-30])  cube([1.8,30,1.6],center=true);
                translate([-27,0,-24])  cube([1.8,30,1.6],center=true);
                
                translate([24,0,-30])  cube([1.8,30,1.6],center=true);
                translate([27,0,-24])  cube([1.8,30,1.6],center=true);
            }
            
            
                translate([0,-15,0]) cube([70,4,10],center=true);
            translate([0,28.5,0]) cube([70,4,10],center=true);
            }
            translate([0,-35,0]){
                translate([23,0,0]) kong(d=5);
                translate([-23,0,0]) kong(d=5);
            }
            translate([0,20,0]){
                translate([23,0,0]) kong(d=5);;
                translate([-23,0,0]) kong(d=5);;
            }
            
        }
        
        translate([12,-12,0]) kong(d=5);;
        translate([-12,-12,0])kong(d=5);;
        
        translate([12,-52,0]) kong(d=5);;
        translate([-12,-52,0]) kong(d=5);;

    }
    
}
module kong(d=5){
    cylinder(d=d+0.4,h=20,center=true);
    translate([0,d/2-d/8+0.2,0]) cube([d-0.8,d/4,30],center=true);
    
}


module fireFixDownC(){

    do = 4;
    translate([0,-4,0]) difference(){
        translate([0,-(126-my_),2]) {
            //#cube([60,80,20],center=true);
            translate([0,-dy,0]) difference(){
                union(){
                    translate([0,-26,-7-do/2])  cube([26,23,26+do],center=true);
                        
                    translate([0,-22,3]){
                        hull(){                     
                            translate([0,0,-5]) cylinder(d=29,h=16,center=true);
                            translate([0,47+dy,0]) cube([60,1,6],center=true);
                        } 
                    }
                    
 
                }
                translate([0,5,0]) {
                    translate([0,dy/2,0]) cube([21,41+dy,30],center=true);
                    translate([0,dy/2,3])  cube([26,41+dy,2],center=true);
                }
            }
            translate([0,37+4,3]) difference(){
                translate([0,-1,0]) cube([60,29,6],center=true);
                translate([0,0,0]) cube([31,31,7],center=true);
                 
                translate([0,0,0]){
                    translate([-24,0,-3])  cube([2.5,30,2.4],center=true);
                    translate([-27,0,3])  cube([2.5,30,2.4],center=true);

                    translate([24,0,-3])  cube([2.5,30,2.4],center=true);
                    translate([27,0,3])  cube([2.5,30,2.4],center=true);
                }
                 
                translate([23,-4,0])kong(d=5);
                translate([-23,-4,0])kong(d=5);
            }
        }
        translate([0,-50-dy,-5-do]){
                translate([0,-(98-my_),-12]){
                scale([1.01,1.01,1])  intersection(){
                    cylinder(d=25,h=17);
                    translate([0,0,18/2]) cube([17,25,17],center=true);                    
                }
                
                //translate([0,25,3.5])   rotate([0,0,-30])  cylinder(6,18,18,$fn=3);
                //translate([0,36,6]) cube([15,40,6],center=true);
                //#translate([0,5,6.5]) scale([1.01,1.01,1])   cube([19.5,23,6],center=true);
                //#translate([0,5,2])  cube([23,23,13],center=true);
                
                //translate([0,14,9]) cylinder(d=19,h=11,center=true);
            }
             
                translate([0,-(90-my_+5),-15])   {
                cube([10,45,30],center=true);             
                           
                //translate([0,14,0]) scale([1,1,1]) cube([10,15,20],center=true);
                //translate([0,22.5,0]) cylinder(d=10,h=20,center=true);
            }
            
            translate([0,-(98-my_),20]) rotate([180,0,0]) {
                translate([0,0,15.3]) rotate([0,90,0])  cylinder(d=3.5,h=70,center=true);
                scale([1.01,1.01,1]) 
                difference() {   
                    intersection(){
                        cylinder(d=25,h=19);
                        translate([0,0,18/2]) cube([19.5,25,19],center=true);                    
                    }
                    
                    translate([0,0,15.8]) union(){    
                        translate([9.8,0,0]) rotate([90,0,0]) linear_extrude(height=30,center=true)scale([0.9,0.9,0.9]) _guanDao();
                        translate([-9.8,0,0]) rotate([90,0,0]) linear_extrude(height=30,center=true) scale([0.9,0.9,0.9]) _guanDao();
                    }            
                }
            }
        }
    }
}
module fireFixDownCBak(){
 
    difference(){
        translate([0,-(126-my_),2]) {
            //#cube([60,80,20],center=true);
            difference(){
                union(){
                    translate([0,-22,-4.5]) difference(){
                        hull(){
                            translate([0,-16,0]) cube([25,1,21],center=true);
                            cylinder(d=30,h=21,center=true);
                        }
                        translate([0,12,0]) cube([40,10,30],center=true);
                    }
                    translate([0,-22,3]){
                        hull(){                     
                            cylinder(d=30,h=6,center=true);
                            translate([0,43,0]) cube([60,1,6],center=true);
                        } 
                    }
                    
                    translate([10,-36.5,-13]) rotate([180,0,-90]) difference(){
                        cyInterfaceBig(_h=20); 
                        translate([3,0,0]) cube([2,10,40],center=true);
                    }
                    translate([-10,-36.5,-13]) rotate([180,0,-90]) difference(){
                        cyInterfaceBig(_h=20); 
                        translate([3,0,0]) cube([2,10,40],center=true);
                    }
                }
                translate([0,5,0]) {
                    translate([0,0,0]) cube([21,40,30],center=true);
                    translate([0,0,3])  cube([26,40,2],center=true);
                }
            }
            translate([0,37,3]) difference(){
                translate([0,-1,0]) cube([60,29,6],center=true);
                translate([0,0,0]) cube([31,31,7],center=true);
                 
                translate([0,0,0]){
                    translate([-24,0,-3])  cube([2.5,30,2.4],center=true);
                    translate([-27,0,3])  cube([2.5,30,2.4],center=true);

                    translate([24,0,-3])  cube([2.5,30,2.4],center=true);
                    translate([27,0,3])  cube([2.5,30,2.4],center=true);
                }
                 
                translate([23,-4,0]) {
                    cylinder(d=5.4,h=30,center=true);
                    translate([0,2.2,0]) cube([4.2,1,30],center=true);
                }
                translate([-23,-4,0]) {
                    cylinder(d=5.4,h=30,center=true);
                    translate([0,2.2,0]) cube([4.2,1,30],center=true);
                }
            }
        }
        translate([0,-50,-5]){
                translate([0,-(98-my_),-8]){
                scale([1.01,1.01,1])  intersection(){
                    cylinder(d=25,h=11);
                    translate([0,0,18/2]) cube([19.5,25,11],center=true);                    
                }
                
                //translate([0,25,3.5])   rotate([0,0,-30])  cylinder(6,18,18,$fn=3);
                //translate([0,36,6]) cube([15,40,6],center=true);
                translate([0,5,6.5]) scale([1.01,1.01,1])   cube([19.5,23,6],center=true);
                translate([0,5,6])  cube([23,23,5],center=true);
                
                //translate([0,14,9]) cylinder(d=19,h=11,center=true);
            }
             
                translate([0,-(90-my_),-5])   {
                cube([10,35,20],center=true);             
                           
                //translate([0,14,0]) scale([1,1,1]) cube([10,15,20],center=true);
                //translate([0,22.5,0]) cylinder(d=10,h=20,center=true);
            }
            
            translate([0,-(98-my_),20]) rotate([180,0,0]) {
                translate([0,0,15.3]) rotate([0,90,0])  cylinder(d=3.5,h=70,center=true);
                scale([1.01,1.01,1]) 
                difference() {   
                    intersection(){
                        cylinder(d=25,h=18);
                        translate([0,0,18/2]) cube([19.5,25,18],center=true);                    
                    }
                    
                    translate([0,0,15.8]) union(){    
                        translate([9.8,0,0]) rotate([90,0,0]) linear_extrude(height=30,center=true)scale([0.9,0.9,0.9]) _guanDao();
                        translate([-9.8,0,0]) rotate([90,0,0]) linear_extrude(height=30,center=true) scale([0.9,0.9,0.9]) _guanDao();
                    }            
                }
            }
        }
    }
}
module fireFixDownB_(){
    kh=11;
    //translate([0,-60,-23]) rotate([0,90,0]) #body(_dx=30);
    difference(){
        translate([0,-(63-my_),5])  difference(){
            union(){
                //cylinder(d=80,h=15,center=true);
                
                cube([60,102,14],center=true);            
                translate([0,-36,-3]) cube([30,30,21],center=true);
            }
            //#translate([0,5,0]) cube([32,44,8],center=true);
            translate([0,5,2]) cube([32,70,14],center=true);
            translate([0,(50),2]){ 
                cube([32,20,14],center=true);
            }

            translate([24,-37,-0.3]) union(){
                cube([20,40,7],center=true);
                translate([-2,-7,0]) cylinder(d=5.8,h=20,center=true);
            }
            translate([-24,-37,-0.3]) union(){
                cube([20,40,7],center=true);
                 translate([2,-7,0]) cylinder(d=5.8,h=20,center=true);
            }
            
            translate([26,9,0]) cube([15,45,7],center=true);
            translate([-26,9,0]) cube([15,45,7],center=true);
            
            //translate([13,0,0]) rotate([90,0,0]) #cylinder(d=3,h=300,center=true);
            //translate([0,-10,2]) #cube([17,44,22],center=true);
        
        }
        difference(){
            translate([0,-30,5])  cube([80,60,6.4],center=true);    
            //translate([0,my+160,32]) cylinder(d=_r*4-1,h=70,center=true);
                      
            translate([0,-50.5,0])  cube([160,60,70],center=true);
            cube([39.6,200,40],center=true);
            
            translate([0,0,32]) union(){                
                translate([-24,0,-30])  cube([1.8,300,1.6],center=true);
                translate([-27,0,-24])  cube([1.8,300,1.6],center=true);
                
                translate([24,0,-30])  cube([1.8,300,1.6],center=true);
                translate([27,0,-24])  cube([1.8,300,1.6],center=true);
            }
        }
        
        
        translate([12,-12,0]) cylinder(d=5.4,h=20,center=true);
        translate([-12,-12,0]) cylinder(d=5.4,h=20,center=true);
        
        translate([12,-52,0]) cylinder(d=5.4,h=20,center=true);
        translate([-12,-52,0]) cylinder(d=5.4,h=20,center=true);
    
        
        translate([0,-(98-my_),-8]){
            scale([1.01,1.01,1])  intersection(){
                cylinder(d=25,h=kh);
                translate([0,0,18/2]) cube([19.5,25,kh],center=true);                    
            }
            
            translate([0,25,3.5])   rotate([0,0,-30])  cylinder(6,18,18,$fn=3);
            //translate([0,36,6]) cube([15,40,6],center=true);
            translate([0,5,6.5]) scale([1.01,1.01,1])   cube([19.5,23,6],center=true);
            translate([0,5,6])  cube([23,23,5],center=true);
            
            //translate([0,14,9]) cylinder(d=19,h=11,center=true);
        }
        
        translate([0,-(90-my_),-5])   {
            cube([10,35,20],center=true);             
                       
            //translate([0,14,0]) scale([1,1,1]) cube([10,15,20],center=true);
            //translate([0,22.5,0]) cylinder(d=10,h=20,center=true);
        }
         
        translate([0,-(98-my_),20]) rotate([180,0,0]) {
            translate([0,0,15.3]) rotate([0,90,0])  cylinder(d=3.5,h=70,center=true);
            scale([1.01,1.01,1]) 
            difference() {    
                
                intersection(){
                    cylinder(d=25,h=18);
                    translate([0,0,18/2]) cube([19.5,25,18],center=true);                    
                }
                
                translate([0,0,15.8]) union(){   
                    
                    translate([0,0,0])   rotate([0,0,0]) rotate_extrude(angle=360) translate([12.5,0]) scale([0.9,0.9,0.9]) _guanDao();
                    translate([9.8,0,0]) rotate([90,0,0]) linear_extrude(height=30,center=true)scale([0.9,0.9,0.9]) _guanDao();
                    translate([-9.8,0,0]) rotate([90,0,0]) linear_extrude(height=30,center=true) scale([0.9,0.9,0.9]) _guanDao();
                }            
            }
        }
    }    
}

module fireFixBT(){
    translate([17,-(90-my_),5-0.3]) {
        cube([5,19,6.5],center=true);
        //translate([-10,11.8,0])  cube([20,11.5,6.5],center=true);
        //translate([-9,2,0]) rotate([0,90,0]) cylinder(d=3,h=10);
        
    }
    translate([23,-(98-my_),5-0.3]) translate([-30,15,0])   cube([52,5,6.5],center=true);
    difference(){
        translate([23,-(95-my),5-0.3]) {
            //cube([17,35,6.5],center=true);
            translate([-12,15,0]) union(){
                cube([16,11,6.5],center=true);
               
            }
            //translate([-14.6,0,-0.3]) rotate([0,90,0]) cylinder(d=3,h=20);
            

        }
        
        translate([0,-(98-my_),20+0.05]) rotate([180,0,0])             scale([1.01,1.01,1]) 
            difference() {    
                
                 translate([0,0,10]) intersection(){
                    cylinder(d=25,h=18);
                    translate([0,0,18/2]) cube([19.5,25,18],center=true);                    
                }
                
                translate([0,0,15.8]) union(){   
                    
                    translate([0,0,0])   rotate([0,0,0]) rotate_extrude(angle=360) translate([12.5,0]) scale([0.9,0.9,0.9]) _guanDao();
                    translate([9.8,0,0]) rotate([90,0,0]) linear_extrude(height=30,center=true)scale([0.9,0.9,0.9]) _guanDao();
                    translate([-9.8,0,0]) rotate([90,0,0]) linear_extrude(height=30,center=true) scale([0.9,0.9,0.9]) _guanDao();
                }            
            }
    }
    
}
module fireFixD(){
    translate([0,0,3]) rotate([0,0,-115]) rotate_extrude(angle=50) translate([_r+3,0]) square([5,60],center=false);
    translate([0,0,3]) rotate([0,0,-116]) translate([_r+13,-10,0]) rotate([0,0,0])fireEarT();
    
     mirror([1,0,0])   translate([0,0,3]) rotate([0,0,-116]) translate([_r+13,-10,0]) rotate([0,0,-4])fireEarT();
    
}
module fireFixC(){
    
    {
        translate([0,0,3]) rotate([0,0,20]) rotate_extrude(angle=140) translate([_r+3,0]) square([3,60],center=false);
        translate([0,0,3]) rotate([0,0,9.65]) translate([_r+9.75,0,0])  fireEarT();
        
         mirror([1,0,0]) translate([0,0,3]) rotate([0,0,9.65]) translate([_r+9.75,0,0])  fireEarT();
    }
    //minkowski(){
    
        
        
    //}
    
}
module finderFixB(){
    translate([0,0,-25.5]) {
        translate([0,0,0]) cube([27,51,1.8],center=true);
        
        translate([0,24.5,4.5]) difference(){ 
            cube([25.5,2,10.5],center=true);
            rotate([90,0,0]) cylinder(d=5,h=10,center=true);
        }
    }
}
module finderFixA(){
    
    {
        difference(){ 
        union(){
            translate([0,0,-20.5]) difference(){
                cube([30,55,14],center=true);                
                translate([0,2,-2]) cube([26,55,14],center=true);
                translate([0,-2.5,5]){
                    translate([10,0,0]) cylinder(d=5.4,h=10,center=true);
                    translate([-10,0,0]) cylinder(d=5.4,h=10,center=true);
                }
                translate([0,-21,5]){
                    translate([3.5,0,0]) cylinder(d=5.5,h=10,center=true);
                    translate([-3.5,0,0]) cylinder(d=5.5,h=10,center=true);
                }
                translate([0,2,-5]) minkowski(){
                    cube([26.5,54,1.5],center=true);
                    rotate([90,0,0]) cylinder(d=1,h=1,center=true);
                }

            }
        
           translate([0,26,-15.2]) sphere(d=2);
        }
        
    }
    

}
    
}
function pol_zu_kart(polvect) = [
	polvect[0]*cos(polvect[1]),  
	polvect[0]*sin(polvect[1])
];
module spring(){

    //cylinder(h=4,d=30);
    h=4;
    hh=6.4;
    ra=20;
    ra1=13.7;
    //ra1=14.9;
    rav = 0.01;
    max_m=(ra)/rav;
    max_m1=(ra1)/rav;
    fMax = (360*3/max_m);
    li =     concat(
   
            [for(i=[0:1:max_m])pol_zu_kart([rav*i,fMax*i])],
                [for(i=[0:1:max_m1])pol_zu_kart([ra1-rav*i,-fMax*i])]
                     
    );
          // echo(li);
    difference(){
        union(){
        linear_extrude(height=h) polygon( li );
            cylinder(h=h,d=12,center=false);
            rotate_extrude() translate([ra-hh,0]) square([hh,h],center=false);
        }
        cylinder(h=9,d=5.4,center=true);
    }
    
}
module springTest(_h=2){

    //cylinder(h=4,d=30);
    
    //hh=6.4;
    ra=40;
    ra1=32.5 ;
    //ra1=14.9;
    rav = 0.01;
    max_m=(ra)/rav;
    max_m1=(ra1)/rav;
    //fMax = (360*3/max_m);
    fMax = (360*5/max_m);
    li =     concat(
   
            [for(i=[0:1:max_m])pol_zu_kart([rav*i,fMax*i])],
                [for(i=[0:1:max_m1])pol_zu_kart([ra1-rav*i,-fMax*i])]
                     
    );
          // echo(li);
    //difference(){
        //union(){
        linear_extrude(height=_h) polygon( li );
            //cylinder(h=h,d=42,center=false);
           // rotate_extrude() translate([ra-hh,0]) square([hh,h],center=false);
       // }
        //cylinder(h=9,d=5.4,center=true);
   // }
    
}

module springFix(){

    translate([0,0,0.5]) union(){
        rotate_extrude(angle=25) translate([_r+4.5,0]) square([4,6]);
        rotate_extrude(angle=25) translate([_r+7.3,0]) square([2,8]);
          }
        translate([_r+11,15,2.5])
        difference(){
            rotate([0,90,0]) {
                cyInterface(_h=14,t_d=4.8);
                translate([0,0,-2]) cylinder(d=8,h=6,center=true);
            }
            translate([0,0,-3.5]) cube([50,50,3],center=true);
        }
  
}
module fire(){ 
    th=15;
    __h=3;
    {        
        difference(){  
            union(){          
                translate([0,0,0]) cylinder(r=_r+7,h=60,center=true);
                translate([0,-_r/2,-2.5])   cube([(_r+7)*2,_r,15],center=true);
                
                translate([0,0,28.5]){
                    rotate([0,0,56]) translate([0,-(_r+9.5),0]) difference(){
                        hull(){
                            cylinder(d=11,h=__h,center=true);
                            translate([20,11,0]) cylinder(d=10,h=__h,center=true);
                        }
                        cylinder(d=5.4,h=__h+1,center=true);
                    }
                    rotate([0,0,-56]) translate([0,-(_r+9.7),0]) difference(){                        
                        hull(){
                            cylinder(d=11,h=__h,center=true);
                            translate([-20,11,0]) cylinder(d=10,h=__h,center=true);
                        }
                        cylinder(d=5.4,h=__h+1,center=true);
                    }
                }                    
                translate([-(_r)-3.5,15,-2.5]) rotate([0,90,0]) fireEar();      
                mirror([1,0,0]) translate([-(_r)-3.5,15,-2.5]) rotate([0,90,0]) fireEar();        
                   
                rotate([0,0,39.8])  translate([_r+8,-2,20]) rotate([0,0,50]) cyInterface();
                rotate([0,0,-39.8])  translate([-(_r+8),-2,20]) rotate([0,0,-50]) cyInterface();
                
            }
            translate([0,0,th])  cylinder(r=_r+4.5 ,h=44,center=true);
            
            translate([0,0,-24]) cylinder(r=_r+2 ,h=13,center=false);
            
            translate([0,(_r)/2,-2.5])  cube([(_r+9)*2,_r,9],center=true);            
            translate([0,15-2,-2.5]) cube([_r*3,30,9],center=true);
            union(){
                translate([0,0,6]){
                    cylinder(r=_r-3,h=60,center=true);  
                }               
                //translate([0,-40,5.6]) cube([110,80,60],center=true);
                //translate([0,-110,0])  cube([20,70,70],center=true);
            }
            translate([0,0,-0.2]){
                translate([-24,0,-30])  cube([2.5,300,2.4],center=true);
                translate([-27,0,-24])  cube([2.5,300,2.4],center=true);
                
                translate([24,0,-30])  cube([2.5,300,2.4],center=true);
                translate([27,0,-24])  cube([2.5,300,2.4],center=true);
            }
            //}
            cube([40,300,70],center=true);
            
            translate([0,75,0])  cube([180,60,80],center=true);
            
            translate([0,-80,0])  cube([180,60,80],center=true);
            translate([0,-20,-2.5]) cube([(_r+4.5)*2,_r,9],center=true);
            translate([0,-100,-27]) union(){
                 cube([180,160,30],center=true);
               
             // cylinder(h=60,d=180,center=true);
            }
            translate([0,-100,0]) cylinder(h=70,d=160,center=true);

            
        }           
    }
  
 
}

module fireFixDownD(){
    _y=42+dy;
    translate([0,-(122-my_+4 ),5]) difference(){
        translate([0,0,0]) union(){            
            translate([0,-dy/2,0.9]) cube([26,_y,1.6],center=true);
            translate([0,-dy/2,0]) cube([21,_y,3],center=true);
            translate([0,-15-dy,-4])  cube([21,7,11],center=true);
            translate([0,3,-5])   cylinder(d=16, h=10,center=true);
             
        }
        translate([0,3,-3]) rotate([0,0,0])  cylinder(d1=12,d2=11.5,h=30,center=true);
        translate([0,-26-dy,-5]) scale([1.01,1.01,1])   intersection(){
            cylinder(d=25,h=28,center=true);
              cube([19.5,25,28],center=true);                    
        }
    }
    
}