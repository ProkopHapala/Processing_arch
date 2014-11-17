
float tsc( double x){
  return sz + zoom*(float)x;
}

void plot( double [][] pos,  double [][] f  ){
  float ox = tsc( pos[0][0] );
  float oy = tsc( pos[1][0] );
  for (int i=0; i<pos[0].length;i++){
    double x = pos[0][i]; double y = pos[1][i];
    float xx=tsc(x); float yy=tsc(y);  
    stroke(0);
    ellipse(xx,yy,5,5);
    line   (xx,yy, ox,oy);
    stroke(255,0,0);
    line   (xx,yy, tsc(x+f[0][i]*fzoom), tsc(y+f[1][i]*fzoom) );
    ox=xx; oy=yy;
  }
}


void rotate( double alfa, double [][] pos ){
  double ca = Math.cos(alfa); 
  double sa = Math.sin(alfa);
  double [] xs  = pos[0];
  double [] ys  = pos[1];
  for (int i=0; i<pos[0].length;i++){ 
     double x = xs[i];
     double y = ys[i];
     xs[i] = ca*x - sa*y;
     ys[i] = sa*x + ca*y;
  };
};
