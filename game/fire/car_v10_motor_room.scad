use <car_v10_lib.scad>
$fn=80;
motorRoom();
module motorRoom(_h=18,_d=25){
    ___h = _h+1.6;
    
    _gh = 7;
    
   // rotate([0,90,0])  
    
      
    difference(){
        union(){
            rotate([0,90,0]) union(){
                intersection(){
                    cylinder(d=_d,h=_h);
                    translate([0,0,_h/2]) cube([19.5,_d,_h],center=true);
                    
                }
                translate([0,0,-2.6])  _ring_lib();
                // translate([0,0,_h-_gh]) cylinder(d1 = _d,d2=_d+2,h=_gh);
               
            } 
        }
        translate([15.3,0,0])  cylinder(d=3.5,h=40,center=true);
        
        translate([15.8,0,0])   rotate([0,90,0]) rotate_extrude(angle=360) translate([12.5,0]) _guanDao();        
        translate([15.8,0,9.8])  rotate([0,90,0]) rotate([90,0,0])   linear_extrude(height=30,center=true) _guanDao();
        translate([15.8,0,-9.8])  rotate([0,90,0]) rotate([90,0,0])   linear_extrude(height=30,center=true) _guanDao();
        
        translate([_h/2,0,0]) union(){
            intersection(){
                rotate([0,90,0]) cylinder(d=21.5,h=___h,center=true);
                cube([___h,25,16],center=true);
            }
          //  cube([___h,6,20],center=true);
        } 
       
     // translate([_h-_gh/2,0,0]) # cube([_gh,16,28],center=true); 
    }
}


module _ring_lib(){ 
    union(){
        //#motor();
        difference(){
            intersection(){
                cylinder(r2=16.5,r1=15.5 ,h=2.6);
                cylinder(r=16.2,h=2.6);
            }
            translate([0,0,-4])cylinder(h=27,d=9.5);
        }

        intersection(){
            translate([0,0,0]) union(){
                cylinder(r1=18,r2=18.4 ,h=2.6);
                //translate([0,0,-0.5]) cylinder(r=16,h=5);
            } 
            _ring_Ka(r=17,x=5,y=5.3,m=9,z=2.6); 
        }
        
        intersection(){
            translate([0,0,1.8]) union(){
                cylinder(r=18.5 ,h=2.6);
                //translate([0,0,-0.5]) cylinder(r=16,h=5);
            } 
            _ring_Ka(r=17,x=5,y=5.3,m=9,z=2.6); 
        }
    }   
    
    
    module _ring_Ka(x=5,y=1.8,z=4,r=19,m=6){    
    tou = 360/m;             
    for(n=[0:1:m-1]){
        translate(kugel_zu_kart([r,90,360/m*n]))  translate([0,0,0])  rotate([0,0,tou*n])       translate([0,0,z/2]) cube([x,y,z],center=true);
    }
    
}
 
}