
final float sx( double f   ){
  return (float)f*390+400;
}

final float sy( double f   ){
  return 400-(float)f*390;
}

final float evalRe(float Vinf,  float x){
   return  Vinf * x *70000.0;
}


float DragScale = 10.0;
float LiftScale = 1.0;
void plotPolar ( float [] Cl, float [] Cd ){
 float LDmax=-10000000; float Dmin=10000000;
 int iLDmax=0; int iDmin=0;
 for (int ialfa=0; ialfa<Cl.length; ialfa++ ){
    //println(sx(-WingS1.Cd_tot[ialfa])+"   "+ sy(WingS1.Cl_tot[ialfa]*0.1) );
    strokeWeight(3);
    point(sx(Cd[ialfa]*DragScale),400+sy(Cl[ialfa]*LiftScale));
    strokeWeight(1);
    if(ialfa>0) line(sx(Cd[ialfa]*DragScale),400+sy(Cl[ialfa]*LiftScale),sx(Cd[ialfa-1]*DragScale),400+sy(Cl[ialfa-1]*LiftScale) );
    if((Cl[ialfa]/Cd[ialfa])>LDmax) {LDmax=(Cl[ialfa]/Cd[ialfa]); iLDmax = ialfa; };
    if(Cd[ialfa]<Dmin) {Dmin=Cd[ialfa]; iDmin = ialfa; };
 }
 ellipse(               sx(Cd[iDmin ]*DragScale),400+sy(Cl[iDmin ]*LiftScale)  ,5,5);
 text( nf(Dmin,1,4)   , sx(Cd[iDmin ]*DragScale),400+sy(Cl[iDmin ]*LiftScale)      );
 //line(400,400,           sx(Cd[iLDmax]*DragScale),400+sy(Cl[iLDmax]*LiftScale)   );
 ellipse(               sx(Cd[iLDmax]*DragScale),400+sy(Cl[iLDmax]*LiftScale) ,5,5);
 text( nfc(LDmax,1) ,   sx(Cd[iLDmax]*DragScale),400+sy(Cl[iLDmax]*LiftScale)      );
}


float AlfaScale = 0.1;

void plotVsAlfa ( float [] C, float ValScale ){
 float Cmax=-10000000; float Cmin=10000000;
 int iCmax=0; int iCmin=0;
 for (int ialfa=0; ialfa<C.length; ialfa++ ){
    float alfa = ialfa*ALFA_STEP;
    strokeWeight(3);
    point(-400+sx(alfa*AlfaScale),400+sy(C[ialfa]*ValScale));
    strokeWeight(1);
    if(ialfa>0) line(sx(alfa*AlfaScale)-400,400+sy(C[ialfa]*ValScale),sx((alfa-ALFA_STEP)*AlfaScale)-400,400+sy(C[ialfa-1]*ValScale) );
    if( C[ialfa]>Cmax ) {Cmax=C[ialfa]; iCmax = ialfa; };     if( C[ialfa]<Cmin ) {Cmin=C[ialfa]; iCmin = ialfa; };
 }
 ellipse(               sx(-400+AlfaScale*iCmin*ALFA_STEP) ,400+sy(  C[iCmin ]*ValScale)  ,5,5);
 text( nf(Cmin,1,4)   , sx(-400+AlfaScale*iCmin*ALFA_STEP) ,400+sy(   C[iCmin ]*ValScale)      );
 //line(400,400,           sx(Cd[iLDmax]*DragScale),400+sy(Cl[iLDmax]*LiftScale)   );
 ellipse(               sx(-400+AlfaScale*iCmax*ALFA_STEP ),400+sy(C[iCmax]*ValScale) ,5,5);
 text( nf(Cmax,1,4) ,   sx(-400+AlfaScale*iCmax*ALFA_STEP ),400+sy(C[iCmax]*ValScale)      );
}


