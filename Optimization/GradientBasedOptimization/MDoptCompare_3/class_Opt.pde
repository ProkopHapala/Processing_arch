
class OptMD {
  
  int nevals;
  float dt;
  float damp;
  
  float of2=1.0,f2,E,oE;
  float [] xs,vs,fs;
  
  float [] oxs; // just for plotting
  
  ScalarFunction func;
    
  OptMD( float dt, float damp, float [] xs0, ScalarFunction func ){
    create( dt, damp, xs0, func );
  }
  
  void create( float dt, float damp, float [] xs0, ScalarFunction func ){
    this.func = func; this.dt=dt; this.damp=damp;
    xs = new float[ xs0.length ];     oxs = new float[ xs0.length ];  
    vs = new float[ xs0.length ];
    fs = new float[ xs0.length ];
    for (int i=0; i<xs.length; i++ ){ xs[i] = xs0[i];  }
    nevals=0;
  }
  
  void updateForce(){
    for (int i=0; i<xs.length; i++ ){ oxs[i]=xs[i]; }
    oE=E;
    E = func.evaluate( xs, fs ); nevals++;
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
    //line( iter-1, 100 - 10*log(of2), iter,  100 - 10*log(f2)     );
    //println( " Ediff = " + (oE-Emin) + " "+(E-Emin)+" "+E+" "+Emin );
    line( iter-1, 100 - 50*log(oE-Emin+0.00000001), iter,  100 - 50*log(E-Emin+0.00000001)     );
    ellipse( x2s(xs[0]),x2s(xs[1]),2,2 );
    line( x2s(oxs[0]),x2s(oxs[1]), x2s(xs[0]),x2s(xs[1]) );
  }

}
