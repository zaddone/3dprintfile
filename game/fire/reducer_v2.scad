use <Getriebe.scad>
use <GetTest.scad>
use <car_v10_lib.scad>

$fn=96;
T = false;
testShow();
showRed(fit=true);
Agear = [17,37,0.5];
Bgear = [13,32,0.6];
gearmod = 0.6;
function pol_zu_kart(polvect) = [
	polvect[0]*cos(polvect[1]),  
	polvect[0]*sin(polvect[1])
];
//0.6 13 32} &{0.5 17 37} 3_13.50 273

module testShow(b=Bgear, a=Agear){
    layer=4;
    width=2;
    slit = 0.2;
    
    modA = a[2];
    ringA=a[0]+a[1]*2;
    ringAr = ringA*modA/2+modA+slit;
    
    modB = b[2];
    ringB=b[0]+b[1]*2;
    ringBr = ringB*modB/2+modB+slit;
    centerRing = (a[0]+a[1])/2 * a[2];
    
    
    rAr = ringAr+width+slit;
    translate([centerRing,0,0]) gearPlanet(nA = a[1],modA = a[2],nB = b[1],modB = b[2],k = slit);
 
     
    difference(){
        union(){
                for(i=[0:1:2]) translate(pol_zu_kart([centerRing,120*i])) gearPlanet(nA = a[1],modA = a[2],nB = b[1],modB = b[2]);
            //ringA(modA,ringA,ringAr,layer,width); 
            rotate([0,0,10]) sunA(n=a[0] ,mod =a[2]);
            translate([0,0,0]) {
                //ringB(rAr,ringBr,layer,width,modB,ringB,slit); 
                rotate([180,0,0]) sunB(n=b[0] ,mod =b[2] );
            }
        }
        
       // translate([rAr,0,0]) cube([rAr*2,rAr*3,layer*4],center=true);
    }
    
}
module ringAlibAm(planetCenter,ringAr,width,h,modA,k,bo = 6){
    difference(){
        ringALibBase(ringAr,width,h-0.4,modA,k,planetCenter) ;
        //cylinder(r=planetCenter,h=10,center=true);
        for(i=[0:1:2]) rotate([0,0,i*120]) translate([planetCenter,0,-h]) cylinder(d=bo+k,h=h*2);
    }
 }
 
module PAssemble(planetCenter=9.75,bo=6,k){
    
    h=5;
    r = (bo)/2-k*3;
    translate([0,0,1]) {
        for(i=[0:1:2]) {
            translate(pol_zu_kart([planetCenter,120*i])) rotate([0,0,75])   rotate_extrude(angle=210) polygon([[0,0],[r,0],[r,-(h-1)],[r-k*2,-h],[0,-h]]);
            rotate([0,0,120*i]) translate([planetCenter,0,0]) cylinder(d=bo+0.5,h=1);         
        }
        rotate_extrude() translate([planetCenter,1]) square([bo,1],center=true);
    }
}
module sunA(n,mod){    
    gearBase(n=n,bo=3.5,diff=0.1,mod =mod,breite=3,test=T);    
}
module sunB(n,mod){    
    union(){
        h=4;
        gearBase(n=n,bo=2,diff=0.1,mod =mod,breite=h,test=T);            
        r = n*mod/2-mod-mod;
        rotate_extrude()polygon([[1,h],[r,h],[r,h+0.6],[1.5,h+0.6]]); 
    }
}

module gearPlanet(nA,modA,nB,modB,breite=4,bo = 6,k=0.2){

    _k = 0.8;
    union(){
        gearBase(nA,bo+k,0.1,modA,breite=4);     
        translate([0,0,-(breite)]){ 
            union(){
                gearBase(nB,0,0.1,modB,breite=4-_k);  
                translate([0,0,4]) rotate([180,0,0])  gearBase(nB,bo+k,0.1,modB,breite=_k);       
                
            }  
            rotate([0,0,-75]) rotate_extrude(angle=150) translate([0,0]) square([(bo+k)/2,breite*2]);
        }
    }
     
}

module showRed(b=Bgear, a=Agear,fit=false,long=50 , holeLong=5 ){
    
    
    
    layer=4;
    width=2;
    
    slit = 0.2;

    modA = a[2];
    ringA=a[0]+a[1]*2;
    ringAr = ringA*modA/2+modA+slit;
    
    centerRing = (a[0]+a[1])/2 * a[2];

    modB = b[2];
    ringB=b[0]+b[1]*2;
    ringBr = ringB*modB/2+modB+slit;
    planetCenter = (b[0]+b[1]) /2 * b[2];
    rAr = ringAr+width+slit;
 
    if (fit){
        
        union(){
            rotate([0,0,0]) { 
                ringA(modA,ringA,ringAr,layer,width);        
            translate([0,0,layer]) rotate([0,0,0]) { 
                ringAlibAm(planetCenter,ringAr,width,layer-2,modA,slit)  ; 
       
                //PAssemble(planetCenter,7,slit);         
                // ringALibBase(centerRing,ringAr,width,layer-2.4,modA,slit){
                     
                     
                 //    };
                ringALibOutput(modA,ringAr,width,holeLong ,layer,slit );
                //translate([0,0,3.6]) rotate([0,0,0]) ringALibOutputB(holeLong,long );
            }    
        }     
            translate([0,0,-(layer+0.4)]) {            
                ringB(rAr,ringBr,layer,width,modB,ringB,slit);  
                   
                translate([0,0,0])  ringBLib(rAr,width,layer,slit){
                    
                    motor130Room(rAr,width ) ;// PAssemble_2(rAr+width);
                    
                }
                motorFix(rAr,width);
                /*  
               translate([0,0,-25-2.2])  motorTemp();
                motorFix(rAr,width);
                 */
                //translate([0,0,-30 ]) motorRoom();
            }     
        }   
    }else{
        translate([0,0,layer*2]) {
            ringA(modA,ringA,ringAr,layer,width);        
            translate([0,0,layer*3]){
                ringALibOutput(modA,ringAr,width,holeLong ,layer );
                translate([0,0,layer*3])   ringALibOutputB(holeLong,long );
            }
        }
         
        translate([0,0,-(layer*2 )]) {
            ringB(rAr,ringBr,layer,width,modB,ringB);        
             translate([0,0,-layer*2 ]) {
                 ringBLib(rAr,width,layer);
            translate([0,0,-30 ]) motorRoom();
             }
        }
        
        
    }
}
module ringALibOutputB(holeLong,long ){
  
    rotate([0,0,90]) union(){
        difference(){
            union(){
                translate([-holeLong/2,-(holeLong) ,-3.5]) {
                    cube([holeLong,holeLong*2,5.5],center=false);                
                }
                translate([-holeLong/2,holeLong/2 ,-1]) cube([holeLong,holeLong*3,3],center=false);
                translate([0,0,1.5]) hull(){
                    translate([-holeLong/2,holeLong*2 ,-1]) cube([holeLong,holeLong*1,3],center=false);
                    translate([0,long,0])cylinder(d=holeLong,h=3); 
                }
            }
            translate([holeLong/2,holeLong/2,0]) cube([2,2,20],center=true);
            translate([-(holeLong/2),-holeLong/2,0]) cube([2,2,20],center=true);
        }
        
        translate([0,long,1.5]){
            cylinder(d=holeLong,h=9);  
            translate([0,0,9]) difference(){                 
                 cylinder(d=holeLong+1,h=1);                  
                translate([(holeLong)/2,-(holeLong+1)/2]) cube([1,holeLong+1,1],center=false);                
            }
            /*
            translate([0,0,3]) difference(){  
                cylinder(d=holeLong+1,h=0.6); 
                translate([(holeLong)/2,-(holeLong+1)/2]) cube([1,holeLong+1,0.6],center=false);
            }
            */
        }
    }
        
    
    
}
module ringALibBase(ringAr,width,h,modA,k,center=0){
 
    w1 = ringAr-width+0.5 - k ;
    w2 = ringAr-width+modA -1.5 -k  ;
    
    w3 = width+width/2;
    //h=layer-1.4;
    rotate_extrude(angle=360) translate([center,0])  polygon([[0,0],[w1-center,0],[w2-center,h],[0,h]]);
   // square([ringAr-width-centerRing,layer-2.4]);
     m = 3;
    ang = 360/m;
    for(i=[0:1:m-1]) rotate([0,0,ang*i+ang/4])  rotate_extrude(angle=ang/2) translate([w2,0])   polygon([[0,0],[w3,0],[w3,h],[0,h]]);
    children();
    
}
module ringALibOutput(modA,ringAr,width,holeLong ,layer,k ){
    
//    k = 0.1;
    l = holeLong+k;
    h = layer-1;
    //#translate([0,0,layer-2.4]) cylinder(h=1,r=ringAr-width+modA-0.2 );
    //m = 3;
    //ang = 360/m;
    //for(i=[0:1:m-1]) rotate([0,0,ang*i+ang/4])  rotate_extrude(angle=ang/2) translate([ringAr-width,0])   polygon([[0,0],[width,0],[width,h-1.4],[0,h-1.4]]);
        
    {
        difference(){
            union(){   
                ringALibBase(ringAr,width,h,modA,k);
               
                translate([0,0,h]) cylinder(h=2,r1=ringAr-width-modA - k - 1.5 ,r2= l+1);
            }
              difference() {
                 union() {  
                    translate([-(l*2)/2 ,-(l+k)/2,-1]) cube([l*2 ,l+k,10],center=false);                    
                    translate([-(ringAr) ,-(l+k)/2,h-0.6]) cube([(ringAr),l+k,5],center=false);
                }
                 {
                   translate([-holeLong/2,holeLong/2,0]) cube([1.5,1.5,20],center=true);
                   translate([(holeLong/2),-holeLong/2,0]) cube([1.5,1.5,20],center=true);
                }
            }
            
        }
        
        
    }
    
    
}
module ringA(modA,ringA,ringAr,layer,width){

    
    //rotate_extrude() translate([ringAr,0]) square([width,layer],center=false);
    union(){
        minWidth = 0.5;
        getPrintRing( modA,ringA,layer,width-minWidth);
        
        rotate_extrude(angle=360) translate([ringAr,0]) polygon([[0,0],[width-minWidth,0],[width,layer-1],[width,layer],[0,layer]]);
        
        //translate([0,0,layer])rotate_extrude() translate([ringA*modA/2-modA ,0]) polygon([[0,0],[width+1,0],[width, 1],[0, 1]]);
        //translate([0,0,layer+1]) rotate_extrude() translate([ringA*modA/2-modA ,0]) polygon([[0,0],[width,0],[width,layer-1],[0,layer-1]]);
         
        m = 3;
        ang = 360/m;
        translate([0,0,layer])union(){ 
            for(i=[1:1:m-1]) {
                rotate([0,0,ang*i-ang/4+0.5]) rotate_extrude(angle=ang/2-1) {
                    translate([ringAr-width+modA,0])   polygon([[0,0],[width+0.5,0],[width,layer-1],[-1.5,layer-1]]);
                    //translate([ringAr-width+modA,layer-1.6]) circle(d=1.2);
                }
                //#rotate([0,0,ang*i+ang/4]) translate([ringAr-width+modA,0,layer-1.8]) cylinder(d=1.5,h=10);
            }
            {
               rotate([0,0, -ang/4+0.5])  rotate_extrude(angle=ang/2-1) translate([ringAr-width+modA,0])   polygon([[0,0],[width+0.5,0],[width,layer-1],[0,layer-1]]);
               rotate([0,0, -ang/8]) rotate_extrude(angle=ang/4) translate([ringAr-width+modA,0])   polygon([[0,0],[width+0.5,0],[width,layer-1],[-1.5,layer-1]]);
                //translate([ringAr-width+modA,layer-1.6]) circle(d=1.2);
            }
            //translate([ringAr-width+modA-1.5,0,layer-1.5]) rotate([90,0,0]) cylinder(d=1.8,h=2,center=true);
        }
         
    }
 

}
module ringBLib( rAr,width,layer,slit){
    k = 0.6;
    l = layer+k;
    rA = rAr+width;
    ran = ( (rA*2*PI)/5); 
    rag =floor( 360/ran);
    rag5 = 360/5;
    
    translate([0,0,-1.8]){
        //rotate_extrude() translate([9.75,0]) square([rA -9.75,1],center=false); 
        
        translate([0,0,1]) difference(){
            rotate_extrude(angle=360) translate([rAr+slit,0]) polygon([[0,0], [width-slit,0 ], [width+width/2,layer ],[width+width/2,layer*2+3],[width,layer*2+3] ,[width,layer] ,[0,layer ]]);//square([width,layer]);
          
            //for(i=[0:1:ran-1]) rotate([0,0,i*rag*2-0.5]) rotate_extrude(angle=rag+1) translate([rAr+slit,0])  polygon([[0,0],  [width,l ] ,[-slit,l ],[-slit,0 ]]);
            rotate([0,0,-rag]) rotate_extrude(angle=rag*2) translate([rAr+width,layer*2-1.8]) square([width,5],center=false);  
            for(i=[0:1:4]) rotate([0,0,rag5*i]){
                rotate_extrude(angle=rag) translate([rAr+width,layer*2-1.8]) square([width,3.4],center=false);  
                rotate([0,0,rag-0.5]) rotate_extrude(angle=rag5-rag+1) translate([rAr+slit,0])  polygon([[0,0],  [width,l ] ,[-slit,l ],[-slit,0 ]]);
            }
            rotate_extrude() translate([rAr ,layer-1.2])  circle(d=1);
        }
          //rotate_extrude() translate([rAr,0]) square([width,1]);  
        children();
         
    }
    
}
module PAssemble_2(){
    //rotate_extrude() translate([9.75,0]) square([rA -9.75,1],center=false); 
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
module ringB(rAr,ringBr,layer,width,modB,ringB ,slit){
    
    union(){
        c3= 360/3;
        q =14;
        l=0.6;
        rA = rAr+width;
        ran = ( (rA*2*PI)/5);
     
        rag =floor( 360/ran);
        rag5 = 360/5;
        echo(ran,rag);
     
        union(){               
            rotate_extrude() translate([ringBr,0])  square([(rAr)-ringBr ,layer],center=false);
            translate([0,0,layer]) difference(){
                rotate_extrude(angle=360) translate([rAr,0]) polygon([[slit,0],[width,0],[width,layer+2],[slit,layer+2],[slit,layer-1],[-slit*2,0]]) ; 
                for(i=[0:1:4]) rotate([0,0,rag5*i]) rotate_extrude(angle=rag) translate([rAr+width/2,1.4]) square([width,3.4],center=false);  
            }
            translate([0,0,layer]) rotate([180,0,0]) getPrintRing( modB,ringB,layer,width);
            translate([0,0,-l]) rotate_extrude()  translate([ringB*modB/2-modB,0]) square([rAr -  (ringB*modB/2-modB) ,l],center=false);  
            difference(){
                
            rotate_extrude(angle=360) translate([rAr,-l])  polygon([[0,0], [width,layer+l],[0,layer+l]]); 
            rotate([0,0,0]) for(i=[0:1:4]) rotate([0,0,rag5*i]) rotate_extrude(angle=rag) translate([rAr-slit,-l]) square([width+slit,layer+1]);//  polygon([[0,0], [width,layer+l],[0,layer+l]]);  
            }
                    
            rotate_extrude(angle=360) translate([rAr,layer/2])  circle(d=0.8);
            
        }
            
     
       
       
        
        m=6;
        rad = 360/m;
        //translate([0,0,layer*2+1.2]) for(i=[0:1:m-1]) translate(kugel_zu_kart([rAr+0.1,90,rad*i])) sphere(d=1.5);   
        
        translate([0,0,layer*2+1.2]) for(i=[0:1:m-1]) rotate([0,0,rad*i]) translate([rAr+0.2,0,0]) {
            //sphere(d=1.5); 
            rotate([90,0,0]) cylinder(d=1.5,h=5,center=true);
        }
        
    }
/*
    translate([0,0,-l])  difference(){
        union(){                    
            //rotate_extrude() translate([21.6-q,0]) square([1.3+q,1.6],center=false);             
            rotate_extrude() translate([ringB*modB/2-modB,0]) square([rAr+width -(ringB*modB/2-modB),l],center=false); 
        }
        //fixed(dr=9.75,m=3,dd=6,hh=16,center=false);
        //for(i=[0:1:2]) rotate([0,0,c3*i]) translate([9.75,0,0]) cylinder(d=6,h=5,center=true);
        for(i=[0:1:2]) rotate([0,0,c3*i-c3/4]) rotate_extrude(angle=c3/2) translate([17,0]) square([2.5,4]);
    }
    */
//    //children(rAr+width+widthEx);
    

}

module getPrintRing(modul,zahnzahl,breite=4.4,randbreite=2){   
 
    translate([0,0,0.8]) pfeilhohlrad_(modul = modul, zahnzahl=zahnzahl, breite=breite-0.8, randbreite=randbreite, eingriffswinkel=20, schraegungswinkel=0,dd_diff=0,spiel_val=0.1);
    for(i=[0:1:4])
    translate([0,0,0.2*i]) pfeilhohlrad_(modul = modul, zahnzahl=zahnzahl, breite=0.2, randbreite=randbreite, eingriffswinkel=20, schraegungswinkel=0,dd_diff=0,spiel_val=1.3-0.3*i);
}

module motorFix(rAr,width){
    translate([0,0,-1]) rotate([180,0,0]) {
           
        difference(){     
            union(){
            rotate_extrude()  square([rAr-0.2-width,0.8]);   
            for(i=[0:1:3]) rotate([0,0,i*90-5]) rotate_extrude(angle=10)   square([( rAr),4.0]); 
              scale([1.3,1.3,1])  motorTemp(_h=8);
                
            }
            
            translate([0,0,2]) motorTemp(_h=10);
            cylinder(d=16,h=20,center=true);
        }  
       
    }
        
    
}
module motor130Room(rAr,width,_h=26,_d=25){
    //width=w/2;
    minR =  _d/2;
    rD = (rAr-minR);
    tanR1 = rD/(_h+1);
    //tanR2 = (rAr-10.7+width)/(_h+1);
    union(){
    difference(){
        union(){
            rotate_extrude(angle=360)   polygon([[rAr-width,1],[rAr-width,-0.6],[rAr-width-1,-0.6],[rD - tanR1*7 + minR ,-6],[minR ,-_h],[minR+width,-_h],[rAr+width,1]]);
        }
        translate([-rAr,-2.5,-_h]) cube([rAr*2,5,10],center=false);
        for(i=[0:1:4]) rotate([0,0,i*90-5.5]) rotate_extrude(angle=11) translate([rAr-width-1,-3]) square([width+1,8]);
    }
    translate([0,0,-_h-2]){
        translate([0,-9,0]) hull(){
            cylinder(d=2.5,h=4);
            translate([-1,-(width+2.5),0]) cube([2,0.5,4]);
        }
        translate([0,9,0]) hull(){
            cylinder(d=2.5,h=4);
            translate([-1,width+2.5,0]) cube([2,0.5,4]);// cylinder(d=2.5,h=4);
        }
        difference(){
            cylinder(d=_d+width*2,h=2);
            cylinder(d=11,h=2);
             cube([30,5,4],center=true);
            //rotate_extrude() translate([5.5,0]) square([_d/2-5.5+width,2]);
        }
    }
    r2 =rD- tanR1 * 6 +minR+width/2;
    o1 = [[(r2),0],[(12),-5],[(10),-_h/2+4],[10,-_h/2],[minR+width,-(_h-5)],[r2+width/2,0]];
    translate([0,0,-5]){
        
        rotate([0,0,90-25]) for(i=[0:1:1]) rotate([0,0,i*20*2]) rotate_extrude(angle=10)  polygon(o1);
        
        rotate([0,0,-90-25]) for(i=[0:1:1]) rotate([0,0,i*20*2]) rotate_extrude(angle=10)  polygon(o1);
            
    }
}
        /*
 
    
  
   
    hull(){
        translate([0,0,-1]) #rotate_extrude() translate([rAr,0]) square([width,1]);
        translate([0,0,-(_h+1)]) #rotate_extrude() translate([_d/2,0]) square([width,1]);
    }  
  */  
}
module motorTemp(_h=25){
     union(){
        intersection(){
            rotate([0,0,0]) cylinder(d=21.5,h=_h,center=false);
            translate([-8,-12.5,0]) cube([16,25,_h],center=false);
        }
      //  cube([___h,6,20],center=true);
    } 
    
    
    }
module motorRoom(rAr,width,_h=18,_d=25){
    
    ___h = _h+1.6;
   
    translate([0,0,-_h]) difference(){
        union(){
        hull(){
            translate([0,0,_h-2]) cylinder(r=rAr,h=2);
            translate([0,0,4]) intersection(){
                cylinder(d=_d,h=4);
                translate([-19.5/2,-_d/2,0]) cube([19.5,_d,1],center=false);                    
            }  
        }
        intersection(){
            cylinder(d=_d,h=4);
            translate([-19.5/2,-_d/2,0]) cube([19.5,_d,4],center=false);                    
        }   

    }
        
  
        translate([0,0,0])  {                   
               rotate_extrude(angle=360) translate([12.5,0]) _guanDao();        
            translate([ 9.8,0])    rotate([90,0,0])   linear_extrude(height=30,center=true) _guanDao();
            translate([-9.8,0])  rotate([90,0,0])   linear_extrude(height=30,center=true) _guanDao();
        }
        
        translate([0,0,_h/2]) union(){
            intersection(){
                rotate([0,0,0]) cylinder(d=21.5,h=___h,center=true);
                cube([16,25,___h],center=true);
            }
          //  cube([___h,6,20],center=true);
        } 
       
     // translate([_h-_gh/2,0,0]) # cube([_gh,16,28],center=true); 
         
    }
    
    
}
 
module _guanDao(){
  translate([0,1]) {
    translate([0,-0.5])circle(0.5); 
     square([1,1],center=true);
    translate([0,0.5]) circle(0.5); 
    }
    
}
 
module gearBase(n=23,bo=6.2,diff=0.1,mod =0.5,breite=4,test=T){
    fans=0;
    eing=20;
    
    k=0.8;
    m = k/0.2;
    a=sin(45)*k*2/m;
    
    //a=sin(45)*k;
    //rrr = n*mod/2+mod;
    //Re = n*mod/2+mod/4;
    translate([0,0,k]) pfeilrad_(modul= mod, zahnzahl=n, breite=breite-k, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff,spiel_val=0.1);
    for(i=[0:1:m-1]) translate([0,0,(k-0.2) - i*0.2]) pfeilrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=fans,dd_diff=diff+a*i,spiel_val=0.1);
    
    /* 
    if (!test){
        intersection(){
            pfeilrad_(modul= mod, zahnzahl=n, breite=k, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=fans,dd_diff=diff,spiel_val=0.1);
        //for(i=[0:1:4])
        //translate([0,0,0.2*i]) 
            cylinder(r1=rrr-a,r2=rrr ,h=k);
        }
    }
     */
    
}