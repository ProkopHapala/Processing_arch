// hermite spline from here http://en.wikipedia.org/wiki/Cubic_Hermite_spline

final static float spline_hermite_didactic( float x, float y0, float y1, float dy0, float dy1 ){
  float x2 = x*x;
  float x3 = x2*x;
  return (2*x3 - 3*x2 + 1)*y0 + (x3-2*x2+x)*dy0 + (-2*x3+3*x2)*y1 + (x3-x2)*dy1;
}

final static float spline_hermite( float x, float y0, float y1, float dy0, float dy1 ){  
  return        y0
        +x*(          dy0              
        +x*( -3*y0 -2*dy0  +3*y1 - dy1   
        +x*(  2*y0 +  dy0  -2*y1 + dy1 )));
}

final static float dspline_hermite( float x, float y0, float y1, float dy0, float dy1 ){  
  return              dy0              
        +x*( -6*y0 -4*dy0  +6*y1 -2*dy1   
        +x*(  6*y0 +3*dy0  -6*y1 +3*dy1 ));
}

final static float ddspline_hermite( float x, float y0, float y1, float dy0, float dy1 ){  
  return     -6*y0 -4*dy0   +6*y1 -2*dy1   
        +x*( 12*y0 +6*dy0  -12*y1 +6*dy1 );
}


final static void gen_dy_4point( float [] ys, float [] dys ){
  float ooy = ys[0];
  float  oy = ys[1];
  for (int i=0; i<dys.length; i++){
    float y = ys[i+2];
    dys[i] = 0.5*( y - ooy );
    ooy=oy; oy=y;
  }
}

final static void gen_dy_monotoneous( float [] ys, float [] dys ){
  float oy  = ys[1]; 
  float ody = oy - ys[0]; 
  for (int i=0; i<dys.length; i++){
    float  y  =  ys[i+2];
    float dy  = y - oy;
    if( (dy*ody)>0 ){ float a = abs(ody); float b = abs(dy); dys[i] = (a*dy+b*ody)/(a+b); }else{ dys[i]=0; }
    oy=y; ody=dy;
  }
}
