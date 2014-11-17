
void paint( float[][] F1, float[][] F2, float s){
  loadPixels();
  for (int iy=0;iy<F.length;iy++){ for (int ix=0;ix<F.length;ix++){
    float c1 = s*F1[ix][iy];
    float c2 = s*F2[ix][iy];
    pixels[iy*width+ix] = color( 255-c2,255-c1-c2, 255-c1 );
  }}
  updatePixels();
}

float findMax( float [][] F){
  float Fmax = -1000000;
  for (int ix=0;ix<F.length;ix++){      for (int iy=0;iy<F.length;iy++){
     if ( F[ix][iy]>Fmax ) Fmax=F[ix][iy];
   }}
  return Fmax;
}
