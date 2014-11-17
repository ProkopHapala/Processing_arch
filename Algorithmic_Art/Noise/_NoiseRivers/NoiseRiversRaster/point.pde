
int npoints=0;

class Point {
  float x,y;  // float vx,vy;
  int len;

  Point(float x, float y){ newPos(); } 
  Point(){ this.x = random(width); this.x = random(height);  }

  void newPos(){  int id=npoints%sz2; int ix=id%sz; int iy=id/sz;
        x = ix+random(1.0); y = iy+random(1.0); len=0; npoints++; 
      }
  void update(){
    stroke(0,16);
    float r = random(1);
    //float f = noise(this.x*.01,this.y*.01)*TWO_PI;
    //float f = VerySimpexNoise2D( this.x*0.02, this.y*0.02 ) * TWO_PI;
    //this.xv =  cos(  f  ); this.yv = -sin(  f  );
    float c= 2.5;
    
    float f =0;
    VectorSimplexNoise2D( (x+xOffset)*0.008*c, y*0.008*c ); f+=(noise_dx+0.5)*2.0f;
    VectorSimplexNoise2D( (x+xOffset)*0.016*c, y*0.016*c ); f+=(noise_dx+0.5)*2.0f;
    
    /*
    //Warp3( x*100,y*100, 0.3, 0.5 );  
    Warp3( x/512,y/512, 1.6, 1.0 );  
    float f=(noise_dx+0.5)*4.0f;  
    */
    /*
    x +=  fastCos_x4( f )*(1+random(4));
    y +=  fastSin_x4( f )*(1+random(4));
    */
    x +=  fastCos_x4( f )*0.5;
    y +=  fastSin_x4( f )*0.5;
    if ((x>F.length-1) || (x<0) || (y>F[0].length-1) || (y<0) ) newPos();
    //F[int(x)][int(y)]++;
    F[int(x)][int(y)] = max ( F[int(x)][int(y)] ,   len );
    len++;
    //if (len>1000000){ newPos(); }
    iters++;
  }

}
