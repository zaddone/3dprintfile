$fn=100;
//boxlib();
!boxFix();
module boxlib(){
    translate([0,0,-2]) rotate_extrude() translate([2.5,0]) square([32,2]); 
    translate([0,0,0]) rotate_extrude() translate([30,0]) polygon([[0,0],[1.5,0],[1.5,6],[1.8,7],[1.8,8],[1.5,9],[0,9]]);
}

module boxFix(){
    // cube([90,240,20],center=true);

    difference(){
    
        translate([0,122.5,15]) {
            translate([0,-20,-10]){ 
                cube([100,44.4,40],center=true);
                //cylinder(d=10,h=1,center=true);
            
            }
            translate([18,0,0])  hull(){
                translate([2.5,0,0]) cylinder(d=4.4,h=15,center=false);
                translate([-2.5,0,0]) cylinder(d=4.4,h=15,center=false);
            }
            translate([-18,0,0])  hull(){
                translate([2.5,0,0]) cylinder(d=4.4,h=15,center=false);
                translate([-2.5,0,0]) cylinder(d=4.4,h=15,center=false);
            }
            
        }
        translate([0,90,-5]) rotate([0,90,0]) cylinder(d=10,h=150,center=true);
        minkowski(){
            cube([90-10,240-10,50],center=true);
            cylinder(d=10,h=1,center=true);
        }
    }

}
 