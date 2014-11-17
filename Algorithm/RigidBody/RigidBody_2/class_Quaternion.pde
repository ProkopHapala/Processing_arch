
class Quaternion {

    double x, y, z, w;

// ============== Constructors & setters

    Quaternion()                                               { seToIdentity();                                           }
    Quaternion( double x, double y, double z, double w       ) { set(x,y,z,w);                                             }
    Quaternion( Quaternion q                                 ) { this.x = q.x; this.y = q.y;  this.z = q.z;  this.w = q.w; }
    
    Quaternion( double[] angles                              ) { fromAngles(angles);               }
    Quaternion( Quaternion q1, Quaternion q2, double interp  ) { slerp(q1, q2, interp);            }
    
    final void seToIdentity()  {    x = y = z = 0;   w = 1;    }
    final void set(double x, double y, double z, double w   ) {  this.x = x;   this.y = y;    this.z = z;   this.w = w;  }
    final void set(Quaternion q                             ) {  this.x = q.x; this.y = q.y;  this.z = q.z; this.w = q.w; }

// ============== Basic Math

    final void   mul(double scalar) {        w *= scalar;        x *= scalar;        y *= scalar;        z *= scalar;        }
    
    final void set_add (Quaternion q) {  this.x += q.x;   this.y += q.y;  this.z += q.z;  this.w += q.w;  }
    final void set_sub (Quaternion q) {  this.x -= q.x;   this.y -= q.y;  this.z -= q.z;  this.w -= q.w;  }

    final double dot(Quaternion q) {        return w * q.w + x * q.x + y * q.y + z * q.z;    }
    final double norm2() {        return w*w + x*x + y*y + z*z;    }

    final double normalize() {
          double norm  = Math.sqrt( x*x + y*y + z*z + w*w);
          double inorm = 1.0d/norm;
          x *= inorm;    y *= inorm;    z *= inorm;   w *= inorm;
          return inorm;
    }
    
// ============== Quaternion Math   

    final void set_mul(Quaternion a, Quaternion b) {
        double aw = a.w, ax = a.x, ay = a.y, az = a.z;
        double bw = b.w, bx = b.x, by = b.y, bz = b.z;
        x =  ax * bw + ay * bz - az * by + aw * bx;
        y = -ax * bz + ay * bw + az * bx + aw * by;
        z =  ax * by - ay * bx + az * bw + aw * bz;
        w = -ax * bx - ay * by - az * bz + aw * bw;
    }
    
      final void mul(Quaternion a) {
        double aw = a.w, ax = a.x, ay = a.y, az = a.z;
        double x_ =  x * aw + y * az - z * ay + w * ax;
        double y_ = -x * az + y * aw + z * ax + w * ay;
        double z_ =  x * ay - y * ax + z * aw + w * az;
                w = -x * ax - y * ay - z * az + w * aw;
        x = x_; y = y_; z = z_;
    }

    final void inverseLocal() {
        double norm = Math.sqrt( x*x + y*y + z*z + w*w);
        if (norm > 0.0) {
            double invNorm = 1.0d / norm;
            x *= -invNorm;
            y *= -invNorm;
            z *= -invNorm;
            w *= invNorm;
        }
    }
    
// ============== Differential rotation
// norm       = norm(omega)
// hat        = omega / norm 
// a          = norm * dt / 2 
// dq         =  ( cos(a), hat * sin(a)  )
// q_new = qmul ( q, dq  )
//
// Taylor trick:
//   cos(a) 
//       = 1 - a^2/2 - a^4/( 2*3*4    )
//       b = norm * dt
//       a = b/2
//       = 1 - b^2/(2*4) - b^4/( 2*3*4*16 )
//   hat * sin( a )  
//       =  hat * a * ( 1 + a^2/(2*3)  + a^4/(2*3*5) )
//       =  (omega/norm) ( norm * dt / 2 ) * ( 1   + a^2/(2*3     )  + a^4/(2*3*5      ) )
//       =   omega*dt/2                    * ( 1   + b^2/(2*3*8   )  + b^4/(2*3*5*32   ) ) 
//       =   omega       *               dt* ( 0.5 + b^2/(2*3*8*2 )  + b^4/(2*3*5*32*2 ) )  
//       b2  = norm^2 * dt^2; 
//       =   omega       *               dt* ( 0.5 + b2/(2*3*8*2 )   + b2^2*(2*3*5*32*2 )

void diffRot_exact ( double3 omega, double dt ) {
  double hx   = omega.x;
  double hy   = omega.y;
  double hz   = omega.z;
  double r2   = hx*hx + hy*hy + hz*hz;
  double norm = Math.sqrt( r2 );
  double a    = dt * norm * 0.5d;
  double sa   = Math.sin( a )/norm; // we normalize it here to save multiplications
  double ca   = Math.cos( a );
  hx*=sa; hy*=sa; hz*=sa;  // hat * sin(a)
  //println( " x,y,z,r2, norm,sa,ca: "+x+" "+y+" "+z+" "+r2+" "+norm+" "+sa+" "+ca );
  double x_ = this.x;
  double y_ = this.y;
  double z_ = this.z;
  double w_ = this.w;
  this.x =  hx*w_ + hy*z_ - hz*y_ + ca*x_;
  this.y = -hx*z_ + hy*w_ + hz*x_ + ca*y_;
  this.z =  hx*y_ - hy*x_ + hz*w_ + ca*z_;
  this.w = -hx*x_ - hy*y_ - hz*z_ + ca*w_;
}

void diffRot_taylor2 ( double3 omega, double dt ) {
  double hx   = omega.x;
  double hy   = omega.y;
  double hz   = omega.z;
  double r2   = hx*hx + hy*hy + hz*hz;
  double b2   = dt*dt*r2;
  final double c2 = 1.0d/(4   *2       );
  final double c3 = 1.0d/(8*2 *2*3     );
  final double c4 = 1.0d/(8   *2*3*4   );
  final double c5 = 1.0d/(8*2 *2*3*4*5 );
  double sa   = dt * ( 0.5d - b2*( c3 - c5*b2 ) ); 
  double ca   =      ( 1    - b2*( c2 - c4*b2 ) );
  hx*=sa; hy*=sa; hz*=sa;  // hat * sin(a)
  //println( " x,y,z,r2, norm,sa,ca: "+x+" "+y+" "+z+" "+r2+" "+norm+" "+sa+" "+ca );
  double x_ = this.x;
  double y_ = this.y;
  double z_ = this.z;
  double w_ = this.w;
  this.x =  hx*w_ + hy*z_ - hz*y_ + ca*x_;
  this.y = -hx*z_ + hy*w_ + hz*x_ + ca*y_;
  this.z =  hx*y_ - hy*x_ + hz*w_ + ca*z_;
  this.w = -hx*x_ - hy*y_ - hz*z_ + ca*w_;
} 
 
 
 // =============== Conversion Rotation Matrix
 
 final void fromRotationMatrix( Matrix3x3 M ) { fromRotationMatrix(M.m00, M.m01, M.m02, M.m10, M.m11, M.m12, M.m20, M.m21, M.m22);  }
    final void fromRotationMatrix(double m00, double m01, double m02, double m10, double m11, double m12, double m20, double m21, double m22) {
        double t = m00 + m11 + m22;
        // we protect the division by s by ensuring that s>=1
        if (t >= 0) { // |w| >= .5
            double s = Math.sqrt(t + 1); // |s|>=1 ...
            w = 0.5f * s;
            s = 0.5f / s;                 // so this division isn't bad
            x = (m21 - m12) * s;
            y = (m02 - m20) * s;
            z = (m10 - m01) * s;
        } else if ((m00 > m11) && (m00 > m22)) {
            double s = Math.sqrt(1.0f + m00 - m11 - m22); // |s|>=1
            x = s * 0.5f; // |x| >= .5
            s = 0.5f / s;
            y = (m10 + m01) * s;
            z = (m02 + m20) * s;
            w = (m21 - m12) * s;
        } else if (m11 > m22) {
            double s = Math.sqrt(1.0f + m11 - m00 - m22); // |s|>=1
            y = s * 0.5f; // |y| >= .5
            s = 0.5f / s;
            x = (m10 + m01) * s;
            z = (m21 + m12) * s;
            w = (m02 - m20) * s;
        } else {
            double s = Math.sqrt(1.0f + m22 - m00 - m11); // |s|>=1
            z = s * 0.5f; // |z| >= .5
            s = 0.5f / s;
            x = (m02 + m20) * s;
            y = (m21 + m12) * s;
            w = (m10 - m01) * s;
        }
    }


    final void toRotationMatrix( Matrix3x3 result) {
        // we explicitly test norm against one here, saving a division
        // at the cost of a test and branch.  Is it worth it?
        double r2 = w*w + x*x + y*y + z*z;
        double s = (r2 > 0d) ? 2d / r2 : 0;
        // compute xs/ys/zs first to save 6 multiplications, since xs/ys/zs
        // will be used 2-4 times each.
        double xs = x * s;
        double ys = y * s;
        double zs = z * s;
        double xx = x * xs;
        double xy = x * ys;
        double xz = x * zs;
        double xw = w * xs;
        double yy = y * ys;
        double yz = y * zs;
        double yw = w * ys;
        double zz = z * zs;
        double zw = w * zs;
        // using s=2/norm (instead of 1/norm) saves 9 multiplications by 2 here
        result.m00 = 1 - (yy + zz);
        result.m01 = (xy - zw);
        result.m02 = (xz + yw);
        result.m10 = (xy + zw);
        result.m11 = 1 - (xx + zz);
        result.m12 = (yz - xw);
        result.m20 = (xz - yw);
        result.m21 = (yz + xw);
        result.m22 = 1 - (xx + yy);
    }

    final void fromAxes( double3 a, double3 b, double3 c) {   fromRotationMatrix( a.x, b.x, c.x, a.y, b.y, c.y, a.z, b.z, c.z );    }
 
// =============== Conversion Angle Axis
 
     final void fromAngleAxis(double angle, double3 axis) {
      double halfAngle = 0.5d * angle;
      double sin = Math.sin(halfAngle);
      w = Math.cos(halfAngle);
      x = sin * axis.x;
      y = sin * axis.y;
      z = sin * axis.z;
    }

    final double toAngleAxis(double3 axisStore) {
        double sqrLength = x * x + y * y + z * z;
        double angle;
        if (sqrLength == 0.0f) {
            angle = 0.0f;
            if (axisStore != null) {
                axisStore.x = 1.0d;
                axisStore.y = 0.0d;
                axisStore.z = 0.0d;
            }
        } else {
            angle = (2.0f * Math.acos(w));
            if (axisStore != null) {
                double invLength = (1.0f / Math.sqrt(sqrLength));
                axisStore.x = x * invLength;
                axisStore.y = y * invLength;
                axisStore.z = z * invLength;
            }
        }

        return angle;
    }
 
 // ============== Conversion Euler Angles

    final void fromAngles(double[] angles) {  fromAngles(angles[0], angles[1], angles[2]);  }
    final void fromAngles(double xAngle, double yAngle, double zAngle) {
        double angle;
        angle = zAngle * 0.5f;
        double sinZ = Math.sin(angle);
        double cosZ = Math.cos(angle);
        angle = yAngle * 0.5f;
        double sinY = Math.sin(angle);
        double cosY = Math.cos(angle);
        angle = xAngle * 0.5f;
        double sinX = Math.sin(angle);
        double cosX = Math.cos(angle);
        // variables used to reduce multiplication calls.
        double cosYXcosZ = cosY * cosZ;
        double sinYXsinZ = sinY * sinZ;
        double cosYXsinZ = cosY * sinZ;
        double sinYXcosZ = sinY * cosZ;
        w = (cosYXcosZ * cosX - sinYXsinZ * sinX);
        x = (cosYXcosZ * sinX + sinYXsinZ * cosX);
        y = (sinYXcosZ * cosX + cosYXsinZ * sinX);
        z = (cosYXsinZ * cosX - sinYXcosZ * sinX);
        normalize();
    }

    final void toAngles( double[] angles ) {
        double sqw = w * w;
        double sqx = x * x;
        double sqy = y * y;
        double sqz = z * z;
        double unit = sqx + sqy + sqz + sqw; // if normalized is one, otherwise
        // is correction factor
        double test = x * y + z * w;
        if (test > 0.499 * unit) { // singularity at north pole
            angles[1] = 2 * Math.atan2(x, w);
            angles[2] = Math.PI*0.5d;
            angles[0] = 0;
        } else if (test < -0.499 * unit) { // singularity at south pole
            angles[1] = -2 * Math.atan2(x, w);
            angles[2] = -Math.PI*0.5d;
            angles[0] = 0;
        } else {
            angles[1] = Math.atan2(2 * y * w - 2 * x * z, sqx - sqy - sqz + sqw); // roll or heading 
            angles[2] = Math.asin(2 * test / unit); // pitch or attitude
            angles[0] = Math.atan2(2 * x * w - 2 * y * z, -sqx + sqy - sqz + sqw); // yaw or bank
        }
    }

 
// ================== Quaternion interpolation

    final Quaternion slerp(Quaternion q1, Quaternion q2, double t) {
        if (q1.x == q2.x && q1.y == q2.y && q1.z == q2.z && q1.w == q2.w) {
            this.set(q1);
            return this;
        }

        double result = (q1.x * q2.x) + (q1.y * q2.y) + (q1.z * q2.z)
                + (q1.w * q2.w);

        if (result < 0.0f) {
            // Negate the second quaternion and the result of the dot product
            q2.x = -q2.x;
            q2.y = -q2.y;
            q2.z = -q2.z;
            q2.w = -q2.w;
            result = -result;
        }

        // Set the first and second scale for the interpolation
        double scale0 = 1 - t;
        double scale1 = t;

        // Check if the angle between the 2 quaternions was big enough to
        // warrant such calculations
        if ((1 - result) > 0.1f) {// Get the angle between the 2 quaternions,
            // and then store the sin() of that angle
            double theta = Math.acos(result);
            double invSinTheta = 1f / Math.sin(theta);

            // Calculate the scale for q1 and q2, according to the angle and
            // it's sine value
            scale0 = Math.sin((1 - t) * theta) * invSinTheta;
            scale1 = Math.sin((t * theta)) * invSinTheta;
        }

        // Calculate the x, y, z and w values for the quaternion by using a
        // special
        // form of linear interpolation for quaternions.
        this.x = (scale0 * q1.x) + (scale1 * q2.x);
        this.y = (scale0 * q1.y) + (scale1 * q2.y);
        this.z = (scale0 * q1.z) + (scale1 * q2.z);
        this.w = (scale0 * q1.w) + (scale1 * q2.w);

        // Return the interpolated quaternion
        return this;
    }

    final void slerp(Quaternion q2, double changeAmnt) {
        if (this.x == q2.x && this.y == q2.y && this.z == q2.z
                && this.w == q2.w) {
            return;
        }

        double result = (this.x * q2.x) + (this.y * q2.y) + (this.z * q2.z)
                + (this.w * q2.w);

        if (result < 0.0f) {
            // Negate the second quaternion and the result of the dot product
            q2.x = -q2.x;
            q2.y = -q2.y;
            q2.z = -q2.z;
            q2.w = -q2.w;
            result = -result;
        }

        // Set the first and second scale for the interpolation
        double scale0 = 1 - changeAmnt;
        double scale1 = changeAmnt;

        // Check if the angle between the 2 quaternions was big enough to
        // warrant such calculations
        if ((1 - result) > 0.1f) {
            // Get the angle between the 2 quaternions, and then store the sin()
            // of that angle
            double theta = Math.acos(result);
            double invSinTheta = 1f / Math.sin(theta);

            // Calculate the scale for q1 and q2, according to the angle and
            // it's sine value
            scale0 = Math.sin((1 - changeAmnt) * theta) * invSinTheta;
            scale1 = Math.sin((changeAmnt * theta)) * invSinTheta;
        }

        // Calculate the x, y, z and w values for the quaternion by using a
        // special
        // form of linear interpolation for quaternions.
        this.x = (scale0 * this.x) + (scale1 * q2.x);
        this.y = (scale0 * this.y) + (scale1 * q2.y);
        this.z = (scale0 * this.z) + (scale1 * q2.z);
        this.w = (scale0 * this.w) + (scale1 * q2.w);
    }


    final void nlerp(Quaternion q2, double blend) {
        double dot = dot(q2);
        double blendI = 1.0f - blend;
        if (dot < 0.0f) {
            x = blendI * x - blend * q2.x;
            y = blendI * y - blend * q2.y;
            z = blendI * z - blend * q2.z;
            w = blendI * w - blend * q2.w;
        } else {
            x = blendI * x + blend * q2.x;
            y = blendI * y + blend * q2.y;
            z = blendI * z + blend * q2.z;
            w = blendI * w + blend * q2.w;
        }
        normalize();
    }

// ================ General utils

    final String toString() {        return "(" + x + ", " + y + ", " + z + ", " + w + ")";    }

}

