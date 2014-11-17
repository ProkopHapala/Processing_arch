static double FIRE_finc   = 1.1; 
double FIRE_fdec   = 0.5;
double FIRE_falpha = 0.99;
int    FIRE_Nmin   = 5;

static double FIRE_dtmax, FIRE_dt=dt;
static double FIRE_acoef,FIRE_acoef0;

  
void move_FIRE(){
  // ==== Update Force
  for ( Link lnk : links)    { lnk.assertForce(); }
  // boundary conditions 
  for ( int ir=0; ir<nR; ir++ ){
    bodies[ 2*( ir + (nL-1)*nR )    ].f.add( fend );
    bodies[ 2*( ir + (nL-1)*nR ) +1 ].f.add( fend );
   }
  
  // ==== Fire step
  double ff = 0, vv = 0, vf = 0; 
  // evaluate norms
  for ( BasicBody b : bodies){              
    ff+= b.f.dot();
    vv+= b.v.dot();
    vf+= b.v.dot(b.f);
  }
  // update params
  if( vf<0 ) {
    for ( BasicBody b : bodies){ b.v.set(0); }
    FIRE_dt   *= FIRE_fdec;
    FIRE_acoef = FIRE_acoef0;
  }else {
    double cF =     FIRE_acoef* Math.sqrt(vv/ff);
    double cV = 1.0-FIRE_acoef;
    for ( BasicBody b : bodies){ b.v.mul(cV);  b.v.fma(b.f, cF );  }
    //for (int i=0; i<xs.length; i++ ){  vs[i]    = vs[i]*cV  + cF*fs[i];  }
    FIRE_dt = Math.min( FIRE_dt*FIRE_finc, FIRE_dtmax ); 
    FIRE_acoef *= FIRE_falpha;
  }
  // normal MD step
  for ( BasicBody b : bodies){ b.move(); }
}

