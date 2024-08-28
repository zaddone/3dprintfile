use <car_v10_lib.scad>
$fn=80;
Body_x = 40;
body_Lock(_dx=Body_x);

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
        
        translate([0,-0.5,-14.1]) difference(){
            rotate([0,90,0])   linear_extrude(height=46,center=true) _guanDao();
            cube([34,10,10],center=true);
        }
        
         
        translate([23,-1.5,-15]) cube([0.5,16,5],center=true);
        translate([-23,-1.5,-15]) cube([0.5,16,5],center=true);
        //translate([17,-1.5,-15]) cube([0.5,16,5],center=true);
        //translate([-17,-1.5,-15]) cube([0.5,16,5],center=true);
        
       // translate([3,-1.5,15]) cube([0.5,16,5],center=true);
       // translate([-3,-1.5,15]) cube([0.5,16,5],center=true);
         
    }
}



module motor_Lock(){
    
    difference(){
        translate([1,1,0]) cube([8,18,19.5],center=true);
        translate([0,-17,0]) difference(){
            rotate([90,0,90]) {
                cylinder(d=25,h=20,center=true);
               
            }
            
            translate([1.6,0,0])  rotate([0,90,0]) rotate_extrude(angle=360) translate([12.5,0]) _guanDao();
        }
        
            translate([1.6,0,9.7])  rotate([0,90,0]) rotate([90,0,0])   linear_extrude(height=30,center=true) _guanDao();
        translate([1.6,0,-9.7])  rotate([0,90,0]) rotate([90,0,0])   linear_extrude(height=30,center=true) _guanDao();
        
      //  translate([1,5,0]) cube([8,12,10],center=true);
    }
    
}




