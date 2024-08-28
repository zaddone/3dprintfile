use <fire_v1_1.scad>
use <reducer_v3.scad>
$fn = 99;
clipHeight = 44;
pi = 3.14159;
rad = 57.29578;
springLong = 50;
R = 64;
maxLong = (springLong+10)/rad * R;
holeLong = 5;

//gearmod = 0.6;
//0.6 13 32} &{0.5 17 37} 3_13.50 273

Agear = [17,37,0.5];
Bgear = [13,32,0.6];
layer=4;
width=2.5;
 slit = 0.2;
//Agear = [16,23,gearmod];
//Bgear = [17,22,gearmod];
centerR = (Agear[0]+Agear[1]*2)*Agear[2]/2+Agear[2]+width*2+width/2 +slit*4 ; 

ringMove = (maxLong+holeLong);
function position(t) = [0,t*ringMove];

//translate([0,0,15]) translate(position($t))  circleRing();
translate([0,0,-3]) fireMainT($t);
translate([0,0,-1.2])  showRed(fit=true,long=(maxLong+holeLong)/2,holeLong=holeLong);
downMain();
module showRed(a=Agear, b=Bgear,fit=false,long=50 , holeLong=5 ){
    
    

    
   

    modA = a[2];
    ringA=a[0]+a[1]*2;
    ringAr = ringA*modA/2+modA+slit;
    
    centerRing = (a[0]+a[1])/2 * a[2];

    modB = b[2];
    ringB=b[0]+b[1]*2;
    ringBr = ringB*modB/2+modB+slit;
    planetCenter = (b[0]+b[1]) /2 * b[2];
    rAr = ringAr+width+slit;
 
    if (fit){
        
        union(){
            rotate([0,0,0]) ringA(modA,ringA,ringAr,layer,width,holeLong,slit);        
            translate([0,0,layer+0.2]) rotate([0,0,90]) { 
                ringAlibAm(planetCenter,ringAr,width,layer-2,modA,slit)  ; 
       
                PAssemble(planetCenter,7,slit);         
                // ringALibBase(centerRing,ringAr,width,layer-2.4,modA,slit){
                     
                     
                 //    };
                ringALibOutput(modA,ringAr,width,holeLong ,layer,slit );
                translate([0,0,3.6]) rotate([0,0,0]) ringALibOutputB(holeLong,long );
            }         
            translate([0,0,-(layer+0.4)]) {            
                ringB(rAr,ringBr,layer,width,modB,ringB,slit);  
                   
                translate([0,0,0])  ringBLib(rAr,width,layer,slit){
                    
                    motor130Room(rAr,width ) ;// PAssemble_2(rAr+width);
                    
                }
                motorFix(rAr,width);
                /*  
               translate([0,0,-25-2.2])  motorTemp();
                motorFix(rAr,width);
                 */
                //translate([0,0,-30 ]) motorRoom();
            }     
        }   
    }else{
        translate([0,0,layer*2]) {
            ringA(modA,ringA,ringAr,layer,width);        
            translate([0,0,layer*3]){
                ringALibOutput(modA,ringAr,width,holeLong ,layer );
                translate([0,0,layer*3])   ringALibOutputB(holeLong,long );
            }
        }
         
        translate([0,0,-(layer*2 )]) {
            ringB(rAr,ringBr,layer,width,modB,ringB);        
             translate([0,0,-layer*2 ]) {
                 ringBLib(rAr,width,layer);
            translate([0,0,-30 ]) motorRoom();
             }
        }
        
        
    }
}

module fireMainT(t){
      
 
    {
        //rotate([0,0,-90+t*180])  rodA();
        translate([0,0,15]) {
            //rodB();
            
            //translate([0,(maxLong+holeLong+21),8]) Head( );
            translate([0,t*ringMove,11
             ]) circleRing();
        }
        
        //translate([0,0,32]) for(i=[1:1:(clipHeight-5)/6.2]) translate([0,0,6.2*i-3]) circleRing();
        translate([0,-((ringMove)/2) + ringMove*t ,0]) {
         translate([0,0,15])  rodB();
        translate([0,-20.9,16]) rotate([0,0,0]) rodD();
        }
        
        // import("fire_v1_springTrack_1.stl");
         mirror([1,0,0])   translate([0,0, 3])springShow();
        
    }
    
}
module centerFix(centerR=10,ar  = 1,lay){
    w = centerR -ar-0.5;
    and = 360/5;
    difference(){
        union(){
            rotate_extrude() translate([ar,lay]) polygon([[0,0],[w,1],[w,4],[0,5]]) ;
              children();
        }
        
        for(j=[0:1:4]) rotate([0,0,j*and]) translate([centerR,0,lay+2]) cylinder(d=holeLong+1,h=3.5,center=true);
    }
    
}
module downMain(){
      
    f=10;
    holeWidth=5;
    m=5;
    ang = 360/m;
    
    h=3;
    union(){
        rotate([0,0,90-(ang+ang/2)]) {
           rotate([0,0,ang*4]) downLockEnd(centerR,f); 
        }   
    }
    begin = 90-(ang+ang/2);

    springShow();
        
        
        
    rotate([0,0,0]) union(){
            union(){
                rotate([0,0,begin]) clipA(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin,ring_r=R);               
                rotate([0,0,begin-ang])  clipB(f,h,ang,holeWidth=holeWidth,centerR = centerR,ring_r=R)  !clipBFix(f=f,h = h,r=R+4.5,flo=28);      
                mirror([1,0,0])rotate([0,0,begin-ang]) clipB(f,h,ang,holeWidth=holeWidth,centerR = centerR,ring_r=R);            
                mirror([1,0,0])rotate([0,0,begin]) clipA(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin,ring_r=R);
                rotate([0,0,begin-ang*4]) clipC(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin,ring_r=R);
        }
    }
    
    
    /*
  rotate([0,0,0]) translate([0,0,-32]) {
 
    TTmotorRoom(holeWidth=5.5,centerR = centerR-6.4,Rh= 3.4);
    rotate([0,0,180]) translate([0,25,8]) {
       beginWheelFix();
       beginWheel();
   }
   
   translate([0,0,33]) TTmotorRoomFix(holeWidth=5.5,centerR = centerR-6.4,Rh= 3.4);
   translate([0,0,0])  TTmotor();
}
    */
     
}
module downLockEnd(centerR = 24.8,f=10,ring_r=R){    
    x = ring_r-centerR+3;
      translate([centerR+(x)/2,0,1.5])  difference() {
            union(){
                cube([x,f+5,7],center=true);                 
            }
            translate([0,4.5,0]) difference(){
                cube([x+1,7,3.6],center=true);
                translate([0,0,-1.5]){
                    translate([0,1,0]) cube([x+10,1,0.8],center=true);
                    translate([0,-1,3]) cube([x+10,1,0.8],center=true);
                }
                
            }
            translate([0,-4.5,0]) difference(){
                cube([x+1,7,3.6],center=true);
                translate([0,0,-1.5]){
                    translate([0,-1,0]) cube([x+10,1,0.8],center=true);
                    translate([0,+1,3]) cube([x+10,1,0.8],center=true);
                }
            }
        }
    {        

        translate([0,0,0]) {
            difference(){
                rotate([0,0,-(f-0.5)]) rotate_extrude(angle=f*2-1) translate([ring_r-6,3.2]) square([10,15]);
                
                translate([x+centerR,-f*2,0])   cube([3,f*4,20],center=false);
                translate([centerR+x/2+1 ,0,16])  { 
                    union(){
                        //cylinder(d=8.5,h=10,center=true);
                        translate([0,0,1.8]) cube([x,12.8,2.4],center=true);
                        translate([0,0,0]) cube([x,11.4,1.6],center=true);
                        translate([0,0,-2]) cube([x,12.8,2.6],center=true);
                       // cube([7,6.5,14],center=true);
                    }
                    
                     
                }
                
            }
            
        }
    }
  
   
    
}
module clipB(f=10,h=3,ang=30,holeWidth=5,centerR = 23.5,ring_r=R){
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
    r = ring_r+4.5;
    m =  asin((f/2)/r) ;
    n =  asin(3/r);
    flo = 28;
    holeRot = f/2+1;
    difference(){        
        rotate([0,0,f]) rotate_extrude(angle=f ) translate([ring_r-5,0]) square([5+4.5+4+2, 16+3 ]);
        rotate([0,0,holeRot]){
            rotate_extrude(angle=f ) translate([r-0.1,3]) square([4.2,16]);
            rotate([0,0,f-1.1]) rotate_extrude(angle=1.2 ) translate([r-1.1,3]) square([5.2, 16 ]);
        }
        
        
    }
    
    rotate([0,0,holeRot]) children();//  clipBFix(f,r,flo);
}
module clipBFix(f,h,r,flo = 28){    
    union(){
        rotate_extrude(angle=f ) translate([r+0.2,h]) square([4-0.4, flo+clipHeight]);
        rotate([0,0,f-0.8]) rotate_extrude(angle=0.8 ) translate([r-1,h]) square([4, 16 ]);       
        rotate_extrude(angle=f ) translate([r-13,flo+clipHeight]) square([4+13, h]); 
        rotate_extrude(angle=f ) translate([r-13,flo]) square([4, clipHeight]);  
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
    
    ixy4 = pol_zu_kart([rr,endAng-40]); 
    
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
    li3 = concat(
            [for(j=[springLong:-1:0])pol_zu_kart([rr+4,j])], 
            [for(j=[0:1:springLong])pol_zu_kart([rr,j])]
           );                
    li4 = concat(
            [for(j=[endAng-f*0.2:-1:endAng-f])pol_zu_kart([rr-7,j])],
            [for(j=[endAng-f:1:endAng])pol_zu_kart([rr,j])]
           );  
      
    li5 = concat(
            [[ixy[0],ixy_1],[ixy4[0],ixy_1],[ixy2[0],ixy2[1]]],  
            //[for(j=[-begin:-1:f/2])pol_zu_kart([rr+4,j])],       
            [for(j=[-begin:1:endAng])pol_zu_kart([rr,j])]);       
    li6 = concat([[rr,0],[rr+10,10],[rr,10]]);
            
    
    union(){
        translate([0,0,0]) linear_extrude(height=hhg+hh) polygon(li0); 
        translate([0,0,0]) linear_extrude(height=17) polygon(li1);           
        translate([0,0,hhg]) linear_extrude(height=hh) polygon(li1);   
   
        
        translate([0,0,hhg+hh]) linear_extrude(height=clipHeight-hh) polygon(li2); 
        translate([0,0,0]) linear_extrude(height=17) polygon(li4); 
        
        translate([0,0,hhg+hh]){ 
          
            difference() {
                linear_extrude(height=10) polygon(li5); 
                 rotate([0,0,f/2]) rotate_extrude(angle = endAng-f/2 ) polygon(li6);
            }
            
            //linear_extrude(height=10+hh) polygon(li7); 
        }
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
module ringALibOutputB(holeLong,long ){
  
    rotate([0,0,90]) union(){
        difference(){
            union(){
                translate([-holeLong/2,-(holeLong) ,-3.5]) {
                    cube([holeLong,holeLong*2,5.5],center=false);                
                }
                translate([-holeLong/2,holeLong/2 ,-1]) cube([holeLong,holeLong*3,3],center=false);
                translate([0,0,1.5]) hull(){
                    translate([-holeLong/2,holeLong*2 ,-1]) cube([holeLong,holeLong*1,3],center=false);
                    translate([0,long,0])cylinder(d=holeLong,h=3); 
                }
            }
            translate([holeLong/2,holeLong/2,0]) cube([2,2,20],center=true);
            translate([-(holeLong/2),-holeLong/2,0]) cube([2,2,20],center=true);
        }
        
        translate([0,long,1.5]){
            cylinder(d=holeLong,h=9);  
            translate([0,0,9]) difference(){                 
                 cylinder(d=holeLong+1,h=1);                  
                translate([(holeLong)/2,-(holeLong+1)/2]) cube([1,holeLong+1,1],center=false);                
            }
            /*
            translate([0,0,3]) difference(){  
                cylinder(d=holeLong+1,h=0.6); 
                translate([(holeLong)/2,-(holeLong+1)/2]) cube([1,holeLong+1,0.6],center=false);
            }
            */
        }
    }
        
    
    
}