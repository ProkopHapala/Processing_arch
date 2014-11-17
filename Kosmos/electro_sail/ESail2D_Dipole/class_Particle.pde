


class Particle{
  double m,ch;
  double fx,fy;
  double x,y;
  double vx,vy;
  Particle( double x0, double y0, double vx0, double vy0, double m, double ch ){ x=x0;y=y0;   vx=vx0;vy=vy0; this.m=m; this.ch=ch; }
 
  void move( ){
    vx+=dt*fx/m; vy+=dt*fy/m;
    x+=vx*dt;  y+=vy*dt; 
    fx=0;fy=0;
  }
  
  void paint( float[][] F, color c){
    int ix = (int)(x*zoom +sz);     int iy = (int)(y*zoom + sz);
    //println(ix+" "+iy);
    if ((ix>0)&&(ix<sz2)&&(iy>0)&&(iy<sz2)){
      //set( ix, iy, c  );
      F[ix][iy]++;
    }
  }
  
  void paintForce( float sc ){
    double xx = x*zoom +sz;     double yy = y*zoom + sz;
    line( (float)xx,         (float)yy,
          (float)(xx+fx*sc), (float)(yy+fy*sc) );
    ellipse( (int)xx, (int)yy ,4,4);
  } 
  
}


void force( Particle A, Particle B){
  double dx = A.x - B.x;
  double dy = A.y - B.y;
  //double k = ke*A.ch*B.ch;
  double r2 = dx*dx+ dy*dy + soft;  // softening
  double r = Math.sqrt(r2);
  double ufr = A.ch*B.ch*ke/(r*r2);
  A.fx += dx*ufr;   A.fy += dy*ufr;  
  B.fx -= dx*ufr;   B.fy -= dy*ufr; 
}


void force2( Particle A, Particle B){
  double dx = A.x - B.x;
  double dy = A.y - B.y;
  //double k = ke*A.ch*B.ch;
  double r2 = dx*dx+ dy*dy + soft;  // softening
  double r = Math.sqrt(r2);
  double ufr = A.ch*B.ch*ke/(r*r2);
  A.fx += dx*ufr;   A.fy += dy*ufr;  
}

