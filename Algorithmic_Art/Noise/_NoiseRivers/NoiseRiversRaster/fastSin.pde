
/*
  this sinus function require input in format < 0, 4.0 > 
*/

float fastSin_x4(float x){
  final float c4 =1.0f/4.0f;
  final float c2 =5.0f/4.0f;
  if       (x<2.0f){ float dx=1.0f-x; float x2=dx*dx; return  1.0f - c2*x2 + c4*x2*x2;  }
  else             { float dx=3.0f-x; float x2=dx*dx; return -1.0f + c2*x2 - c4*x2*x2;  }
};

float fastCos_x4(float x){
  final float c4 =1.0f/4.0f;
  final float c2 =5.0f/4.0f;
  if       (x<1.0f){                  float x2= x* x; return  1.0f - c2*x2 + c4*x2*x2; }
  else if  (x<3.0f){ float dx=2.0f-x; float x2=dx*dx; return -1.0f + c2*x2 - c4*x2*x2; }
  else             { float dx=4.0f-x; float x2=dx*dx; return  1.0f - c2*x2 + c4*x2*x2; }
};
