

final static double sq(double x){return x*x;} 
final static double sign(double a, double b) {
    double amag = Math.abs(a);
    double out = amag;
    if (b < 0.0)
      out = -1.0 * amag;
    return out;
}
 
final static double double3_dot ( double [] a, double [] b              ) { return a[0]*b[0]+a[1]*b[1]+a[2]*b[2];   } 
final static double double3_mag2( double [] a                           ) { return sq(a[0]) + sq(a[1]) + sq(a[2]);  }
final static double double3_mag ( double [] a                           ) { return Math.sqrt(double3_mag2(a));      }
final static void double3_set ( double f, double [] c ) { c[0]=f; c[1]=f; c[2]=f; }
final static void double3_sub ( double [] a, double [] b, double [] c ) { c[0]=a[0]-b[0]; c[1]=a[1]-b[1]; c[2]=a[2]-b[2]; } 
String double3_toString( double [] a){ return "{ "+a[0]+" "+a[2]+" "+a[1]+" }"; }

interface ScalarFunction{
  double evaluate(double x);
}

