 $fn=100;
d1 = 3.5;
l3 = (31.3)/2;
l1 = (20)/2;
l2 = (14)/2;
hd = 10;
d2l=16;
tx = 53.6;
ty = 15;
z = 3;

g=56;

difference(){
    translate([0,0,0])  minkowski(){
         cube([65-d1,70-d1,z-1],center=true);    
         cylinder(d=d1,h=1,center=true);     

    }
    
    translate([0,15,0]){
        cylinder(d=23,h=10,center=true);
                translate([-l3, -l3]) cylinder(d=d1,h=20,center=true);
        translate([l3, -l3]) cylinder(d=d1,h=20,center=true);
        translate([-l3, l3]) cylinder(d=d1,h=20,center=true);
        translate([l3, l3]) cylinder(d=d1,h=20,center=true);
   
    
    translate([0,-6,0]){
        translate([0,-29,0]){
            translate([-l1, -l1]) cylinder(d=d1,h=20,center=true);
            translate([l1, -l1]) cylinder(d=d1,h=20,center=true);
            translate([-l1, l1]) cylinder(d=d1,h=20,center=true);
            translate([l1, l1]) cylinder(d=d1,h=20,center=true);
        }
        /*
        translate([0,5,0]){
        translate([-l2,0,0]) cylinder(d=d1,h=20,center=true); 
        translate([l2,0,0])  cylinder(d=d1,h=20,center=true); 
        }
        */
        

    }
    }
    
        translate([0,0,0]){
            translate([28,0,0]) hull(){
                translate([0,g/2,0]) cylinder(d=d1,h=20,center=true);
                translate([0,-g/2,0])cylinder(d=d1,h=20,center=true);
                
            }
            translate([-28,0,0]) hull(){
                translate([0,g/2,0]) cylinder(d=d1,h=20,center=true);
                translate([0,-g/2,0])cylinder(d=d1,h=20,center=true);
                
            }    
        }
}


