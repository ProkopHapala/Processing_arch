final float acoef0 = 0.1;
float acoef = acoef0; 

final float finc   = 1.1; 
final float fdec   = 0.5;
final float falpha = 0.99;
final int   Nmin   = 5;

int cutiter;

void Move_FIRE(){
    float normV = sqrt(sAB( V, V));
    float normF = sqrt(sAB( F, F));
    float cosVF = sAB( V, F)/(normV*normF);
    print ( " normV "+normV+" normF "+normF+" cosVF "+cosVF );
    // V = (1-a)*V + a*F*norm(V)/norm(F)
    multAf ( V,    (1.0-acoef)       );
    adAcB  ( V, F, acoef*normV/normF );
    if( cosVF<0 ) {
      setAf(V,0.0);
      cutiter = iter;
      dt   *= fdec;
      acoef = acoef0;
    }else {
     // if( (iter-cutiter)>Nmin) {
        dt = min( dt*finc, dtmax ); 
        acoef *= falpha;
     // }
    }
  
  adAcB(V,F,dt);   // apply force
  adAcB(R,V,dt);   // move 
  
  float dE = E - oE; float odE=oE-ooE;

}

