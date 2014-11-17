void hermite2D( float u, float v, float [] p00, float [] p01, float [] p10, float [] p11, float [] pout ){
  float u2   = u*u;
  float u3   = u2*u;
  
  // optimized
  float temp_2u3_3u2 = 2*u3 - 3*u2  ;
  float bu0  =  temp_2u3_3u2    + 1 ;
  float bu1  = -temp_2u3_3u2        ;
  float temp_u3_u2 = u3 -   u2;
  float tu0  =  temp_u3_u2 - u2 + u;
  float tu1  =  temp_u3_u2         ;
  
  float x0   = p00[0]* bu0 + p01[0]* bu1 + p00[1]* tu0 + p01[1]* tu1;
  float x1   = p10[0]* bu0 + p11[0]* bu1 + p10[1]* tu0 + p11[1]* tu1;
  float x0_v = p00[2]* bu0 + p01[2]* bu1 ;
  float x1_v = p10[2]* bu0 + p11[2]* bu1 ;
  
  float y0   = p00[3]* bu0 + p01[3]* bu1 + p00[4]* tu0 + p01[4]* tu1;
  float y1   = p10[3]* bu0 + p11[3]* bu1 + p10[4]* tu0 + p11[4]* tu1;
  float y0_v = p00[5]* bu0 + p01[5]* bu1 ;
  float y1_v = p10[5]* bu0 + p11[5]* bu1 ;
  
  float z0   = p00[6]* bu0 + p01[6]* bu1 + p00[7]* tu0 + p01[7]* tu1;
  float z1   = p10[6]* bu0 + p11[6]* bu1 + p10[7]* tu0 + p11[7]* tu1;
  float z0_v = p00[8]* bu0 + p01[8]* bu1 ;
  float z1_v = p10[8]* bu0 + p11[8]* bu1 ;
  
  float v2  = v*v;
  float v3  = v2*v;
  
  float temp_2v3_3v2 = 2*v3 - 3*v2  ;
  float bv0  =  temp_2v3_3v2    + 1 ;
  float bv1  = -temp_2v3_3v2        ;
  float temp_v3_v2 = v3 -   v2;
  float tv0  =  temp_v3_v2 - v2 + v;
  float tv1  =  temp_v3_v2         ;
  
  pout[0] =  x0*bv0 + x1*bv1 + x0_v*tv0 + x1_v*tv1;
  pout[1] =  y0*bv0 + y1*bv1 + y0_v*tv0 + y1_v*tv1;
  pout[2] =  z0*bv0 + z1*bv1 + z0_v*tv0 + z1_v*tv1;
  
}
