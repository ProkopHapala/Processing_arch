

float speed = 4;

class Point {
  float x,y,xv=0, yv=0;
  float len;
    
  Point(float x, float y){   this.x = x; this.y = y; len = 0; } 
  boolean update(){
    int ix = int(x); int iy = int(y);
    if ((ix>sz) || (ix<0) || (iy>sz) || (iy<0) ) { return true; }
    float alfa=1.5*myNoise(x*sc,y*sc)*TWO_PI;
    xv =  speed*cos(  alfa  ); yv = -speed*sin(  alfa  );
    len +=sqrt( xv*xv + yv*yv);
    x += xv; y += yv;
    return false;
  }

}
