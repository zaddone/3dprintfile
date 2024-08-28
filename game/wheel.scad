use <GetTest.scad>
use <gears.scad>
$fn=100;
Agear = [10,26,0.5];
Bgear = [11,25,0.5];
layer=4;
width=2;
slit = 0.2;
holeLong=5;
modA = Agear[2];
ringA=Agear[0]+Agear[1]*2;
ringAr = ringA*modA/2+modA+slit;
centerRing = (Agear[0]+Agear[1])/2 * Agear[2];


modB = Bgear[2];
ringB=Bgear[0]+Bgear[1]*2;
ringBr = ringB*modB/2+modB+slit; 


rAr = ringAr+width+slit;
rArL = (ringA*modA-modA*2-slit)/2;


!union(){
    z_ = 10;
    translate([0,0,4.4]) {
        translate([0,0,z_]) {
            showRingA();
            translate([0,0,z_]) showWheelRoom();
        }
   
    }
    showRingB();
   translate([0,0,-z_]) {
       RingBFix();
   // translate([0,0,-z_]) RingBFixPlan();
    translate([0,0,-z_*2]) RingTyre();
   }
}
module RingBFix(){
    
    o=0.6;   
        
    rAr_ = rAr+width+slit/2;
    ringBLib(rAr,width,layer,slit,0) {
        rotate_extrude(angle=360)polygon([[0,-o],[rAr_+0.5,-o],[rAr_+0.5,1-o],[rAr_,1-o], [rAr_ ,12], [rAr_,1],[centerRing+1.5,1],[centerRing+1.5,0],[centerRing-1.5,0],[centerRing-1.5,1],[(Bgear[0]*Bgear[2]+Bgear[2]*4)/2,1],[(Bgear[0]*Bgear[2]+Bgear[2]*4)/2,0],[0,0]]);
    }
    
}
module RingBFixPlan(){
    
    o=0.6;   
    ar = 360/3;
    d=5;
    rAr_ = rAr+width+slit/2;
    ringBLib(rAr,width,layer,slit,0) {
        difference(){
            rotate_extrude(angle=360) translate([centerRing-1,0]) square([rAr_-(centerRing-1),1]);                
            for(i=[0:1:2]) translate(pol_zu_kart([centerRing,ar*i])) union(){
                cylinder(d=d,h=5,center=true);
                translate([0.5,0,0]) cube([d,d/2,5],center=true);
            }
        }
    }
    
}
module RingTyre() {
    d= (rAr+width+2)*2;
    h_ = (layer*2-2)/3;
    intersection(){
        rotate_extrude() translate([(rAr+width),0]) polygon([[0,0],[1.5,0],[3,1],[3,1+h_],[1.5,1+h_+0.5],[3,1+h_+1],[3,1+h_*2+1],[1.5,1+h_*2+1+0.5],[3,1+h_*2+1+1],[3,layer*2+1],[1.5,layer*2+2],[0,layer*2+2]]);
        pfeilrad_(0.3,ceil(d/0.3),layer*2+2,(rAr+width)*2,0,40);
    }
    
 
}
module ringBLib( rAr,width,layer,slit,t=0){
    k = 0.6;
    l = layer+k;
    rA = rAr+width;
    ran = ( (rA*2*PI)/5); 
    rag =floor( 360/ran);
    m=7;
    rag5 = 360/m;
    //rag6 = 360/6;
    translate([0,0,-1.8]){
        //rotate_extrude() translate([9.75,0]) square([rA -9.75,1],center=false); 
        
        translate([0,0,1]) difference(){
            rotate_extrude(angle=360) translate([rAr+slit,0]) polygon([[0,0], [width-slit,0 ]  ,[width-slit,layer] ,[t,layer ]]);//square([width,layer]);
            for(i=[0:1:m-1]) rotate([0,0,rag5*i]){
                //rotate_extrude(angle=rag) translate([rAr+width,layer*2-1.8]) square([width,3.4],center=false);  
                rotate([0,0,rag-0.5]) rotate_extrude(angle=rag5-rag+1) translate([rAr+slit,0])  polygon([[0,0],  [width,l ] ,[-slit,l ],[-slit,0 ]]);
            }
            rotate([0,0,rag5]) rotate_extrude(angle=360-rag5) translate([rAr ,layer-1.2])  circle(d=1);
        }
          //rotate_extrude() translate([rAr,0]) square([width,1]);  
        children();
         
    }
    
}
 
module showRingB(){
    ringB(rAr,ringBr,layer,width,modB,ringB ,slit);
    
}
module showWheelRoom(){
    translate([0,0,(layer+0.0)]){
        wheelRoom(ringAr,width,4,modA,holeLong,slit);
      
    }
}
module showRingA(){
    
    ringA(modA,ringA,ringAr,layer,width,holeLong,slit);
    
}

module wheelRoom(ringAr,width,layer,modA,holeLong,slit){
    kh = 5;
    mh = 19+kh ;
    
    h = layer;
    w3 = width/2;
    m = 3;
    ang = 360/m;
    /*
    rr=ringAr ;
    
    minRng = (holeLong*0.9)/rr * (180/PI);
    for(i=[0:1:m-1]) rotate([0,0,ang*i-minRng/2]) rotate_extrude(angle=minRng) translate([rr-width/2 ,0])   polygon([[0,0],[slit,0], [w3,h-1],[w3,h],[0,h]]);
        )*/
    difference(){
        union(){
            ringALibBase(ringAr,width,h,modA,slit,0);
            translate([0,0,0]) intersection(){
                rotate([0,0,0]) cylinder(d=24.8,h=mh,center=false);
                translate([-9.8,-12.5,0]) cube([19.6,25,mh],center=false);
            }
          
        }
        /*
         #translate([0,0,20]){
            translate([9.8,0,0]) cube([1,25,1.4],center=true);
            translate([-9.8,0,0]) cube([1,25,1.4],center=true);
            translate([0,0,0]) rotate([90,0,0]) cylinder(d=5,h=30,center=true);
        }
        */
        translate([0,0,0]) scale([0.8,0.8,1]) motorTemp(_h=kh);
        translate([0,0,kh])  motorTemp(_h=25); 
        
    }
}

module motorTemp(_h=25){
     union(){
        intersection(){
            rotate([0,0,0]) cylinder(d=20.4,h=_h,center=false);
            translate([-8,-12.5,0]) cube([15.5,25,_h],center=false);
        }
      //  cube([___h,6,20],center=true);
    }    
}
module ringALibBase(ringAr,width,h,modA,k,center=0,fix=true){
 
    w1 =ringAr;// ringAr-width+modA - k ;
    
    //w2 = ringAr-width+modA -1.5 -k  ;
    
    w3 = width/2;
    h=layer-1.2;
    rotate_extrude(angle=360) translate([center,0])  polygon([[0,0],[ringAr-width/2-center,0],[ringAr-width/2-center ,h],[0,h]]);
   // square([ringAr-width-centerRing,layer-2.4]);
    if (fix){
    
           minRng = (holeLong*0.9)/ringAr * (180/PI);
    for(i=[0:1:m-1]) rotate([0,0,ang*i-minRng/2]) rotate_extrude(angle=minRng) translate([ringAr-width/2 ,0])   polygon([[0,0],[slit,0], [w3,h-1],[w3,h],[0,h]]); 
        
    }
    m = 3;
    ang = 360/m;
    for(i=[0:1:m-1])  {
        rotate([0,0,ang*i+ang/4]) rotate_extrude(angle=ang/2) translate([w1,0])   polygon([[0,0],[-width,0],[-width,h],[0,h]]);
        //rotate([0,0,ang*i-minRng/2]) rotate_extrude(angle=minRng) translate([w1 ,0])   polygon([[0,0],[k,0], [w3,h-1],[w3,h],[0,h]]);
        
    }
    //children();
    
}

module ringA(modA,ringA,ringAr,layer,width,holeLong,slit){

    
    //rotate_extrude() translate([ringAr,0]) square([width,layer],center=false);
    union(){
        minWidth = 0.5;
        getPrintRing( modA,ringA,layer,width-minWidth,slit);
        rotate_extrude(angle=360) translate([ringAr,0]) polygon([ [width-minWidth ,0],[width,layer-1],[width,layer],[width-minWidth,layer]]);
        rr = (ringA*modA-modA*2)/2 +slit;
        minRng = holeLong/rr * (180/PI);
        
        lh=4;
         
        m = 3;
        ang = 360/m;
        //p1= [[0,0],[width+0.5,0],[width,layer-1],[-1.5,layer-1]];
        p2 = [[0,0],[width+0.5,0],[width,lh+0.6],[0,lh+0.6]];
        p3 = [[-1,0],[ 0.5,0],[ 1.5,layer-2.4],[ 1.5,layer-1],[-1,layer-1]];
        
        translate([0,0,layer])difference(){ 
            for(i=[0:1:m-1]) {
                rotate([0,0,ang*i ])  difference() {
                    
                   rotate([0,0, -ang/4+0.5])   rotate_extrude(angle=ang/2-1) translate([rr,0])   polygon(p2);
                    
                   rotate([0,0,-minRng/2]) rotate_extrude(angle=minRng) translate([rr,0])   polygon(p3);
               
                     
                }
                 
            }
            for(i=[1:1:m-1]) {
               rotate([0,0,ang*i -ang/4+0.5]) rotate_extrude(angle=ang/2-1) translate([rr,lh+0.6]) polygon([[0,-1],[0,0], [1,0]]);// circle(d=1.2);
            }
            
        }
         
    }
 

}


module ringB(rAr,ringBr,layer,width,modB,ringB ,slit){
    
    union(){
        c3= 360/3;
        q =14;
        l=0.8;
        rA = rAr+width;
        ran = ( (rA*2*PI)/5);     
        rag =floor( 360/ran);
        //rag5 = 360/5;
        m=7;
        rag6 = 360/m;
        echo(ran,rag);
        cr = ringB*modB/2+modB+slit/2;     
        union(){               
            rotate_extrude() translate([ringBr,0])  square([(rAr)-ringBr ,layer],center=false);
            translate([0,0,layer]) union(){
                rotate_extrude(angle=360) translate([rAr,0]) polygon([[slit,0],[width,0],[width,layer+1],[width+0.2,layer+1],[width+0.5,layer+1.6],[width+0.5,layer+2],[slit,layer+2],[slit,layer-1],[0,0] ]) ; 
                 
                //for(i=[0:1:4]) rotate([0,0,rag5*i]) rotate_extrude(angle=rag) translate([rAr+width/2,1.4]) square([width,3.4],center=false);  
            }
            translate([0,0,layer]) rotate([180,0,0]) getPrintRing( modB,ringB,layer,width,slit );
            translate([0,0,-l]){
                rotate_extrude()  translate([ cr,0]) square([rAr - cr ,l],center=false); 
                getPrintRing( modB,ringB,l,width,slit ); 
            }
            difference(){                
                rotate_extrude(angle=360) translate([rAr,-l])  polygon([[0,0],[slit,0],  [width,layer+l],[0,layer+l]]); 
                rotate([0,0,0]) for(i=[0:1:m-1]) rotate([0,0,rag6*i]) rotate_extrude(angle=rag) translate([rAr-slit,-l]) square([width+slit,layer+1]);//  polygon([[0,0], [width,layer+l],[0,layer+l]]);  
            }                    
            rotate([0,0,rag6]) rotate_extrude(angle=360-rag6) translate([rAr,layer/2])  circle(d=0.8);            
        }               
        rotate_extrude(angle=360) translate([rAr+0.3,layer*2+1.3]) circle(d=1.7);        
    }
}
