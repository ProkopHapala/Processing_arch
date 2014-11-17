
String vec2string(double [] a){
  String s = "";
  for(int i=0; i<a.length; i++) {     s+=a[i]+" ";   }
  return s;
}

final static float x2s( double x  ){
   return zoom*((float)x)+sz;
};


void plotPointInRotation( double3 v, Matrix3x3 R ){
  plotPointInRotation( v.x, v.y, v.z, R );
}

void plotPointInRotation( double x, double y, double z , Matrix3x3 R ){
  float sx = x2s(  R.m10*x + R.m11*y + R.m12*z );
  float sy = x2s(  R.m20*x + R.m21*y + R.m22*z );
  point( sx, 2*sz-sy );
}

void plotCircleInRotation( double3 v, Matrix3x3 R, float radius ){
  plotCircleInRotation( v.x, v.y, v.z, R, radius );
}

void plotCircleInRotation( double x, double y, double z , Matrix3x3 R, float radius ){
  float sx = x2s(  R.m10*x + R.m11*y + R.m12*z );
  float sy = x2s(  R.m20*x + R.m21*y + R.m22*z );
  ellipse( sx, 2*sz-sy, radius, radius );
}

void plotLineInRotation( double3 v0, double3 v1, Matrix3x3 R ){
  plotLineInRotation( v0.x, v0.y, v0.z, v1.x, v1.y, v1.z, R );
}

void plotLineInRotation( double x0, double y0, double z0, double x1, double y1, double z1, Matrix3x3 R ){
  float sx0 = x2s(  R.m10*x0 + R.m11*y0 + R.m12*z0 );
  float sy0 = x2s(  R.m20*x0 + R.m21*y0 + R.m22*z0 );
  float sx1 = x2s(  R.m10*x1 + R.m11*y1 + R.m12*z1 );
  float sy1 = x2s(  R.m20*x1 + R.m21*y1 + R.m22*z1 );
  line( sx0, 2*sz-sy0,  sx1, 2*sz-sy1 );
}


void testOrthogonality( Matrix3x3 R ){  
  double aa = R.m00*R.m00 + R.m01*R.m01 + R.m02*R.m02;
  double ab = R.m00*R.m10 + R.m01*R.m11 + R.m02*R.m12;
  double ac = R.m00*R.m20 + R.m01*R.m21 + R.m02*R.m22;
  double bb = R.m10*R.m10 + R.m11*R.m11 + R.m12*R.m12;
  double bc = R.m10*R.m20 + R.m11*R.m21 + R.m12*R.m22;
  double cc = R.m20*R.m20 + R.m21*R.m21 + R.m22*R.m22;
  println(  aa+"   "+ab+"   "+ac  );
  println(  ab+"   "+bb+"   "+bc  );
  println(  ac+"   "+bc+"   "+cc  );
}
