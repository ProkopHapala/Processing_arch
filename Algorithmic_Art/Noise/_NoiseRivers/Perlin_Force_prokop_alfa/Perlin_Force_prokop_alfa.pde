
int sz = 512;
float sc = 0.01;

ArrayList<Point> points = new ArrayList();

float valmax = 1000;
float [][] acum = new float[sz+1][sz+1]; 

Boolean md = false;


float myNoise(float x, float y){
return noise(x,y);
};

void setup(){
  size(2*sz,sz);
  background(255);
  noiseDetail(8,0.7);
  //noiseSeed(1);
  //smooth();
  for (int ix=0;ix<sz;ix++){
    for (int iy=0;iy<sz;iy++){
      float c = myNoise(ix*sc,iy*sc)*255;
      set(ix,iy, color( c, c, c ) );
    };
  };
  for(int f=0; f<100; f+=1){ points.add(new Point(random(sz),random(sz)) ); }
}

void draw(){
  for (int i=0;i<100; i++){
    for(Point p : points){
      p.update();
      if(p.finished){
        p.reset(random(sz), random(sz));
      }
    } 
  }
  plot();
  println(points.size());
}


void keyPressed(){
if(key=='s'){save("out.png");}
}



