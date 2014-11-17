
/*
 this is very fast sinus and cosinus approximation using 4th-degree polynominal on HALF_PI segments
 this version is optized to wokr on interval 0..2Pi which is mapped to 0..4.0 in order to be faster
*/

float fastSin_x4(float x){
  final float c4 =1.0/4.0;
  final float c2 =5.0/4.0;
  if       (x<2.0f){ float dx=1.0f-x; float x2=dx*dx; return  1.0f - c2*x2 + c4*x2*x2;  }
  else             { float dx=3.0f-x; float x2=dx*dx; return -1.0f + c2*x2 - c4*x2*x2;  }
};

float fastCos_x4(float x){
  final float c4 =1.0/4.0;
  final float c2 =5.0/4.0;
  if       (x<1.0f){                  float x2= x* x; return  1.0f - c2*x2 + c4*x2*x2; }
  else if  (x<3.0f){ float dx=2.0f-x; float x2=dx*dx; return -1.0f + c2*x2 - c4*x2*x2; }
  else             { float dx=4.0f-x; float x2=dx*dx; return  1.0f - c2*x2 + c4*x2*x2; }
};
