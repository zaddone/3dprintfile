module _guanDao(){
    
    circle(0.6); 
    translate([0,-0.5]) square([1.2,1],center=true);
    translate([0,-1]) circle(0.6); 
    
}
 
module cyInterfaceBig(t_d=4.8,fk=1.1,_h = 36){
    __h = _h/2-2;
    difference(){ 
        union(){
            cylinder(d=t_d,h=_h,center=true);
            translate([0,0,__h]) {
                cylinder(d1=t_d*fk,d2 = t_d,h=3,center=false);
                translate([0,0,-2]) cylinder(d=t_d*fk,h=2,center=false);
                translate([0,0,-5]) cylinder(d2=t_d*fk,d1 = t_d,h=3,center=false);
            }
        }
        translate([0,0,__h]) cube([t_d+2,t_d/5,t_d+10],center=true);
    }    
}
module cyInterface(t_d=4.8,fk=0.8,_h = 36){
    __h = _h/2-1;
    difference(){ 
        union(){
            cylinder(d=t_d,h=_h,center=true);
            translate([0,0,__h]) {
                cylinder(d1=t_d+fk,d2 = t_d,h=2,center=false);
                translate([0,0,-1]) cylinder(d=t_d+fk,h=1,center=false);
                translate([0,0,-3]) cylinder(d2=t_d+fk,d1 = t_d,h=2,center=false);
            }
        }
        translate([0,0,__h]) cube([t_d+2,1,10],center=true);
    }    
}



module _links( dx = 14){
    out_d = 9.5;
    //l_h = 3.4;
    t_d = 4.8;    
    t_h_ = 26;
    //t_y_ = 12.3;
    
    translate([-8,0,1.5]) rotate([0,-90,0]) difference(){
        cyInterface(t_d = t_d,_h = t_h_);
        translate([-2.5,0,0]) cube([2,6,t_h_*2],center=true);
    }
    /*
    difference(){
        //hull(){
        translate([dx,0,0]) union(){
            cylinder(d=out_d,h=2,center=false);
            translate([-out_d/2,0,1]) cube([out_d,out_d,2],center=true);
        }
          //  translate([-dx,0,0]) cylinder(d=out_d,h=2,center=false);
        //}
        translate([dx,0,0]) cylinder(d=5.5,h=5,center=true);
        //translate([-dx,0,0]) cylinder(d=5.5,h=5,center=true);
    }
    */
}
function kugel_zu_kart(vect) = [
	vect[0]*sin(vect[1])*cos(vect[2]),  
	vect[0]*sin(vect[1])*sin(vect[2]),
	vect[0]*cos(vect[1])
];

