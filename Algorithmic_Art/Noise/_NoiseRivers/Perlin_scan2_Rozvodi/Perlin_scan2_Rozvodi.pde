
int sz = 512;
float sc = 0.05;

Point p1;

float valmax = 1024;
float [][] acum = new float[sz+1][sz+1]; 
Boolean md = false;

float myNoise(float x, float y){
  return noise(x,y);
};

void setup(){
  size(2*sz,sz);
  //background(200);
  noiseDetail(3,0.5);
  colorMode(HSB,1);
  noiseSeed(2);
  //smooth();
  for (int ix=0;ix<sz;ix++){
    for (int iy=0;iy<sz;iy++){
      float c = myNoise(ix*sc,iy*sc);
      set(ix,iy, color( 1, 0, c ) );
    };
  };
}

int ix=0,iy=0;
void draw(){
  for (int i=0;i<1000; i++){
    ix++;
    if(ix>sz){ix=0;iy++;}
    p1 = new Point(ix,iy);
    for (int j=0;j<1000; j++){
      if(p1.update()) break;
    }
    //float c = (255 - p1.len/3)/256.0;
    float c = p1.len/4/256.0;
    //println(p1.len+" "+c);
    set(ix+sz,iy, color( sin(50*atan2(p1.x,p1.y)/TWO_PI)/2+0.5,1,c));
  }
}






