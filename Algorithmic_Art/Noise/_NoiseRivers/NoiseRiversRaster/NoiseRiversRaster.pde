

final int sz = 512;
final int sz2 = sz*sz;
final int n = 10000;
int iters = 0;
float xOffset=0.0;
Point [] points;
float [][] F;

void setup(){
  size(sz,sz, P2D);
  colorMode(RGB,1);
  background(255);
  points = new Point[n];
  F      = new float[sz][sz]; 
  for (int i=0;i<n; i++){ points[i]=new Point(); }
}

void draw(){
  for (int ic=0;ic<10; ic++){
    for (int i=0;i<n; i++){ points[i].update(); }
  } 
  //xOffset+=2.0;
  float Fmax = findMax(F); 
  paint( F, 1.0/Fmax );
 // fade(F,0.9);
  
  println( "  iters: " + iters +"  Fmax: " + Fmax );
}







