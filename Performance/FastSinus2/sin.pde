

float fastCos_lin(float xin){
  float xx = xin/PI;
  int xi = int(xx);
  float x = 2.0*(xx-xi);
  if ((xi % 2)==0){    return 1.0-x;
  }else{              return x-1.0; }
}

float fastSin_lin(float xin){
  return fastCos_lin(xin-HALF_PI);
}

float fastCos_int(float x){
  float xx = x/HALF_PI;
  int xi = int(xx);
  float dx = xx-xi;
  int i = xi % 4;
  if       (i==0){                   return  1.0 - dx*dx;  }
  else if  (i==1){ float mx=1.0-dx;  return -1.0 + mx*mx;  }
  else if  (i==2){                   return -1.0 + dx*dx;  }
  else            { float mx=1.0-dx; return  1.0 - mx*mx;  }
};

float fastSin_int(float x){
  float xx = x/HALF_PI;
  int xi = int(xx);
  float dx = xx-xi;
  int i = xi % 4;
  if       (i==0){ float mx=1.0-dx;  return +1.0 - mx*mx;  }
  else if  (i==1){                   return +1.0 - dx*dx;  }
  else if  (i==2){ float mx=1.0-dx;  return -1.0 + mx*mx;  }
  else           {                   return -1.0 + dx*dx;  }
};

float fastCos_int2(float xin){
  final float c4 =1.0/4.0;
  final float c2 =5.0/4.0;
  float xx = xin/HALF_PI;
  int xi = int(xx);
  float x = (xx-xi);
  int i = xi % 4;
  if       (i==0){            float x2=x*x; return  1.0 - c2*x2 +c4*x2*x2;  }
  else if  (i==1){ x=(1.0-x); float x2=x*x; return -1.0 + c2*x2 -c4*x2*x2;  }
  else if  (i==2){            float x2=x*x; return -1.0 + c2*x2 -c4*x2*x2;  }
  else           { x=(1.0-x); float x2=x*x; return  1.0 - c2*x2 +c4*x2*x2;  }
};

float fastSin_int2(float x){
 return fastCos_int2(x-HALF_PI);
}
