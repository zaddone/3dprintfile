$fn=7;
color("blue") intersection(){
hull(){
    cylinder(d2=5,d1=25,h=10);
translate([0,0,-7]) sphere(d=30);
}
translate([0,0,-3]) cube([30,30,30],center=true);
}