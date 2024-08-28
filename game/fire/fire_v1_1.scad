use <fire_v1.scad>
//use <car_v10_lib.scad>
use <car_v10_battery.scad>
$fn = 100;
clipHeight = 44;
pi = 3.14159;
rad = 57.29578;
springLong = 50;
R = 64;
maxLong = (springLong+10)/rad * R;
holeLong = 5;
 
translate([0,0,-3]) fireMain(false);
!downMain();
translate([0,-(100-1),-25]) batteryBody();
module fireMain(fe=true){
      
    n = fe?1:-1;
    {
        rotate([0,0,n*90])  rodA();
        translate([0,n*(maxLong+holeLong)/2,15]) {
            rodB();
            
            //translate([0,(maxLong+holeLong+21),8]) Head( );
            rotate([0,0,0]) translate([0,(maxLong+holeLong)/2,10 ]) circleRing();
        }
        
        //translate([0,0,32]) for(i=[1:1:(clipHeight-5)/6.2]) translate([0,0,6.2*i-3]) circleRing();
        translate([0,-((maxLong+holeLong)/2)*-n,16]) translate([0,-20.9,0]) rotate([0,0,0]) rodD();
        
        
         mirror([1,0,0])   translate([0,0, 3])springShow();
        
    }
}
module downMain(){
      
    f=10;
    holeWidth=5;
    m=5;
    ang = 360/m;
    centerR = 24.8; 
    h=3;
    union(){
        rotate([0,0,90-(ang+ang/2)]) {
            rotate([0,0,ang*4])  downLockEnd(centerR,f); 
        }  
        translate([0,0,-3])  translate([0,-((maxLong+holeLong)/2),16]) translate([0,-20.9,0]) rotate([0,0,0]) rodD();
        
        //translate([0,(maxLong+holeLong)/2,15])  translate([0,-35,8]) HeadBack( );
    }
    begin = 90-(ang+ang/2);

    springShow();
        
        
        
    rotate([0,0,0]) union(){
        union(){
            rotate([0,0,begin])  clipA(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin);               
            rotate([0,0,begin-ang])  clipB(f,h,ang,holeWidth=holeWidth,centerR = centerR);      
            mirror([1,0,0])rotate([0,0,begin-ang]) clipB(f,h,ang,holeWidth=holeWidth,centerR = centerR);            
            mirror([1,0,0])rotate([0,0,begin]) clipA(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin);
            rotate([0,0,begin-ang*4]) clipC(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin);
        }
    }
    
  rotate([0,0,0]) translate([0,0,-32]) {
 
    TTmotorRoom(holeWidth=5.5,centerR = centerR-6.4,Rh= 3.4);
    rotate([0,0,180]) translate([0,25,8]) {
       beginWheelFix();
       beginWheel();
   }
   
   translate([0,0,33]) TTmotorRoomFix(holeWidth=5.5,centerR = centerR-6.4,Rh= 3.4);
   translate([0,0,0])  TTmotor();
}
     
}
module springShow(ro=0,ring_r=R){
    
    translate([0,0,30-4.6])  {
        translate([ring_r+18.5,0,-5]) rotate([0,90,0]){
           spring();       
        }
          translate([0,0,-7]){
            rotate([0,0,ro]) springTrack();
        }
    }    
    
    
}
module downLockEnd(centerR = 24.8,f=10,ring_r=R){    
    x = ring_r-centerR;
    translate([centerR+(x)/2+3,0,1.5]){        
        difference() {
            union(){
                cube([x,f+5,7],center=true);
                //translate([0,0,-6.7])  cube([x,24,10],center=true);
            }
            translate([0,4.5,0]) difference(){
                cube([x+1,7,3.4],center=true);
                translate([0,0,-1.5]){
                    translate([0,1,0]) cube([x+10,1,0.8],center=true);
                    translate([0,-1,3-0.2]) cube([x+10,1,0.8],center=true);
                }
                
            }
            translate([0,-4.5,0]) difference(){
                cube([x+1,7,3.4],center=true);
                translate([0,0,-1.5]){
                    translate([0,-1,0]) cube([x+10,1,0.8],center=true);
                    translate([0,+1,3-0.2]) cube([x+10,1,0.8],center=true);
                }
            }
        }
        translate([x/2-3,0,12]) {
            difference(){
                translate([-5,0,-3]) minkowski(){
                    cube([15,f+11,11.5],center=true);
                    
                    rotate([0,90,0])  cylinder(d=3,h=1,center=true);
                    //translate([-10,0,-5]) # cube([2,f+5,4],center=true);
                }
                translate([0,0,2.5])  { 
                    union(){
                        //cylinder(d=8.5,h=10,center=true);
                        translate([0,0,1.8]) cube([27,12.8,2.4],center=true);
                        translate([0,0,0]) cube([27,11.4,1.6],center=true);
                        translate([0,0,-2]) cube([27,12.8,2.6],center=true);
                       // cube([7,6.5,14],center=true);
                    }
                    
                     
                }
                
            }
            /*
            #intersection(){
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
            */
        }
    }
    //downLock(centerR,f);
   
    
}
module springTrack(ring_r=R){
    exR = 4.5;
    long = springLong;
    ixy = pol_zu_kart([ring_r+exR,long]);  
    ixy2 = pol_zu_kart([ring_r+exR+5,long]);  
    li2 = concat(
    [ixy2,[ixy2[0],ixy2[1]+maxLong/10] ],
    [
        //pol_zu_kart([ring_r+exR+6,long+10]),
        pol_zu_kart([ring_r+exR+9,long ]),
    ]
    );
    li1 = concat(
    [ixy,[ixy[0]-exR,ixy[1]+maxLong/4],[ixy[0]+exR,ixy[1]+maxLong/4]],
    [
    //pol_zu_kart([ring_r+exR+2,long+15]),
        //pol_zu_kart([ring_r+exR+5,long+15]),
    
        pol_zu_kart([ring_r+exR+9,long ]),
    ]
    );
    li0 = concat(
            //[for(j=[long/2:-1:0])pol_zu_kart([ring_r+6,j])],
            [for(j=[0:1:long])pol_zu_kart([ring_r+exR,j])],
            [            
            //pol_zu_kart([ring_r+exR+10,long+10]),
            //pol_zu_kart([ring_r+exR+15,long+5]),
            pol_zu_kart([ring_r+exR+9,long]),
            [ring_r+exR+13.5,4],
            [ring_r+exR+13.5,-4],
            [ring_r+exR+ 5,-4],
            [ring_r+exR+ 5,0],
            ]
            
           ); 
 
    translate([0,0,-0.5]) {
        translate([0,0,0.5])   
            union(){
                 
                translate([0,0,0]){ 
                   //cylinder(r=ring_r+exR,h=2); 
                    hull(){
                        linear_extrude(height=0.6) polygon(li1); 
                        translate([0,0,6.4]) linear_extrude(height=0.6) polygon(li2);
                    }
                }
                 
                translate(pol_zu_kart([ring_r+exR,long])) rotate([0,0,21]) union(){  
                    
 
                }
                difference(){
                    union(){
                    
                         linear_extrude(height=7) polygon(li0); 
                       
                    }
                     
                    rotate([0,0,0]) translate([0,0,3.5]) rotate_extrude(angle=360)  translate([ring_r+2.5,0]) circle(3.5);
                    
                    translate([0,-long/2,5]) cube([ring_r+exR+13.5,long,2]);
                    
                    
                     
                }
            }

        
        difference(){
             union(){
                translate([ring_r+22,0,2.5])   rotate([0,90,0])  cylinderInput(h=10,d=4.8);
                /*
                 hull(){
                   translate([ring_r+12,0,2.5]) rotate([0,90,0]) translate([0,0,5.5]) cylinder(d=8,h=1,center=true);
                    //rotate([0,0,0]) translate([-3.5,0,-5]) cube([11,11,2],center=true);//cylinder(d=13,h=1,center=true);
                    //#linear_extrude(height=4) polygon(li4);
                    translate([0,0,0.5]) rotate([0,0,0]) rotate_extrude(angle=10) translate([ring_r+7,0]) square([1,4]);
                    
                }
                 */
            }
             
            translate([ring_r+12,0,-1])   cube([50,50,3],center=true);
        }
    }
    
    
}
module clipA(f=10,h=3,ang=30,holeWidth=5,centerR = 23.5,begin=10,ring_r=R){
    rr = ring_r+4;
    hh = 12;
    dh = 0;
    
    hhg = 27;
    //m = asin((f/2)/ring_r) ;
    endAng = ang-f;
    //echo("---",endAng);
    ixy = pol_zu_kart([rr,endAng]);    
    ixy1 = pol_zu_kart([rr,endAng-20]);     
    ixy2 = pol_zu_kart([rr+4,-begin]);
    ixy3 = pol_zu_kart([rr,endAng-f]);
    
    //ixy4 = pol_zu_kart([rr,endAng-f]); 
    ixy_1 = ixy[1]+1;
    
    translate([centerR+5,0,0]) difference(){ 
        hull(){
            cube([ring_r-centerR-5,f,h],center=false);
            translate([0,-f/3*2,-h]) cube([ring_r-centerR-5,f/3*2+2,h*3],center=false);
        }
        translate([-1,-f,0]) difference(){
            translate([0,-0.5,-0.2]) cube([rr-centerR+10,f+0.5,h+0.4],center=false);
            translate([0,f/2-1,-0.2]) cube([rr-centerR+10,1,0.8],center=false);
            translate([0,f/2+1,h-0.6]) cube([rr-centerR+10,1,0.8],center=false);
        }
    }
    difference(){
        union(){
            clipBase(f=f,h=h,ang=ang,holeSpacing=50,holeWidth=holeWidth,centerR=centerR);
            rotate([0,0,ang]) mirror([0,1,0]) translate([centerR+5,0,0]) difference(){ 
                hull(){
                    cube([rr-centerR,f,h],center=false);
                    translate([0,-f/3*2,-h]) cube([rr-centerR,f/3*2+2,h*3],center=false);
                }
                translate([-1,-f,0]) difference(){
                    translate([0,0,-0.2]) cube([rr-centerR+10,f+0.5,h+0.4],center=false);
                    translate([0,f/2-1,-0.2]) cube([rr-centerR+10,1,0.8],center=false);
                    translate([0,f/2+1,h-0.6]) cube([rr-centerR+10,1,0.8],center=false);
                }
            }
            //translate([0,0,30])  rotate([0,0,ang-f*2]) {
                  //  rotate_extrude(angle=f) translate([rr,0]) square([8, clipHeight]);      
                    //translate([r+1,9,0]) cylinder(d=13,h=13+clipHeight);
               // }
        }
        translate([0,ixy_1,-3.5])  cube([ixy1[0],ring_r/2,40+clipHeight]);
    }

    
    //echo("---", ixy[1]/tan(60),ixy1[0]);
    
    //ratm= atan( abs(ixy1[0]-ixy2[0]) / abs(ixy[1]-ixy2[1]));
    li0 = concat(
            [for(j=[-begin:-1:f/2])pol_zu_kart([rr+4,j])], 
            [for(j=[f/2:1:-begin])pol_zu_kart([rr,j])]
           );
            
    li1 = concat(
            [[ixy[0],ixy_1],[ixy1[0],ixy_1],[ixy2[0],ixy2[1]]],        
            [for(j=[-begin:1:endAng])pol_zu_kart([rr,j])]); 
    li2 = concat(
            [[ixy[0],ixy_1],[ixy3[0],ixy_1],[ixy3[0]+1,ixy3[1]+1]],
            [for(j=[endAng-f:1:endAng])pol_zu_kart([rr,j])]
           );
            
    li4 = concat(
            [for(j=[endAng-f*0.2:-1:endAng-f])pol_zu_kart([rr-7,j])],
            [for(j=[endAng-f:1:endAng])pol_zu_kart([rr,j])]
           );
            
    li3 = concat(
            [for(j=[springLong:-1:0])pol_zu_kart([rr+4,j])], 
            [for(j=[0:1:springLong])pol_zu_kart([rr,j])]
           );
    union(){
        translate([0,0,0]) linear_extrude(height=hhg+hh) polygon(li0); 
        translate([0,0,0]) linear_extrude(height=17) polygon(li1); 
          
        translate([0,0,hhg]) linear_extrude(height=hh) polygon(li1);
        
        translate([0,0,hhg+hh]) linear_extrude(height=clipHeight-hh) polygon(li2); 
        translate([0,0,0]) linear_extrude(height=17) polygon(li4); 
        //rotate([0,0,endAng-f]) rotate_extrude(angle=f) translate([ring_r,0]) square([5,17]);
    }
    translate([0,0,17+3.5]) difference(){
        hull(){
            rotate([0,0,-begin]) translate([ring_r+20,0,0]) rotate([0,90,0]) {
                //cylinder(d=45,h=8,center=true);                
                translate([0,0,-12]) rotate([0,0,-10]) rotate_extrude(angle=200) translate([10,0]) square([12,18]);
            }
            translate([ixy1[0]+15,ixy_1-0.5,0])  cube([30,1,26],center=true);
        } 
        
        rotate([0,0,-begin]) translate([ring_r+20,0,0]) rotate([0,90,0]){
            //#hull(){
                cylinder(d=41,h=6,center=true);
               // translate([0,33,0]) # cube([20,1,6],center=true);
            //}
            hull(){
                cylinder(d=30,h=50,center=true);
                rotate([-begin,0,0]) translate([0,29,0])  cube([18,1,50],center=true);
            }
        }
        //rotate([0,0,-begin]) translate([0,0,-3.5]) #linear_extrude(height=13) polygon(li3);
        translate([0,0,-3.5])  cube([ixy1[0]+26,ring_r*2,hhg-17]);
        
        translate([0,0,-3.5]) rotate([0,0,-begin])  cube([rr+18,ring_r*2,hhg-17]);
    }
 
}
 


module clipC(f=10,h=3,ang=30,holeWidth=5,centerR = 23.5,begin=10,ring_r=R){
    r = ring_r+3.5;
    difference(){
        clipBase(f=1,h=h,ang=ang,holeSpacing=50,holeWidth=holeWidth,centerR=centerR); 
        
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
         intersection(){
        union(){
            rotate([0,0,m]) rotate_extrude(angle=ang-m *2) translate([rr,0]) square([3, 18]);
           rotate([0,0,(ang)/2]) translate([rr+1,0,10])
               cube([3,15,16],center=true);
              
           }
           rotate([0,0,(ang)/2]) translate([rr+1,0,-6])  rotate([0,90,0]) cylinder(d=50,h=10,center=true);
        }
        
        translate([0,0,13])  intersection(){
           rotate([-ang/2,90,0]) cylinder(d=8.5,h=120,center=true);   
           rotate([0,0,ang/2])   cube([120,14,4.6],center=true);
        }
    }
    //translate([0,0,0]) rotate_extrude(angle=ang-f) translate([r,0]) square([4, 13]);
     
}
module HeadBack(down = 5,twidth = 2, width = 11.8){
     
   translate([-width/2,0,0])  rotate([0,90,0]) linear_extrude(width) polygon([[down,-twidth-25],[down,twidth], [-(4),-twidth+1],[-6,0],[-(7),-twidth],[down,-twidth-25]]);
   
      /*
    #union(){ 
        hull(){    
            //translate([0,-2.5,8]) cube([width,3,1],center=true);            
            translate([0,-2.5,7]) cube([width,2,1],center=true);
            translate([0,2,0]) cube([width,3,1],center=true);                
            translate([0,-1,-(down-twidth/2)]) cube([width,5,twidth],center=true);
        }   
        translate([0,-2,9])  hull(){
            translate([0,-1,1]) cube([width,1,2],center=true);
            translate([0,1,0]) cube([width,3,0.1],center=true);
            translate([0,-1,-4]) cube([width,1,1],center=true);
            //#translate([0,-1,-2]) cube([width,1,1],center=true);
        }
    }
    
    hull(){
        translate([0,-15,0])cube([width,1,down*2],center=true);
        translate([0,-twidth,down/2]) #cube([width,1,down],center=true);
        // translate([0,7,2]) cube([width,1,down+10],center=true);
    }   
 
    */
}


module clipBase(f=10,h=3,ang=30,holeSpacing=50,holeWidth=5,centerR = 23.5,ring_r=R){
    ex =4.5;
    r = ring_r+ex; 
    difference(){
        union(){
 
            linear_extrude(height=h) polygon(
                concat(
 
                [for(j=[ang:-1:0])pol_zu_kart([centerR,j])],
                [for(j=[0:1:ang])pol_zu_kart([r,j])])
            );  
             rotate([0,0,(ang)/2]) translate([centerR,0,0])    cylinder(d=holeWidth,h=h,center=false);
                
        }     
        
        translate([1,-f/2,-1]) cube([r+ex,f,h+clipHeight],center=false);
        rotate([0,0,ang]) translate([1,-f/2,-1]) cube([r+ex,f,h+clipHeight],center=false);
        
    }
}
module circleRing(r=R,an=360){    
    color("Green") rotate_extrude(angle=an) translate([r,0,0]) circle(3);  
}
function pol_zu_kart(polvect) = [
	polvect[0]*cos(polvect[1]),  
	polvect[0]*sin(polvect[1])
];

module rodD(width=12){
    //translate([0,85,-10]) cylinder(d=7,h=20,center=true);
    longX=(10+holeLong);
    long = (maxLong+35);
    difference(){
        translate([0,-(long/2-longX/2+0.5),1.5+1.5]){
            translate([0,0,2]) cube([width,long+longX,2],center=true);
            translate([0,0,0]) cube([width-2.5,long+longX,2],center=true);
            translate([0,0,-2]) cube([width,long+longX,2],center=true);
        }

       // translate([0,-1,0]) cube([width,holeLong+10,2],center=true);
       translate([0,8,0]) translate([0,0.9,0]) cube([8+0.2,holeLong+0.5,13],center=true);
    
    }
  
    translate([0,-(maxLong/2-22),6]) HeadBack( width = width,down=0);
    
}

module rodB(){    
    long = maxLong+holeLong+1;
    difference(){  
        union(){    
         
            translate([0,0,-1])  hull(){
                translate([-(long)/2,0,0]) cylinder(d=12,h=4,center=false);
                translate([(long)/2,0,0]) cylinder(d=12,h=4,center=false);
            }
            translate([0,0,1])  hull(){  
                translate([0,4.5,0])   cube([(long)+12/2,1,4],center=true);
                translate([0,15,0]) intersection(){
                    rotate([-90,90,0])  translate([0,0,-2]) cylinder(h=1,d=8,center=true);        
                    cube([10,100,4],center=true);
                }
            
            }
  
            translate([0,-12,0]) union(){
                translate([0,2.5,0])  hull(){
                    hull(){
                        translate([holeLong,0,0]) cylinder(d=10,h=2,center=true);
                        translate([-holeLong,0,0]) cylinder(d=10,h=2,center=true);                       
                    }
                    translate([0,5.5,0])   cube([(long)+12/2,1,2],center=true);
                }
                translate([0,0,4]){
                    minkowski(){
                        cube([8-1,holeLong-1,5],center=true);
                        cylinder(d=1,h=1,center=true);
                    }
                    translate([0,holeLong/2,3-0.6]) sphere(d=1.2);
                }
                 
                /*
                translate([0,0,3.5]) union(){
                    translate([holeLong,0,0]) cylinder(d=holeLong,h=1,center=false);
                    translate([-holeLong,0,0]) cylinder(d=holeLong,h=1,center=false);
                }
                */
            }
            
        }
        hull(){
            translate([-(long)/2,0,0]) cylinder(d=holeLong,h=10,center=true);
            translate([(long)/2,0,0]) cylinder(d=holeLong,h=10,center=true);
        }

    }
    
    translate([0,(long+22)/2+6,1]) intersection(){
        rotate([-90,90,0]) {
            //translate([0,0,(maxLong/2+holeLong)+5]){
                //#cyInterfaceBig(_h=15,t_d=7,fk=1.2);
                //cylinderInput(h=20,d=7);
            //}
            translate([0,0,-2]) cylinder(h=(long)+12,d=8,center=true);
        }
        translate([0,0,0])  cube([10,long+50,4],center=true);
    }  
    
}
module clipB_(f=10,h=3,ang=30,holeWidth=5,centerR = 23.5,ring_r=R){
    
    r = ring_r+4.5;
    difference(){
        clipBase(f=3,h=h,ang=ang,holeSpacing=50,holeWidth=holeWidth,centerR=centerR);  
    
            translate([0,-1,0]) union(){
            translate([0,f/2+0.8,0]) cube([r +10,1.4,0.8],center=false);
            translate([0,f/2-1.2,h-0.8]) cube([r +10,1.4,0.8],center=false);
        }

        rotate([0,0,ang]) mirror([0,1,0]) translate([0,-1,0]) union(){
            translate([0,f/2+0.8,0]) cube([r +10,1.4,0.8],center=false);
            translate([0,f/2-1.2,h-0.8]) cube([r +10,1.4,0.8],center=false);
        }
    }
    
}
module clipB(f=10,h=3,ang=30,holeWidth=5,centerR = 23.5,ring_r=R){
    r = ring_r+4.5;
    //f=1;
    difference(){
        union(){
            clipBase(f=3,h=h,ang=ang,holeSpacing=50,holeWidth=holeWidth,centerR=centerR);  
                
            m =  asin((f/2)/r) ;
            n =  asin(3/r);
            difference(){
                rotate([0,0,m+n+5]) rotate_extrude(angle=f*2 ) translate([r,0]) square([4, 30+clipHeight]);
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
            rotate([0,0,(m+n+5)]) rotate_extrude(angle=f*2) translate([r-6,0]) square([10, 17]);
            rotate([0,0,m+n]) {
                difference(){
                    hull(){
                        rotate_extrude(angle=ang-m *2-n) translate([r+0.5,0]) square([2,3 ]);                
                        translate([104,0,0]) cylinder(d=10,h=3);
                    }
                    translate([103.6,-0.5,0]) cylinder(d=5.2,h=10,center=true);
                    translate([80,2.5,0]) cylinder(d=5.2,h=10,center=true);
                    
                }
            } 
        }
        translate([0,-1,0]) union(){
            translate([0,f/2+0.8,0]) cube([r +10,1.4,0.8],center=false);
            translate([0,f/2-1.2,h-0.8]) cube([r +10,1.4,0.8],center=false);
        }

        rotate([0,0,ang]) mirror([0,1,0]) translate([0,-1,0]) union(){
            translate([0,f/2+0.8,0]) cube([r +10,1.4,0.8],center=false);
            translate([0,f/2-1.2,h-0.8]) cube([r +10,1.4,0.8],center=false);
        }
    
    }
}
module rodA(){
    zr = 0;    
    rotate([0,0,zr]){
         translate([0,0,12]){
           
            difference(){
                union(){
                    translate([(maxLong+holeLong)/2,(10-holeLong)/2,0]){
                        cylinder(d=holeLong-0.5,h=8);      
                         translate([0,0,7]) cylinder(d=holeLong+1,h=1);   
                        translate([0,0,1]) cylinder(d=holeLong+1,h=0.6); 
                    }
                    translate([0,0,-6]) cylinder(d=10,h=14,center=true);
                    hull(){
                        cylinder(d=10,h=2,center=true);
                        translate([(maxLong+holeLong)/2,(10-holeLong)/2,0])  cylinder(d=holeLong+1,h=2,center=true);
                    //translate([(maxLong+holeLong)/2,0,0])  cylinder(d=holeLong+1,h=2,center=true);
                    } 
                    //translate([mx,0,7])rotate([0,0,90]) cyInterfaceBigT(t_d=12,_h=12); 
                } 
                translate([0,0,0]) intersection(){
                    cylinder(d=6,h=50,center=true);
                    cube([8,4,50],center=true); 
                }
                
                translate([0,5.2,0]) cube([(maxLong+holeLong*2),1,30],center=true);
               //translate([(maxLong+holeLong)/2,0,0])  cylinder(d=holeLong,h=3,center=true);
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
     h=5;
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
        
        translate([0,0,h/2-head]) rotate([0,90,0]) cylinder(d=2.5,h=d*2,center=true);
    }    
}