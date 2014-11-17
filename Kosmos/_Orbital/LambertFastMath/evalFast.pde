



class EvalFast implements ScalarFunc{
  
  // http://web.mit.edu/kenta/www/three/taylor.html  
  // asin(x) = x + 1/6 x^3 + 3/40 x^5 + 5/112 x^7 + 35/1152 x^9 + 63/2816 x^11
  final double fastAsin(double x){
    final double c3 = 1.0d/6;
    final double c5 = 3.0d/40;
    final double c7 = 5.112d/40;
    double xx = x*x;
    return x*( 1 + xx*( c3 + c5*xx) );
    //return x*( 1 + xx*( c3 + xx*(c5 + xx*c7)) );
  }
  
  final double fastCircle(double x){
    final double c2 = -1.0d/2;
    final double c4 = -1.0d/8;
    final double c6 = -1.0d/16;
    final double c8 = -5.0d/128;
    final double c10 = -7.0d/256;
    double xx = x*x;
    return 1 + xx*( c2 + xx*(c4 + c6 ) );
    //return 1 + xx*( c2 + xx*(c4 + xx*(c6 + xx*(c8 + xx*c10) ) ) );
  }
  
  final double getalpha(double a) {
    double arg =  (s_alpha / a)-1;
    double alpha = fastAsin(arg) + 1.57079632679;
    return alpha;
  }
  
  final double getbeta(double a) {
    double arg =  (s_beta / a)-1;
    double alpha = fastAsin(arg) + 1.57079632679;
    return alpha;
  }
  
  double getdt(double a, double alpha, double beta) {
    double sa = Math.sin(alpha);                                   // this is basically circle :  sin(2*asin(sqrt(x))) = 2*sqrt(0.25-(0.5-x)^2))
    double sb = Math.sin(beta);                                    // this is an other circle
    double dt = Math.pow(a, 1.5) * (alpha - sa - beta + sb) / Math.sqrt(mu);
    //println("    "+ a+" "+ alpha +" "+beta    );
    return dt;
  }
  
  double myTaylor1(double x){
    double c3 = 1.0d/6;
    double c5 = 3.0d/40;
    double c7 = 5.0d/112;
    double c9 = 35.0d/1152;
    double xx = x*x;
    return x*xx*( c3 + xx*(c5 + xx*(c7 + xx*c9 ) ) );
  }
  
  
  //pi/2 - 1 + 2*x + 2*x**2 + 4*x**3/3 + 2*x**4 + 12*x**5/5 + 4*x**6 + 40*x**7/7 + 10*x**8 + 140*x**9/9 + O(x**10)
  double myTaylor2(double x){
    final double c0 = 0.57079632679d;
    final double c1 = 2;
    final double c2 = 2;
    final double c3 = 4/3.0d;
    final double c4 = 2;
    final double c5 = 12/5.0d;
    final double c6 = 4;
    final double c7 = 40/7.0d;
    final double c8 = 10*x;
    return c0+x*(c1+x*(c2+x*(c3+x*(c4+x*(c5+x*(c6 + x*(c7+x*c8)))))));
  }
  
  double byHermite(double x){
    double xx = (x-0.05)*10;
    int ix = (int)(long)xx;
    double dx = xx-ix; 
    if ((ix<9)&&(ix>=0)){
      return P3(dx, C0[ix],C1[ix],C2[ix],C3[ix]);
    }else{
      return 0;
    }
  }
  
  
  /*
  double myTaylor3(double x){
    x=x-0.01d;
    double c0 = 1.57079632679d - 1.5694589718931d;
    double c1 = 0.20100756305184d;
    double c2 = 5.07594856191523d;
    double c3 = 82.0355323137828d;
    double c4 = 3109.99603247654d;
    return c0+x*(c1+x*(c2+x*(c3+x*c4)));
  }
  */
  
  double getdt_fast(double a) {
    


/*
    double p      = (s_alpha / a)-1; 
    double  alpha = fastAsin  ( p ) + 1.57079632679;
    double salpha = fastCircle( p );
    //double salpha = Math.sin(alpha); 
    double alf=alpha- salpha;

    
    double q     = (s_beta / a)-1;
    double  beta = fastAsin  ( q ) + 1.57079632679;
    //double sbeta = fastCircle( q );  
    double sbeta = Math.sin(beta);
    double bet=beta- sbeta;
*/
    //double alf=  myTaylor2( (0.5d*s_alpha / a)-0.5 );
    //double bet=  myTaylor2( (0.5d*s_beta / a)-0.5 );
    
    double alf=  byHermite( (s_alpha / a)-1 );
    double bet=  byHermite( (s_beta  / a)-1 );

    return a * Math.sqrt(a) * ( alf - bet ) * imu_sqrt;
    // ======= not yet optimized
    //double dt = Math.pow(a, 1.5) * (alpha - sa - beta + sb) / Math.sqrt(mu);
    //return a * Math.sqrt(a) * ( alpha - salpha - beta + sbeta ) * imu_sqrt;
    //println("    "+ a+" "+ alpha +" "+beta    );
    //return dt;
    //return salpha;
    //return sbeta;
  }
  
  public double eval(double a) {
    //double alpha = getalpha(a);   // E is the eccentric anomaly associated with radius r
    //return alpha;
    //double beta = getbeta(a);
    //return beta;
    //double out = dt - getdt(a, alpha, beta);
    //return out;
    //return a;
    //return dt - getdt_fast(a);
    //return fastAsin(a*2-1.0) + 1.57079632679;
    //return fastCircle(a*2-1.0);
    
    //return myTaylor1( (s_beta/a) - 1 );
    //return myTaylor1( a );
    //return myTaylor1( 2*a-1 ) +  1.57079632679;
    //return myTaylor2( a-0.5 );
    
    //return myTaylor3( a );
    return byHermite(a);
    
    //double aa = Math.asin(2*a-1) + 1.57079632679;
    //return aa - Math.sin(aa);
    //return aa;
    
  }


}
