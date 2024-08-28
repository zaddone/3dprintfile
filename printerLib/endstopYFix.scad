$fn=100;
d_=3;
 
translate([8,0,0]) {
    cube([16,16,6],center=true);   
}
translate([20,12,0]) {
    translate([0,-1.5,0]) cube([26,5,6],center=true);
    intersection(){
        translate([0,0,1.5]) {
            rotate([90,0,0]) {
                translate([9,0.2,0]) cylinder(d=d_,h=8,center=true);
                translate([-9,0.2,0]) cylinder(d=d_,h=8,center=true);
            }
            translate([0,5,0]) rotate([90,0,0]) {
                translate([9.2,0,0]) cylinder(d2=d_+0.5,d1=d_,h=2,center=true);
                translate([-9.2,0,0]) cylinder(d2=d_+0.5,d1=d_,h=2,center=true);
            }
        }
        cube([26,16,6],center=true);
    }
}
difference(){
    translate([0,0,-10]) cube([4,16,26],center=true);
    translate([0,0,-8]){
        rotate([0,90,0]) cylinder(d=4,h=20,center=true);
        translate([0,0,-10]) rotate([0,90,0]) cylinder(d=4,h=20,center=true);
    }
}
 /*
 intersection(){
   translate([-1,0,0]) cube([2,5 ,6],center=true);
   translate([-2,0,0])rotate([0,90,0])  hull(){
         translate([1.5,0,0]) cylinder(h=2,d=5);
         translate([-1.5,0,0]) cylinder(h=2,d=5);
    }
}
translate([-(3.5),0,0]) minkowski(){
    cube([2,7,4],center=true);
    rotate([0,90,0]) cylinder(h=1,d=2,center=true);
}
*/
