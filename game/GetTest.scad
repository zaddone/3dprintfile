use <Getriebe.scad>
pi = 3.14159;
rad = 57.29578;
spiel = 0.05;	
$fn=200;
//module_val = 0.5;

dd_diff_val = 0;
//da_diff = 1.8;
//df_diff = 0.02;

module getPrintRing(modul,zahnzahl,breite=4.4,randbreite=2,diff = 0.2){   
     
    translate([0,0,0.8]) hohlrad_(modul = modul, zahnzahl=zahnzahl, breite=breite-0.8, randbreite=randbreite, eingriffswinkel=20, schraegungswinkel=0,dd_diff=diff,spiel_val=0.1);
    for(i=[0:1:4])
    translate([0,0,0.2*i]) hohlrad_(modul = modul, zahnzahl=zahnzahl, breite=0.2, randbreite=randbreite, eingriffswinkel=20, schraegungswinkel=0,dd_diff=diff,spiel_val=1.3-0.3*i);
}

module stirnrad_(modul, zahnzahl, breite, bohrung, eingriffswinkel = 20, schraegungswinkel = 0, dd_diff = dd_diff_val,spiel_val =spiel) {

	// Dimensions-Berechnungen	
	d = modul * zahnzahl -dd_diff;											// Teilkreisdurchmesser
	r = d / 2;														// Teilkreisradius
	alpha_stirn = atan(tan(eingriffswinkel)/cos(schraegungswinkel));// Schrägungswinkel im Stirnschnitt
	db = d * cos(alpha_stirn);										// Grundkreisdurchmesser
	rb = db / 2;													// Grundkreisradius
	da = (modul <1)? d + modul * 2.2 : d + modul * 2;				// Kopfkreisdurchmesser nach DIN 58400 bzw. DIN 867
	//da =  d + modul * da_diff;	
    ra = da / 2;													// Kopfkreisradius
	c =  (zahnzahl <3)? 0 : modul/6;								// Kopfspiel
	df = d - 2 * (modul + c);										// Fußkreisdurchmesser
	rf = df / 2;													// Fußkreisradius
	rho_ra = acos(rb/ra);											// maximaler Abrollwinkel;
																	// Evolvente beginnt auf Grundkreis und endet an Kopfkreis
	rho_r = acos(rb/r);												// Abrollwinkel am Teilkreis;
																	// Evolvente beginnt auf Grundkreis und endet an Kopfkreis
	phi_r = grad(tan(rho_r)-radian(rho_r));							// Winkel zum Punkt der Evolvente auf Teilkreis
	gamma = rad*breite/(r*tan(90-schraegungswinkel));				// Torsionswinkel für Extrusion
	schritt = rho_ra/16;											// Evolvente wird in 16 Stücke geteilt
	tau = 360/zahnzahl;												// Teilungswinkel
	
	r_loch = (2*rf - bohrung)/8;									// Radius der Löcher für Material-/Gewichtsersparnis
	rm = bohrung/2+2*r_loch;										// Abstand der Achsen der Löcher von der Hauptachse
	z_loch = floor(2*pi*rm/(3*r_loch));								// Anzahl der Löcher für Material-/Gewichtsersparnis
	
	//optimiert = (optimiert && r >= breite*1.5 && d > 2*bohrung);	// ist Optimierung sinnvoll?

	// Zeichnung
	union(){
		rotate([0,0,-phi_r-90*(1-spiel_val)/zahnzahl]){						// Zahn auf x-Achse zentrieren;
																		// macht Ausrichtung mit anderen Rädern einfacher

			linear_extrude(height = breite, twist = gamma){
				difference(){
					union(){
						zahnbreite = (180*(1-spiel_val))/zahnzahl+2*phi_r;
						circle(rf);										// Fußkreis	
						for (rot = [0:tau:360]){
							rotate (rot){								// "Zahnzahl-mal" kopieren und drehen
								polygon(concat(							// Zahn
									[[0,0]],							// Zahnsegment beginnt und endet im Ursprung
									[for (rho = [0:schritt:rho_ra])		// von null Grad (Grundkreis)
																		// bis maximalen Evolventenwinkel (Kopfkreis)
										pol_zu_kart(ev(rb,rho))],		// Erste Evolventen-Flanke

									[pol_zu_kart(ev(rb,rho_ra))],		// Punkt der Evolvente auf Kopfkreis

									[for (rho = [rho_ra:-schritt:0])	// von maximalen Evolventenwinkel (Kopfkreis)
																		// bis null Grad (Grundkreis)
										pol_zu_kart([ev(rb,rho)[0], zahnbreite-ev(rb,rho)[1]])]
																		// Zweite Evolventen-Flanke
																		// (180*(1-spiel)) statt 180 Grad,
																		// um Spiel an den Flanken zu erlauben
									)
								);
							}
						}
					}			
					circle(r = rm+r_loch*1.49);							// "Bohrung"
				}
			}
		}
		// mit Materialersparnis

			linear_extrude(height = breite){
				difference(){
					circle(r = rm+r_loch*1.61);
					circle(r = bohrung/2);
				}
			}
    
		 
	}
}
module pfeilrad_(modul=0.5, zahnzahl=0, breite=0, bohrung=0, eingriffswinkel = 20, schraegungswinkel=0, dd_diff = dd_diff_val,spiel_val =spiel){

	breite = breite/2;
	d = modul * zahnzahl - dd_diff;											// Teilkreisdurchmesser
	r = d / 2;														// Teilkreisradius
	c =  (zahnzahl <3)? 0 : modul/6;								// Kopfspiel

	df = d - 2 * (modul + c);										// Fußkreisdurchmesser
	rf = df / 2;													// Fußkreisradius

	r_loch = (2*rf - bohrung)/8;									// Radius der Löcher für Material-/Gewichtsersparnis
	rm = bohrung/2+2*r_loch;										// Abstand der Achsen der Löcher von der Hauptachse
	z_loch = floor(2*pi*rm/(3*r_loch));								// Anzahl der Löcher für Material-/Gewichtsersparnis
	
	//optimiert = (optimiert && r >= breite*3 && d > 2*bohrung);		// ist Optimierung sinnvoll?

	translate([0,0,breite]){
		union(){
			stirnrad_(modul, zahnzahl, breite, 2*(rm+r_loch*1.49), eingriffswinkel, schraegungswinkel,dd_diff,spiel_val);		// untere Hälfte
			mirror([0,0,1]){
				stirnrad_(modul, zahnzahl, breite, 2*(rm+r_loch*1.49), eingriffswinkel, schraegungswinkel,dd_diff,spiel_val);	// obere Hälfte
			}
		}
	}
	// mit Materialersparnis
	 
		linear_extrude(height = breite*2){
			difference(){
				circle(r = rm+r_loch*1.51);
				circle(r = bohrung/2);
			}
		}
	 
}
module hohlrad_(modul, zahnzahl, breite, randbreite, eingriffswinkel = 20, schraegungswinkel = 0, dd_diff=dd_diff_val,spiel_val =spiel) {

	// Dimensions-Berechnungen	
	ha = (zahnzahl >= 20) ? 0.02 * atan((zahnzahl/15)/pi) : 0.6;	// Verkürzungsfaktor Zahnkopfhöhe
	d = modul * zahnzahl + dd_diff;											// Teilkreisdurchmesser
	r = d / 2;														// Teilkreisradius
	alpha_stirn = atan(tan(eingriffswinkel)/cos(schraegungswinkel));// Schrägungswinkel im Stirnschnitt
	db = d * cos(alpha_stirn);										// Grundkreisdurchmesser
	rb = db / 2;													// Grundkreisradius
	c = modul / 6;													// Kopfspiel
	da = (modul <1)? d + (modul+c) * 2.2 : d + (modul+c) * 2;		// Kopfkreisdurchmesser
	ra = da / 2;													// Kopfkreisradius
	df = d - 2 * modul * ha;										// Fußkreisdurchmesser
	rf = df / 2;													// Fußkreisradius
	rho_ra = acos(rb/ra);											// maximaler Evolventenwinkel;
																	// Evolvente beginnt auf Grundkreis und endet an Kopfkreis
	rho_r = acos(rb/r);												// Evolventenwinkel am Teilkreis;
																	// Evolvente beginnt auf Grundkreis und endet an Kopfkreis
	phi_r = grad(tan(rho_r)-radian(rho_r));							// Winkel zum Punkt der Evolvente auf Teilkreis
	gamma = rad*breite/(r*tan(90-schraegungswinkel));				// Torsionswinkel für Extrusion
	schritt = rho_ra/16;											// Evolvente wird in 16 Stücke geteilt
	tau = 360/zahnzahl;												// Teilungswinkel

	// Zeichnung
	rotate([0,0,-phi_r-90*(1+spiel_val)/zahnzahl])						// Zahn auf x-Achse zentrieren;
																	// macht Ausrichtung mit anderen Rädern einfacher
	linear_extrude(height = breite, twist = gamma){
		difference(){
			circle(r = ra + randbreite);							// Außenkreis
			union(){
				zahnbreite = (180*(1+spiel_val))/zahnzahl+2*phi_r;
				circle(rf);											// Fußkreis	
				for (rot = [0:tau:360]){
					rotate (rot) {									// "Zahnzahl-mal" kopieren und drehen
						polygon( concat(
							[[0,0]],
							[for (rho = [0:schritt:rho_ra])			// von null Grad (Grundkreis)
																	// bis maximaler Evolventenwinkel (Kopfkreis)
								pol_zu_kart(ev(rb,rho))],
							[pol_zu_kart(ev(rb,rho_ra))],
							[for (rho = [rho_ra:-schritt:0])		// von maximaler Evolventenwinkel (Kopfkreis)
																	// bis null Grad (Grundkreis)
								pol_zu_kart([ev(rb,rho)[0], zahnbreite-ev(rb,rho)[1]])]
																	// (180*(1+spiel)) statt 180,
																	// um Spiel an den Flanken zu erlauben
							)
						);
					}
				}
			}
		}
	}
	
}
module pfeilhohlrad_(modul, zahnzahl, breite, randbreite, eingriffswinkel = 20, schraegungswinkel = 0,dd_diff =dd_diff_val,spiel_val =spiel ) {

	breite = breite / 2;
	translate([0,0,breite])
		union(){
		hohlrad_(modul, zahnzahl, breite, randbreite, eingriffswinkel, schraegungswinkel,dd_diff,spiel_val);		// untere Hälfte
		mirror([0,0,1])
			hohlrad_(modul, zahnzahl, breite, randbreite, eingriffswinkel, schraegungswinkel,dd_diff,spiel_val);	// obere Hälfte
	}
}

module planetengetriebe_(modul, zahnzahl_sonne, zahnzahl_planet, anzahl_planeten, breite, randbreite, bohrung, eingriffswinkel=20, schraegungswinkel=0,dd_diff =dd_diff_val,spiel_val =spiel ){

	// Dimensions-Berechnungen
	d_sonne = modul*zahnzahl_sonne;										// Teilkreisdurchmesser Sonne
	d_planet = modul*zahnzahl_planet;									// Teilkreisdurchmesser Planeten
	achsabstand = modul*(zahnzahl_sonne +  zahnzahl_planet) / 2;		// Abstand von Sonnenrad-/Hohlradachse und Planetenachse
	zahnzahl_hohlrad = zahnzahl_sonne + 2*zahnzahl_planet;				// Anzahl der Zähne des Hohlrades
    d_hohlrad = modul*zahnzahl_hohlrad;									// Teilkreisdurchmesser Hohlrad

	drehen = istgerade(zahnzahl_planet);								// Muss das Sonnenrad gedreht werden?
		
	n_max = floor(180/asin(modul*(zahnzahl_planet)/(modul*(zahnzahl_sonne +  zahnzahl_planet))));
																		// Anzahl Planetenräder: höchstens so viele, wie ohne
																		// Überlappung möglich

	// Zeichnung
	rotate([0,0,180/zahnzahl_sonne*drehen]){
		pfeilrad_ (modul, zahnzahl_sonne, breite, bohrung, eingriffswinkel, -schraegungswinkel,dd_diff ,spiel_val );		// Sonnenrad
	}

 
        if(anzahl_planeten==0){
            list = [ for (n=[2 : 1 : n_max]) if ((((zahnzahl_hohlrad+zahnzahl_sonne)/n)==floor((zahnzahl_hohlrad+zahnzahl_sonne)/n))) n];
            anzahl_planeten = list[0];										// Ermittele Anzahl Planetenräder
             achsabstand = modul*(zahnzahl_sonne + zahnzahl_planet)/2;		// Abstand von Sonnenrad-/Hohlradachse
            for(n=[0:1:anzahl_planeten-1]){
                translate(kugel_zu_kart([achsabstand,90,360/anzahl_planeten*n]))
					rotate([0,0,n*360*d_sonne/d_planet])
						pfeilrad_ (modul, zahnzahl_planet, breite, bohrung, eingriffswinkel, schraegungswinkel,dd_diff ,spiel_val );	// Planetenräder
            }
       }
       else{
            achsabstand = modul*(zahnzahl_sonne + zahnzahl_planet)/2;		// Abstand von Sonnenrad-/Hohlradachse
            for(n=[0:1:anzahl_planeten-1]){
                translate(kugel_zu_kart([achsabstand,90,360/anzahl_planeten*n]))
                rotate([0,0,n*360*d_sonne/(d_planet)])
                    pfeilrad_ (modul, zahnzahl_planet, breite, bohrung, eingriffswinkel, schraegungswinkel,dd_diff ,spiel_val  );	// Planetenräder
            }
		}
	 

	pfeilhohlrad_ (modul, zahnzahl_hohlrad, breite, randbreite, eingriffswinkel, schraegungswinkel,dd_diff  ,spiel_val  ); // Hohlrad

}
 