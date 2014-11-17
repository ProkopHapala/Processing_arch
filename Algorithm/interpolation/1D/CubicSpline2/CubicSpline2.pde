

static float [] ys = { 0, 1, -1, 0.3, 0.4, 1.5, 1, 0  };

float [] dys1 = new float[ys.length-2];
float [] dys2 = new float[ys.length-2];

int   nsub = 50;
float yzoom = 100;
float du = 1.0/nsub;

void setup(){
  size(400,400);
  
  gen_dy_4point     ( ys, dys1 );
  gen_dy_monotoneous( ys, dys2 );
  
  for (int i=0;i<ys.length;i++){  stroke(0); ellipse( nsub*i, 200-yzoom*(float)ys[i], 3, 3 ); }
  //plotSpline( ys, dys1, #0000FF, 0x800000FF, 0x400000FF );
  plotSpline( ys, dys2, #000000, #008000, #FF0000 );
}
