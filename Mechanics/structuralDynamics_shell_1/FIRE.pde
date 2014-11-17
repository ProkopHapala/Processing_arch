static double FIRE_finc   = 1.1; 
double FIRE_fdec   = 0.5;
double FIRE_falpha = 0.99;
int    FIRE_Nmin   = 5;

static double FIRE_dtmax=dt, FIRE_dt=dt;
static double FIRE_acoef,FIRE_acoef0;

  
void move_FIRE(){  
  // ==== Fire step
  double ff = 0, vv = 0, vf = 0; 
  // evaluate norms
  for ( Vertex ver : verticles){              
    ff+= sq(ver.fx)+sq(ver.fy)+sq(ver.fz);
    vv+= sq(ver.vx)+sq(ver.vy)+sq(ver.vz);
    vf+=   ver.vx * ver.fx   +   ver.vy * ver.fy    +    ver.vz*ver.fz;
  }
  // update params
  //println( vf +" "+ff+" "+vf );
  if( vf<0 ) {
    for ( Vertex ver : verticles ){ ver.vx=0; ver.vy=0; ver.vz=0;  }
    FIRE_dt   *= FIRE_fdec;
    //println( " FIRE_dt down to: " + FIRE_dt );
    FIRE_acoef = FIRE_acoef0;
  }else {
    double cF =     FIRE_acoef* Math.sqrt(vv/ff);
    double cV = 1.0-FIRE_acoef;
    for ( Vertex ver : verticles ){ 
      ver.vx = ver.vx*cV + ver.fx*cF ; 
      ver.vy = ver.vy*cV + ver.fy*cF ; 
      ver.vz = ver.vz*cV + ver.fz*cF ; 
    }
    //for ( BasicBody b : bodies){ b.v.mul(cV);  b.v.fma(b.f, cF );  }
    //for (int i=0; i<xs.length; i++ ){  vs[i]    = vs[i]*cV  + cF*fs[i];  }
    FIRE_dt = Math.min( FIRE_dt*FIRE_finc, FIRE_dtmax ); 
    FIRE_acoef *= FIRE_falpha;
  }
  // normal MD step
  for ( Vertex ver : verticles ){ ver.move( FIRE_dt ); }
}

