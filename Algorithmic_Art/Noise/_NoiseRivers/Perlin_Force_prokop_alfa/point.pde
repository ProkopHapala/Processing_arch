


class Point {
  float x,y,xv = 0, yv = 0;
  int steps;
  Boolean finished;

  Point(float x, float y){ reset(x,y);  } 
  void reset (float x, float y){this.x = x; this.y = y; steps = 0; finished=false; }
  
  void update(){
    int ix = int(x); int iy = int(y);
    if ((ix>sz) || (ix<0) || (iy>sz) || (iy<0) ) {   finished = true; return; }
    if( acum[ix][iy]>valmax ) { finished = true;  return; }
    float alfa=myNoise(x*sc,y*sc)*TWO_PI;
    xv =  cos(  alfa  ); yv = -sin(  alfa  );
    //acum[ix][iy]+=steps;
    acum[ix][iy]+=1;
    //line(this.x+this.xv, this.y+this.yv,this.x,this.y );
    x += xv; y += yv;
    steps++;
    //stroke(0,3); point(sz+x,y);
  }

}
