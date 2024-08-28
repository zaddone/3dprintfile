use <Getriebe.scad>
use <GetTest.scad>

use <reducer_v4.scad>

$fn=100;
T=false;
showWheelRoom();

module showWheelRoom(Agear = [10,26,0.5],Bgear = [11,25,0.5]){
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
    translate([0,0,(layer+0.2)]){
        wheelRoom(ringAr,width,4,modA,holeLong,slit);
      
    }
    
    
    
    ringA(modA,ringA,ringAr,layer,width,holeLong,slit);
    translate([0,0,-(layer+0.4)]) {
        ringB(rAr,ringBr,layer,width,modB,ringB,slit);  
        wheelOut(rAr,width,layer,slit,Bgear,centerRing,slit);
        translate([0,0,-0.4]) libAmFixB(centerRing,layer,Bgear,slit,rAr,width); 
    }
    union(){
        libAmFixA(centerRing,layer,Agear,Bgear,slit);
        libAmFixA_1(centerRing,layer,Agear,Bgear,slit);
        libAmTop1(centerRing,Agear,slit);
        //libAmTop2(centerRing,Agear,slit);
     //   translate([0,0,-(layer)])   libAmFixB(centerRing,layer,Bgear,slit,rAr,width); 
    }
}
 
module wheelRoom(ringAr,width,layer,modA,holeLong,slit){
    kh = 5;
    mh = 19+kh ;
    
    h = layer;
    w3 = width/2;
    m = 3;
    ang = 360/m;
    rr=ringAr ;
    
    minRng = (holeLong*0.9)/rr * (180/PI);
    for(i=[0:1:m-1]) rotate([0,0,ang*i-minRng/2]) rotate_extrude(angle=minRng) translate([rr-width/2 ,0])   polygon([[0,0],[slit,0], [w3,h-1],[w3,h],[0,h]]);
        
    difference(){
        union(){
            ringALibBase(ringAr,width,h,modA,slit,0);
            translate([0,0,0]) intersection(){
                rotate([0,0,0]) cylinder(d=24.8,h=mh,center=false);
                translate([-9.8,-12.5,0]) cube([19.6,25,mh],center=false);
            }
          
        }
         translate([0,0,20]){
            translate([9.8,0,0]) cube([1,25,1.4],center=true);
            translate([-9.8,0,0]) cube([1,25,1.4],center=true);
            translate([0,0,0]) rotate([90,0,0]) cylinder(d=5,h=30,center=true);
        }
        translate([0,0,0]) scale([0.8,0.8,1]) motorTemp(_h=kh);
        translate([0,0,kh]) # motorTemp(_h=25); 
        
    }
}
 
module motorTemp(_h=25){
     union(){
        intersection(){
            rotate([0,0,0]) cylinder(d=20.5,h=_h,center=false);
            translate([-8,-12.5,0]) cube([15.5,25,_h],center=false);
        }
      //  cube([___h,6,20],center=true);
    }    
}
module ringALibBase(ringAr,width,h,modA,k,center=0){
 
    w1 =ringAr;// ringAr-width+modA - k ;
    
    //w2 = ringAr-width+modA -1.5 -k  ;
    
    w3 = width/2;
    //h=layer-1.4;
    rotate_extrude(angle=360) translate([center,0])  polygon([[0,0],[ringAr-width/2-center,0],[ringAr-width/2-center ,h],[0,h]]);
   // square([ringAr-width-centerRing,layer-2.4]);
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
        
        //translate([0,0,layer])rotate_extrude() translate([ringA*modA/2-modA ,0]) polygon([[0,0],[width+1,0],[width, 1],[0, 1]]);
        //translate([0,0,layer+1]) rotate_extrude() translate([ringA*modA/2-modA ,0]) polygon([[0,0],[width,0],[width,layer-1],[0,layer-1]]);
        //rr=ringAr-width+modA
        rr = (ringA*modA-modA*2)/2 +slit;
        minRng = holeLong/rr * (180/PI);
        
        lh=4;
         
        m = 3;
        ang = 360/m;
        //p1= [[0,0],[width+0.5,0],[width,layer-1],[-1.5,layer-1]];
        p2 = [[0,0],[width+0.5,0],[width,lh+0.6],[0,lh+0.6]];
        p3 = [[-1,0],[ 0.5,0],[ 1.8,layer-2.4],[ 1.8,layer-1],[-1,layer-1]];
        //p3 = [[-1,0],[ width*2,0] ,[width*2,lh-1],[-1,lh-1]];
        //p4 = [[1,0],[width-1,0],[width-1, 1],[1, 1]];
        translate([0,0,layer])difference(){ 
            for(i=[0:1:m-1]) {
                rotate([0,0,ang*i ])  difference() {
                    
                   rotate([0,0, -ang/4+0.5])   rotate_extrude(angle=ang/2-1) translate([rr,0])   polygon(p2);
                    
                   rotate([0,0,-minRng/2]) rotate_extrude(angle=minRng) translate([rr,0])   polygon(p3);
               
                    //rotate([0,0, -ang/8]) rotate_extrude(angle=ang/4) translate([ringAr-width+modA,0])   polygon(p1);
                    //translate([ringAr-width+modA,layer-1.6]) circle(d=1.2);
                }
                //#rotate([0,0,ang*i+ang/4]) translate([ringAr-width+modA,0,layer-1.8]) cylinder(d=1.5,h=10);
            }
            for(i=[1:1:m-1]) {
               rotate([0,0,ang*i -ang/4+0.5]) rotate_extrude(angle=ang/2-1) translate([rr,lh+0.6]) polygon([[0,-1],[0,0], [1,0]]);// circle(d=1.2);
            }
            //#rotate([0,0,-minRng/2-1]) rotate_extrude(angle=minRng+2) translate([rr,0])   polygon(p4);
            //translate([rr+width/2,0,layer/2 ])  cube([width*2,holeLong+slit*2,0.4],center=true);// cylinder(d=1.8,h=2,center=true);
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
        rag5 = 360/5;
        rag6 = 360/6;
        echo(ran,rag);
        cr = ringB*modB/2+modB+slit/2;     
        union(){               
            rotate_extrude() translate([ringBr,0])  square([(rAr)-ringBr ,layer],center=false);
            translate([0,0,layer]) difference(){
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
            rotate([0,0,0]) for(i=[0:1:5]) rotate([0,0,rag6*i]) rotate_extrude(angle=rag) translate([rAr-slit,-l]) square([width+slit,layer+1]);//  polygon([[0,0], [width,layer+l],[0,layer+l]]);  
            }                    
            rotate_extrude(angle=360-rag6) translate([rAr,layer/2])  circle(d=0.8);            
        }               
        rotate_extrude(angle=360) translate([rAr+0.2,layer*2+1.2]) circle(d=1.5);        
    }
}

module libAmFixB(centerRing,layer,Bgear,k,rAr,width){
    
    ringBLib(rAr,width,layer,k,0) {
         rotate_extrude() translate([centerRing+5,0]) square([(rAr+width)-(centerRing+5),1]);
         difference(){
            union(){
             
            libAm(centerRing,layer,Bgear[0],Bgear[1],Bgear[2],k);
            for(i=[0:1:2]) rotate([0,0,120*i]){
                translate([centerRing,0])   rotate_extrude(angle=360) translate([2.25,0]) square([(Bgear[1]*Bgear[2]+Bgear[2]*4-4.5)/2,1]);
                
                }          
            }
              
               cylinder(d=Bgear[0]*Bgear[2]+Bgear[2]*4,h=layer);
          }
     }
  
}
module libAmTop1(centerRing,Agear,slit){
    c1 = (Agear[1]*Agear[2]+Agear[2]*2)/2 ;
 
    
    translate([0,0,4]) hohlrad_(modul = Agear[2], zahnzahl=Agear[1], breite=3.4, randbreite=3, eingriffswinkel=20, schraegungswinkel=0,dd_diff=0,spiel_val=0.3);
    rotate_extrude() translate([1.2,0]) square([c1+3-1.2,4]);
}
module libAmTop2(centerRing,Agear,slit){
    c1 = (Agear[1]*Agear[2]-Agear[2]*2)/2 -slit ;
    difference(){
        union(){
            translate([0,0,3]){
                for(i=[0:1:2]) rotate([0,0,360/3*i]) translate([centerRing,0])  cylinder(r=c1,h=5);
                translate([0,0,3]) cylinder(h=2,r=centerRing);
            }
        }
         for(i=[0:1:2]) rotate([0,0,360/3*i]) translate([centerRing,0]) cylinder(d=2.5,h=50,center=true);

    }
}
module libAmFixA_1(centerRing,layer,Agear,Bgear,k){
    //translate([0,0,layer]) cylinder(r=centerRing+3,h=1);
    h=4;
    c1 = (Agear[1]*Agear[2]-Agear[2]*2)/2;
    difference(){
        union(){
            libAm(centerRing,layer-1,Agear[0],Agear[1],Agear[2],k);
            translate([0,0,layer-1])  for(i=[0:1:2]) rotate([0,0,120*i]) translate([centerRing,0]) rotate([0,0,80]) rotate_extrude(angle=200) translate([c1,0]) square([(Agear[1]*Agear[2]+Agear[2]*8)/2-c1,h]);
        } 
    }
}
module libAmFixA(centerRing,layer,Agear,Bgear,k){
    //translate([0,0,layer]) cylinder(r=centerRing+3,h=1);
    h=4;
    c1 = (Agear[1]*Agear[2]-Agear[2]*2)/2;
    difference(){
        union(){
         rotate([0,0,60]){
          for(i=[0:1:2]) rotate([0,0,120*i]) translate([centerRing+1,0,0]){
                //cylinder(d=4,h=layer*2,center=true);
                //cube([4,3.5,layer*2],center=true);
                translate([0,0,-layer]) linear_extrude(layer*2-1+h) polygon([[-2,0],[2,4],[2,-4]]);
                //translate([0,0,layer+1]) cube([4,8,2],center=true);
            }
             }
        //translate([0,0,layer-1]) rotate([0,0,30]) cylinder(   r=centerRing+(Agear[1]*Agear[2])/2-Agear[2]*2,h=h+1,$fn=6);
        libAm(centerRing,layer-1,Agear[0],Agear[1],Agear[2],k);
        translate([0,0,layer-1])  for(i=[0:1:2]) rotate([0,0,120*i]) translate([centerRing,0]) rotate([0,0,80]) rotate_extrude(angle=200) translate([c1,0]) square([(Agear[1]*Agear[2]+Agear[2]*8)/2-c1,h]);
         }
         
        //translate([0,0,layer-1]) for(i=[0:1:2])  rotate([0,0,120*i]) translate([centerRing,0,0])cylinder(h=h,d=5);
        translate([0,0,-(layer)]) scale([1.05,1.05,1]) libAm(centerRing,layer,Bgear[0],Bgear[1],Bgear[2],k);
       
    }

}
module libAm(centerRing,h_,s,n,m,k ){
    w=1.4-k;
    // c = s*m/2+m*2;
    //h_=4;
    //difference(){
        union(){
            for(i=[0:1:2]) translate(pol_zu_kart([centerRing,120*i])) {
            //translate([0,0,0]) planetA(Agear[1],modA,  4,0,0,test=true );
               intersection(){
                   hohlrad_(modul = m, zahnzahl=n, breite=h_, randbreite=w, eingriffswinkel=20, schraegungswinkel=0,dd_diff=k,spiel_val=0.3);
                   rotate([0,0,360/3*i]){
                       rotate([0,0,80])  rotate_extrude(angle=200) translate([n*m/2-m,0]) square([w+m*3,h_],center=false);
                       //rotate([0,0,-50/2+180])  rotate_extrude(angle=50) translate([n*m/2-m,0]) square([w+m*3,h_],center=false);
                   }
               }               
            }     
     //pfeilrad(modul= m, zahnzahl=s, breite=h_ , bohrung=0, eingriffswinkel=20, schraegungswinkel=0);       
           // translate([0,0,h_/2]) cube([2.5,2.5,h_],center=true);
        }
       
        //translate([0,0,4-0.6]) letter(tag,size=3);
    //}
}
module getPrintRing(modul,zahnzahl,breite=4.4,randbreite=2,diff = 0.2){   
    
 
 
    translate([0,0,0.8]) hohlrad_(modul = modul, zahnzahl=zahnzahl, breite=breite-0.8, randbreite=randbreite, eingriffswinkel=20, schraegungswinkel=0,dd_diff=diff,spiel_val=0.1);
    for(i=[0:1:4])
    translate([0,0,0.2*i]) hohlrad_(modul = modul, zahnzahl=zahnzahl, breite=0.2, randbreite=randbreite, eingriffswinkel=20, schraegungswinkel=0,dd_diff=diff,spiel_val=1.3-0.3*i);
}
module ringBLib( rAr,width,layer,slit,t=0){
    k = 0.6;
    l = layer+k;
    rA = rAr+width;
    ran = ( (rA*2*PI)/5); 
    rag =floor( 360/ran);
    //rag5 = 360/5;
    rag6 = 360/6;
    translate([0,0,-1.8]){
        //rotate_extrude() translate([9.75,0]) square([rA -9.75,1],center=false); 
        
        translate([0,0,1]) difference(){
            rotate_extrude(angle=360) translate([rAr+slit,0]) polygon([[0,0], [width-slit,0 ]  ,[width-slit,layer] ,[t,layer ]]);//square([width,layer]);
          
            //for(i=[0:1:ran-1]) rotate([0,0,i*rag*2-0.5]) rotate_extrude(angle=rag+1) translate([rAr+slit,0])  polygon([[0,0],  [width,l ] ,[-slit,l ],[-slit,0 ]]);
            //rotate([0,0,-rag]) rotate_extrude(angle=rag*2) translate([rAr+width,layer*2-1.8]) square([width,5],center=false);  
             
            
            for(i=[0:1:5]) rotate([0,0,rag6*i]){
                //rotate_extrude(angle=rag) translate([rAr+width,layer*2-1.8]) square([width,3.4],center=false);  
                rotate([0,0,rag-0.5]) rotate_extrude(angle=rag6-rag+1) translate([rAr+slit,0])  polygon([[0,0],  [width,l ] ,[-slit,l ],[-slit,0 ]]);
            }
            rotate_extrude(angle=360-rag6) translate([rAr ,layer-1.2])  circle(d=1);
        }
          //rotate_extrude() translate([rAr,0]) square([width,1]);  
        children();
         
    }
    
}
module wheelOut(rAr,width,layer,k,Bgear,centerRing ,slit){
    o=0.6;
    rAr_ = rAr+width+slit/2;
    ringBLib(rAr,width,layer,k,0) # rotate_extrude(angle=360)polygon([[0,-o],[rAr_+0.5,-o],[rAr_+0.5,1-o],[rAr_,1-o], [rAr_ ,12], [rAr_,1],[centerRing+1.5,1],[centerRing+1.5,0],[centerRing-1.5,0],[centerRing-1.5,1],[(Bgear[0]*Bgear[2]+Bgear[2]*4)/2,1],[(Bgear[0]*Bgear[2]+Bgear[2]*4)/2,0],[0,0]]);
    
 
    
}