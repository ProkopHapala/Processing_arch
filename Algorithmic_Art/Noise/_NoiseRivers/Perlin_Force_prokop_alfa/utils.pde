
/*
void plot(float [][] F){
  loadPixels();
  for (int ix=0;ix<sz;ix++){
      for (int iy=0;iy<sz;iy++){
      int c = F [ix][iy];
      pixels[i+halfImage] = c<<16 || c<<8 || c;
    }
  }
  updatePixels();
}
*/


float acumMin = 0;
void plot(){
  float omin = acumMin; acumMin=1000000;
  for (int ix=0;ix<sz;ix++){
    for (int iy=0;iy<sz;iy++){
      //float c = 255-acum[ix][iy]*255/valmax;
      acumMin = min(acumMin,acum[ix][iy]);
      float c = 255-sqrt(acum[ix][iy]-omin)*255/sqrt(valmax);
      set(ix+sz,iy, color( c, c, c ) );
    };
  };
}
