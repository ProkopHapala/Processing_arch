

final float dtmaxPro = 0.25;


void Move_FIREpro(){
    float normV = sqrt(sAB( V, V));
    float normF = sqrt(sAB( F, F));
    float cosVF = sAB( V, F)/(normV*normF);
    print ( " normV "+normV+" normF "+normF+" cosVF "+cosVF );
    if( cosVF<-0.1 ) {
      stroke(255,0,255);  line(R[0]*sz+sz,R[1]*sz+sz,R[0]*sz+sz+V[0]*100, R[1]*sz+sz+V[1]*100);
      multAf ( V, 0.5 );
      AcpB  ( Vp, V);  
      AparaB( Vp, F  );
      AortoB( V, F  );
      //adAcB ( V, Vp, -0.5  );  
      adAcB(V,F,0.5*dt);   // apply force
      stroke(0,255,255);  line(R[0]*sz+sz,R[1]*sz+sz,R[0]*sz+sz + V[0]*100, R[1]*sz+sz+V[1]*100);
      cutiter = iter;
      dt    *= 0.8;
      acoef *= min(1.2*acoef,acoef0);
    }else {
      // V = (1-a)*V + a*F*norm(V)/norm(F)
      multAf ( V,    (1.0-acoef)       );
      adAcB  ( V, F, acoef*normV/normF );
      adAcB(V,F,dt);   // apply force
      if( (iter-cutiter)>Nmin) {
        dt = min( dt*finc, dtmaxPro ); 
        acoef *= falpha;
      }
    }
  
 // adAcB(V,F,dt);   // apply force
  adAcB(R,V,dt);   // move 
  
  float dE = E - oE; float odE=oE-ooE;

}

