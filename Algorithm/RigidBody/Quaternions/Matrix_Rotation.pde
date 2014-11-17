

// very fast rotation, usefull just by very small angle, very low precission
// cost
//  6 additions 
//  6 multiplications
void rotVecByVec( double [] a, double w [] ){
  double ax = a[0];
  double ay = a[1]; 
  double az = a[2]; 
  double wx = omega[0];
  double wy = omega[1];
  double wz = omega[2];
  
  a[0] = ax  + wy*az - wz*ay;
  a[1] = ay  + wz*ax - wx*az;
  a[2] = az  + wx*ay - wy*ax;
  
}

// Exact rotation aby arbitrary angle

void applyOmegaVecExact( double [ ] v,  double [] omega ){
  
  double x  = v[0];
  double y  = v[1];
  double z  = v[2];
  double wx = omega[0];
  double wy = omega[1];
  double wz = omega[2];
  
  double r    = Math.sqrt( wx*wx + wy*wy + wz*wz );
  double invn = 1/r;
  wx*= invn;
  wy*= invn;
  wz*= invn;
  
  double ca   = Math.cos( r );
  double sa   = Math.sin( r );
 
  double p  = x*wx +  y*wy +  z*wz ;
  
  double xI = wx*p;
  double yI = wy*p;
  double zI = wz*p;
  
  double xT = x-xI;
  double yT = y-yI;
  double zT = z-zI;
  
  double xL = wy*zT - wz*yT;
  double yL = wz*xT - wx*zT;
  double zL = wx*yT - wy*xT;

  v[0] = xI + ca*xT + sa*xL; 
  v[1] = yI + ca*yT + sa*yL;
  v[2] = zI + ca*zT + sa*zL; 
  
}

// Exact rotation aby arbitrary angle to several vectors ( e.g. to rotation matrix )
// it is much faster do several vectors at once - because cosstly operation ( sin, cos, sqrt ) are done just once
// this way you can rotate for example molecule ( if. position of atoms are expressed relative to centre of mass )

/*
  cost:

  pre-loop:
    sin, cos, sqrt
    1x division
    2x addition
    6x multiplication
  loop (for each vector )
    18 multiplication
    14 additions
  
*/

void applyOmegaVecsExact( double [][] vs,  double [] omega ){
  
  double wx = omega[0];
  double wy = omega[1];
  double wz = omega[2];
  
  double r    = Math.sqrt( wx*wx + wy*wy + wz*wz );
  double invn = 1/r;
  wx*= invn;
  wy*= invn;
  wz*= invn;
  
  double ca   = Math.cos( r );
  double sa   = Math.sin( r );
 
  for (int i =0; i<vs.length; i++ ){
    double [] v  = vs[i];
    double x  = v[0];
    double y  = v[1];
    double z  = v[2];
 
    double p  = x*wx +  y*wy +  z*wz ;
  
    double xI = wx*p;
    double yI = wy*p;
    double zI = wz*p;
  
    double xT = x-xI;
    double yT = y-yI;
    double zT = z-zI;
  
    double xL = wy*zT - wz*yT;
    double yL = wz*xT - wx*zT;
    double zL = wx*yT - wy*xT;

    v[0] = xI + ca*xT + sa*xL; 
    v[1] = yI + ca*yT + sa*yL;
    v[2] = zI + ca*zT + sa*zL; 
  }
}

