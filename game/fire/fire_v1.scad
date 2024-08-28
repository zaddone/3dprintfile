use <car_v10_lib.scad>
use <car_v10.scad>
use <car_v10_battery.scad>
 
pi = 3.14159;
rad = 57.29578;
springLong = 50;
holeLong = 5.4;
ring_r = 63;
_r = ring_r;
maxLong = springLong/rad * ring_r;
clipHeight = 34;
$fn = 100;

headLong = 25;
/*
!union(){
    ang = 360/5;
    f=10;
      rotate([0,0,-ang/2+f/2]) for(i=[1:1:4]) rotate([0,0,ang*i])  rotate_extrude(angle=ang-f) translate([ring_r,0]) square([10,50]);

}
*/

//translate([0,-110,-78])rotate([0,0,180]) showBody();
!mirror([1,0,0]) springTrack();
union(){
    translate([0,0,-31]){
    translate([0,0,-2]) rotate([0,0,0]){
        //translate([0,0,-29])  TTmotorRoom();
        rodA();
        rotate([0,0,90]) rodA();
        rotate([0,0,-90]) rodA();
        rotate([0,0,-180]) rodA();
    }
    translate([0,(maxLong+holeLong)/2,12.9])  rodB();
        
        
    //translate ([0,(maxLong+holeLong)/2+18,13.5]) rodFix();
    //translate ([0,-((maxLong+holeLong)/2+18),13.5]) rodFix();
    
    translate ([0,((maxLong+holeLong)/2+18),14]) rodC();
        
    translate ([0,-((maxLong+holeLong)/2+18),14]) {
        rotate([0,0,180]) rodD();
        
        translate([0,-100,-10])  finderFix();
        
    }
    translate([0,12,14])  rotate([0,0,180]) #rodD();
    //rotate([0,0,180]) rodC();
}


translate([0,0,-20]){
    /*
    translate([0, maxLong+headLong,-2]) {
        Track();
        mirror([1,0,0]) Track();
    }
    */
    translate([0,maxLong+holeLong-5,10]) {
        Head( );
        translate([0,maxLong+holeLong,0]) Head( );
        //translate([0,-9.5,8]){
           //rodB();
           // springA();
           //translate([0,maxLong,0])rodB();
        //}      
        
    }
    
    
    //!springA();
    
    
}
}

//#fire();
 
union(){
    cent = 25;
    //clip(cent);
    
    //mirror([1,0,0]) clip(cent);
   rotate([0,0,0]) translate([0,0,-62]) {
       !TTmotorRoom();
       translate([0,-25,8]) {
           beginWheelFix();
           beginWheel();
       }
   }
    translate([0,0,-30]) downFix();
    translate([0,maxLong+holeLong,-4]) circleRing();
    
      
    // for(i=[1:1:(clipHeight-5)/6.2]) translate([0,0,6.2*i-3]) circleRing();

    translate([0,0,-102]) #cube([1,300,1],center=true);
}
module beginWheel(){
    translate([0,15.5,-29]) rotate([0,90,0]) {
            cylinder(d=38,h=6,center=true);
            cylinder(d=5.2,h=20,center=true);
            //translate([-1.6,0,0]) cube([2,4,20],center=true);
        }
    
}
module beginWheelFix(){

    cyInterface(_h=10,t_d=9.6);
    difference(){
        translate([0,0,-7]) hull(){
            cylinder(d=12,h=5);
            translate([0,15,-30]) cylinder(d=15,h=15);
        }
        
        translate([0,15.5,-29]) rotate([0,90,0]) {
            cylinder(d=40,h=7,center=true);
            cylinder(d=5.2,h=20,center=true);
            translate([-1.6,0,0]) cube([2,4,20],center=true);
        }
        translate([0,0,-32]) rotate([15,0,0]) cube([7,40,40],center=true);
    }
    
}
module finder(){
    cube([20,40,8],center=true);
    translate([0,20,4]) cube([20,6,20],center=true);
    
}
module finderFix(){
    
    //finder();
    translate([0,1.5,-2]) difference(){
            minkowski(){        
            cube([28,46,1],center=true);
            cylinder(d=5,h=1,center=true);
        }
        translate([12,19.5,0]) cylinder(d=5.4,h=10,center=true);
        translate([-12,19.5,0]) cylinder(d=5.4,h=10,center=true);
        
        translate([12,-20.5,0]) cylinder(d=5.4,h=10,center=true);
        translate([-12,-20.5,0]) cylinder(d=5.4,h=10,center=true);
        translate([-7,-10,0]) cylinder(d=3.5,h=10,center=true);
        translate([7,-10,0]) cylinder(d=3.5,h=10,center=true);
    }
}

module rodD(){
    //translate([0,85,-10]) cylinder(d=7,h=20,center=true);
    translate([0,45,0]) intersection(){
        rotate([-90,90,0]) {
            //translate([0,0,38]) cyInterfaceBig(_h=15,t_d=holeLong+3,fk=1.2);
            //hull(){
                translate([0,0,0]) cylinder(h=100,d=8,center=true);
                //translate([0,-2,0]) cylinder(h=67.8,d=5,center=true);
            //}
        }
        translate([0,0,0]) cube([10,120,3],center=true);
    }
    translate([0,-9,0.5]) difference(){
        hull(){
            translate([holeLong,0,0]) cylinder(d=11,h=2,center=true);
            translate([-holeLong,0,0]) cylinder(d=11,h=2,center=true);           
        }
        hull(){
        translate([holeLong,0,0]) cylinder(d=holeLong,h=14,center=true);
        translate([-holeLong,0,0]) cylinder(d=holeLong,h=14,center=true);
        }
    }
    
}
module rodC(){
    translate([0,30,0]) {
        intersection(){
            rotate([-90,90,0]) {
                translate([0,0,38]) cyInterfaceBig(_h=15,t_d=7,fk=1.2);
                cylinder(h=67.8,d=8,center=true);
                //hull(){
                //    translate([0,2,0]) cylinder(h=67.8,d=holeLong+0.5,center=true);
                //    translate([0,-2,0]) cylinder(h=67.8,d=holeLong+0.5,center=true);
                //}
                //translate([0,0,35]) cylinder(d=10,h=2,center=true);
            }
            translate([0,0,0]) cube([10,100,3],center=true);
        }
        
    }
    translate([0,-9,0.5]) difference(){
        hull(){
            translate([holeLong,0,0]) cylinder(d=11,h=2,center=true);
            translate([-holeLong,0,0]) cylinder(d=11,h=2,center=true);           
        }
        hull(){
        translate([holeLong,0,0]) cylinder(d=holeLong,h=14,center=true);
        translate([-holeLong,0,0]) cylinder(d=holeLong,h=14,center=true);
        }
    }
}
module rodFix(){
     difference(){
        translate([0,0,1])  union() {
            cube([holeLong*2,4,8],center=true);
            translate([0,0,-3.5]){
                translate([holeLong,0,0]) rotate([0,180,90]) cyInterface(_h=15,t_d=holeLong-0.6);
                translate([-holeLong,0,0]) rotate([0,180,90]) cyInterface(_h=15,t_d=holeLong-0.6);
            }
        }
        rotate([90,0,0]) hull(){
            cylinder(d=holeLong+1,h=10,center=true);
            translate([0,-2,0])  cylinder(d=holeLong+1,h=10,center=true);
        }
        
        translate([0,-2.5,0]) cube([holeLong*3,1,20],center=true);
    }    
}

module clipBase(f=10,h=3,ang=30,holeSpacing=50,holeWidth=5,centerR = 23.5){
    ex = 3.5;
    r = ring_r+ex; 
    difference(){
        union(){
            //rotate_extrude(angle=ang) translate([r,0]) square([4,10]);
            linear_extrude(height=h) polygon(
                concat(
            [pol_zu_kart( [centerR,ang])],
           
            //[pol_zu_kart([centerR,(ang - exn)])],
            // [pol_zu_kart([centerR,ang - (ang - exn)])],
                [pol_zu_kart([centerR,0])] ,
                [for(j=[0:1:ang])pol_zu_kart([r,j])])
            );  
             rotate([0,0,(ang)/2]) translate([centerR,0,0])  hull(){
                 cylinder(d=holeWidth,h=h,center=false);
                 translate([-holeWidth,0,0]) cylinder(d=holeWidth,h=h,center=false);
             }
        }
        
        
            translate([1,-f/2,-1]) cube([r+ex,f,h+clipHeight],center=false);
            rotate([0,0,ang]) translate([1,-f/2,-1]) cube([r+ex,f,h+clipHeight],center=false);
        
    }
}
module cylinderInput(d=10,h=10,t=25){
    head = d/2;
    add = tan(t)*head;
    w = d/6;
    echo(add);
    difference(){
        
        union(){
            translate([0,0,-head/2]) cylinder(d=d,h=h-head,center=true);
            
            translate([0,0,h/2-head])  cylinder(d1=d+w,d2 =d*0.85,h=head );
            
            translate([0,0,h/2-head-w]) cylinder(d=d+w,h=w);
            
            translate([0,0,h/2-head-w*2]) cylinder(d1 =d ,d2=d+w,h=w);
        }
        translate([(d+w)/2,0,h/2-head])  cube([w,d,head+w],center=true);
        translate([-(d+w)/2,0,h/2-head])  cube([w,d,head+w],center=true);
        translate([0,0,h/2-head])  cube([d+w+1,w+0.4,head*2+w],center=true);
    }
    
}

module downLock(centerR = 24.8,f=10){
    x = ring_r-centerR;
    translate([centerR+(x)/2,0,1.5]) difference() {
        cube([x,f+5,7],center=true);
        translate([0,6,0]) cube([x+1,3,3.4],center=true);
         translate([0,-6,0]) cube([x+1,3,3.4],center=true);
    }
    //cube([])
}
module downLockEnd(centerR = 24.8,f=10){
    
    x = ring_r-centerR;
    translate([centerR+(x)/2+3,0,1.5]){
        
        difference() {
            union(){
                cube([x,f+5,7],center=true);
                //translate([0,0,-6.7])  cube([x,24,10],center=true);
            }
            translate([0,6,0]) cube([x+1,3,3.4],center=true);
            translate([0,-6,0]) cube([x+1,3,3.4],center=true);
        }
        translate([x/2-2,0,12]) {
            difference(){
                translate([0,0,-3]) cube([4,f+5,14],center=true);
                translate([0,0,-0.5]) rotate([0,90,0]){ 
                    intersection(){
                        cylinder(d=8.5,h=10,center=true);
                        cube([3.6,9,10],center=true);
                    }
                    translate([-1.2,0,0]) hull(){
                        cube([1,7.5,10],center=true);
                        translate([-5,0,0]) cube([1,2,10],center=true);
                    }
                }
                
            }
            intersection(){
                union(){
                translate([1,(f+5)/2,-3]) {
                    //sphere(d=4);
                    cylinder(d2=5,d1=1,h=6,center=true);
                    translate([0,0,5]) cylinder(d=5,h=4,center=true);
                }
                
                
                translate([1,-(f+5)/2,-3]){
                    //sphere(d=4);
                    cylinder(d2=5,d1=1,h=6,center=true);
                    translate([0,0,5]) cylinder(d=5,h=4,center=true);
                }
            }
                
                translate([0,0,-3]) cube([4,f+20,14],center=true);
            }
        }
    }
    //downLock(centerR,f);
   
    
}
module downFix(cent = 30){
    m=5;
    ang = 360/m;
    f=10;
    h=3;
    centerR = 24.8;
    holeWidth=5;
    union(){
     rotate([0,0,90-(ang+ang/2)]) {
        //for(i=[0:1:m-2])   rotate([0,0,ang*i]) {
        //     downLock(centerR,f);         
        //}
   
        rotate([0,0,ang*4]) downLockEnd(centerR,f); 
     }
  
     begin = 90-(ang+ang/2);
     translate([0,0,30-4.6]){
        translate([ring_r+12,15,-5]) rotate([0,90,0]){
            spring();       
        }
        translate([0,0,-7]){
            springTrack();
        }
    }
    
    rotate([0,0,0]) union(){
         union(){
        rotate([0,0,begin]) {
            clipA(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin);
            rotate([0,0,ang/2]) translate([ring_r+15,-5,20.4]) rotate([1,90,-f*2]){
            //spring();       
            }
        }
        
            
        rotate([0,0,begin-ang])  clipB(f,h,ang,holeWidth=holeWidth,centerR = centerR);
       
         mirror([1,0,0])rotate([0,0,begin-ang]) clipB(f,h,ang,holeWidth=holeWidth,centerR = centerR);
        
        mirror([1,0,0])rotate([0,0,begin]) clipA(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin);

        rotate([0,0,begin-ang*4]) clipC(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin);
        }
    }
}
 
}
module clipA(f=10,h=3,ang=30,holeWidth=5,centerR = 23.5,begin=10){
      r = ring_r+3.5; 
    m = asin((f/2)/r) ;

    rr = r+4;

    hh = 10;

    kh = 45;
    dh = 0;
    kr = 30;
    difference(){
        union(){
            clipBase(f=f,h=h,ang=ang,holeSpacing=50,holeWidth=holeWidth,centerR=centerR);
            
            translate([centerR,0,0]) difference(){ 
                hull(){
                    cube([ring_r-centerR,f,h],center=false);
                    translate([0,-f/3*2,-h]) cube([ring_r-centerR,f/3*2,h*3],center=false);
                }
                translate([-1,-f,0]) difference(){
                    cube([rr-centerR+10,f+0.5,h],center=false);
                    translate([0,f/2-1,0]) cube([rr-centerR+10,1,0.6],center=false);
                    translate([0,f/2+1,h-0.6]) cube([rr-centerR+10,1,0.6],center=false);
                }
            }
            rotate([0,0,ang]) mirror([0,1,0]) translate([centerR,0,0]) difference(){ 
                hull(){
                    cube([rr-centerR+5,f,h],center=false);
                    translate([0,-f/3*2,-h]) cube([rr-centerR,f/3*2,h*3],center=false);
                }
                translate([-1,-f,0]) difference(){
                    cube([rr-centerR+10,f+0.5,h],center=false);
                    translate([0,f/2-1,0]) cube([rr-centerR+10,1,0.6],center=false);
                    translate([0,f/2+1,h-0.6]) cube([rr-centerR+10,1,0.6],center=false);
                }
            }

    
    //rotate([0,0,ang]) translate([centerR,-f/2,0]) # cube([ring_r-centerR+3.5,f,h],center=false);
    

    
    difference(){
        rotate([0,0,m]) translate([0,0,-dh]) linear_extrude(height=30+hh+dh) polygon(
                concat(
                [pol_zu_kart( [rr+23,ang/2+f-2])],
                //[pol_zu_kart([rr,f])],
                //[pol_zu_kart( [rr+15,ang/2-f*2])],
                [pol_zu_kart( [rr*1.15,f])],

                //[pol_zu_kart( [rr+5,0])],
                [for(j=[f:1:ang-m*2])pol_zu_kart([rr,j])])
                ); 
        translate([r-6,36,20.4])  rotate([0,90,-begin]){
            translate([0,0,6]) hull(){
                cylinder(d=hh/2+31,h=5,center=true);
                rotate([0,0,kr]) translate([0,-25,0]) cube([hh/2+30+1,50,5],center=true);
            }
            translate([0,0,10]) scale([0.75,0.75,1]) hull(){
                cylinder(d=hh/2+31,h=5,center=true);
                rotate([0,0,kr]) translate([0,-25,0]) cube([hh/2+30+1,50,5],center=true);
            }
        }
        
        rotate([0,0,m])rotate([0,0,(ang-springLong)/2+m/2])  translate([42,0,17]) cube([30,70,13]);
    }
         rotate([0,0,m]){
            
         difference() {
            union(){
                translate([0,0,17]) rotate_extrude(angle=ang-m *2) translate([r,0]) square([4, 13+hh]);
                rotate_extrude(angle=ang-m *2) translate([r,0]) square([4, 17]);                
                /*
                translate([0,0,-dh]) #linear_extrude(height=30+hh+dh) polygon(
                concat(
                [pol_zu_kart( [rr+23,ang/2+f-2])],
                //[pol_zu_kart( [rr+15,ang/2-f*2])],
                [pol_zu_kart( [rr*1.15,m+f])],

                //[pol_zu_kart( [rr+5,0])],
                [for(j=[m+f:1:ang-m*2])pol_zu_kart([rr,j])])
                ); 
                 // rotate([0,0,(f+1.7)])  translate([70.7,0,0]) #cube([30,70,13]); 
                */
            }
            

          //rotate([0,0,(ang-springLong)/2+m/2])  translate([42,0,17]) cube([30,70,13]);
            
           translate([0,0,17]) rotate([0,0,(ang-springLong)/2+m/2]) {
               
            rotate_extrude(angle=springLong+1) translate([r-1,0]) square([40, 13]);
           
               
           }
      
               
              
             
        }
            
 
    }
                
        //translate([0,0,30]) rotate_extrude(angle=ang-m *2-n) translate([r+0.5,0]) square([2,clipHeight ]);
 
            }
       translate([0,65,-h]) cube([rr+10,f,h+30+hh+1],center=false);
    }
         
}
module clipABak(f=10,h=3,ang=30,holeWidth=5,centerR = 23.5){
  
     clipBase(f=f,h=h,ang=ang,holeSpacing=50,holeWidth=holeWidth,centerR=centerR);
    
    
     r = ring_r+3.5; 
        m = asin((f/2)/r) ;
    //n = asin(3/r);
         
        
        
        rotate([0,0,m]){
            rotate_extrude(angle=ang-m *2) translate([r,0]) square([4, 17]);
        translate([0,0,17]) #difference() {
             rotate_extrude(angle=ang-m *2) translate([r,0]) square([4, 13+clipHeight]);
            
           rotate([0,0,(ang-springLong)/2+m/2]) rotate_extrude(angle=springLong+1) translate([r-1,0]) square([6, 13]);
             
        }
    }
        //translate([0,0,30]) rotate_extrude(angle=ang-m *2-n) translate([r+0.5,0]) square([2,clipHeight ]);
 
    
         
}
module clipB(f=10,h=3,ang=30,holeWidth=5,centerR = 23.5){
    r = ring_r+3.5;
    //f=1;
    difference(){
    clipBase(f=1,h=h,ang=ang,holeSpacing=50,holeWidth=holeWidth,centerR=centerR);   
         rotate([0,0,ang]) mirror([0,1,0]) translate([0,-1,0]) #union(){
            translate([0,f/2+0.8,0]) cube([r +10,1.4,0.8],center=false);
            translate([0,f/2-1.2,h-0.8]) cube([r +10,1.4,0.8],center=false);
        }
    } 
    m =  asin((f/2)/r) ;
    n =  asin(3/r);
    difference(){
        rotate([0,0,1/2]) rotate_extrude(angle=ang-m ) translate([r,0]) square([4, 30]);
        translate([r,0,12.5]) rotate([0,90,0]){ 
                    intersection(){
                        cylinder(d=8.5,h=10,center=true);
                        cube([3.6,9,10],center=true);
                    }
                    translate([-1.2,0,0]) hull(){
                        cube([1,7.5,10],center=true);
                        translate([-5,0,0]) cube([1,2,10],center=true);
                    }
                }
    }
    rotate([0,0,(m+n+5)]) rotate_extrude(angle=20) translate([r-6,0]) square([10, 20]);
    rotate([0,0,m+n]) {
        
        
       
        
        translate([0,0,30]){
            rotate_extrude(angle=ang-m *2-n) translate([r ,0]) square([2,10 ]);
        
            
            
        }
        difference(){
            hull(){
                rotate_extrude(angle=ang-m *2-n) translate([r+0.5,0]) square([2,3 ]);                
                translate([104,0,0]) cylinder(d=10,h=3);
            }
            translate([103.6,-0.5,0]) cylinder(d=5.2,h=10,center=true);
            translate([80.5,10.5,0]) cylinder(d=5.2,h=10,center=true);
            
        }
    }
}
module clipC(f=10,h=3,ang=30,holeWidth=5,centerR = 23.5,begin=10){
    r = ring_r+3.5;
    difference(){
    clipBase(f=0,h=h,ang=ang,holeSpacing=50,holeWidth=holeWidth,centerR=centerR); 
        
         translate([0,-1,0]) union(){
            translate([0,f/2+0.8,0]) cube([r +10,1.4,0.8],center=false);
            translate([0,f/2-1.2,h-0.8]) cube([r +10,1.4,0.8],center=false);
        }
        
        rotate([0,0,ang]) mirror([0,1,0]) translate([0,-1,0]) union(){
            translate([0,f/2+0.8,0]) cube([r +10,1.4,0.8],center=false);
            translate([0,f/2-1.2,h-0.8]) cube([r +10,1.4,0.8],center=false);
        }
        
    }
    
    
    ff=f*3;
    m = asin((ff/2)/r) ;
    n = asin(3/r);
    rr = (maxLong+holeLong)/2+16.5;
    difference(){
    rotate([0,0,m]) rotate_extrude(angle=ang-m *2) translate([rr,0]) square([3, 20]);
        
        translate([0,0,13])  intersection(){
           rotate([-ang/2,90,0]) cylinder(d=10.5,h=120,center=true);   
           rotate([0,0,ang/2])   cube([120,14,3.6],center=true);
        }
    }
    //translate([0,0,0]) rotate_extrude(angle=ang-f) translate([r,0]) square([4, 13]);
    
}
 
module slider(){    
    difference(){ 
        rotate([0,90,0]){
            cylinder(d=4,h=25,center=true);
            translate([0,0,13]) cylinder(d=5,h=2,center=true);
            translate([0,0,-13]) cylinder(d=5,h=2,center=true);
        }
        translate([0,-2,0]) cube([30,1,6],center=true);
    }
}
 
module TTmotor(){
       translate([-11.15,54.5,0])  rotate([90,0,0]) import("motor.STL",convexity=2,$fn=100);
}
module TTmotorRoom(holeWidth=5.5,centerR=18.4,Rh = 3.4){
    union(){      
       ran = 360/5;  
        
       difference(){
           union(){
               translate([0,0,22]) cylinder(d=40,h=31,center=true);
                translate([0,0,8]){
                     
                    hull(){
                    cylinder(d=40,h=3,center=true);
                    translate([0,25,0]) cylinder(d=20,h=3,center=true);
                    }
                }
                translate([0,0,8])  difference(){
                    hull(){
                        translate([0,-27,0]) cylinder(d=15,h=3,center=true);
                         cylinder(d=40,h=3,center=true);
                    }
                    translate([0,-27,0]) cylinder(d=10,h=4,center=true);
                }
              
            } 
            for(i=[0:1:4]) rotate([0,0,ran*i]) translate([0,centerR,31.8])  hull(){
                 cylinder(d=holeWidth,h=Rh,center=false);
                 translate([0,holeWidth,0]) cylinder(d=holeWidth,h=Rh,center=false);
             }
            
            translate([8.65,20.45,10]) cylinder(d=3,h=20,center=true);
            translate([-8.65,20.45,10]) cylinder(d=3,h=20,center=true);
            translate([0,13.9,18.8]) difference(){
                translate([0,0,5]) minkowski(){
                    cube([12,40,30],center=true);
                    cylinder(d=11,h=1);
                }
                translate([0,22.2,-5])  cube([32,20,10],center=true);
                
            }
            
            translate([0,40,17.7])  intersection(){
                 rotate([90,0,0]) cylinder(d=22.5,h=20);
                 cube([23,30,18],center=true);
            }
            translate([0,-14,17.7]) cube([5.5,6.5,2.8],center=true);
        }

        
        //translate([0,0,0]) # TTmotor();
    }
    
}
module circleRing(r=_r,an=360){    
    color("Green") rotate_extrude(angle=an) translate([r,0,0]) circle(3);  
}
module clip(cent = 30,ang=360/4){
    
    minWide = 2;
    addWide = 1.5;
    LaunchPort = 10;
    
    nring_r = ring_r+7.5; 
  
 
    //bottomWide =  ;
    rotate([0,0,ang/2]) rotate_extrude(angle=-ang) {
        translate([ring_r+3+1,0]) square([minWide,clipHeight]);
        translate([ring_r+3+1+minWide,0]) square([addWide,20]);
    }
       /*
    translate([0,0,-25]) intersection(){
        rotate([0,0,-90]) rotate_extrude(angle=180) translate([cent,0]) square([nring_r-cent,2],center=false);
        translate([nring_r/2+cent,0,1])  cube([nring_r,sqrt( nring_r*nring_r *2),2],center=true);
    }
    */
  
    //translate([-(ring_r)-3.5,15,-2.5]) rotate([0,90,0]) Ear();      
    translate([0,0,-LaunchPort*2]) {
        rotate([0,0,-1])  rotate_extrude(angle=-ang/2+1) translate([ring_r+3+1,0]) square([addWide+minWide,LaunchPort*2]);
        translate([0,0,0]) union(){
            rotate([0,0,-ang/4]) rotate_extrude(angle=-ang/4) translate([ring_r-3,0]) square([addWide+minWide+3.5,LaunchPort]);
            
          rotate([0,0,ang/2]) rotate_extrude(angle=-ang/2-1)  translate([ring_r+3+1,0]) square([addWide+minWide,LaunchPort-3]);
        }
    }
   

    translate([0,0,-4.6]){
        translate([ring_r+12,15,-5]) rotate([0,90,0]){
            spring();       
        }
        translate([0,0,-7]){
            springTrack();
        }
    }
        
    
    //rotate_extrude(angle=-100) translate([ring_r+3+1,0]) square([2,70]);
}
 
 
module rodA(){
    zr = 0;    
    rotate([0,0,zr]){
         translate([0,0,12]){
           
            difference(){
                union(){
                    translate([(maxLong+holeLong)/2,(10-holeLong)/2,0]) {
               cylinder(d=holeLong,h=8);
               //translate([0,0,5]) cylinder(d=holeLong*2,h=1);
           }
                    translate([0,0,-6]) cylinder(d=10,h=14,center=true);
                    hull(){
                        cylinder(d=10,h=2,center=true);
                        translate([(maxLong+holeLong)/2,(10-holeLong)/2,0])  cylinder(d=holeLong,h=2,center=true);
                    } 
                    //translate([mx,0,7])rotate([0,0,90]) cyInterfaceBigT(t_d=12,_h=12); 
                } 
                translate([0,0,0]) intersection(){
                    cylinder(d=6,h=50,center=true);
                    cube([8,4,50],center=true); 
                }
                
                translate([0,5,0]) cube([(maxLong+holeLong*2),1,30],center=true);
               //translate([(maxLong+holeLong)/2,0,0])  cylinder(d=holeLong,h=3,center=true);
            }     
        }
    }    
}
 
 
module rodB(){
    {
        difference(){  
            union(){      
                hull(){
                    translate([-(maxLong+holeLong)/2,0,0]) cylinder(d=12,h=2,center=true);
                    translate([(maxLong+holeLong)/2,0,0]) cylinder(d=12,h=2,center=true);
                }
                translate([0,9,0]) union(){
                    translate([0,-2.5,0]) hull(){
                        translate([holeLong,0,0]) cylinder(d=10,h=2,center=true);
                        translate([-holeLong,0,0]) cylinder(d=10,h=2,center=true);                       
                    }
                    hull(){
                        translate([holeLong,0,0]) cylinder(d=holeLong-0.5,h=3,center=false);
                        translate([-holeLong,0,0]) cylinder(d=holeLong-0.5,h=3,center=false);
                    }
                    
                }
                translate([0,-9,0]) union(){
                    translate([0,2.5,0])  hull(){
                        translate([holeLong,0,0]) cylinder(d=10,h=2,center=true);
                        translate([-holeLong,0,0]) cylinder(d=10,h=2,center=true);                       
                    }
                    hull(){
                        translate([holeLong,0,0]) cylinder(d=holeLong-0.5,h=3,center=false);
                        translate([-holeLong,0,0]) cylinder(d=holeLong-0.5,h=3,center=false);
                    }
                }
                
            }
            hull(){
                translate([-(maxLong+holeLong)/2,0,0]) cylinder(d=holeLong,h=5,center=true);
                translate([(maxLong+holeLong)/2,0,0]) cylinder(d=holeLong,h=5,center=true);
            }
    
        }
        
        
        
    }
    
}
module cyInterfaceBigT(t_d=4.8,fk=1.1,_h = 36){
    __h = _h/2-2;
    difference(){ 
        union(){
            cylinder(d=t_d,h=_h,center=true);
            translate([0,0,__h]) {
                cylinder(d1=t_d*fk,d2 = t_d,h=3,center=false);
                translate([0,0,-2]) cylinder(d=t_d*fk,h=2,center=false);
                translate([0,0,-5]) cylinder(d2=t_d*fk,d1 = t_d,h=3,center=false);
            }
        }
        translate([0,0,__h]) cube([t_d+2,1,t_d+3],center=true);
    }    
}

module Track(springLong = headLong){
    
    Tracklong =maxLong+springLong*3; 
    union(){         
        translate([-11,0,9]) difference(){
            union(){
               // hull(){
                translate([-2,0,0]) cube([6,Tracklong,8],center=true);
                    // cube([5,Tracklong,9],center=true);
               // }
                //translate([-9,0,0]) cube([8,Tracklong,5],center=true);
            }
            translate([0,0,0]) cube([6,Tracklong+1,2.4],center=true);   
            //translate([-2,0,0]) cube([2.5,Tracklong+1,5.5],center=true);              
        }
    }    
}
module Head(down = 13,twidth = 2){
    bh = 11; 
    width = 22;
    difference(){
        translate([0,0,0]){ 
           translate([0,0,0])  hull(){                
               translate([0,-2.5,7]) cube([width,2,1],center=true);
               translate([0,2,0]) cube([width,3,1],center=true);                
               translate([0,-1,-(down-twidth/2)]) cube([width,5,twidth],center=true);
           }  
           //#translate([0,-3,(down+5)/2]) cube([19,1,down+5],center=true);
           
            
     
           
            translate([0,-2,9]) hull(){
                translate([0,-1,1]) cube([width,1,2],center=true);
                translate([0,1,0]) cube([width,3,0.1],center=true);
                translate([0,-1,-4]) cube([width,1,1],center=true);
            }
        }   
        translate([0,1,-(down-6)])  rotate([90,0,0]){
            hull(){
                translate([2,0,0]) cylinder(d=10,h=5,center=true);
                translate([-2,0,0]) cylinder(d=10,h=5,center=true);
            }
            intersection(){
                cylinder(d=7.4,h=15,center=true);
                cube([10,3.5,15],center=true);
                
            }
            
        }
        
    }    
}
 


module springBase(ra=20,ra1=13.7,h=3,fm=360*3){

    rav = 0.01;
    max_m=(ra)/rav;
    max_m1=(ra1)/rav;
    fMax = (fm/max_m); 
    linear_extrude(height=h) polygon(concat(   
        [for(i=[0:1:max_m])pol_zu_kart([rav*i,fMax*i])],
        [for(i=[0:1:max_m1])pol_zu_kart([ra1-rav*i,-fMax*i])]
    ));
    
}
module spring(){
   
    hh=6.4;
     h=3;
    ra=20;
    ra1=13.7;
    difference(){
        union(){
        
            springBase(ra,ra1,h=h);
            cylinder(h=h,d=12,center=false);
            rotate_extrude() translate([ra-hh,0]) square([hh,h],center=false);
        }
        cylinder(h=9,d=5.4,center=true);
    }
    
}

function pol_zu_kart(polvect) = [
	polvect[0]*cos(polvect[1]),  
	polvect[0]*sin(polvect[1])
];
module springA(){
    h=4;
    ra=9;
    ra1= 7;
    inW = 4.8;
    move = 2.4;
    translate([0,0,10]){ rotate([0,0,90])difference(){
        union(){
            rotate([0,0,10]){
                translate([0,0,0]) rotate([0,0,0])  springBase(ra,ra1,h,fm=360);
                translate([0,0,0]) rotate([0,0,180]) springBase(ra,ra1,h,fm=360);
            }

            translate([ra+move,0,h/2]) rotate([0,90,0])intersection(){
                union(){
                    cyInterface(_h=10,t_d=inW);
                    translate([0,0,-3]) cylinder(d=inW+1,h=4,center=true);
                }
                cube([h,inW*2,10*2],center=true);
            }
            rotate([0,0,-55]) hull(){
                translate([1,0,0]) cylinder(d=2.5,h=h,center=false);
                translate([-1,0,0]) cylinder(d=2.5,h=h,center=false);
            }
            translate([-(ra+move),0,0]) { 
                cylinder(d=9.5,h=h);
                translate([0,0,1.5]) rotate([90,0,90]) slider();   
            } 
        }
        translate([-(ra+move),0,0]) cylinder(d=5.4,h=10,center=true);
    }
     
}
    //translate([ra,0,0]) cylinder(h=h,d=ra1,center=false);
    
    //cylinder(h=h,d=ra1,center=false);
}
module springTrack(){
    long = springLong-5;
    translate([0,0,-0.5]) {
        translate([0,0,0.5])   difference(){   
            union(){
                    rotate_extrude(angle=long) translate([ring_r+4.5,0]) square([3.5,11]);
                    //#rotate_extrude(angle=springLong/2) translate([ring_r+8,0]) square([1,13]);           
                    rotate([0,0,long/2])rotate_extrude(angle=long/2) translate([ring_r-2,0]) square([6.5,4]); 
                }
            rotate([8,0,20]) translate([0,0,4]) rotate_extrude(angle=360)  translate([ring_r+2.5,0]) circle(3.5);
            
          
        }
        translate([_r+12,15,2.5])
        difference(){
            rotate([0,90,0]) {
                translate([0,0,1]) cyInterface(_h=12,t_d=4.8);
                translate([0,0,-3.5]) cylinder(d=8,h=6,center=true);
            }
            translate([0,0,-3.5]) cube([50,50,3],center=true);
        }
    }
  
}

