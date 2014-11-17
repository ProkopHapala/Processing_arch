
class Opt_FIRE_o extends OptMD {
  
float cosmin    = -0.25;  
float orto_damp =  1.0;  
float finc      = 1.1; 
float fdec      = 0.5;
float falpha    = 0.99;
int   Nmin      = 5;

float dtmax,dtmin;
float acoef,acoef0;

float Emin=10000000; 
int  nEnotDown=0;
int  maxEnotDown=1000;

float [] xsmin;

int cutiter;
  
  Opt_FIRE_o( float dt, float damp, float [] xs0, OptProblem problem ){
    super( dt, damp, xs0, problem );
    xsmin = new float [xs.length];
    this.dt=dtmax = dt;
    dtmin=0.1*dtmax;
    acoef=acoef0  = damp; 
  }

  void move(){
    if( nEnotDown > maxEnotDown ){ 
      nEnotDown = 0;
      for (int i=0; i<xs.length; i++ ){
        xs[i] = xsmin[i]; 
        vs[i] = 0;
        
      }
    } 
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
      float  cF = vf/ff;
      float cosvf = vf/sqrt(vv*ff);
      //stroke(1,0,0); line( x2s(xs[0]),x2s(xs[1]), x2s(xs[0]+vs[0]),x2s(xs[1]+vs[1]) );
      //stroke(0,0,1); line( x2s(xs[0]),x2s(xs[1]), x2s(xs[0]+fs[0]),x2s(xs[1]+fs[1]) );
      for (int i=0; i<xs.length; i++ ){  
        float vIIf = fs[i]*cF;
        //println( " >> "+ vs[i]+" "+(vs[i]-vIIf)+"  c "  );
        //vs[i]  = (vs[i] - vIIf)*orto_damp; 
        vs[i]  = (vs[i] - vIIf)*abs(cosvf); 
        //vs[i]  = (vs[i] - vIIf)*cosvf*cosvf; 
      }  
      //stroke(0,1,0); line( x2s(xs[0]),x2s(xs[1]), x2s(xs[0]+vs[0]),x2s(xs[1]+vs[1]) );
      if( cosvf< cosmin ){
        dt    = max( dtmin, dt*fdec);
        acoef = acoef0;
      }  
    }else {
      float cF =     acoef* sqrt(vv/ff);
      float cV = 1.0-acoef;
      for (int i=0; i<xs.length; i++ ){  vs[i]    = vs[i]*cV  + cF*fs[i];  }
      dt = min( dt*finc, dtmax ); 
      acoef *= falpha;
    }
    println(" E "+E+" Emin "+Emin+" nEnotDown "+nEnotDown );
    /*
    if( nEnotDown > maxEnotDown ){ 
      nEnotDown = 0;
      for (int i=0; i<xs.length; i++ ){ vs[i] = 0; }
    }
    */
    if(E<Emin){ 
      Emin=E; nEnotDown=0;
      for (int i=0; i<xs.length; i++ ){ xsmin[i]=xs[i]; }
    }else{ nEnotDown++; }
    // normal MD step
    for (int i=0; i<xs.length; i++ ){
      float vi     = vs[i] + fs[i]*dt;
            vs[i]  = vi;
            xs[i] += vi*dt;
    }
  }

}

