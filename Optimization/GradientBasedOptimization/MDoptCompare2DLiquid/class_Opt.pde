
class OptMD {
  
  color clr;
  
  int nevals;
  float dt;
  float damp;
  
  float of2=1.0,f2,E,oE;
  float [] xs,vs,fs;
  
  float [] oxs; // just for plotting
  
  OptProblem problem;
    
  OptMD( float dt, float damp, float [] xs0, OptProblem problem ){
    create( dt, damp, xs0, problem );
  }
  
  void create( float dt, float damp, float [] xs0, OptProblem problem ){
    this.problem = problem; this.dt=dt; this.damp=damp;
    xs = new float[ xs0.length ];     oxs = new float[ xs0.length ];  
    vs = new float[ xs0.length ];
    fs = new float[ xs0.length ];
    for (int i=0; i<xs.length; i++ ){ xs[i] = xs0[i];  }
    nevals=0;
  }
  
  void updateForce(){
    for (int i=0; i<xs.length; i++ ){ oxs[i]=xs[i]; }
    E = problem.evaluate( xs, fs ); nevals++;
    of2=f2;f2=0;
    for (int i=0; i<xs.length; i++ ){ float fi=fs[i];  f2+=fi*fi; }
  }
  
  void move(){    
    updateForce();
    for (int i=0; i<xs.length; i++ ){
      float vi = vs[i];
      //println(" vi "+vi+" 1.0-damp "+(1.0-damp));
      vi       = vi*(1.0-damp) + fs[i]*dt;
      vs[i]    = vi;
      xs[i]   += vi*dt;
    }
  }
  
  void kickStart(float dt ){
    updateForce();
    for (int i=0; i<xs.length; i++ ){
      float vi = vs[i];
      vi      += fs[i]*dt;
      vs[i]    = vi;
      xs[i]   += vi*dt;
    }
  }
  
  void plot( ){
    overlay.stroke(clr);
    overlay.line( frameCount-1, 100 - 10*log(of2), frameCount,  100 - 10*log(f2)     );
    
    //overlay.line( iter-1, 200 - 0.1*E, iter,  200 - 0.1*E     );
    //println( " Ediff = " + (oE-Emin) + " "+(E-Emin)+" "+E+" "+Emin );
    overlay.line( frameCount-1, 400 - 10*log(oE-EminGlob+0.0001), frameCount,  400 - 10*log(E-EminGlob+0.0001)     );
    oE=E;
  }

}
