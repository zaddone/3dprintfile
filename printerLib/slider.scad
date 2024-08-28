$fn=100;
d1 = 3.5;
d2 = 5.5;
l3 = (31.3)/2;
!show(false);
module show(d2=true){
   //cube([200,200,1]);
   translate([-65,20,0]) {
       if (d2){
           projection()
        {
        
        translate([-57,152,0]) mirror([0,0,0]) rotate([90,0,90])  KPfixX();
        translate([24,45,0]) rotate([0,0,90])  sliderRight();
        translate([19,125,0]) rotate([0,0,90])  sliderLeft();
        translate([-74,0,0]) rotate([90,0,0]) motorFix();
        translate([-74,81,0])  rotate([90,0,0]) motorFix();
        translate([-115,45,0]) rotate([90,0,0]) headFix();
        }
    }
    else union(){
        
        translate([-57,152,-16]) mirror([0,0,0]) rotate([90,0,90])  KPfixX();
        translate([24,45,0]) rotate([0,0,90])  sliderRight();
        translate([19,125,0]) rotate([0,0,90])  sliderLeft();
        translate([-74,0,0]) rotate([90,0,0]) motorFix();
        translate([-74,81,0])  rotate([90,0,0]) motorFix();
        translate([-115,45,0]) rotate([90,0,0]) headFix();
        }
}
   
}
//square([10,10],center=true);
translate([-1.5,0,0]){
    #translate([2,-25,-2])block();
    translate([30,0,0]){
        rotate([90,0,0]) cube([20,20,500],center=true);
       translate([0,-200,0])  cube([20,20,500],center=true);
    }
   // rotate([90,0,0]) cylinder(r=15,h=500,center=true);
 
    
  //  translate([0,0,0]) rotate([90,0,0])# cube([30,42,500],center=true);
    //translate([0,200,0])motorFix();
    translate([15+2.5,-200,0]) KPfix();
  translate([15+2.5,-200,0])  mirror([1,0,0]) KPfix();
    
    
}
module KPfixX(){
    difference(){
         translate([-20,16.5,-13]) minkowski(){
             difference(){
             cube([53-10,3-1,80-10],center=true);
                 
               translate([-5,0,5])  cube([40,4,70],center=true);
             }
             rotate([90,0,0]) cylinder(d=10,h=1);
         }
         
            translate([0,0,21])rotate([90,0,0]){
                cylinder(d=d2,h=100,center=true);
               //rotate([180,0,0])  cylinder(d=10,h=2.5);
            }
            translate([0,0,-21])rotate([90,0,0]) {
                cylinder(d=d2,h=100,center=true);
                //rotate([180,0,0])  cylinder(d=10,h=2.5);
            }
        
        translate([-20,0,-(15+3+30)]) union(){
            translate([-20,0]) rotate([90,0,0]) cylinder(d=d2,h=100,center=true);
            translate([5,0]) rotate([90,0,0]) cylinder(d=d2,h=100,center=true);
        }
       
    }
    
    
}
module KPfix(){
    difference(){
        translate([0,-13,-28]) minkowski(){
            cube([2,28,100],center=true);
            rotate([0,90,0]) cylinder(d=10,h=1,center=true);
        }
        translate([0,0,21]) rotate([0,90,0]) {
            cylinder(d=d2,h=100,center=true);
           //rotate([0,0,0])  cylinder(d=10,h=2.5);
        }
        translate([0,0,-21]) rotate([0,90,0]) {
            cylinder(d=d2,h=100,center=true);
            translate([0,0,-1]) rotate([0,0,0])  cylinder(d=10,h=2.5);
        }
        //translate([0,-20,0]) rotate([0,90,0]) cylinder(d=d2,h=100,center=true);
        //translate([0, 5,0]) rotate([0,90,0]) cylinder(d=d2,h=100,center=true);
        translate([0,-25,0])hull(){
            translate([0, 0,-21]) rotate([0,90,0]) cylinder(d=d2,h=100,center=true);
            translate([0, 0,-77]) rotate([0,90,0]) cylinder(d=d2,h=100,center=true);
        }
    }
}

translate([40,0,0]){
    rotate([90,0,0]) {
        cylinder(d=10,h=500,center=true);
        //cube([43,20,400],center=true);
    }
     difference() {
        translate([-20,-34,0]) cube([40,68,13],center=false);        
         
        translate([14,23,0]) cylinder(d=d2,h=40,center=true);
         
        translate([14,-23,0]) cylinder(d=d2,h=40,center=true);
        translate([-14,-23,0]) cylinder(d=d2,h=40,center=true);
        translate([-14,23,0]) cylinder(d=d2,h=40,center=true);
    }
     translate([350,24-8+3.5,3+15+30+3]) KPfixX();
    translate([0,0,14.5]) union(){
        sliderRight();
        translate([350,0,0]) {
            mirror([1,0,0]) sliderLeft();
            
        }
    }
    
    translate([0,24-8,3+15+3+30]) rotate([0,90,0]) motorK();
    translate([100,24,3]){
        #cube([500,20,20],center=true);
        translate([0,-8,15+3+30]) rotate([90,0,0]) rotate([0,0,90]) block();
        translate([0,-8,15+3+30]) rotate([0,90,0]) # cylinder(r=15,h=500,center=true);
        translate([0,-25,0]) headFix();
        translate([0,-16.5,0]) difference(){
            cube([45.4,13,27],center=true);
            
            translate([10,0,10]) rotate([90,0,0]) cylinder(d=d1,h=200,center=true);
            translate([-10,0,10]) rotate([90,0,0]) cylinder(d=d1,h=200,center=true);
            translate([10,0,-10]) rotate([90,0,0]) cylinder(d=d1,h=200,center=true);
            translate([-10,0,-10]) rotate([90,0,0]) cylinder(d=d1,h=200,center=true);
            
        }
    }
    
}
module block(){
        difference(){
            cube([34,30,30],center=true);
            rotate([90,0,0]) cylinder(d=10,h=40,center=true);
            translate([12,10,0]) cylinder(d=4.5,h=50,center=true);
            translate([-12,10,0]) cylinder(d=4.5,h=50,center=true);
            translate([12,-10,0]) cylinder(d=4.5,h=50,center=true);
            translate([-12,-10,0]) cylinder(d=4.5,h=50,center=true);
        }
    
}
module headFix(){
    rotate([90,0,0]) difference(){
        translate([0,5,0]) minkowski(){
            cube([40-d1,120-d1,2],center=true);    
            cylinder(d=d1,h=1,center=true);   
        }    
        translate([10, 10])   cylinder(d=d1,h=200,center=true);
        translate([-10, 10])  cylinder(d=d1,h=200,center=true);
        translate([10,-10])  cylinder(d=d1,h=200,center=true);
        translate([-10, -10]) cylinder(d=d1,h=200,center=true);
        translate([0,-35,0]) motorK();
        
        translate([0,22,0]) {
            cylinder(d=15,h=20,center=true);
            translate([14,0,0]) cylinder(d=d1,h=20,center=true);
            translate([-14,0,0]) cylinder(d=d1,h=20,center=true);
        }
        translate([0,48,0]){
            translate([10,12,0])  cylinder(d=5.5,h=50,center=true);
            translate([-10,12,0]) cylinder(d=5.5,h=50,center=true);
            translate([10,-12,0]) cylinder(d=5.5,h=50,center=true);
            translate([-10,-12,0]) cylinder(d=5.5,h=50,center=true);
        }
    }
    
}
module motorK(){    
    cylinder(d=23,h=10,center=true);
    translate([-l3, -l3]) cylinder(d=d1+0.5,h=20,center=true);
    translate([l3, -l3]) cylinder(d=d1+0.5,h=20,center=true);
    translate([-l3, l3]) cylinder(d=d1+0.5,h=20,center=true);
    translate([l3, l3]) cylinder(d=d1+0.5,h=20,center=true);    
}
module motorFix(){
    
    difference(){
        translate([20,0,-20]) minkowski(){
            cube([80-5,2,80-5],center=true);
            rotate([90,0,0]) cylinder(d=5,h=1,center=true);
        }
        translate([50,0,0]) rotate([90,0,0]) cylinder(d=d2,h=20,center=true);
        translate([30,0,0]) rotate([90,0,0]) cylinder(d=d2,h=20,center=true);
        translate([30,0,-25]) rotate([90,0,0]) cylinder(d=d2,h=20,center=true);
        translate([30,0,-45]) rotate([90,0,0]) cylinder(d=d2,h=20,center=true);
        
        translate([0,0,-2]) rotate([90,0,0])motorK();
    }
    
}
module sliderLeft(){
    difference(){
        translate([-5,-2,0]) minkowski(){
            difference(){
                translate([3,-2,0]) cube([120-5-6,72-5,2],center=true);
                translate([50,-10,0]) cube([55,65,2],center=true);
                translate([-37,15,0]) cube([50,50,2],center=true);
            }
              cylinder(d=5,h=1,center=true);
        }
        
        
        translate([14,22.8,0]) cylinder(d=d2,h=40,center=true);         
        translate([14,-22.8,0]) cylinder(d=d2,h=40,center=true);
        translate([-14,-22.8,0]) cylinder(d=d2,h=40,center=true);
        translate([-14,22.8,0]) cylinder(d=d2,h=40,center=true);
        
        translate([-39.5,-25,0]){
            translate([12,10,0]) cylinder(d=d2,h=50,center=true);
            translate([-12,10,0]) cylinder(d=d2,h=50,center=true);
            translate([12,-10,0]) cylinder(d=d2,h=50,center=true);
            translate([-12,-10,0]) cylinder(d=d2,h=50,center=true);          
            
        }
 
        
        
        
        translate([5,24,0]) {
            
            translate([45,0,0])cylinder(d=d2,h=40,center=true);
            translate([30,0,0]) cylinder(d=d2,h=40,center=true);
        }
    }   
    
}
module sliderRight(){
  
    difference(){
        translate([-5,-2,0]) minkowski(){
            difference(){
                cube([120-5,78-5,2],center=true);
                translate([50,-10,0]) cube([55,65,2],center=true);
               // #translate([-55,20,0]) cube([50,50,2],center=true);
            }
              cylinder(d=5,h=1,center=true);
        }
        
        
        translate([14,22.8,0]) cylinder(d=d2,h=40,center=true);         
        translate([14,-22.8,0]) cylinder(d=d2,h=40,center=true);
        translate([-14,-22.8,0]) cylinder(d=d2,h=40,center=true);
        translate([-14,22.8,0]) cylinder(d=d2,h=40,center=true);
        
        translate([-39.5,-25,0]){
            translate([12,10,0]) cylinder(d=d2,h=50,center=true);
            translate([-12,10,0]) cylinder(d=d2,h=50,center=true);
            translate([12,-10,0]) cylinder(d=d2,h=50,center=true);
            translate([-12,-10,0]) cylinder(d=d2,h=50,center=true);          
            
        }
        translate([-32,16,0]){
            hull(){
            translate([0, -15]) cylinder(d=d2,h=20,center=true);
            translate([-27, -15]) cylinder(d=d2,h=20,center=true);
            }
            hull(){
            translate([0, 15]) cylinder(d=d2,h=20,center=true);            
            translate([-27, 15]) cylinder(d=d2,h=20,center=true);
            }
        }
        
        
        
        translate([5,24,0]) {
            
            translate([45,0,0])cylinder(d=d2,h=40,center=true);
            translate([30,0,0]) cylinder(d=d2,h=40,center=true);
        }
    }   
    
}