
void paint( float[][] F, float s){
  for (int ix=0;ix<F.length;ix++){      for (int iy=0;iy<F.length;iy++){
     //set(ix,iy,  color(   sqrt(s*F[ix][iy])  )  );
     set(ix,iy,  color(   1-sqrt(s*F[ix][iy] ))  );
    }  }
}

void fade( float[][] F, float s){
  for (int ix=0;ix<F.length;ix++){      for (int iy=0;iy<F.length;iy++){
     F[ix][iy]*=s;
    }  }
}



float findMax( float[][] F){
  float Fmax = -1000000;
  for (int ix=0;ix<F.length;ix++){      for (int iy=0;iy<F.length;iy++){
     if ( F[ix][iy]>Fmax ) Fmax=F[ix][iy];
   }}
  return Fmax;
}

