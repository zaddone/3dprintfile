use <Getriebe.scad>
use <GetTest.scad>
$fn=100;
T=false;
Agear = [10,26,0.5];
Bgear = [11,25,0.5];

centerRing = (Agear[0]+Agear[1])/2 * Agear[2];
plantFix(5,false);
slit = 0.2;
!plant(Agear[1],Bgear[1],Agear[2]);
module plant(a,b,n){
    o =5;
    difference(){
        union(){
            gearBase(a,5,0.1,n,4,false,0.3);
            translate([0,0,-4]) gearBase(b,5,0.1,n,4,false,0.3);
        }
        translate([0.5,0,0]) cube([o,o/2,8],center=true);
    }
}
module plantFix(o=5,show = true){
    ar = 360/3;
    o = o-slit*2;
    if (show) {
       translate([0,0,4])  for(i=[0:1:2]) translate(pol_zu_kart([centerRing,ar*i]))   plant(Agear[1],Bgear[1],Agear[2]);
    }
    
    for(i=[0:1:2]) translate(pol_zu_kart([centerRing,ar*i])) union(){
        cylinder(d=o,h=5,center=true);
        translate([0.5,0,0]) cube([o,o/2,5],center=true);
    }
    translate([0,0,-0.5]) rotate_extrude() translate([centerRing,-1.5]) square([o,1],center=true);
    
}
 
module gearBase(n=23,bo=6.2,diff=0.1,mod =0.5,breite=4,test=T,k=0.3){
    fans=0;
    eing=20;
    
    //k=0.3;
    spiel_val = 0.1;
    //m = k/0.2;
    //a=sin(45)*k*2 ;
    if (test){
        stirnrad_(modul= mod, zahnzahl=n, breite=breite , bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans);
    }else{
    stirnrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff+k*2,spiel_val=spiel_val);
    translate([0,0,0.2]) stirnrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff+k,spiel_val=spiel_val);
    
    translate([0,0,0.4]) stirnrad_(modul= mod, zahnzahl=n, breite=breite-0.8, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff,spiel_val=spiel_val);
    
    translate([0,0,breite-0.4]) stirnrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff+k,spiel_val=spiel_val);
    translate([0,0,breite-0.2]) stirnrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=-fans,dd_diff=diff+k*2,spiel_val=spiel_val);
   
    }
    //for(i=[0:1:m-1]) translate([0,0,(k-0.2) - i*0.2]) pfeilrad_(modul= mod, zahnzahl=n, breite=0.2, bohrung=bo, eingriffswinkel=eing, schraegungswinkel=fans,dd_diff=diff+a*i,spiel_val=0.1); 
    
}
function pol_zu_kart(polvect) = [
	polvect[0]*cos(polvect[1]),  
	polvect[0]*sin(polvect[1])
];