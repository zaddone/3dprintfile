use <Getriebe.scad>
use <GetTest.scad>
use <reducer_v2.scad>
$fn=100;
T=false;
Agear = [11,25,0.5];
Bgear = [10,26,0.5];
layer=4;
width=2.5;
slit = 0.2;
holeLong=5;
modA = Agear[2];
ringA=Agear[0]+Agear[1]*2;
ringAr = ringA*modA/2+modA+slit;

modB = Bgear[2];
ringB=Bgear[0]+Bgear[1]*2;
ringBr = ringB*modB/2+modB+slit;
centerRing = (Bgear[0]+Bgear[1])/2 * Bgear[2];


rAr = ringAr+width+slit;
rArL = (ringA*modA-modA*2-slit)/2;

ShowGear();
translate([0,0,-(layer+0.4)]){
    //ringB(rAr,ringBr,layer,width,modB,ringB,slit);  
    ringBLib(rAr,width,layer,slit)   motor130Room(rAr,width ) ;
        
  // PAssemble(centerRing,7,slit); 
    
   // motorFix(ringAr+width,width);
}
union(){
    //ringA(modA,ringA,ringAr,layer,width,holeLong,slit); 
    translate([0,0,layer]) {
        ringAlibAm(centerRing,rArL,width,layer-2,modA,slit)  ; 
        translate([0,rArL,0]) !ringALibOutput(modA,rArL,width,holeLong ,layer,slit );
       // wheelRoom(ringAr,width,layer,modA,holeLong,slit);
    }
}
module ShowGear(b=Bgear, a=Agear){
 
    
    
    //rAr = ringAr+width+slit;
    translate([centerRing,0,0]) gearPlanet(nA = a[1],modA = a[2],nB = b[1],modB = b[2],k = slit);
 
     
    difference(){
        union(){
                for(i=[0:1:2]) translate(pol_zu_kart([centerRing,120*i])) gearPlanet(nA = a[1],modA = a[2],nB = b[1],modB = b[2]);
            ringA(modA,ringA,ringAr,layer,width,holeLong,slit);
            rotate([0,0,0]) sunA(n=a[0] ,mod =a[2]);
            //rangBase(n=a[0] ,mod =a[2] )  sunA(n=a[0] ,mod =a[2],test=true);
                
                rotate([180,0,0]) sunB(n=b[0] ,mod =b[2] );                
              // rangBase(n=b[0] ,mod =b[2] ) sunB(n=b[0] ,mod =b[2] ,test=true);
           // translate([0,0,-(layer+0.4)]) {
                ringB(rAr,ringBr,layer,width,modB,ringB,slit);       
                
           // }
        }
        
       // translate([rAr,0,0]) cube([rAr*2,rAr*3,layer*4],center=true);
    }
    
}

module wheelRoom(ringAr,width,layer,modA,holeLong,slit){
        h = layer-1.2;
    w3 = width/2;
     m = 3;
    ang = 360/m;
    rr=ringAr ;
    minRng = (holeLong*0.9)/rr * (180/PI);
    for(i=[0:1:m-1]) rotate([0,0,ang*i-minRng/2]) rotate_extrude(angle=minRng) translate([rr ,0])   polygon([[0,0],[slit,0], [w3,h-1],[w3,h],[0,h]]);
    difference(){
        union(){
            ringALibBase(ringAr,width,h,modA,slit,0);
            scale([1.25,1.2,1]) motorTemp(_h=10); 
            translate([-1.5,-18,0]) cube([3,36,10]);
        }
        translate([0,0,-0.2]) scale([0.9,0.9,1]) motorTemp(_h=1.4);
        translate([0,0,1]) motorTemp(_h=26);
    }
    
}
module ringA(modA,ringA,ringAr,layer,width,holeLong,slit){

    
    //rotate_extrude() translate([ringAr,0]) square([width,layer],center=false);
    union(){
        minWidth = 0.5;
        getPrintRing( modA,ringA,layer,width-minWidth);
        
        rotate_extrude(angle=360) translate([ringAr,0]) polygon([[0,0],[width-minWidth,0],[width,layer-1],[width,layer],[0,layer]]);
        
        //translate([0,0,layer])rotate_extrude() translate([ringA*modA/2-modA ,0]) polygon([[0,0],[width+1,0],[width, 1],[0, 1]]);
        //translate([0,0,layer+1]) rotate_extrude() translate([ringA*modA/2-modA ,0]) polygon([[0,0],[width,0],[width,layer-1],[0,layer-1]]);
        //rr=ringAr-width+modA
        rr = (ringA*modA-modA*2)/2;
        minRng = holeLong/rr * (180/PI);
         
        m = 3;
        ang = 360/m;
        //p1= [[0,0],[width+0.5,0],[width,layer-1],[-1.5,layer-1]];
        p2 = [[0,0],[width+0.5,0],[width,layer+0.6],[0,layer+0.6]];
        p3 = [[-1,0],[ 0.5,0],[ 1.8,layer-2.4],[ 1.8,layer-1],[-1,layer-1]];
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
               rotate([0,0,ang*i -ang/4+0.5]) rotate_extrude(angle=ang/2-1) translate([rr,layer+0.6]) polygon([[0,-1],[0,0], [1,0]]);// circle(d=1.2);
            }
            //#rotate([0,0,-minRng/2-1]) rotate_extrude(angle=minRng+2) translate([rr,0])   polygon(p4);
            //translate([rr+width/2,0,layer/2 ])  cube([width*2,holeLong+slit*2,0.4],center=true);// cylinder(d=1.8,h=2,center=true);
        }
         
    }
 

}
module ringBlibAm(){
    //libAm(Agear[0],Agear[1],Agear[2]);
    
    translate([0,0,4]){
        libAm(Bgear[0],Bgear[1],Bgear[2]);
       // for(i=[0:1:2]) translate(pol_zu_kart([centerRing,120*i])) planetB(Bgear[1],modB,  4,0,0,test=true );
    }
   // #translate([0,0,8])  rotate([180,0,6]) ringB(rAr,ringBr,layer,width,modB,ringB,slit);   
}
module libAm(s,n,m){
    w=1.4;
     c = s*m/2+m*2;
    h_=4;
        for(i=[0:1:2]) translate(pol_zu_kart([centerRing,120*i])) {
        //translate([0,0,0]) planetA(Agear[1],modA,  4,0,0,test=true );
           difference(){
               pfeilhohlrad_(modul = m, zahnzahl=n, breite=h_, randbreite=w, eingriffswinkel=20, schraegungswinkel=0,dd_diff=0.1,spiel_val=0.3);
               rotate([0,0,360/3*i]){
                   rotate([0,0,-160/2])  rotate_extrude(angle=160) translate([n*m/2-m,0]) square([w+m*3,h_],center=false);
                   rotate([0,0,-50/2+180])  rotate_extrude(angle=50) translate([n*m/2-m,0]) square([w+m*3,h_],center=false);
               }
           }
    }
}
 
module ringAlibAm(planetCenter,ringAr,width,h,modA,k,bo = 6){
    
    
    
    c = Agear[0]*modA/2+modA*2;
    //sunA(Agear[0],modA);
    h_=4;
   translate([0,0,h]) {
       ringBlibAm();
     // #translate([0,0,8])  rotate([180,0,0]) ringB(rAr,ringBr,layer,width,modB,ringB,slit);   
       }
    #translate([0,0,h+4]) rotate([180,0,6]) ringA(modA,ringA,ringAr,layer,width,holeLong,slit);
    translate([0,0,h]) union() {
         for(i=[0:1:2]) translate(pol_zu_kart([centerRing,120*i]))  translate([0,0,0]) planetA(Agear[1],modA,  4,0,0,test=true );
        //cylinder(r=planetCenter,h=4);
       // rotate_extrude() translate([c,0]) square([ Agear[1]*modA/2,h_],center=false);
       // for(i=[0:1:2]) translate(pol_zu_kart([centerRing,120*i])) scale([1.05,1.05,1.1]) planetA(Agear[1],modA,  h_,0,k,test=true );
        //scale([1.05,1.05,1.1])     sunA(Agear[0],modA);
  
       libAm(Agear[0],Agear[1],Agear[2]);
    }
    difference(){
        ringALibBase(ringAr,width,h-0.4,modA,k,c) ;
        translate([c-1,-1,0]) cube([2,2,h]);
        //cylinder(r=planetCenter,h=10,center=true);
       // for(i=[0:1:2]) rotate([0,0,i*120]) translate([planetCenter,0,-h]) cylinder(d= Agear[1]*modA/2,h=h*2);
    }
 }
module ringALibOutput(modA,ringAr,width,holeLong ,layer,k ){
     
    l = holeLong+k;
    h = layer-1.2;
    w3 = width/2;
     m = 3;
    ang = 360/m;
    rr=ringAr ;
    minRng = (holeLong*0.9)/rr * (180/PI);
    {
        
        for(i=[0:1:m-1]) rotate([0,0,ang*i-minRng/2]) rotate_extrude(angle=minRng) translate([rr ,0])   polygon([[0,0],[k,0], [w3,h-1],[w3,h],[0,h]]);
        difference(){
            union(){   
                ringALibBase(ringAr,width,h,modA,k,center=0);
               
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
module sunA(n,mod,test=false){    
    gearBase(n=n,bo=2,diff=0.0,mod =mod,breite=3.6,test=test);    
}
module ringALibBase(ringAr,width,h,modA,k,center=0){
 
    w1 =ringAr;// ringAr-width+modA - k ;
    
    //w2 = ringAr-width+modA -1.5 -k  ;
    
    w3 = width/2;
    //h=layer-1.4;
    rotate_extrude(angle=360) translate([center,0])  polygon([[0,0],[w1-center,0],[w1-center,h],[0,h]]);
   // square([ringAr-width-centerRing,layer-2.4]);
     m = 3;
    ang = 360/m;
    for(i=[0:1:m-1])  {
        rotate([0,0,ang*i+ang/4]) rotate_extrude(angle=ang/2) translate([w1,0])   polygon([[0,0],[width,0],[width,h],[0,h]]);
        //rotate([0,0,ang*i-minRng/2]) rotate_extrude(angle=minRng) translate([w1 ,0])   polygon([[0,0],[k,0], [w3,h-1],[w3,h],[0,h]]);
        
    }
    //children();
    
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
                rotate_extrude(angle=360) translate([rAr,0]) polygon([[slit,0],[width,0],[width,layer+2],[slit,layer+2],[slit,layer-1],[-slit*2,0] ]) ; 
                for(i=[0:1:4]) rotate([0,0,rag5*i]) rotate_extrude(angle=rag) translate([rAr+width/2,1.4]) square([width,3.4],center=false);  
            }
            translate([0,0,layer]) rotate([180,0,0]) getPrintRing( modB,ringB,layer,width );
            translate([0,0,-l]) rotate_extrude()  translate([ringB*modB/2-modB,0]) square([rAr -  (ringB*modB/2-modB) ,l],center=false);  
            difference(){
                
            rotate_extrude(angle=360) translate([rAr,-l])  polygon([[0,0], [width,layer+l],[0,layer+l]]); 
            rotate([0,0,0]) for(i=[0:1:4]) rotate([0,0,rag5*i]) rotate_extrude(angle=rag) translate([rAr-slit,-l]) square([width+slit,layer+1]);//  polygon([[0,0], [width,layer+l],[0,layer+l]]);  
            }
                    
            rotate_extrude(angle=360) translate([rAr,layer/2])  circle(d=0.8);
            
        }
            
     
         rotate_extrude(angle=360) translate([rAr+0.2,layer*2+1.2]) circle(d=1.5);
       
        /*
        m=6;
        rad = 360/m;
        //translate([0,0,layer*2+1.2]) for(i=[0:1:m-1]) translate(kugel_zu_kart([rAr+0.1,90,rad*i])) sphere(d=1.5);   
        
        translate([0,0,layer*2+1.2]) for(i=[0:1:m-1]) rotate([0,0,rad*i]) translate([rAr+0.2,0,0]) {
            //sphere(d=1.5); 
            rotate([90,0,0]) cylinder(d=1.5,h=5,center=true);
        }
        
    
     */
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
module gearPlanet(nA,modA,nB,modB,breite=4,bo = 2,k=0,test = false){

    //_k = 0.8;
   // bo= nB*modB - modB*10;
   // bo = 2;
    union(){
        //gearBase(nA,bo+k,0.1,modA,breite=breite);  
        union(){
            planetA(nA,modA,  breite,bo,k,test );
       // rangBase(n=nA,mod=modA,breite=breite);// planetA(nA,modA,  breite,bo,k ,true);
       // translate([nA*modA*2,0,1])   inRang(n=nA,mod=modA,breite=breite);
        }
        
        translate([0,0,-(breite)]){
            planetB(nB,modB,breite,bo,k,test);// gearBase(nB,0,0.1,modB,breite=breite);     
          //  rangBase(n=nB,mod=modB,breite=breite);// planetA(nA,modA,  breite,bo,k ,true);
          //  translate([nB*modB*2,0,1]) inRang(n=nB,mod=modB,breite=breite);
        }         
        
         
    }
     
}
module inRang(n,mod,breite,diff=-0.05){
    rr = (n*mod-mod*3)/2;
    rm = (n*mod)/2+3+mod*1.5-diff*2 ;
    //cylinder(d=n*mod-mod*3,h=breite*2.2);
    translate([0,0,0]) {
        rotate_extrude() translate([rr-3,0]) square([3,breite*2.5]);
        rotate_extrude() translate([rm,0]) square([3,breite*3]);
    }
    translate([0,0,-1]) cylinder(r=rm+3,h=1); 
    
}
module rangBase(n,mod,breite=4,diff = -0.05,spiel = 0.15 ){   
    d = n* mod;
    //rotate_extrude() translate([(d+mod*3)/2,0]) square([1,breite*2]);
    sk = 1.02;
    pfeilhohlrad_(modul = mod, zahnzahl=n, breite=breite, randbreite=3, eingriffswinkel=20, schraegungswinkel=0,dd_diff=-diff*2,spiel_val=spiel*2);
     translate([0,0,breite]) pfeilhohlrad_(modul = mod, zahnzahl=n, breite=breite, randbreite=3, eingriffswinkel=20, schraegungswinkel=0,dd_diff=0,spiel_val=0);
     translate([0,0,breite*2])  rotate_extrude() translate([n*mod/2 +mod*2 - diff*2,0]) square([3-mod,breite*2]) ;
    /*
    difference(){
        cylinder(d=d+mod*3+2,h=breite*2,center=false);
        cylinder(d=d-mod*3,h=breite*2,center=false);
        scale([sk,sk,1]){
        children();
        translate([0,0,breite]) children();
        }
    }
    */
}
module planetA(nA,modA,  breite,bo,k,test=false  ){
    if (test){
        gearBase(nA,0 ,0.1,modA,breite,test);  
    }else{
        
        difference(){
        gearBase(nA,bo+k ,0.1,modA,breite,test);  
        translate([0,0,breite-0.6])  letter("A",size=nA*modA/2);
        }
    }
    
   // rotate([0,0,-90]) rotate_extrude(angle=180) translate([0, 0]) square([(bo+k)/2,breite]);
}
module planetB(nB,modB,  breite,bo,k ,test=false ){
        if (test){
        gearBase(nB,0 ,0.1,modB,breite,test);  
    }else{
    difference(){
    gearBase(nB,bo+k,0.1,modB,breite,test);  
    translate([0,0,breite-0.6])  letter("B",size=nB*modB/2);
    }
}
    //rotate([0,0,90]) rotate_extrude(angle=180) translate([0, 0]) square([(bo+k)/2,breite]);
   // #translate([0,0,breite])difference(){
   //     rotate([0,0,90])   rotate_extrude(angle=180) translate([0, 0]) square([(bo)/2,breite -1]);
   //     translate([0,0,breite/2]) cube([k,bo+k,breite],center=true);
   // }
}
module letter(l,size) {
    font = "Liberation Sans"; //["Liberation Sans", "Liberation Sans:style=Bold", "Liberation 
    //cube_size = 60;
    //letter_size = 50;
    letter_height = 0.6;
    linear_extrude(height = letter_height) {
        text(l, size = size, font = font, halign = "center", valign = "center", $fn = 16);
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
                 cube([_d+width*2,5,4],center=true);
                //rotate_extrude() translate([5.5,0]) square([_d/2-5.5+width,2]);
            }
        }
        r2 =rD- tanR1 * 6 +minR+width/2;
        o1 = [[(r2),0],[(12),-5],[(10.2),-_h/2+4],[10.2,-_h/2],[minR,-(_h-5)],[r2+width/2,0]];
        translate([0,0,-5]){
            
            rotate([0,0,90-25]) for(i=[0:1:1]) rotate([0,0,i*20*2]) rotate_extrude(angle=10)  polygon(o1);
            
            rotate([0,0,-90-25]) for(i=[0:1:1]) rotate([0,0,i*20*2]) rotate_extrude(angle=10)  polygon(o1);
                
        }
    }
  
}
module sunB(n,mod,test = false){    
    union(){
        b = 1.8;
        h=4;
        gearBase(n=n,bo=b,diff=0.0,mod =mod,breite=h,test=test,k=0.2);            
        r = n*mod/2-mod-mod;
        rotate_extrude()polygon([[b/2,h],[r,h],[r,h+0.6],[1.5,h+0.6]]); 
        
        
    }
}

module gearBase(n=23,bo=6.2,diff=0.1,mod =0.5,breite=4,test=T,k=0.3){
    fans=0;
    eing=20;
    
    //k=0.3;
    spiel_val = 0.1;
    //m = k/0.2;
    //a=sin(45)*k*2 ;
    if (test){
        pfeilrad(modul= mod, zahnzahl=n, breite=breite , bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans);
    }else{
    pfeilrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff+k*2,spiel_val=spiel_val);
    translate([0,0,0.2]) pfeilrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff+k,spiel_val=spiel_val);
    
    translate([0,0,0.4]) pfeilrad_(modul= mod, zahnzahl=n, breite=breite-0.8, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff,spiel_val=spiel_val);
    
    translate([0,0,breite-0.4]) pfeilrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff+k,spiel_val=spiel_val);
    translate([0,0,breite-0.2]) pfeilrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff+k*2,spiel_val=spiel_val);
   
    }
    //for(i=[0:1:m-1]) translate([0,0,(k-0.2) - i*0.2]) pfeilrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=fans,dd_diff=diff+a*i,spiel_val=0.1); 
    
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