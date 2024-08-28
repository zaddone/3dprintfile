use <Getriebe.scad>
use <GetTest.scad>


$fn=96;
module_val = 0.5;
eing=20; 
fans=0;
fansA=0;

//planetAssemble();
wheel();
//sunB();
 
module wheel(){
    difference(){
        union(){
            r = 360/6*3;
            rotate([0,0,r]) union(){
                //ringA();
                       
            }
            union(){
                    translate([0,0,-4.8])rotate([0,0,360/3*0]) union(){
                    #ringB();
                     //ringB_lib();
                }
                translate([0,0,4.3])rotate([180,0,0]) planetAll();
            }
              
           translate([0,0,-5]) sunB();
           !sunA();
 
        }
 
    }
    //motorFix();
 
}
module ring_Ka(x=5,y=1.8,z=4,r=19,m=6){    
    tou = 360/m;             
    for(n=[0:1:m-1]){
        translate(kugel_zu_kart([r,90,360/m*n]))  translate([0,0,0])  rotate([0,0,tou*n])       translate([0,0,z/2]) cube([x,y,z],center=true);
    }
    
}

module sunB(){
    d=3.5;
    bo=d;
    n=17;
    difference(){
        union(){
            translate([0,0,4]) rotate([180,0,0]) gearBase(bo=d,n=17,diff=0.0); 
            translate([0,0,0]) cylinder(d=11,h=0.4,center=true);  
        }
        translate([0,0,-1]) cylinder(d=d,h=10);
        cube([1.2,5,10],center=true);
    }
}
module sunA_(){
    d=0;
    difference(){
        gearBase(bo=d,n=16);
        cube([2.2,2.2,14],center=true);
        //cylinder(d1=2,h=5,center=true);
    }

    translate([0,0,4]) difference(){
        cylinder(d=6.6,h=1.2);
        cube([2.2,2.2,4],center=true);
        //cylinder(d1=2,h=5,center=true);
    }
   // cube([]);
   // translate([0,1.3,2.5])  cube([3,2,5],center=true);
    
}
module sunA(){
    d=0;
    difference(){
        gearBase(bo=d,n=16);
        //cube([2.2,2.2,14],center=true);
        cylinder(d1=2,h=50,center=true);
    }

    translate([0,0,4]) difference(){
        cylinder(d=6.6,h=1.2);
        //cube([2.2,2.2,4],center=true);
        cylinder(d1=2,h=5,center=true);
    }
   // cube([]);
   // translate([0,1.3,2.5])  cube([3,2,5],center=true);
    
}


module planetA(b=6){
    
    gearBase(n=23,bo=b,diff=0.1);
   
}
module planetB(b=6){
   
    gearBase(n=22,bo=b,diff=0.1);
   
}

module gearBase(n=23,bo=6.2,diff=0){
 
    translate([0,0,0.8])  difference(){ 
        pfeilrad_(modul= module_val, zahnzahl=n, breite=3.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff,spiel_val=0.1);
 
    }

    intersection(){
         stirnrad_(modul= module_val, zahnzahl=n, breite=0.8, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=fans,dd_diff=diff,spiel_val=0.1); 
        cylinder(d2= n*0.5+1,d1=n*0.5-1,h=0.8);
    }  
  
}


module planet(){
    //cube([6,6,])
    difference(){
        union(){
            translate([0,0,4.8]) planetB(0);
            translate([0,0,4])  cylinder(d=9.9,h=0.8);
           // planetA(0);
        }
 
        difference(){
            cylinder(d=6,h=20,center=true);
            translate([2.8,0,0])  cube([3,6,20],center=true);
        }
    }
}
 
module planetAll(dr=9.75){   
    m=3;
    union(){
        translate(kugel_zu_kart([dr,90,360/m*0]))  union(){
            planet();
        }
        translate(kugel_zu_kart([dr,90,-360/m*1]))  union(){
            planet();
        }
        translate(kugel_zu_kart([dr,90,-360/m*2])) rotate([0,0,0])   union(){
            planet();
        }
    }
 
}
module pfeiNew(modul = module_val, zahnzahl=62, breite=3.4, randbreite=6, eingriffswinkel=20, schraegungswinkel=30 ){

    pfeilhohlrad_(modul = modul, zahnzahl=zahnzahl, breite=breite, randbreite=randbreite, eingriffswinkel=eingriffswinkel, schraegungswinkel=schraegungswinkel,dd_diff=0,spiel_val=0.1);
     
}
module ringA(){
    union(){   
        q = 0.6; 
        difference(){
            cylinder(r1=19,r2=17.5 ,h=q+7); 
            translate([0,0,-0.6]) cylinder(r=16.2,h=q+7);
            translate([0,0,6]) cylinder(r=15.8,h=q+7);
            translate([0,0,-4.8])  rotate_extrude() translate([20.1,0]) translate([-0.9,7.5]) circle(r=2);   
   
            translate([0,0,3]) ring_Ka(r=18,x=5,y=5.5,m=9,z=q+3.4+2); 
       
        }
        
        intersection(){  
        
            difference(){
                cylinder(r=23.3,h=0.8);
                cylinder(r2=14.97,r1=15.8,h=0.8);
            }
          
             pfeiNew (modul =module_val, zahnzahl=62, breite=0.8, randbreite=1.2, eingriffswinkel=20, schraegungswinkel=fansA);
        }
       
        translate([0,0,0.8]) pfeiNew(modul = module_val, zahnzahl=62, breite=3.6, randbreite=1.2, eingriffswinkel=20, schraegungswinkel=fansA); 
        
      
       
 
         
    }
    
}

module ringB(isW = true){
    wy = isW?0:0.4;
    difference(){
        union(){
            q =14;
            l=0.6;
            rotate_extrude() translate([21.4,0]) square([1.5,11.2],center=false); 

            translate([0,0,-1.6])  difference(){
                union(){
                    rotate_extrude() translate([21.6-q,0]) square([1.3+q,1.6],center=false); 
                    rotate_extrude() translate([21.6-q,0]) square([1.6+q-wy,0.6],center=false); 
                }
                fixed(dr=9.75,m=3,dd=6,hh=16,center=false);
            }
            translate([0,0,10.6+l]) rotate_extrude() translate([19.7,0]) square([3.6-wy,0.6],center=false);
            
            translate([0,0,0]) union(){  
                rotate_extrude() translate([20.2,0]) difference(){
                    square([2,11.2],center=false);
                    translate([-0.9,7.5]) circle(r=2);
                }
                ringB_base(); 
            }

        }
        translate([0,0,8])  ring_Ka(r=18.7,x=3,y=3,m=1,z=5);
        translate([0,0,0])  ring_X();

    }
  
}

module ring_X(m=5,r=20,ang=30,x=2,y=8){    
    tou = 360/m;             
    for(n=[0:1:m-1]){
        translate(kugel_zu_kart([0,90,360/m*n]))   rotate([0,0,tou*n])  rotate_extrude(angle=ang) translate([r,0]) square([x,y],center=true);
        
    }
    
}
module ringB_lib(){
    translate([0,0,-2.6])  union(){
        cylinder(d=42,h=1);
        fixed(dr=9.75,m=3,dd=5.6,hh=2.4,center=false);
       cylinder(r=7.4,h=2);
       
    }
    rotate([0,0,1]) ring_X(m=5,r=20,ang=28,x=1.5,y=5);
    
}
module ringB_base(){
    pfeiNew (modul =module_val, zahnzahl=61, breite=4.4, randbreite=5, eingriffswinkel=eing, schraegungswinkel=fans);    

}
module fixed(dr=18.9,m=5,dd=1.9,hh=16,center=false){
    for(n=[0:1:m-1]){
    //translate([18.4,0,0])
        translate(kugel_zu_kart([dr,90,360/m*n]))
        cylinder(d=dd,h=hh ,center=center);
    }
}

module PAssemble_1(){
    union(){
        difference(){
            translate([0,0,-1]) rotate_extrude() translate([7.5,0]) square([14,0.8],center=false);   
            fixed(dr=9.75,m=3,dd=6,hh=10,center=true); 
        }
        
        difference(){
            translate([0,0,1.2]) rotate_extrude() translate([18.9,0]) square([1.8,4],center=true);
            ring_Ka(r=18.7,x=4,y=8.5,m=6);
            translate([0,0,-1]) ring_Ka(r=18.7,x=6,y=5,m=6);        
        }   
    }
    
}
    
module PAssemble_2(){
    
    rotate_extrude() translate([7,0]) square([5.8,0.8],center=false);   
    translate([0,0,0]){
        m=3;
        h=5;

        for(n=[0:1:m-1]){

            translate(kugel_zu_kart([9.75,90,360/m*n]))  union(){
                cylinder(d=6.5,h=1.4,center=false);
                difference(){
                    union(){
                        cylinder(d=5.6,h=h,center=false);
                        // translate([1.5,0,h])  cylinder(d1=2.2,d2=1.7,h=0.6,center=false);
                        translate([0,0,h]) cylinder(d1=5.6,d2=5,h=0.6,center=false);
                    }
                    translate([4,0,0]) cube([6,6,10+5*2],center=true);
                }
            }
        }
    }       

}
module planetAssemble(){
    //PAssemble_1();    
    PAssemble_2();  
}