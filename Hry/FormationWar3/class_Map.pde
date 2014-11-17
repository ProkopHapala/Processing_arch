

/*
this Trrain is defined by lineary interpolated rectangular grid 
*/

class Map{
  float paintMin,paintMax, paintRange;
  float fMin,fMax, fRange;
  float [][] F;   // sea level altitude
  //float tx,mtx,ty,mty;
  //int ix,iy;
  float dx,dy;
  
  float slope( float x, float y, float dx, float dy ){
      int ix      = int(x);         int iy      = int(y);
    float tx      = x-ix;         float ty      = y-iy;
    float mtx     = 1.0-tx;       float mty     = 1.0-ty;
    float dfdx = mty*( F[ix+1][iy  ]-F[ix][iy] ) + ty*( F[ix+1][iy+1]-F[ix  ][iy+1] );    
    float dfdy = mtx*( F[ix  ][iy+1]-F[ix][iy] ) + tx*( F[ix+1][iy+1]-F[ix+1][iy  ] );
    return dfdx*dx + dfdy*dy;
  }
  float f(float x, float y){   
      int ix      = int(x);         int iy      = int(y);
    float tx      = x-ix;         float ty      = y-iy;
    float mtx     = 1.0-tx;       float mty     = 1.0-ty;
    return mty*(mtx*F[ix][iy] + tx*F[ix+1][iy]) + ty*( mtx*F[ix][iy+1] + tx*F[ix+1][iy+1] );
  }
  /*
  void in( float x, float y){
    ix      = int(x);       iy      = int(y);
    tx      = x-ix;         ty      = y-iy;
    mtx     = 1.0-tx;       mty     = 1.0-ty;
  }
  float f(){
    return mty*(mtx*F[ix][iy] + tx*F[ix+1][iy]) + ty*( mtx*F[ix][iy+1] + tx*F[ix+1][iy+1] );
  }
  void slope(){
    dx = mty*( F[ix+1][iy  ]-F[ix][iy] ) + ty*( F[ix+1][iy+1]-F[ix  ][iy+1] );    
    dy = mtx*( F[ix  ][iy+1]-F[ix][iy] ) + tx*( F[ix+1][iy+1]-F[ix+1][iy  ] );
  }
  float    f(float x, float y){  n(x,y);  return f(); }
  void slope(float x, float y){  in(x,y); slope();    }
  float eval(float x, float y){  in(x,y); slope(); return f(); }
  */
  
  PImage toTexture(){
    PImage img = createImage(F.length, F[0].length, RGB);
    img.loadPixels();
    int i=0;
    for (int iy=0; iy<F[0].length; iy++){
      for (int ix=0; ix<F.length; ix++){ 
        float c = (F[ix][iy]-paintMin)/paintRange;
        img.pixels[i++] = color(c,c,c);
     }
    }
    img.updatePixels();
    return img;
  }
  
  PShape toShape(){
   PShape grid = createShape(GROUP);
   for (int ix=1; ix<F.length; ix++){ 
     for (int iy=1; iy<F[0].length; iy++){
       float c00 = (F[ix-1][iy-1]-paintMin)/paintRange; 
       float c10 = (F[ix  ][iy-1]-paintMin)/paintRange;
       float c11 = (F[ix  ][iy  ]-paintMin)/paintRange;
       float c01 = (F[ix-1][iy  ]-paintMin)/paintRange;
       PShape s1 = createShape();
          s1.beginShape();
          s1.noStroke();
          s1.vertex( ix-1,iy-1);   s1.setFill( 0, color(c00,c00,c00)&0x80FFFFFF );
          s1.vertex( ix  ,iy-1);   s1.setFill( 1, color(c10,c10,c10)&0x80FFFFFF );
          s1.vertex( ix  ,iy  );   s1.setFill( 2, color(c11,c11,c11)&0x80FFFFFF );
          s1.vertex( ix-1,iy  );   s1.setFill( 3, color(c01,c01,c01)&0x80FFFFFF );
       s1.endShape(CLOSE);
       grid.addChild(s1);
       PShape s2 = createShape();
          s2.beginShape();
          s2.noStroke();
          s2.vertex( ix-1,iy-1);   s2.setFill( 0, color(c00,c00,c00)&0x80FFFFFF );
          s2.vertex( ix-1,iy  );   s2.setFill( 1, color(c01,c01,c01)&0x80FFFFFF );
          s2.vertex( ix  ,iy  );   s2.setFill( 2, color(c11,c11,c11)&0x80FFFFFF );
          s2.vertex( ix  ,iy-1);   s2.setFill( 3, color(c10,c10,c10)&0x80FFFFFF );
       s2.endShape(CLOSE);
       grid.addChild(s2);
     }
   } 
   return grid;
  }  
  
  void findRange(){
    for (int ix=0; ix<F.length; ix++){  for (int iy=0; iy<F[0].length; iy++){ float f = F[ix][iy];
        if(f>fMax){fMax=f; }; if(f<fMin){fMin=f; }
    } }
    fRange = fMax - fMin;  
  }
  
  void autoPaintRange() { paintRange = fRange; paintMin = fMin; paintMax = fMax;   }
  void fillWave( float [][] fq ){
    for (int ix=0; ix<F.length; ix++){  for (int iy=0; iy<F[0].length; iy++){   
      float x = TWO_PI*((float)ix)/F.length;  float y = TWO_PI*((float)iy)/F[0].length; 
      float ff=0;
      for (int i=0; i<fq.length; i++){  float [] q = fq[i];
        ff += q[2]*cos(q[0]*x+q[1]*y + q[3]); 
      }
      F[ix][iy] = ff;
    }}
  };
  void fillRandom(float fMin, float fMax, float freq){
    this.fMin=fMin; this.fMax=fMax; fRange = fMax-fMin;
    for (int ix=0; ix<F.length; ix++){  for (int iy=0; iy<F[0].length; iy++){      
        F[ix][iy] = noise( freq*ix , freq*iy  ) * fRange + fMin;
        
        //F[ix][iy] = ix^iy;
        //F[ix][iy] = sin(ix*0.5);
        //F[ix][iy] = random(1.0 )*fRange+ fMin;
        //println(F[ix][iy]);
    } }
  }
  Map(float F[][])   {   this.F = F;               }   
  Map(int nx, int ny){   F = new float[nx+1][ny+1];    }
}
