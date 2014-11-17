class Point {
  float x,y;  // float vx,vy;

  Point(float x, float y){ this.x = x; this.y = y; } 
  Point(){ this.x = random(width); this.x = random(height);  }

  void newPos(){ x = random(F.length-1); y = random(F[0].length-1); }
  void update(){
    stroke(0,16);
    float r = random(1);
    //float f = noise(this.x*.01,this.y*.01)*TWO_PI;
    //float f = VerySimpexNoise2D( this.x*0.02, this.y*0.02 ) * TWO_PI;
    //this.xv =  cos(  f  ); this.yv = -sin(  f  );
    float c= 2.5;
    float f  = VerySimpexNoise2D( (x+xOffset)*0.008*c, y*0.008*c ) * 4.0f
             + VerySimpexNoise2D( (x+xOffset)*0.016*c, y*0.016*c ) * 1.0f
             + VerySimpexNoise2D( (x+xOffset)*0.032*c, y*0.032*c ) * 1.0f;
    x +=  fastCos_x4( f );
    y +=  fastSin_x4( f );
    if ((x>F.length-1) || (x<0) || (y>F[0].length-1) || (y<0) ) newPos();
    F[int(x)][int(y)]++;
    if( F[int(x)][int(y)]<100.0 ){  
              F[int(x)][int(y)]++;
    }else{    newPos();              }
    iters++;
  }

}
