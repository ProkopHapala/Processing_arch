

class Opt_FIRE extends OptMD {
  
float finc   = 1.1; 
float fdec   = 0.5;
float falpha = 0.99;
int   Nmin   = 5;

float dtmax;
float acoef,acoef0;

int cutiter;
  
  Opt_FIRE( float dt, float damp, float [] xs0, OptProblem problem ){
    super( dt, damp, xs0,problem );
    this.dt=dtmax = dt;
    acoef=acoef0  = damp; 
  }

  void move(){
    updateForce();
    //println( " FIRE "+fs[0]+" "+fs[1]+" "+vs[0]+" "+vs[1] );
    float ff = 0, vv = 0, vf = 0; 
    // evaluate norms
    for (int i=0; i<xs.length; i++ ){
      float vi = vs[i];
      float fi = fs[i];
      ff+=fi*fi;
      vv+=vi*vi;
      vf+=vi*fi;
    }  
    // update params
    if( vf<0 ) {
      for (int i=0; i<xs.length; i++ ){  vs[i]    = 0;  }
      dt   *= fdec;
      acoef = acoef0;
    }else {
      float cF =     acoef* sqrt(vv/ff);
      float cV = 1.0-acoef;
      for (int i=0; i<xs.length; i++ ){  vs[i]    = vs[i]*cV  + cF*fs[i];  }
      dt = min( dt*finc, dtmax ); 
      acoef *= falpha;
    }
    // normal MD step
    for (int i=0; i<xs.length; i++ ){
      float vi     = vs[i] + fs[i]*dt;
            vs[i]  = vi;
            xs[i] += vi*dt;
    }
  }

}

