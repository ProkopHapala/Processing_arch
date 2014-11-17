
class Matrix3x3 {
  double m00, m01, m02,
         m10, m11, m12,
         m20, m21, m22;
  
  Matrix3x3(){};
  Matrix3x3(double [][] vs ){
    m00=vs[0][0];    m01=vs[0][1];    m02=vs[0][2];
    m10=vs[1][0];    m11=vs[1][1];    m12=vs[1][2];
    m20=vs[2][0];    m21=vs[2][1];    m22=vs[2][2];
  };
  
  void setIdentity(){  m01=m02=m12=m10=m20=m21=0;   m00=m11=m22=1; }
  
  void toVectors(double [][] vs ){
    vs[0][0]=m00;    vs[0][1]=m01;    vs[0][2]=m02;
    vs[1][0]=m10;    vs[1][1]=m11;    vs[1][2]=m12;
    vs[2][0]=m20;    vs[2][1]=m21;    vs[2][2]=m22;
  };
  
  final void transposel() {
    double tmp;
    tmp = m01; m01 = m10; m10 = tmp;
    tmp = m02; m02 = m20; m20 = tmp;
    tmp = m12; m12 = m21; m21 = tmp;
  }
   
  final double determinant() {
    double fCo00 = m11 * m22 - m12 * m21;
    double fCo10 = m12 * m20 - m10 * m22;
    double fCo20 = m10 * m21 - m11 * m20;
    double fDet  = m00 * fCo00 + m01 * fCo10 + m02 * fCo20;
    return fDet;
  }
   
  final void adjoint( Matrix3x3  store ) {
    store.m00 = m11 * m22 - m12 * m21;
    store.m01 = m02 * m21 - m01 * m22;
    store.m02 = m01 * m12 - m02 * m11;
    store.m10 = m12 * m20 - m10 * m22;
    store.m11 = m00 * m22 - m02 * m20;
    store.m12 = m02 * m10 - m00 * m12;
    store.m20 = m10 * m21 - m11 * m20;
    store.m21 = m01 * m20 - m00 * m21;
    store.m22 = m00 * m11 - m01 * m10;
  } 
    
   final void inversion( Matrix3x3  store ) {
        double idet = 1.0d/determinant();
        println( " 1/determinant: "+idet );
        double f00 = m11 * m22 - m12 * m21;
        double f01 = m02 * m21 - m01 * m22;
        double f02 = m01 * m12 - m02 * m11;
        double f10 = m12 * m20 - m10 * m22;
        double f11 = m00 * m22 - m02 * m20;
        double f12 = m02 * m10 - m00 * m12;
        double f20 = m10 * m21 - m11 * m20;
        double f21 = m01 * m20 - m00 * m21;
        double f22 = m00 * m11 - m01 * m10;
        store.m00 = f00*idet;
        store.m01 = f01*idet;
        store.m02 = f02*idet;
        store.m10 = f10*idet;
        store.m11 = f11*idet;
        store.m12 = f12*idet;
        store.m20 = f20*idet;
        store.m21 = f21*idet;
        store.m22 = f22*idet;
    }  
    
  final void transform( double3 vin, double3 vout ) {
        double x = vin.x, y = vin.y, z = vin.z;
        vout.x = m00 * x + m01 * y + m02 * z;
        vout.y = m10 * x + m11 * y + m12 * z;
        vout.z = m20 * x + m21 * y + m22 * z;
  }
  
 final void transform_T( double3 vin, double3 vout ) {
        double x = vin.x, y = vin.y, z = vin.z;
        vout.x = m00 * x + m10 * y + m20 * z;
        vout.y = m01 * x + m11 * y + m21 * z;
        vout.z = m02 * x + m12 * y + m22 * z;
  }
  /*
  final void add_transformed( double dt, double3 vin, double3 vout ) {
        double x = vin.x*dt, y = vin.y*dt, z = vin.z*dt;
        vout.x += m00 * x + m01 * y + m02 * z;
        vout.y += m10 * x + m11 * y + m12 * z;
        vout.z += m20 * x + m21 * y + m22 * z;
  }
  
 final void add_transformed_T( double dt, double3 vin, double3 vout ) {
        double x = vin.x*dt, y = vin.y*dt, z = vin.z*dt;
        vout.x += m00 * x + m10 * y + m20 * z;
        vout.y += m01 * x + m11 * y + m21 * z;
        vout.z += m02 * x + m12 * y + m22 * z;
  }
  */
  final void mmul( Matrix3x3 A, Matrix3x3 out ) {
        double a00 = A.m00, a01 = A.m01, a02 = A.m02,
               a10 = A.m10, a11 = A.m11, a12 = A.m12,
               a20 = A.m20, a21 = A.m21, a22 = A.m22;
        out.m00 = m00 * a00 + m01 * a10 + m02 * a20;
        out.m01 = m00 * a01 + m01 * a11 + m02 * a21;
        out.m02 = m00 * a02 + m01 * a12 + m02 * a22;
        out.m10 = m10 * a00 + m11 * a10 + m12 * a20;
        out.m11 = m10 * a01 + m11 * a11 + m12 * a21;
        out.m12 = m10 * a02 + m11 * a12 + m12 * a22;
        out.m20 = m20 * a00 + m21 * a10 + m22 * a20;
        out.m21 = m20 * a01 + m21 * a11 + m22 * a21;
        out.m22 = m20 * a02 + m21 * a12 + m22 * a22;
    }  
    
    final void mmul_T( Matrix3x3 A, Matrix3x3 out ) {
        double a00 = A.m00, a01 = A.m01, a02 = A.m02,
               a10 = A.m10, a11 = A.m11, a12 = A.m12,
               a20 = A.m20, a21 = A.m21, a22 = A.m22;
        out.m00 = m00 * a00 + m10 * a10 + m20 * a20;
        out.m01 = m00 * a01 + m10 * a11 + m20 * a21;
        out.m02 = m00 * a02 + m10 * a12 + m20 * a22;
        out.m10 = m01 * a00 + m11 * a10 + m21 * a20;
        out.m11 = m01 * a01 + m11 * a11 + m21 * a21;
        out.m12 = m01 * a02 + m11 * a12 + m21 * a22;
        out.m20 = m02 * a00 + m12 * a10 + m22 * a20;
        out.m21 = m02 * a01 + m12 * a11 + m22 * a21;
        out.m22 = m02 * a02 + m12 * a12 + m22 * a22;
    } 
    
    //  out = transpose(M)*A*M 
    final void similarityTransform( Matrix3x3 A, Matrix3x3 out ) {
        double a00 = A.m00, a01 = A.m01, a02 = A.m02,
               a10 = A.m10, a11 = A.m11, a12 = A.m12,
               a20 = A.m20, a21 = A.m21, a22 = A.m22;
        //  B = A*M
        double b00 = a00 * m00 + a01 * m10 + a02 * m20;
        double b01 = a00 * m01 + a01 * m11 + a02 * m21;
        double b02 = a00 * m02 + a01 * m12 + a02 * m22;
        double b10 = a10 * m00 + a11 * m10 + a12 * m20;
        double b11 = a10 * m01 + a11 * m11 + a12 * m21;
        double b12 = a10 * m02 + a11 * m12 + a12 * m22;
        double b20 = a20 * m00 + a21 * m10 + a22 * m20;
        double b21 = a20 * m01 + a21 * m11 + a22 * m21;
        double b22 = a20 * m02 + a21 * m12 + a22 * m22;  
        //  out = transpose(M)*B       
        out.m00 = m00 * b00 + m10 * b10 + m20 * b20;
        out.m01 = m00 * b01 + m10 * b11 + m20 * b21;
        out.m02 = m00 * b02 + m10 * b12 + m20 * b22;
        out.m10 = m01 * b00 + m11 * b10 + m21 * b20;
        out.m11 = m01 * b01 + m11 * b11 + m21 * b21;
        out.m12 = m01 * b02 + m11 * b12 + m21 * b22;
        out.m20 = m02 * b00 + m12 * b10 + m22 * b20;
        out.m21 = m02 * b01 + m12 * b11 + m22 * b21;
        out.m22 = m02 * b02 + m12 * b12 + m22 * b22;
    }  
    
    //  out = M*A*transpose(M) 
    final void similarityTransform_T( Matrix3x3 A, Matrix3x3 out ) {
        double a00 = A.m00, a01 = A.m01, a02 = A.m02,
               a10 = A.m10, a11 = A.m11, a12 = A.m12,
               a20 = A.m20, a21 = A.m21, a22 = A.m22;
        //  B = A*transpose(M)
        double b00 = a00 * m00 + a01 * m01 + a02 * m02;
        double b01 = a00 * m10 + a01 * m11 + a02 * m12;
        double b02 = a00 * m20 + a01 * m21 + a02 * m22;
        double b10 = a10 * m00 + a11 * m01 + a12 * m02;
        double b11 = a10 * m10 + a11 * m11 + a12 * m12;
        double b12 = a10 * m20 + a11 * m21 + a12 * m22;
        double b20 = a20 * m00 + a21 * m01 + a22 * m02;
        double b21 = a20 * m10 + a21 * m11 + a22 * m12;
        double b22 = a20 * m20 + a21 * m21 + a22 * m22;     
   StringBuilder result = new StringBuilder("");
   result.append(b00);   result.append("  ");   result.append(b01);   result.append("  ");   result.append(b02);   result.append(" \n");   
   result.append(b10);   result.append("  ");   result.append(b11);   result.append("  ");   result.append(b12);   result.append(" \n");   
   result.append(b20);   result.append("  ");   result.append(b21);   result.append("  ");   result.append(b22);   result.append(" \n");
   println(result);
        //  out = M*B       
        out.m00 = m00 * b00 + m01 * b10 + m02 * b20;
        out.m01 = m00 * b01 + m01 * b11 + m02 * b21;
        out.m02 = m00 * b02 + m01 * b12 + m02 * b22;
        out.m10 = m10 * b00 + m11 * b10 + m12 * b20;
        out.m11 = m10 * b01 + m11 * b11 + m12 * b21;
        out.m12 = m10 * b02 + m11 * b12 + m12 * b22;
        out.m20 = m20 * b00 + m21 * b10 + m22 * b20;
        out.m21 = m20 * b01 + m21 * b11 + m22 * b21;
        out.m22 = m20 * b02 + m21 * b12 + m22 * b22;
    }  
  
    final void fromAngleNormalAxis(double angle, double3 axis) {
        double fCos = Math.cos(angle);
        double fSin = Math.sin(angle);
        double fOneMinusCos = ((double) 1.0d) - fCos;
        double fX2 = axis.x * axis.x;
        double fY2 = axis.y * axis.y;
        double fZ2 = axis.z * axis.z;
        double fXYM = axis.x * axis.y * fOneMinusCos;
        double fXZM = axis.x * axis.z * fOneMinusCos;
        double fYZM = axis.y * axis.z * fOneMinusCos;
        double fXSin = axis.x * fSin;
        double fYSin = axis.y * fSin;
        double fZSin = axis.z * fSin;

        m00 = fX2 * fOneMinusCos + fCos;
        m01 = fXYM - fZSin;
        m02 = fXZM + fYSin;
        m10 = fXYM + fZSin;
        m11 = fY2 * fOneMinusCos + fCos;
        m12 = fYZM - fXSin;
        m20 = fXZM - fYSin;
        m21 = fYZM + fXSin;
        m22 = fZ2 * fOneMinusCos + fCos;
    }
    
// ================ ortho-Normalize

void ortonormalize(){
 
  double iar = 1/Math.sqrt( m00*m00 + m01*m01 + m02*m02 );
  m00 *= iar;
  m01 *= iar;
  m02 *= iar;
  double ab = m00*m10 + m01*m11 + m02*m12;
  m10 -= m00*ab; 
  m11 -= m01*ab; 
  m12 -= m02*ab; 
  double ibr = 1/Math.sqrt( m10*m10 + m11*m11 + m12*m12 );
  m10  *=ibr;
  m11  *=ibr;
  m12  *=ibr;
  double ac = m00*m20 + m01*m21 + m02*m22;
  double bc = m10*m20 + m11*m21 + m12*m22; 
  m20 -= m00*ac + m10*bc; 
  m21 -= m01*ac + m11*bc; 
  m22 -= m02*ac + m12*bc; 
  double icr = 1/Math.sqrt( m20*m20 + m21*m21 + m22*m22 );
  m20 *= icr;
  m21 *= icr;
  m22 *= icr;
}
    
    
 String toString() {
   StringBuilder result = new StringBuilder("");
   result.append(m00);   result.append("  ");   result.append(m01);   result.append("  ");   result.append(m02);   result.append(" \n");   
   result.append(m10);   result.append("  ");   result.append(m11);   result.append("  ");   result.append(m12);   result.append(" \n");   
   result.append(m20);   result.append("  ");   result.append(m21);   result.append("  ");   result.append(m22);   result.append(" \n");
   return result.toString();
 }
  
}
