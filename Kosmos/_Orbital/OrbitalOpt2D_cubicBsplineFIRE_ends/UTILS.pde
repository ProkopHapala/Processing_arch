
float sx( double x ){
  return sz+yzoom*(float)x;
}

void plotSpline(){
  float du = 1.0/nsub;
  int n= Cs[0].length;
  stroke(0); for (int i=0;i<n;i++){ ellipse( sx( Cs[0][i] ) , sx( Cs[1][i] ), 3, 3 ); }
  stroke(128,128,0); ellipse( sx(Cs[0][0  ]) , sx(Cs[1][0  ]), 3, 3 );
  stroke(255,  0,0); ellipse( sx(Cs[0][1  ]) , sx(Cs[1][1  ]), 3, 3 );
  stroke(0,  0,255); ellipse( sx(Cs[0][n-2]) , sx(Cs[1][n-2]), 3, 3 );
  stroke(0,128,128); ellipse( sx(Cs[0][n-1]) , sx(Cs[1][n-1]), 3, 3 );
  float ox=sx( Bspline  ( 0, Cs[0][3], Cs[0][2], Cs[0][1], Cs[0][0] ) );
  float oy=sx( Bspline  ( 0, Cs[1][3], Cs[1][2], Cs[1][1], Cs[1][0] ) );
  for (int i=3;i<n;i++){ 
    for(int iu=0;iu<nsub;iu++){
      float u = iu*du;
      float x   = sx( Bspline  ( u, Cs[0][i], Cs[0][i-1], Cs[0][i-2], Cs[0][i-3] ) );
      float y   = sx( Bspline  ( u, Cs[1][i], Cs[1][i-1], Cs[1][i-2], Cs[1][i-3] ) );
      stroke(0,0,0); line( ox,oy,   x,y   );
      ox=x; oy=y;
    }
  }
  stroke(128,128,128);
  line(0,sz,2*sz,sz);
  line(sz,0,sz,2*sz);
}

void init_tranjectory(  ){
  double rstart   = Math.sqrt(  xstart[0]*xstart[0]  +   xstart[1]*xstart[1] );
  double phistart = Math.atan2( xstart[0], xstart[1] );
  double rend     = Math.sqrt(  xend[0]*xend[0]  +   xend[1]*xend[1] );
  double phiend   = Math.atan2( xend[0], xend[1] );
  double du       = 1.0/(Cs[0].length-3);
  println( " start = (" + rstart +","+ phistart + ")  end = (" + rend +","+ phiend + ") " );
  println( " du = "+du );
  for (int i=0; i<(Cs[0].length-3); i++){
    double u = du*i; double mu = 1 - u;
    double r   = mu*rstart   + u*rend;
    double phi = mu*phistart + u*phiend;
    double cp = Math.cos(phi); 
    double sp = Math.sin(phi);
    Cs[0][i+1]=sp*r; 
    Cs[1][i+1]=cp*r;
    //println( i+" "+Cs[0][i+1]+" "+Cs[1][i+1]+" u "+u+"   r "+r+" phi "+phi );
  }
}

String vec2str(double [] a){ 
  String s = "";
  for (int i=0; i<a.length-3; i++){  s+=" "+a[i]; }
  return s;
}


