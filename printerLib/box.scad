$fn=100;

axisIntervalY = 100;
axisIntervalX = 78;
wheelMiddleWidth = 40;
rackWidth= 3;
rotate([0,0,90]) fixed(); 
cap();
crane();
translate([100,0,115]) {
    rotate([90,0,0]){ 
        //translate([0,0,-68/2])  rotate_extrude() translate([58/2,0]) square([70,68],center=false);            
        //translate([55,-95,0]) cylinder(d=20,h=90,center=true);
        //translate([-55,-95,0]) cylinder(d=20,h=90,center=true);
        translate([0,-95,0]){
            //translate([0,0,axisIntervalX/2-rackWidth/2]) rack();
            //translate([0,0,-(axisIntervalX/2-rackWidth/2)]) rack();
            translate([0,5,0]){
                translate([axisIntervalY/2,0,0]) {
                    axis(m=-24);
                    translate([0,0,0]) !wheel(m=-15);
                }
                translate([-axisIntervalY/2,0,0]) {
                    axis(m=14);
                    translate([0,0,0]) wheel(m=4);
                }
            }            
        }       
    }    
    translate([0,0,-110]) base();
    //translate([0,0,-95]) cube([120,20,20],center=true);
}
module crane(){
    difference(){
        translate([0,0,0]) linear_extrude(10)  polygon([[0,0],[18,0],[20,2],[20,58],[22,60],[58,55],[60,56.5],[60,58],[58,60],[18,65],[16,63],[16,5],[14,3],[0,3]]);
        translate([10,0,5]) rotate([90,0,0]) cylinder(d=3.5,h=20,center=true);
    }
}
module cap(){
    translate([0,0,-2]) difference(){
        rotate_extrude() translate([0,0]) square([34,2]); 
        translate([20,0,0]) cylinder(d=4.5,h=10,center=true);
    }
    translate([0,0,0]) rotate_extrude() translate([30,0]) polygon([[0,0],[1.5,0],[1.5,6],[1.8,7],[1.8,8],[1.5,9],[0,9]]);
}
module baseFix(){
    difference(){
        hull(){
            translate([0,0,0]) cube([15,wheelMiddleWidth,1],center=true);
            translate([0,0,20]) cube([25,wheelMiddleWidth,1],center=true);
            
        }
        translate([0,0,10]) cube([26,wheelMiddleWidth-10,22],center=true);
        translate([0,0,18]) rotate([90,0,0]) cylinder(d=15,h=wheelMiddleWidth,center=true);
    }
    
}
module base(){
    translate([0,0,1]) difference(){
        cube([axisIntervalY,wheelMiddleWidth,3],center=true);
        cube([axisIntervalY-20,wheelMiddleWidth-15,4],center=true);
    }
    translate([axisIntervalY/2,0,0]) baseFix();
    rotate([0,0,180]) translate([axisIntervalY/2,0,0]) baseFix();
    
}
module fixed(){
    // cube([90,240,20],center=true);

    difference(){
    
        translate([0,122.5,15]) {
            translate([0,-20,-10]){ 
                translate([0,5,7]) minkowski(){
                    cube([110,24.4,25],center=true);
                    cylinder(d=8,h=1,center=true);
                }
                translate([0,0,18]) hull(){
                    translate([0,30,0]) cylinder(d=30,h=4,center=true);
                    cylinder(d=100,h=4,center=true);
                }
            
            }
            /*
            translate([18,0,0])  hull(){
                translate([2.5,0,0]) cylinder(d=4.4,h=25,center=false);
                translate([-2.5,0,0]) cylinder(d=4.4,h=25,center=false);
            }
            translate([-18,0,0])  hull(){
                translate([2.5,0,0]) cylinder(d=4.4,h=25,center=false);
                translate([-2.5,0,0]) cylinder(d=4.4,h=25,center=false);
            }
            */
            
        }
        translate([0,132,0]){
            cylinder(d=5.5,h=100,center=true);
            translate([0,13,0]) cylinder(d=5.5,h=100,center=true);
        }
        translate([0,105,5]) rotate([0,90,0]) cylinder(d=10,h=150,center=true);
        minkowski(){
            cube([110-10,240-10,50],center=true);
            cylinder(d=10,h=1,center=true);
        }
    }

}


module rack(){
    difference(){
        minkowski(){
            cube([axisIntervalY,10,rackWidth-1],center=true);
            cylinder(d=20,h=1,center=true);
        }
        translate([0,5,0]){
            translate([axisIntervalY/2,0,0]) cylinder(d=15,h=10,center=true);
            translate([-axisIntervalY/2,0,0]) cylinder(d=15,h=10,center=true);
        }
        //translate([0,-7,0]) #cube([20,4,6],center=true);
    }  
}
module axis(m = 20){
    translate([0,0,0]) difference(){
        union(){
           cylinder(d=16,h=wheelMiddleWidth-1-10,center=true);
           translate([0,0,wheelMiddleWidth/2-5]) cylinder(d1=16,d2=14.5,h=1,center=true);
           translate([0,0,-(wheelMiddleWidth/2-5)]) cylinder(d2=16,d1=14.5,h=1,center=true);
           cylinder(d2=16,d1=14.5,h=1,center=true);
           cylinder(d=14.5,h=axisIntervalX-m,center=true);
        }
        translate([13,0,0]) cube([16,16,axisIntervalX-m],center=true);
    
    }
}
module wheel(m=0){
    w = ((axisIntervalX-wheelMiddleWidth-rackWidth*2)/2-m)/2;
    translate([0,0,wheelMiddleWidth/2+w]) rotate_extrude() translate([7.6,0]) {
        //square([2.5,10]);
        polygon([[0,-w],[3,-w],[2.5,0],[3,w],[0,w]]);
    }
}

