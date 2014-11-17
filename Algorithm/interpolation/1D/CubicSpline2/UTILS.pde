


void plotSpline( float [] ys, float [] dys, color cy, color cdy, color cddy ){
  float   ox   = nsub;
  float   os   = 200-   yzoom*(float)  spline_hermite ( 0, ys[0], ys[1], dys[0], dys[1]  );
  float  ods   = 200-   yzoom*(float)  spline_hermite ( 0, ys[0], ys[1], dys[0], dys[1]  ) * 0.25;
  float odds   = 200-   yzoom*(float)  spline_hermite ( 0, ys[0], ys[1], dys[0], dys[1]  ) * 0.05;
  for (int i=1;i<dys.length;i++){ 
    float  x0 = nsub*i;
    float  y0 =  ys[i];
    float  y1 =  ys[i+1];
    float dy0 = dys[i-1];
    float dy1 = dys[i];  
    for(int iu=0;iu<nsub;iu++){
      float u = iu*du; float x = x0 + u*nsub;
      float   s   = 200-   yzoom*(float)   spline_hermite ( u, y0, y1, dy0, dy1  );
      float  ds   = 200-   yzoom*(float)  dspline_hermite ( u, y0, y1, dy0, dy1  ) * 0.25;
      float dds   = 200-   yzoom*(float) ddspline_hermite ( u, y0, y1, dy0, dy1  ) * 0.05;
      stroke( cy ); line( ox,os,   x,s   );
      stroke( cdy ); line( ox,ods,  x,ds  );
      stroke( cddy); line( ox,odds, x,dds );
      //println( ox+" "+x+" "+os+" "+s );
      ox=x; os=s; ods=ds; odds=dds;
    }
  }

}
