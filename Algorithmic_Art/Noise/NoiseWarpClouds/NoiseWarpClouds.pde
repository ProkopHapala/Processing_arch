
final int sz = 512;
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
float c2=1.6*sin( frameCount*0.1  );
//float c2=sin(   );
for (int ix=0;ix<sz;ix+=1){
  for (int iy=0;iy<sz;iy+=1){
    float dx=0,dy=0;
    
 //method 1
    Warp3( ix, iy,  0.5 , c2 );
    set(ix,iy,color(noise_dx+0.5,noise_dz+0.5,noise_dy+0.5)); 
    
    /*
 // method 2 
    Warp3( ix, iy,  0.5 , 1.2 ); 
    VectorSimplexNoise2D( ix/32.0+noise_dx*8,  iy/32.0+noise_dy*8 );
    set(ix,iy,color(noise_dx+0.5,noise_dx+0.5,noise_dx+0.5)); 
    */
    /*
 // method 3   
    Warp3( ix, iy,  0.3 , 0.8 );
    VectorSimplexNoise2D( noise_dx*512,  noise_dy*512 );
    set(ix,iy,color(noise_dx+0.5,noise_dx+0.5,noise_dx+0.5));  
    */
  }
}
}





void Warp1( float x, float y, float sc ){
  noise_dx=0; noise_dy=0;
  float f=1.0;
  for (int i=0; i<8; i++){
    VectorSimplexNoise2D( x+noise_dx*sc, y+noise_dy*sc );
  };
};

void Warp2( float x, float y, float ff ){
  noise_dx=0; noise_dy=0;
  float f=1.0;
  for (int i=0; i<8; i++){
    VectorSimplexNoise2D( x*f+noise_dx, y*f+noise_dy );
    f*=ff;
  };
};

void Warp3( float x, float y, float ff, float sc ){
  noise_dx=0; noise_dy=0;
  float f=1.0;
  for (int i=0; i<8; i++){
    VectorSimplexNoise2D( x*f+noise_dx*sc, y*f+noise_dy*sc );
    f*=ff;
  };
};
