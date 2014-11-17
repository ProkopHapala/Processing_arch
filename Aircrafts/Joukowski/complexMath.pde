
void cmult( float ax, float ay,   float bx, float by ){
  cx = ax*bx - ay*by;
  cy = ax*by + ay*bx; 
}

void csq( float ax, float ay  ){
  cx= ax*ax - ay*ay;
  cy= 2*ax*ay;
}

float cabs2( float ax, float ay ){
return ax*ax+ ay*ay; 
};

float cabs( float ax, float ay ){
return sqrt(cabs2( ax, ay ));
}

void cdiv( float ax, float ay,   float bx, float by ){
  float iR2 = 1.0/cabs2(bx,by);
  cx = (ax*bx + ay*by)*iR2;
  cy = (ay*bx - ax*by)*iR2;
}
