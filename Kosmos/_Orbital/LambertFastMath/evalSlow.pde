

// =============== Total slow


interface ScalarFunc{
  double eval(double a);
}

class EvalSlow implements ScalarFunc{

  double getalpha(double a) {
    double arg =  s / (2.0 * a);
    double alpha = 2.0 * Math.asin(Math.sqrt(arg)); //  asin(sqrt( uu )),     uu = ( |r0| + |rf| + c )/4a
    //if (this.aflag) { alpha = 2.0 * Constants.pi - alpha; }
    //println("    arg"+ arg+" alpha "+ alpha  );
    return alpha;
  }

  double getbeta(double a) {
    double arg = (s - c) / (2.0 * a);
    double beta = 2.0 * Math.asin(Math.sqrt(arg));   //  asin(sqrt( uu )),     uu = ( |r0| + |rf| - c )/4a         
    //if (this.bflag) { beta = -1.0 * beta; }
    //println("    arg"+ arg+" beta "+ beta  );
    return beta;
  }

  double getdt(double a, double alpha, double beta) {
    double sa = Math.sin(alpha);                                   // this is basically circle :  sin(2*asin(sqrt(x))) = 2*sqrt(0.25-(0.5-x)^2))
    double sb = Math.sin(beta);                                    // this is an other circle
    double dt = Math.pow(a, 1.5) * (alpha - sa - beta + sb) / Math.sqrt(mu);
    //println("    "+ a+" "+ alpha +" "+beta    );
    return dt;
  }
  
  public double eval(double a) {
    double alpha = getalpha(a);   // E is the eccentric anomaly associated with radius r
    //return alpha;
    double beta = getbeta(a);
    //return beta;
    //return dt - getdt(a, alpha, beta);
    //return a;
    
    
    //return alpha - Math.sin(alpha);
    //return beta - Math.sin(beta);
    
    double aa = 2.0 * Math.asin(Math.sqrt(a));
    //double aa = Math.asin(a);
    return aa - Math.sin(aa);
    //return aa;
    
    //return Math.sin(alpha); 
    //return Math.sin(beta); 
    //return 2.0 * Math.asin(Math.sqrt( a ));
    //return Math.sin( 2.0 * Math.asin(Math.sqrt( a )));
  }
  
}
