
double FIRE_finc   = 1.1; 
double FIRE_fdec   = 0.5;
double FIRE_falpha = 0.99;

double FIRE_dtmax=0.001;  double FIRE_dt    = FIRE_dtmax;
double FIRE_acoef0=0.1;    double FIRE_acoef = FIRE_acoef0;
  
double move_FIREtrue( double [][] Cs, double [][] fCs,  double [][] vCs  ){

  double []  xs =  Cs[0];
  double []  ys =  Cs[1];
  double [] vxs = vCs[0];
  double [] vys = vCs[1];
  double [] fxs = fCs[0];
  double [] fys = fCs[1];
    
    double ff = 0, vv = 0, vf = 0; 
    // evaluate norms
    for (int i=2;i<(ncoef-2);i++){ 
      double vxi = vxs[i];
      double fxi = fxs[i];
      double vyi = vys[i];
      double fyi = fys[i];
      ff += fxi*fxi + fyi*fyi;
      vv += vxi*vxi + vyi*vyi;
      vf += vxi*fxi + vyi*fyi;
    }  
    // update params
    if( vf<0 ) {
      for (int i=2;i<(ncoef-2);i++){  vxs[i]    = 0;  vys[i]    = 0;  }
      FIRE_dt    *= FIRE_fdec;
      FIRE_acoef  = FIRE_acoef0;
    }else {
      double cF =     FIRE_acoef* Math.sqrt(vv/ff);
      double cV = 1.0-FIRE_acoef;
      for (int i=0; i<xs.length; i++ ){  vxs[i]    = vxs[i]*cV  + cF*fxs[i];   vys[i]    = vys[i]*cV  + cF*fys[i];  }
      FIRE_dt = Math.min( FIRE_dt*FIRE_finc, FIRE_dtmax ); 
      FIRE_acoef *= FIRE_falpha;
    }
    // normal MD step
    for (int i=2;i<(ncoef-2);i++){
      double vxi    = vxs[i] + fxs[i]*FIRE_dt;
      double vyi    = vys[i] + fys[i]*FIRE_dt;
            vxs[i]  = vxi;
            vys[i]  = vyi;
            xs[i] += vxi*FIRE_dt;
            ys[i] += vyi*FIRE_dt;
    }
    return ff;
}

