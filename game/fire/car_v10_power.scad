$fn=80;
power();
module power(){
    //cube([18,3,25],center=true); 
    
    difference(){
        minkowski(){
            cube([35,1.5,30],center=true);
            rotate([90,0,0]) cylinder(d=5,h=1.5,center=true);
            //cylinder(d=5,h=1,center=true);
        }
        translate([0,1,0]) cube([18,2,40],center=true);
        
        translate([14.9,0,11]) rotate([90,0,0]) cylinder(d=5.2,h=10,center=true);
        translate([14.9,0,-11]) rotate([90,0,0]) cylinder(d=5.2,h=10,center=true);
        translate([-14.9,0,11]) rotate([90,0,0]) cylinder(d=5.2,h=10,center=true);
        translate([-14.9,0,-11]) rotate([90,0,0]) cylinder(d=5.2,h=10,center=true);
        
    }
    
}