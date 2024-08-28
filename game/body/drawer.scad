use <bottom.scad>

$fn=100;

rotate([0,90,0]) translate([0,0,6]){
    translate([0,0,4]){
        mcuA();
        mcuB();
    }
    
    //translate([0,0,16]) motorDriver();
    translate([0,0,28]) motorDriver();
    
    union() {
        body();
        mirror([0,1,0]) translate([0,0,0])  body();
    }   
}

translate ([13,0,21])showBottom();

 


//translate ([28,15,0]) rotate([90,0,0]) showWheelRoom();
module mcuA(){
    #union(){
        difference(){
            translate([0,0,0]) {
                cube([30,35,10],center=true);
                translate([0,0,-4]) cube([34,35,2],center=true);
                
            }
            translate([0,0,1]) union(){
                cube([26,35,10],center=true);
                translate([0,0,5]){
                translate([0,15,0]) cube([31,5,10],center=true);
                translate([0,-14,0]) cube([31,7,10],center=true);
                }
            }
            translate([0,5,-4]) cube([16,25,3],center=true);
        }
        
    }
}
module mcuB(){
    translate([0,1,2]) union(){
        cube([16,26,2],center=true);
        translate([0,14,0])union(){
            cube([30.2,5,2],center=true);
             translate([0,-0.5,0]){
                translate([16,0,0]) cube([2,6,2],center=true);
                translate([-16,0,0]) cube([2,6,2],center=true);
            }
        }
        translate([0,-14,0]) {
            cube([30.2,5,2],center=true);
            translate([0,0.5,0]){
                translate([16,0,0]) cube([2,6,2],center=true);
                translate([-16,0,0]) cube([2,6,2],center=true);
            }
      
        }
    }
}

module infaceHead(){
    
    difference(){
        union(){
            cylinder(d1=7,d2=7.5,h=3,center=false);
            translate([0,0,3])cylinder(d2=7,d1=7.5,h=3,center=false);
        }
        translate([0,0,3]) cube([1,8,6],center=true);
    }
    
}
module body(m=10){
    w=40;
    
    difference(){
        translate([0,0,6*(m)/2-3]){
            rotate([90,0,0])  minkowski(){
                cube([37,6*m+3,42-3,],center=true);
                cylinder(d=3,h=3,center=true);
            }
           
            translate([0,-18.5,0 ]){
                intersection(){
                    union(){
                        translate([0,0,w/2]) {
                            rotate([0,90,0])  {
                                cylinder(d=7,h=44,center=true);
                                translate([0,0,22])infaceHead();
                                mirror([0,0,1])translate([0,0,22])infaceHead();
                            }
                             
                        }
                        translate([0,0,-w/2])  rotate([0,90,0]) {
                            cylinder(d=7,h=44,center=true);
                            translate([0,0,22])infaceHead();
                            mirror([0,0,1])translate([0,0,22])infaceHead();
                        }
                    }
                    translate([0,1.5,0]) cube([50+12,8,w+8],center=true);
                }
            }            
        }
        //translate([0,0,6*(m)/2-3]) rotate([0,0,0]) cylinder(d=25,h=6*(m)+6,center=true);
        translate([0,3,0]){
            translate([0,0,6*m/2-3]) cube([25,52,6*m],center=true);
            translate([0,0,6*m/2-3]) cube([33,44,6*m],center=true);
            for(i=[0:1:m-1])translate([0,0,i*6])  cube([34.6,42,2.4],center=true);
        }
       translate([0,20,6*m/2-3]) cube([41,40,6*m+10],center=true);
       
        
        
    }  
    
}
 

 
module motorDriver(){
    difference(){
        union(){
            translate([0,0,2])difference(){
                cube([34,35,2],center=true);
                
                cube([20,35,2],center=true);
                cube([34,20,2],center=true);
            }
            translate([0,0,0.5]) cube([25,29,5],center=true);
        }
        
        cube([21.5,25.5,5],center=true);
        cube([20,24,15],center=true);
        
        
    }
    //#cube([21,24.7,5],center=true);
    
    translate([10.5,0,0]) rotate([90,0,0]) cylinder(d=1.5,h=3,center=true);
    translate([-10.5,0,0]) rotate([90,0,0]) cylinder(d=1.5,h=3,center=true);
}