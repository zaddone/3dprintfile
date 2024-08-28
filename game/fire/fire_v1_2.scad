use <fire_v1_1.scad>
 
use <car_v10_lib.scad>
use <car_v10_battery.scad>

rad = 57.29578;
springLong = 50;
ring_r = 63;
maxLong = (springLong+10)/rad * ring_r;
holeLong = 5;

translate([0,0,-3]) fireMain(true);
downMain();

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

    translate([0,0,30-4.6]){
        translate([ring_r+18.5,0,-5]) rotate([0,90,0]){
            spring();       
        }
        translate([0,0,-7]){
            springTrack();
        }
    }
        
        
        
    rotate([0,0,0]) union(){
            union(){
                rotate([0,0,begin]) clipA(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin);               
                rotate([0,0,begin-ang])  clipB(f,h,ang,holeWidth=holeWidth,centerR = centerR);      
                mirror([1,0,0])rotate([0,0,begin-ang]) clipB(f,h,ang,holeWidth=holeWidth,centerR = centerR);            
                mirror([1,0,0])rotate([0,0,begin]) clipA(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin);
                rotate([0,0,begin-ang*4]) clipC(f,h,ang,holeWidth=holeWidth,centerR = centerR,begin=begin);
        }
    }
  
     
}