
// ======== Algorithm

final void flow_and_errosion( ){
   // gradient evaluation
   for(int i=1;i<n-1;i++){ for(int j=1;j<n-1;j++){ 
     float hij  = h[i][j];
     int imin = 0,jmin = 0;
     float dh,dhmin=0,dhmin2=0;
     dh = h[i-1][j  ]-hij;         if( dh<dhmin ){  imin = -1; jmin =  0; dhmin2=dhmin; dhmin = dh; }
     dh = h[i+1][j  ]-hij;         if( dh<dhmin ){  imin = +1; jmin =  0; dhmin2=dhmin; dhmin = dh; }
     dh = h[i  ][j-1]-hij;         if( dh<dhmin ){  imin =  0; jmin = -1; dhmin2=dhmin; dhmin = dh; }
     dh = h[i  ][j+1]-hij;         if( dh<dhmin ){  imin =  0; jmin = +1; dhmin2=dhmin; dhmin = dh; }
     final float cdiag = 0.70710678118;
     dh = (h[i-1][j-1]-hij)*cdiag; if( dh<dhmin ){  imin = -1; jmin = -1; dhmin2=dhmin; dhmin = dh; }
     dh = (h[i-1][j+1]-hij)*cdiag; if( dh<dhmin ){  imin = -1; jmin = +1; dhmin2=dhmin; dhmin = dh; }
     dh = (h[i+1][j-1]-hij)*cdiag; if( dh<dhmin ){  imin = +1; jmin = -1; dhmin2=dhmin; dhmin = dh; }
     dh = (h[i+1][j+1]-hij)*cdiag; if( dh<dhmin ){  imin = +1; jmin = +1; dhmin2=dhmin; dhmin = dh; }
     //println( i+" "+j+" "+dhmin+" "+dhmin2 );
     if( dhmin<-0.00001 ){
       float wij   = watter[i][j];
       float sediment = wij*c_sediment/(1-dhmin); wij-=sediment;
       watter_[i+imin][j+jmin] += wij;
       //float mud =  c_errode * wij*(-dhmin);
       float mud =  c_errode * sqrt(wij)*(-dhmin);
       mud = min( mud, (dhmin2 - dhmin) * 0.1  );
       h[i][j]            =   hij  - mud + sediment;
       //h[i][j]            =    f_orig*h_orig[i][j] + mf_orig*hij  - mud + sediment;
       h[i+imin][j+jmin] += mud*f_sediment;
     }
   } } 
}

final void rain_and_evaporation ( ){
  for(int i=1;i<n-1;i++){ for(int j=1;j<n-1;j++){ 
    float wij     = watter_[i][j]  + c_rain;   watter_[i][j] = 0.0;
    watter[i][j]  = watter[i][j]*mf_mix +   wij*f_mix;
  } }
}

final void plot(int ix0, int iy0, float sc, float [][] Fin ){
  int nj=Fin[0].length;
  float fmin = 0;
  if (sc<0){
    fmin = 1000000; float fmax = -1000000;
    for(int i=2;i<Fin.length-2;i++){ for(int j=2;j<nj-2;j++){
      float fij  = Fin[i][j];
      if(fij>fmax) fmax=fij;  if(fij<fmin) fmin=fij;
    } }
    sc = -sc/(fmax-fmin);
  }
  for(int i=0;i<Fin.length;i++){ for(int j=0;j<nj;j++){
    float f = 255*sc*(Fin[i][j]-fmin); 
    color c = color(f,f,f);
    set(i+ix0,j+iy0, c);
  } }
}




