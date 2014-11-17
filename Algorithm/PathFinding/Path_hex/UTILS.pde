
void PaintGrid( int ix0, int iy0, float [][] f, float maxf){
float sc=255/maxf;
for (int ix=0; ix<f.length; ix++){  
for (int iy=0; iy<f[0].length; iy++){ 
  //stroke(f[ix][iy]*sc);
  //point (ix+ix0-0.5*iy,iy+iy0); 
  set(int(ix+ix0-0.5*iy),iy+iy0,color(f[ix][iy]*sc));
}}
}

void PaintPosBuff( int ix0, int iy0, PosBuff A){
  stroke(0,255,0);
  for (int ii=0; ii<A.n; ii++){
    point ( A.x[ii]+ix0-0.5*A.y[ii], A.y[ii]+iy0 );
  }
}

