

// JAT: Java Astrodynamics Toolkit

public class Lambert implements ScalarFunction {

  double s,c,magr0,magrf; 
  
  double  dt = 0.0;
  double  mu = 0.0;
  boolean aflag = false;
  boolean bflag = false;
  double  [] r0, rf, v0, vf, dr;
  double  [] newv0, newvf, deltav0,deltavf;
  double  tof, dv0, dvf;
  double  a;
  
  int matIters = 10000;
  
  boolean debug=false;
  
  public Lambert( double mu ) { 
    this.mu = mu;
    dr  = new double[3]; 
    deltav0 = new double[3]; 
    deltavf = new double[3]; 
    newv0   = new double[3];
    newvf   = new double[3];
    double [] dr = new double[3];
  }
  
  public double compute( double [] r0, double [] v0, double [] rf, double [] vf, double dt) {
    init(r0, rf);
    double a = compute_a( dt );
    if (a>0){
      compute_endVelocity();
      return compute_dvCost( v0, vf );
    }else{ return a; }
  };
  
  public void init( double [] r0, double [] rf ){
    reset();
    this.r0 = r0;
    this.rf = rf;
    this.magr0 = double3_mag(r0);
    this.magrf = double3_mag(rf);
    double3_sub(r0,rf,dr);
    this.c = double3_mag(dr);
    this.s = (magr0 + magrf + c) / 2.0;
  }
  
  public double compute_a( double dt ){
    this.dt = dt;
    double tp = 0.0;
    double amin = s / 2.0;
    if(debug) println("amin = " + amin);
    double dtheta = Math.acos(  double3_dot(r0,rf) / (magr0 * magrf));
    // dtheta = 2.0 * Constants.pi - dtheta;
    if(debug) println("dtheta = " + dtheta);
    if (dtheta < Math.PI) { 
      tp = Math.sqrt(2.0 / (mu)) * (Math.pow(s, 1.5) - Math.pow(s - c, 1.5)) / 3.0;
    }
    if (dtheta >  Math.PI) {
      tp = Math.sqrt(2.0 / (mu)) * (Math.pow(s, 1.5) + Math.pow(s - c, 1.5)) / 3.0;
      this.bflag = true;
    }
    if(debug) println("tp = " + tp);
    double betam = getbeta(amin);
    double tm = getdt(amin, Math.PI, betam);
    if(debug) println("tm = " + tm);
    if (dtheta == Math.PI) { if(debug) println(" dtheta = 180.0. Do a Hohmann");      return -1;    }
    double ahigh = 1000.0 * amin;
    double npts = 3000.0;
    // this.dt = (2.70-0.89)*86400;
    if(debug) println("dt = " + dt);
    if (this.dt < tp) { if(debug) println("No elliptical path possible ");  return -2;   }
    if (this.dt > tm) {      this.aflag = true;    }
    double fm = evaluate(amin);
    double ftemp = evaluate(ahigh);
    if ((fm * ftemp) >= 0.0) { if(debug) println(" initial guesses do not bound "); return -3; }
    if(debug) println(" >>> ZeroFinding a(t) ... ");
    ZeroFinder zeroFinder = new ZeroFinder(this, matIters, 1.0E-6, 1.0E-15);
    double sma = zeroFinder.regulaFalsi(amin, ahigh);
    if ( !zeroFinder.converged  ) { if(debug) println(" solution not found in "+matIters+" iterations "); return -4; }
    if(debug) println(" >>> ... ZeroFinding DONE  ");
    if(debug) println(" a(t) = "+sma);
    this.a = sma; 
    this.tof = dt;
    return sma;
  }
  
  void compute_endVelocity( ){
    double alpha = getalpha(this.a);
    double beta  = getbeta(this.a);
    double de    = alpha - beta;
    double f = 1.0 - (this.a / magr0) * (1.0 - Math.cos(de));
    double g = dt - Math.sqrt(this.a * this.a * this.a / mu) * (de - Math.sin(de));

    newv0[0] = (rf[0] - f * r0[0]) / g;
    newv0[1] = (rf[1] - f * r0[1]) / g;
    newv0[2] = (rf[2] - f * r0[2]) / g;    
    if(debug) println( " v0 : "+ newv0 );
    
    double fdot = -1.0 * (Math.sqrt(mu * this.a) / (magr0 * magrf)) * Math.sin(de);
    double gdot = 1.0 - (this.a / magrf) * (1.0 - Math.cos(de));
    newvf[0] = fdot * r0[0] + gdot * newv0[0];
    newvf[1] = fdot * r0[1] + gdot * newv0[1];
    newvf[2] = fdot * r0[2] + gdot * newv0[2];
    if(debug) println( " vf : "+ newvf );
  }
  
  double compute_dvCost( double [] v0, double [] vf ){
    double3_sub(newv0,v0,deltav0 );
    this.dv0 = double3_mag(deltav0);
    if(debug) println( " deltav-0: "+ dv0 + " " + double3_toString(deltav0) );
    double3_sub(vf,newvf,deltavf);
    this.dvf = double3_mag(deltavf);
    if(debug) println( " deltav-0: "+ dvf + " " + double3_toString(deltavf) );
    double totaldv = dv0 + dvf;
    return totaldv;
  }

  public void reset() {
    s = 0.0;
    c = 0.0;
    aflag = false;
    bflag = false;
  //  debug_print = false;
  }





 // ============= Thiw will not change ========== 
  
  private double getalpha(double a) {
    double alpha = 2.0 * Math.asin(Math.sqrt(s / (2.0 * a))); //  asin(sqrt( uu )),     uu = ( |r0| + |rf| + c )/4a
    if (this.aflag) {
      alpha = 2.0 * Math.PI - alpha;
    }
    return alpha;
  }

  private double getbeta(double a) {
    double beta = 2.0 * Math.asin(Math.sqrt((s - c) / (2.0 * a)));   //  asin(sqrt( uu )),     uu = ( |r0| + |rf| - c )/4a         
    if (this.bflag) {
      beta = -1.0 * beta;
    }
    return beta;
  }

  private double getdt(double a, double alpha, double beta) {
    double sa = Math.sin(alpha);                                   // this is basically circle :  sin(2*asin(sqrt(x))) = 2*sqrt(0.25-(0.5-x)^2))
    double sb = Math.sin(beta);                                    // this is an other circle
    double dt = Math.pow(a, 1.5) * (alpha - sa - beta + sb) / Math.sqrt(mu);
    return dt;
  }

  public double evaluate(double a) {
    double alpha = getalpha(a);   // E is the eccentric anomaly associated with radius r
    double beta = getbeta(a);
    double out = dt - getdt(a, alpha, beta);
    //println ( "   eval a:"+a+" tdiff "+ out );
    return out;
  }

}
