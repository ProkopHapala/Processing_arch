

double qnormalize( double [] q ){
  double x  = q[0];
  double y  = q[1];
  double z  = q[2];
  double w  = q[3];
  double r  = Math.sqrt( x*x + y*y + z*z + w*w );
  double ir = 1/r;
  q[0] = x*ir;
  q[1] = y*ir;
  q[2] = z*ir;
  q[3] = w*ir;
  return r;
}

void AngleAxis_to_quaternion  ( double angle, double [] ax, double [] q) {
  double halfAngle = angle * 0.5d;
  double sa = Math.sin(halfAngle);
     q[3] = Math.cos(halfAngle);
     q[0] = sa * ax[0];
     q[1] = sa * ax[1];
     q[2] = sa * ax[2];
}

void rotate_quaternion_by_omega_vec ( double [] omega, double [] q ) {
  double x = omega[0];
  double y = omega[1];
  double z = omega[2];

  double r2    = x*x + y*y + z*z;
  double norm = Math.sqrt( r2 );
   
  double halfAngle = norm * 0.5d;
  double sa = Math.sin( halfAngle )/norm; // we normalize it here to save multiplications
  double ca = Math.cos( halfAngle );
  x*=sa; y*=sa; z*=sa; // 

  double qx = q[0];
  double qy = q[1];
  double qz = q[2];
  double qw = q[3];
  
  q[0] =  x*qw + y*qz - z*qy + ca*qx;
  q[1] = -x*qz + y*qw + z*qx + ca*qy;
  q[2] =  x*qy - y*qx + z*qw + ca*qz;
  q[3] = -x*qx - y*qy - z*qz + ca*qw;
}

void rotate_quaternion_by_omega_vec_Fast ( double [] omega, double [] q ) {
  double x = omega[0];
  double y = omega[1];
  double z = omega[2];

  double r2    = x*x + y*y + z*z;

/*
  // talylor second order usually this is precise enought 
  final double c2 = 1.0d/(2   * 2*2)      ;
  final double c3 = 1.0d/(2*3 * 2*2*2 )      ;
  double ca =    1    - c2*r2              ;  // --,,---                         1        -  1 / 2 * 2^2
  double sa =    0.5d - c3*r2   ;  // 2 terms of taylor expansion     1 / 2^1  +  1 / 6 * 2^3 
  //println( " t2 z1  "+ sa +" "+ca  );
*/

  // taylor 3rd order 
  final double c2 = -1.0d/(2       * 2*2);
  final double c3 = -1.0d/(2*3     * 2*2*2);
  final double c4 =  1.0d/(2*3*4   * 2*2*2*2);
  final double c5 =  1.0d/(2*3*4*5 * 2*2*2*2*2);
  double ca =    1    + r2*( c2 + c4*r2 );  // --,,---                         1        -  1 / 2 * 2^2
  double sa =    0.5d + r2*( c3 + c5*r2 );  // 2 terms of taylor expansion     1 / 2^1  +  1 / 6 * 2^3 


  //println( " t2 z1  "+ sa +" "+ca  );


/*
  // better accuracy 5 more multiplications
  final double c3 = 1.0d/( 6.0 *4*4*4  ) ;
  final double c2 = 1.0d/( 2.0 *4*4    ) ;
  double sa_ =    0.25d - c3*r2          ;  
  double ca_ =    1     - c2*r2          ;  
  double ca  = ca_*ca_ - sa_*sa_*r2      ;
  double sa  = 2*ca_*sa_                 ;
  //println( " t2 z2  "+ sa +" "+ca  );
*/ 
  
/*
  // if you really need even more accuracy ;-)
  // an other 5 more multiplications
  final double c3 = 1.0d/( 6 *8*8*8 );
  final double c2 = 1.0d/( 2 *8*8   );
  double sa = (  0.125d - c3*r2 )      ;
  double ca =    1      - c2*r2        ;
  double ca_ = ca*ca - sa*sa*r2;
  double sa_ = 2*ca*sa;
         ca = ca_*ca_ - sa_*sa_*r2;
         sa = 2*ca_*sa_;
*/ 
  
  x*=sa;
  y*=sa;
  z*=sa;

  double qx = q[0];
  double qy = q[1];
  double qz = q[2];
  double qw = q[3];
  
  q[0] =  x*qw + y*qz - z*qy + ca*qx;
  q[1] = -x*qz + y*qw + z*qx + ca*qy;
  q[2] =  x*qy - y*qx + z*qw + ca*qz;
  q[3] = -x*qx - y*qy - z*qz + ca*qw;

}


void Qmul( double [] q1, double [] q2, double [] qout ) {
  double x1=q1[0]; double y1=q1[1]; double z1=q1[2]; double w1=q1[3];
  double x2=q2[0]; double y2=q2[1]; double z2=q2[2]; double w2=q2[3];
  qout[0] =  x1*w2 + y1*z2 - z1*y2 + w1*x2;
  qout[1] = -x1*z2 + y1*w2 + z1*x2 + w1*y2;
  qout[2] =  x1*y2 - y1*x2 + z1*w2 + w1*z2;
  qout[3] = -x1*x2 - y1*y2 - z1*z2 + w1*w2;
}

void matrix_to_quaternion( double [][] R, double [] q ) {
  
  double m00 = R[0][0];
  double m01 = R[0][1]; 
  double m02 = R[0][2]; 
  double m10 = R[1][0];
  double m11 = R[1][1]; 
  double m12 = R[1][2];
  double m20 = R[2][0];
  double m21 = R[2][1]; 
  double m22 = R[2][2];

  double  t = m00 + m11 + m22;

  // we protect the division by s by ensuring that s>=1
  if (t >= 0) { // |w| >= .5
    double  s = Math.sqrt(t + 1); // |s|>=1 ...
    q[3] = 0.5f * s;
        s = 0.5f / s;                 // so this division isn't bad
    q[0] = (m21 - m12) * s;
    q[1] = (m02 - m20) * s;
    q[2] = (m10 - m01) * s;
  } else if ((m00 > m11) && (m00 > m22)) {
    double  s = Math.sqrt(1.0f + m00 - m11 - m22); // |s|>=1
    q[0] = s * 0.5f; // |x| >= .5
       s = 0.5f / s;
    q[1] = (m10 + m01) * s;
    q[2] = (m02 + m20) * s;
    q[3] = (m21 - m12) * s;
  } else if (m11 > m22) {
    double  s = Math.sqrt(1.0f + m11 - m00 - m22); // |s|>=1
    q[1] = s * 0.5f; // |y| >= .5
       s = 0.5f / s;
    q[0] = (m10 + m01) * s;
    q[2] = (m21 + m12) * s;
    q[3] = (m02 - m20) * s;
  } else {
    double  s = Math.sqrt(1.0f + m22 - m00 - m11); // |s|>=1
    q[2] = s * 0.5f; // |z| >= .5
       s = 0.5f / s;
    q[0] = (m02 + m20) * s;
    q[1] = (m21 + m12) * s;
    q[3] = (m10 - m01) * s;
  }
}


void quaternion_to_matrix(  double [] q, double [][] R  ){
  double x = q[0];
  double y = q[1];
  double z = q[2];
  double w = q[3];
  
  
        double  norm = Math.sqrt( x*x + y*y + z*z + w*w );
        // we explicitly test norm against one here, saving a division
        // at the cost of a test and branch.  Is it worth it?
        double  s = (norm == 1f) ? 2f : (norm > 0f) ? 2f / norm : 0;

        // compute xs/ys/zs first to save 6 multiplications, since xs/ys/zs
        // will be used 2-4 times each.
        double  xs = x * s;
        double  ys = y * s;
        double  zs = z * s;
        double  xx = x * xs;
        double  xy = x * ys;
        double  xz = x * zs;
        double  xw = w * xs;
        double  yy = y * ys;
        double  yz = y * zs;
        double  yw = w * ys;
        double  zz = z * zs;
        double  zw = w * zs;

        // using s=2/norm (instead of 1/norm) saves 9 multiplications by 2 here
        R[0][0] = 1 - (yy + zz);
        R[0][1] = (xy - zw);
        R[0][2] = (xz + yw);
        R[1][0] = (xy + zw);
        R[1][1] = 1 - (xx + zz);
        R[1][2] = (yz - xw);
        R[2][0] = (xz - yw);
        R[2][1] = (yz + xw);
        R[2][2] = 1 - (xx + yy);

    }
