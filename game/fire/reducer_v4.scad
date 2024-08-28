use <Getriebe.scad>
use <GetTest.scad>
use <reducer_v3.scad>
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

!libAmFix();
ringA(modA,ringA,ringAr,layer,width,holeLong,slit);
sunA(n=Agear[0] ,mod =Agear[2] ); 
    //libAm(Agear[0],Agear[1],Agear[2],"A");
     //planetA(Agear[1],Agear[2],4,2,0.2); 
translate([0,0,-(layer+0.4)]){
    ringB(rAr,ringBr,layer,width,modB,ringB,slit);       
    //ringBLib(rAr,width,layer,slit,1) ;
    libAm(Bgear[0],Bgear[1],Bgear[2],"");
    
    //planetB(Bgear[1],Bgear[2],4,2,0.2);
    
    sunB(n=Bgear[0] ,mod =Bgear[2] ); 
    sunBAm();
}

module sunBAm(){
    translate([0,0,-1])pfeilhohlrad_(modul = Bgear[2], zahnzahl=Bgear[0], breite=7, randbreite=2, eingriffswinkel=20, schraegungswinkel=0,dd_diff=slit*2,spiel_val=0.2);
    dr  =(Bgear[2]*Bgear[0]+2-Bgear[2]) /2;
    translate([0,0,-2]) {
        rotate_extrude()translate([2,0]) square([dr,1]);
        
        cylinder(r=dr+2,1);
         
        
        rotate_extrude()translate([10.5,0]) square([1.3,22]);
        for(i=[0:1:4]) rotate([0,0,360/5*i]) rotate_extrude(angle=20)translate([dr+2,0]) square([(11-dr)-2,5]);
    }
    //cylinder(d=Bgear[0]*Bgear[2]+Bgear[2]*4,h=1);
    //sunB(n=Bgear[0] ,mod =Bgear[2] ); 
}
module sunB(n,mod,test = false){    
    union(){
        b = 1.8;
        h=4;
        gearBase(n=n,bo=b,diff=0.0,mod =mod,breite=h,test=test,k=0.2);            
        //r = n*mod/2-mod-mod;
        //rotate_extrude()polygon([[b/2,h],[r,h],[r,h+0.6],[1.5,h+0.6]]);         
    }
}
module sunA(n,mod,test=false){    
    gearBase(n=n,bo=3,diff=0.0,mod =mod,breite=3.6,test=test);    
}
module libAmFix(){
    //translate([0,0,layer]) cylinder(r=centerRing+3,h=1);
    h=7;
    difference(){
        union(){
         rotate([0,0,60]){
          for(i=[0:1:2]) rotate([0,0,120*i]) translate([centerRing+1,0,0]){
                //cylinder(d=4,h=layer*2,center=true);
                //cube([4,3.5,layer*2],center=true);
                translate([0,0,-layer]) linear_extrude(layer*2) polygon([[-2,0],[2,4],[2,-4]]);
                //translate([0,0,layer+1]) cube([4,8,2],center=true);
            }
             }
        translate([0,0,layer]) rotate([0,0,30]) cylinder(   r=centerRing+(Agear[1]*Agear[2])/2-Agear[2]*2,h=h,$fn=6);
        libAm(Agear[0],Agear[1],Agear[2]);
         }
         
        translate([0,0,layer]) for(i=[0:1:2])  rotate([0,0,120*i]) translate([centerRing,0,0])cylinder(h=h,d=(Agear[1]*Agear[2]-Agear[2]*2));
        translate([0,0,-(layer)]) scale([1.05,1.05,1]) libAm(Bgear[0],Bgear[1],Bgear[2],"");
       
    }

}
module planetA(nA,modA,  breite,bo,k,test=false  ){
    if (test){
        gearBase(nA,0 ,0.1,modA,breite,test);  
    }else{
        translate([0,0,0]) cylinder(d=2,h=0.6);
        difference(){
            gearBase(nA,bo+k ,0.1,modA,breite,test);  
            translate([0,0,breite-0.6]) cylinder(d=nA*modA/2,h=0.6);
            //translate([0,0,breite-0.6])  letter("A",size=nA*modA/2);
        }
    }
    
  
}
module planetB(nB,modB,  breite,bo,k ,test=false ){
        if (test){
        gearBase(nB,0 ,0.1,modB,breite,test);  
    }else{
    difference(){
        gearBase(nB,bo+k,0.1,modB,breite,test);  
        translate([0,0,breite-0.6]) cylinder(d=nB*modB/2,h=0.6);
    //translate([0,0,breite-0.6])  letter("B",size=nB*modB/2);
    }
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
module ringA(modA,ringA,ringAr,layer,width,holeLong,slit){

    
    //rotate_extrude() translate([ringAr,0]) square([width,layer],center=false);
    union(){
        minWidth = 0.5;
        getPrintRing( modA,ringA,layer,width-minWidth,slit*2);
        rotate_extrude(angle=360) translate([ringAr,0]) polygon([ [width-minWidth,0],[width,layer-1],[width,layer],[width-minWidth,layer]]);
        
        //translate([0,0,layer])rotate_extrude() translate([ringA*modA/2-modA ,0]) polygon([[0,0],[width+1,0],[width, 1],[0, 1]]);
        //translate([0,0,layer+1]) rotate_extrude() translate([ringA*modA/2-modA ,0]) polygon([[0,0],[width,0],[width,layer-1],[0,layer-1]]);
        //rr=ringAr-width+modA
        rr = (ringA*modA-modA*2)/2 +slit;
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
module ringB(rAr,ringBr,layer,width,modB,ringB ,slit){
    
    union(){
        c3= 360/3;
        q =14;
        l=0.8;
        rA = rAr+width;
        ran = ( (rA*2*PI)/5);     
        rag =floor( 360/ran);
        rag5 = 360/5;
        echo(ran,rag);
        cr = ringB*modB/2+modB+slit/2;     
        union(){               
            rotate_extrude() translate([ringBr,0])  square([(rAr)-ringBr ,layer],center=false);
            translate([0,0,layer]) difference(){
                rotate_extrude(angle=360) translate([rAr,0]) polygon([[slit,0],[width,0],[width,layer+2],[slit,layer+2],[slit,layer-1],[0,0] ]) ; 
                for(i=[0:1:4]) rotate([0,0,rag5*i]) rotate_extrude(angle=rag) translate([rAr+width/2,1.4]) square([width,3.4],center=false);  
            }
            translate([0,0,layer]) rotate([180,0,0]) getPrintRing( modB,ringB,layer,width,slit );
            translate([0,0,-l]){
                rotate_extrude()  translate([ cr,0]) square([rAr - cr ,l],center=false); 
                getPrintRing( modB,ringB,l,width,slit ); 
            }
            difference(){
                
            rotate_extrude(angle=360) translate([rAr,-l])  polygon([[0,0],[slit,0],  [width,layer+l],[0,layer+l]]); 
            rotate([0,0,0]) for(i=[0:1:4]) rotate([0,0,rag5*i]) rotate_extrude(angle=rag) translate([rAr-slit,-l]) square([width+slit,layer+1]);//  polygon([[0,0], [width,layer+l],[0,layer+l]]);  
            }                    
            rotate_extrude(angle=360) translate([rAr,layer/2])  circle(d=0.8);            
        }               
        rotate_extrude(angle=360) translate([rAr+0.2,layer*2+1.2]) circle(d=1.5);        
    }
}
     
module getPrintRing(modul,zahnzahl,breite=4.4,randbreite=2,diff = 0.2){   
 
    translate([0,0,0.8]) pfeilhohlrad_(modul = modul, zahnzahl=zahnzahl, breite=breite-0.8, randbreite=randbreite, eingriffswinkel=20, schraegungswinkel=0,dd_diff=diff,spiel_val=0.1);
    for(i=[0:1:4])
    translate([0,0,0.2*i]) pfeilhohlrad_(modul = modul, zahnzahl=zahnzahl, breite=0.2, randbreite=randbreite, eingriffswinkel=20, schraegungswinkel=0,dd_diff=diff,spiel_val=1.3-0.3*i);
}
    
module ringBLib( rAr,width,layer,slit,t=0){
    k = 0.6;
    l = layer+k;
    rA = rAr+width;
    ran = ( (rA*2*PI)/5); 
    rag =floor( 360/ran);
    rag5 = 360/5;
    
    translate([0,0,-1.8]){
        //rotate_extrude() translate([9.75,0]) square([rA -9.75,1],center=false); 
        
        translate([0,0,1]) difference(){
            rotate_extrude(angle=360) translate([rAr+slit,0]) polygon([[0,0], [width-slit,0 ], [width+width/2,layer ],[width+width/2,layer*2+3],[width,layer*2+3] ,[width,layer] ,[t,layer ]]);//square([width,layer]);
          
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

module libAm(s,n,m,tag){
    w=1.4;
     c = s*m/2+m*2;
    h_=4;
    difference(){
        union(){
            for(i=[0:1:2]) translate(pol_zu_kart([centerRing,120*i])) {
            //translate([0,0,0]) planetA(Agear[1],modA,  4,0,0,test=true );
               difference(){
                   pfeilhohlrad_(modul = m, zahnzahl=n, breite=h_, randbreite=w, eingriffswinkel=20, schraegungswinkel=0,dd_diff=0.1,spiel_val=0.3);
                   rotate([0,0,360/3*i]){
                       rotate([0,0,-160/2])  rotate_extrude(angle=160) translate([n*m/2-m,0]) square([w+m*3,h_],center=false);
                       //rotate([0,0,-50/2+180])  rotate_extrude(angle=50) translate([n*m/2-m,0]) square([w+m*3,h_],center=false);
                   }
               }               
            }            
            translate([0,0,h_/2]) cube([2.5,2.5,h_],center=true);
        }
        translate([0,0,4-0.6]) letter(tag,size=3);
    }
}

module letter(l,size=2) {
    font = "Liberation Sans"; //["Liberation Sans", "Liberation Sans:style=Bold", "Liberation 
    //cube_size = 60;
    //letter_size = 50;
    letter_height = 0.6;
    linear_extrude(height = letter_height) {
        text(l, size = size, font = font, halign = "center", valign = "center", $fn = 16);
    }
}