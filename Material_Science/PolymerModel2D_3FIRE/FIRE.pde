static double FIRE_finc   = 1.1; 
double FIRE_fdec   = 0.5;
double FIRE_falpha = 0.99;
int    FIRE_Nmin   = 5;

static double FIRE_dtmax, FIRE_dt=dt;
static double FIRE_acoef,FIRE_acoef0;

  
void move_FIRE(){
  // ==== Fire step
  double ff = 0, vv = 0, vf = 0; 
  // evaluate norms
  for ( Atom a : atoms ){
    if(!a.fixed){    
      ff += a.fx*a.fx + a.fy*a.fy;
      vv += a.vx*a.vx + a.vy*a.vy;
      vf += a.vx*a.fx + a.vy*a.fy;
    }
  }
  // update params
  if( vf<0 ) {
    for ( Atom a : atoms ){ a.vx = 0; a.vy = 0;  }
    FIRE_dt   *= FIRE_fdec;
    FIRE_acoef = FIRE_acoef0;
  }else {
    double cF =     FIRE_acoef* Math.sqrt(vv/ff);
    double cV = 1.0-FIRE_acoef;
    for ( Atom a : atoms ){ 
      a.vx = a.vx*cV + a.fx*cF;
      a.vy = a.vy*cV + a.fy*cF;
    }
    //for (int i=0; i<xs.length; i++ ){  vs[i]    = vs[i]*cV  + cF*fs[i];  }
    FIRE_dt = Math.min( FIRE_dt*FIRE_finc, FIRE_dtmax ); 
    FIRE_acoef *= FIRE_falpha;
  }
  // normal MD step
  for ( Atom a : atoms ){ a.move(); }
}

