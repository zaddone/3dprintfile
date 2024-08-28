use <car_v10_lib.scad>
use <car_v10_battery.scad>
use <car_v10_body.scad>
use <car_v10_body_lock.scad>
use <car_v10_motor_room.scad>
use <car_v10_finder.scad>
use <car_v10_wheel.scad>
uv = 8; 
Body_x = 30;
showBody();
module showBatteryBody(interX=20){
     rotate([0,0,180]) translate([0,-13,23])  
        union(){
            battery();
translate([0,36+8,6.6]) !batteryFixFire(interX);
translate([0,-52+8,6.6]) rotate([0,0,180]) batteryFixFire(interX=12);
            translate([0,0,0.2])  battery_top();
            translate([-12,uv,-3.5]) battery_fix();
            mirror([1,0,0]) translate([-12,uv,-3.5]) battery_fix();
            
            //translate([0,48,7]) #cube([18,2,25],center=true);
            //translate([0,uv,26]) fire();
        }
  
    
 }
module showBody(){
union(){
   
    translate([0,4,0]){
        body(_dx=Body_x);
        translate([0,20,0])  body_Lock(_dx=Body_x);
         translate([-Body_x/2-27.7,-6,0]) {
             motorRoom();
             translate([-10,0,0]) rotate([0,90,0]) ringB();
         }
        rotate([0,180,0]) translate([-Body_x/2-27.7,-6,0]){
            motorRoom();
             translate([-10,0,0]) rotate([0,90,0]) ringB();
        }
    }
    showBatteryBody();
    /*
    translate([0,1,50]){
        finderFixDown();
        mirror([0,1,0]) finderFixDown();
        finderFix();
    }
    */
    //translate([0,1,50]) # fire();
    //translate([0,1,60]) ring();
    //translate([0,-33,29]) # power();
}

//cube([40,100,50],center=true);
//translate([-40,0,0]) cube([40,100,50],center=true);
}

/*
translate([-Body_x/2,0,0]){
 translate([-27.7,0,0])  motorRoom();
 // translate([-15,6,0])  motor_Lock();
 // translate([-4,0,0])  #motorRoomBottom();
}
union(){
    rotate([0,0,0]) translate([-Body_x/2,0,0]){
        translate([-27.7,-6,0])  motorRoom();
     // translate([-13.5,12,0]) motor_Lock();
     // translate([-4,0,0])  #motorRoomBottom();
    }
    //translate([-24.9,0,0]) motorRoomTop();
    //#motorRoomBottom();
    rotate([0,0,0]) union(){
       difference(){
           ! body(_dx=Body_x);
                       
            //translate([0,-10,0])  cube([100,30,60],center=true);
         
        }
       // translate([0,20,0])  body_Lock(_dx=Body_x);
    }
    translate([0,0,40]) battery();
} 

*/