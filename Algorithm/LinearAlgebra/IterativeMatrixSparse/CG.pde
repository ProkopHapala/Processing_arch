// ========== CG Temporary

// from2:
// http://fortknox.csc.ncsu.edu/proj/hppac/papers/son.pdf
// https://github.com/mikiobraun/jblas-examples/blob/master/src/CG.java

static double []  r     = new double[n];
static double []  r2    = new double[n];
static double []  p     = new double[n];
static double []  Ap    = new double[n];
final void CG( final double [][] A, final double [] b, double [] x ){
  mmul(A,x,r);
  sub( b, r, r );
  System.arraycopy( r, 0, p, 0, r.length );
 // println (" r = "+ vec2string(r)    );
 // println (" p = "+ vec2string(p)    );
  double rho = dot(r,r);
  double alpha = 0;
  for (iters =0; iters<maxIters; iters++) {
      mmul(A, p, Ap);
      alpha = rho / dot(p,Ap);
      fma( x, p ,  alpha,   x );
      fma( r, Ap, -alpha,   r2 );
      err2 = dot(r2,r2);
      //println( iter+ " Residual error = "+ Math.sqrt(error2) );
      //println (" x = "+ vec2string(x)    );
      if (err2 < maxErr2 ) break;
      double rho2 = dot(r2,r2);
      double beta = rho2 / rho;
      fma( r2, p, beta, p );
      rho = rho2;
      double [] swap = r; r = r2; r2 = swap;
  }
}

final void CG_SIMD( final double [][] A, final double [] b, double [] x ){
  mmul_SIMD(A,x,r);
  sub( b, r, r );
  System.arraycopy( r, 0, p, 0, r.length );
 // println (" r = "+ vec2string(r)    );
 // println (" p = "+ vec2string(p)    );
  double rho = dot_SIMD(r,r);
  double alpha = 0;
  for (iters =0; iters<maxIters; iters++) {
      mmul_SIMD(A, p, Ap);
      alpha = rho / dot_SIMD(p,Ap);
      fma_SIMD( x, p ,  alpha,   x );
      fma_SIMD( r, Ap, -alpha,   r2 );
      err2 = dot_SIMD(r2,r2);
      //println( iter+ " Residual error = "+ Math.sqrt(error2) );
      //println (" x = "+ vec2string(x)    );
      if (err2 < maxErr2 ) break;
      double rho2 = dot_SIMD(r2,r2);
      double beta = rho2 / rho;
      fma_SIMD( r2, p, beta, p );
      rho = rho2;
      double [] swap = r; r = r2; r2 = swap;
  }
}



//
// xGS       = 1.6019705279117757E-14 1.0000000000000535 1.0000000000000084 1.725009149179564E-14 0.9999999999999738 -2.410766200969013E-14 7.176482853981453E-15 0.9999999999999797 1.1184952673014473E-14 
// xTrue     = 0.0                    1.0                1.0                0.0                   1.0                -0.0                  -0.0                   1.0                0.0 


