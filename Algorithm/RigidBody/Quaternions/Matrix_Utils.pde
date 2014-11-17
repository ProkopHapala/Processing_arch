

double normalize( double [] v ){
  double x  = v[0];
  double y  = v[1];
  double z  = v[2];
  double r  = Math.sqrt( x*x + y*y + z*z );
  double ir = 1/r;
  v[0] = x*ir;
  v[1] = y*ir;
  v[2] = z*ir;
  return r;
}

void matXvecs( double [][] R, double [][] vs, double [][] outs  ){
  double ax = R[0][0];
  double ay = R[0][1]; 
  double az = R[0][2]; 
  double bx = R[1][0];
  double by = R[1][1]; 
  double bz = R[1][2];
  double cx = R[2][0];
  double cy = R[2][1]; 
  double cz = R[2][2];
  
  for (int i=0; i<vs.length; i++){
    double [] v  = vs[i];
    double a     = v[0];
    double b     = v[1];
    double c     = v[2];
    
    double [] out  = outs[i];
    out[0] = a*ax + b*bx + c*cx;
    out[1] = a*ay + b*by + c*cy;
    out[2] = a*az + b*bz + c*cz;
  }
} 

// ================ ortho-Gonaliza

void ortogonalize( double [][] R ){
  double ax = R[0][0];
  double ay = R[0][1]; 
  double az = R[0][2]; 
  double bx = R[1][0];
  double by = R[1][1]; 
  double bz = R[1][2];
  double cx = R[2][0];
  double cy = R[2][1]; 
  double cz = R[2][2];
  
  double iar2 = 1/( ax*ax + ay*ay + az*az );
  double ab   =   ( ax*bx + ay*by + az*bz ) * iar2;
  bx -= ax*ab; 
  by -= ay*ab; 
  bz -= az*ab; 
  R[1][0] = bx;
  R[1][1] = by;
  R[1][2] = bz;
  double ac  = ( ax*cx + ay*cy + az*cz ) * iar2;
  double br2 =   bx*bx + by*by + bz*bz;
  double bc  = ( bx*cx + by*cy + bz*cz ) / br2; 
  R[2][0] = cx - ax*ac - bx*bc;
  R[2][1] = cy - ay*ac - by*bc; 
  R[2][2] = cz - az*ac - bz*bc; 
  
}

// ================ ortho-Normalize

void ortonormalize( double [][] R ){
  double ax = R[0][0];
  double ay = R[0][1]; 
  double az = R[0][2]; 
  double bx = R[1][0];
  double by = R[1][1]; 
  double bz = R[1][2];
  double cx = R[2][0];
  double cy = R[2][1]; 
  double cz = R[2][2];
  
  double iar = 1/Math.sqrt( ax*ax + ay*ay + az*az );
  ax *= iar;
  ay *= iar;
  az *= iar;
  R[0][0] = ax;
  R[0][1] = ay;
  R[0][2] = az;
  double ab = ax*bx + ay*by + az*bz ;
  bx -= ax*ab; 
  by -= ay*ab; 
  bz -= az*ab; 
  double ibr = 1/Math.sqrt( bx*bx + by*by + bz*bz );
  bx  *=ibr;
  by  *=ibr;
  bz  *=ibr;
  R[1][0] = bx;
  R[1][1] = by;
  R[1][2] = bz;
  double ac = ax*cx + ay*cy + az*cz ;
  double bc = bx*cx + by*cy + bz*cz ; 
  cx -= ax*ac + bx*bc; 
  cy -= ay*ac + by*bc; 
  cz -= az*ac + bz*bc; 
  double icr = 1/Math.sqrt( cx*cx + cy*cy + cz*cz );
  R[2][0] = cx*icr;
  R[2][1] = cy*icr;
  R[2][2] = cz*icr;
}

void testOrthogonality( double [][] R ){
  double ax = R[0][0];
  double ay = R[0][1]; 
  double az = R[0][2]; 
  double bx = R[1][0];
  double by = R[1][1]; 
  double bz = R[1][2];
  double cx = R[2][0];
  double cy = R[2][1]; 
  double cz = R[2][2];
  
  double aa = ax*ax + ay*ay + az*az;
  double ab = ax*bx + ay*by + az*bz;
  double ac = ax*cx + ay*cy + az*cz;
  
  double bb = bx*bx + by*by + bz*bz;
  double bc = bx*cx + by*cy + bz*cz;
  
  double cc = cx*cx + cy*cy + cz*cz;

  println(  aa+"   "+ab+"   "+ac  );
  println(  ab+"   "+bb+"   "+bc  );
  println(  ac+"   "+bc+"   "+cc  );
}
