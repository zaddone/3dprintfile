$fn=100;
 

module bottom_1(){
    difference(){
        union(){
            hull(){
                translate([55,0,0]) cylinder(d=35,h=5,center=true);
                translate([-55,0,0]) cylinder(d=35,h=5,center=true);
            }

        }
        translate([55,0,0]) cylinder(d=15,h=10,center=true);
        translate([-55,0,0]) cylinder(d=15,h=10,center=true);
        //translate([0,-7,0]) #cube([20,4,6],center=true);
    }  
}
module bottom_2(){
   translate([0,0,0]){
      {
           cylinder(d=16,h=58,center=true);
           cylinder(d=14.5,h=88,center=true);
       }
 
   }
}
module bottom_3(){
    rotate_extrude() translate([7.5,0]) {
        //square([2.5,10]);
        polygon([[0,0],[3,0],[2.5,4],[3,8],[0,8]]);
    }
}


rotate([0,0,0]) union(){
    #hull(){
        cylinder(d1=90,d2=90,h=230);
        translate([200,0,0]) cylinder(d1=90,d2=80,h=230);
    }
    translate([100,0,115]) {
        rotate([90,0,0]){ 
            translate([0,0,-68/2])  rotate_extrude() translate([58/2,0]) square([70,68],center=false);            
            //translate([55,-95,0]) cylinder(d=20,h=90,center=true);
            //translate([-55,-95,0]) cylinder(d=20,h=90,center=true);
            translate([0,-95,0]){
                translate([0,0,42]) !bottom_1();
                translate([0,0,-42])   bottom_1();
                translate([55,0,0]) {
                    bottom_2();
                    translate([0,0,30]) bottom_3();
                }
                translate([-55,0,0]) bottom_2();
                
            }
            
            
        }
        //translate([0,0,-95]) cube([120,20,20],center=true);
    }
}

 