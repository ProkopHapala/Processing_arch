
final int   sz = 512;
final float watterLevel= 0.55;

void setup(){
/*  
tris = new float[10][10];
for (int ix=0;ix<tris.length;ix++){ for (int iy=0;iy<tris[0].length;iy++){
   tris[ix][iy] = random(1.0);
}}
*/  
  
size (sz,sz);
colorMode(RGB,1.0);
background(0);

}



void draw(){
//float c1=0.5+0.25*sin( frameCount*0.1  );
//float c2=1.6*sin( frameCount*0.1  );
float sa=sin( frameCount*0.1  );
float ca=cos( frameCount*0.1  );

for (int ix=0;ix<sz;ix+=1){
  for (int iy=0;iy<sz;iy+=1){
    float dx=0,dy=0;
    
 //method 1
    //Warp3( ix, iy,  0.5 , c2 );

     Warp3R( (ix+noise_dx + frameCount*5)*2, (iy+noise_dy )*2,  0.5, 1.2, ca, sa );
    //Warp4( ix, iy,  0.5 , c2 );
    //Warp4R( ix, iy,  0.65 , 0.5, c3  );
    float c = (noise_dx + noise_dy + 1.0)*0.5;
    if ( c<watterLevel) {
      set(ix,iy, color(0,0.5,1.0));
    }else {
      c-=watterLevel;
      c=c/(1.0-watterLevel);
      c=1.0 - 4*c*c;
      set(ix,iy,color(c+1.0,c+0.5,c));
    }
    //set(ix,iy,color(noise_dx+0.5,(noise_dx+noise_dx),noise_dy+0.5)); 

  }
}
}

void Warp3( float x, float y, float ff, float sc ){
  noise_dx=0; noise_dy=0;
  float f=1.0;
  for (int i=0; i<8; i++){
    VectorSimplexNoise2D( x*f+noise_dx*sc, y*f+noise_dy*sc );
    f*=ff;
  };
};

void Warp4( float x, float y, float ff, float sc ){
  noise_dx=0; noise_dy=0;
  float f=1.0;
  for (int i=0; i<8; i++){
    x*=ff;             y*=ff;
    x+= noise_dx*sc;   y+= noise_dy*sc;
    VectorSimplexNoise2D( x, y );
  };
};

void Warp3R( float x, float y, float ff, float sc, float ca, float sa ){
  noise_dx=0; noise_dy=0;
  float f=1.0;
  for (int i=0; i<8; i++){
    float xx = x*f+ sc*(noise_dx*ca + noise_dy*sa);
    float yy = y*f+ sc*(noise_dy*ca - noise_dx*sa);
    VectorSimplexNoise2D( xx, yy );
    f*=ff;
  };
};

void Warp4R( float x, float y, float ff, float sc, float rc ){
  float mc = 1.0-rc;
  noise_dx=0; noise_dy=0;
  float f=1.0;
  for (int i=0; i<12; i++){
    x*=ff; y*=ff; 
    x+= sc*(noise_dx*rc + noise_dy*mc);             
    y+= sc*(noise_dx*mc - noise_dy*rc);
    VectorSimplexNoise2D( x, y );
  };
};
