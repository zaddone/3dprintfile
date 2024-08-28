use <car_v10_lib.scad>

$fn=80;
bx = 32;
ty = 75;
by = 29;
uv = 8; 
batteryBody();
module batteryBody(interX=12){
    difference(){
        union(){
            battery();
translate([0,36+8,6.6]) batteryFixFire(interX);
translate([0,-52+8,6.6]) rotate([0,0,180]) batteryFixFire(interX=12);
            translate([0,0,0.2])  battery_top();
            translate([-12,uv,-3.5]) battery_fix();
            mirror([1,0,0]) translate([-12,uv,-3.5]) battery_fix();
            
            //translate([0,48,7]) #cube([18,2,25],center=true);
            //translate([0,uv,26]) fire();
        }
        //cube([]);
    }
}
module _battery18650_(_h=67){
    //rotate([-20,0,0]) 
    //translate([0,20,16])
    rotate([90,0,0]) 
    union(){
        cylinder(d=19,h=_h,center=true);
        //cube([14,20,67],center=true);
        //cylinder(d=1.8,h=80,center=true);
        //translate([0,-2,33.5])   cube([11,15,2],center=true);
        //translate([0,-2,-33.5])   cube([11,15,2],center=true);
        
    }
}
module battery_fix(){
    rotate([90,0,0]) difference(){
        cylinder(d=5,h=by+4,center=true);
        translate([-2.5,0,0]) cube([1,5,by+5],center=true);
    }
    difference() {
        union(){
            translate([0,0,13]) cube([4,by-0.4-6,29],center=true);
            translate([0,12,17]) difference(){
                cyInterface(_h=35);
                translate([-2.5,0,0]) cube([1,5,45],center=true);
            }
            translate([0,-12,17]) difference(){
                cyInterface(_h=35);
                translate([-2.5,0,0]) cube([1,5,45],center=true);
            }
        }
        translate([0,8.2,21.2]) rotate([0,90,0]) cylinder(d=5.4,h=40,center=true);
        translate([0,-8.2,21.2]) rotate([0,90,0]) cylinder(d=5.4,h=40,center=true);
    }
}

module battery_top(){
    bat_h = 67;
    //ex = 12;
    ex = 0;
   
    translate([13,-38,17]) difference(){
        rotate([90,90,0])  cyInterface(_h=21);
        translate([0,0,2.5]) cube([5,30,1],center=true);
    }
    translate([-13,-38,17]) difference(){
        rotate([90,90,0])  cyInterface(_h=21);
        translate([0,0,2.5]) cube([5,30,1],center=true);
    }
    
    translate([13,38+ex,17]) difference(){
        rotate([-90,90,0])  cyInterface(_h=21);
        translate([0,0,2.5]) cube([5,30,1],center=true);
    }
    translate([-13,38+ex,17]) difference(){
        rotate([-90,90,0])  cyInterface(_h=21);
        translate([0,0,2.5]) cube([5,30,1],center=true);
    }
 
    translate([0,0,11]) intersection(){
        translate([0,0,-7.2])  cylinder(h=14,d2=85,d1=70);
        difference(){
            cube([4,80,14],center=true);
            translate([0,0,-4.2])  cylinder(h=14,d2=80,d1=bat_h);
            _battery18650_(_h=bat_h);
        }
    }
    difference(){ 
        translate([0,ex/2,11])  union(){
            minkowski(){       
                cube([bx-6,ty+2+ex,11],center=true);
                cylinder(d=6,h=5,center=true);
            }  
            
        }
        /*
        #translate([0,45,10]){
            translate([0,2,0]) {
                cube([18,2,20],center=true);
                //translate([6.5,0,0]) cube([5,2,30],center=true);
                //translate([-6.5,0,0])cube([5,2,30],center=true);
            }
            translate([0,0.5,0]) cube([17,8,20],center=true);
            translate([0,-2,0])  cube([25,4,30],center=true);
        }
        */
        
        translate([0,ex/2,3.7])  minkowski(){
            cube([bx-4-4,ty+ex,1],center=true);
            cylinder( d=2.5,h=0.4,center=true);
        }
        translate([0,ex/2,5.6]) minkowski() {
            cube([bx-8,ty+ex,1.6],center=true);
            cylinder(d2=5.5,d1=2.5,h=1.2,center=true);   
        }
        translate([0,0,6.5]) cube([10,ty,20],center=true);
        translate([0,uv,0]) union(){
            
            translate([0,0,4]) difference(){ 
                union(){
                    cube([bx+10,by,22],center=true);
                    translate([14,0,0]) cube([10,by,40],center=true);
                    translate([-14,0,0]) cube([10,by,40],center=true);
                    cube([bx+10,by-15,40],center=true);
                }
                rotate([0,90,0]){
                    translate([-13.5,8,0]) cylinder(d=4.8,h=bx,center=true);
                    translate([-13.5,-8,0]) cylinder(d=4.8,h=bx,center=true);
                }
            }
        }
        
    
        translate([0,0,5])  _battery18650_(_h=68);
    }
}
module batteryFixFire(interX = 12){

    difference(){
        union(){
            minkowski(){
                cube([interX*2+11,2,28],center=true);
                rotate([90,0,0]) cylinder(d=6,h=1,center=true);
            }
            translate([0,2,0])  minkowski(){
                cube([10,2,33],center=true);
                cylinder(d=3,h=1,center=true);
            }
           
            union(){
                translate([interX,0,19]) rotate([0,0,90]) cyInterface(_h=11);
                translate([-interX,0,19]) rotate([0,0,90]) cyInterface(_h=11);
            }
        }
        translate([0,-2.5,15]) cube([interX*2+11,2,26],center=true);
        
        translate([13,0,10.5]) rotate([90,0,0]) cylinder(d=5.6,h=10,center=true);
        
        translate([-13,0,10.5]) rotate([90,0,0]) cylinder(d=5.6,h=10,center=true);
        
        translate([13,0,-11.5]) rotate([90,0,0]) cylinder(d=5.6,h=10,center=true);
        translate([-13,0,-11.5]) rotate([90,0,0]) cylinder(d=5.6,h=10,center=true);
        
        cube([6,4,40],center=true);
        
        
    }
    
}
module battery(){
    bh=-5.5;
    cd = 11;
    
    ex = 0;
    
    translate([13,-38,-5]) difference(){
        rotate([90,90,0])  cyInterface(_h=21);
        translate([0,0,-2.5]) cube([5,30,1],center=true);
    }
    translate([-13,-38,-5]) difference(){
        rotate([90,90,0])  cyInterface(_h=21);
        translate([0,0,-2.5]) cube([5,30,1],center=true);
    }
    
    translate([13,38+ex,-5]) difference(){
        rotate([-90,90,0])  cyInterface(_h=21);
        translate([0,0,-2.5]) cube([5,30,1],center=true);
    }
    translate([-13,38+ex,-5]) difference(){
        rotate([-90,90,0])  cyInterface(_h=21);
        translate([0,0,-2.5]) cube([5,30,1],center=true);
    }
 
    difference(){
        translate([0,0,0])  union(){
            translate([0,ex/2,0 ]) union(){ 
                translate([0,0,-2]) minkowski(){
                    //cube([bx-6-3,80-3,9-3],center=true);
                    cube([bx-6,ty+2+ex,5],center=true);
                    cylinder(d=6,h=5,center=true);
                }
                translate([0,0,3.7]) minkowski(){
                    cube([bx-4-4,ty+ex,1],center=true);
                    cylinder( d=2,h=0.4,center=true);
                }
                translate([0,0,5.7]) minkowski() {
                    cube([bx-8,ty+ex,1.4],center=true);
                    cylinder(d2=5,d1=2,h=1.2,center=true);   
                }                
            }
            translate([0,uv,0]){
                translate([0,(by/2+cd/2),bh]) difference(){
                    hull(){
                        translate([20,0,0]) cylinder(d=cd,h=3,center=true);
                        translate([-20,0,0]) cylinder(d=cd,h=3,center=true);                                       
                    }
                    translate([20,0,0]) cylinder(d=5.4,h=4,center=true);
                    translate([-20,0,0]) cylinder(d=5.4,h=4,center=true);
                }
                translate([0,-(by/2+cd/2),bh]) difference(){
                    hull(){
                        translate([20,0,0]) cylinder(d=cd,h=3,center=true);
                        translate([-20,0,0]) cylinder(d=cd,h=3,center=true);                                       
                    }
                    translate([20,0,0]) cylinder(d=5.4,h=4,center=true);
                    translate([-20,0,0]) cylinder(d=5.4,h=4,center=true);
                }
            }
        }
        /*
        translate([0,45,0]){
            translate([0,2,0]) {
                cube([18,2,20],center=true);
                //translate([0,-1,0]) cube([11,3,20],center=true);
            }
            translate([0,0.5,0]) cube([17,8,20],center=true);
            translate([0,-2,0])  cube([25,4,30],center=true);
        }
        */
        
        translate([0,uv,2]) union(){
            cube([bx,by,10],center=true);
            translate([bx/2,0,0]) {
                cube([13,by,20],center=true);
                translate([-4,0,-5.5]) rotate([90,0,0]) union(){
                    cylinder(d=5.4,h=by+5,center=true);
                    rotate([0,0,40]) translate([0,4,0]) cube([5,7,by+5],center=true);
                }
            }
            translate([-bx/2,0,0]) {
                cube([13,by,20],center=true);
                 translate([4,0,-5.5]) rotate([90,0,0])union(){
                     cylinder(d=5.4,h=by+5,center=true);
                     rotate([0,0,-40]) translate([0,4,0]) cube([5,7,by+5],center=true);
                 }
            }
        }
        
        
        translate([0,0,2])  union(){
            translate([0,35,5]) cube([11,1,20],center=true);
          
            translate([0,35,5]){
                cube([5,37,8],center=true);    
                translate([0,-2,0]) cube([11,5,8],center=true);  
            } 
            
            translate([0,-35,5]) cube([11,1,20],center=true);
            
          
            translate([0,-35,5]) {
                cube([5,17,8],center=true);  
                translate([0,2,0]) cube([11,5,8],center=true); 
            }
        }
        translate([0,0,5])  _battery18650_(_h=68);
    }
}

  
