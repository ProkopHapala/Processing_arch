

double move_PROKOP( double [][] Cs, double [][] fCs,  double [][] vCs ){
  double []  xs =  Cs[0];
  double []  ys =  Cs[1];
  double [] vxs = vCs[0];
  double [] vys = vCs[1];
  double [] fxs = fCs[0];
  double [] fys = fCs[1];
  double a = alfa; double ma = 1.0d-a;
  double ff = 0,vv = 0,P=0; 
  for (int i=2;i<(ncoef-2);i++){ 
    double vxi = vxs[i]; 
    double fxi = fxs[i];
    double vyi = vys[i]; 
    double fyi = fys[i];
    ff += fxi*fxi + fyi*fyi;
    vv += vxi*vxi + vyi*vyi;
    P  += vxi*fxi + vyi*fyi;
  }
  //double fvscale = a*Math.sqrt( vv/ff );
  double cVF= a*Math.sqrt( vv*ff );
  //println( "vv: "+vv+" ff: "+ff+" P: "+P+" fscale: "+fvscale  );
  for (int i=2;i<(ncoef-2);i++){
      double vx_  = vxs[i] + ( 1 - cVF )*fxs[i];
      double vy_  = vys[i] + ( 1 - cVF )*fys[i];
    vxs[i]  = vx_    ;
    vys[i]  = vy_    ;
     xs[i] += vx_*dt ; 
     ys[i] += vy_*dt ; 
  }  
  return ff;
}
