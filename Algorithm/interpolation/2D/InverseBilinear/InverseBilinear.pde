
//                    x00 x01  x10  x11

static float [] ys = {  16, 260,  73, 230  };
static float [] xs = {  30,  25, 266, 242  };

static float [] uv = {0,0,0,0};
static float [] xy = {0,0};

void setup(){
  
  size(300,300);
  
  ellipse( xs[0], ys[0], 5,5 );
  ellipse( xs[1], ys[1], 5,5 );
  ellipse( xs[2], ys[2], 5,5 );
  ellipse( xs[3], ys[3], 5,5 );
  
  line( xs[0], ys[0], xs[2], ys[2] );
  line( xs[1], ys[1], xs[3], ys[3] );
  line( xs[2], ys[2], xs[3], ys[3] );
  line( xs[1], ys[1], xs[0], ys[0] );

}

void draw(){
}

void mouseReleased(){
  invbilerp( mouseX, mouseY,    xs[0], xs[1], xs[2], xs[3],    ys[0], ys[1], ys[2], ys[3],  uv );
  bilerp   ( uv[0], uv[1],       xs[0], xs[1], xs[2], xs[3],    ys[0], ys[1], ys[2], ys[3],  xy );
  
  stroke(255,0,0); line( lerp(xs[0], xs[1], uv[0]), lerp(ys[0], ys[1], uv[0]),   lerp(xs[2], xs[3], uv[0]), lerp(ys[2], ys[3], uv[0])  );
  stroke(0,0,255); line( lerp(xs[0], xs[2], uv[1]), lerp(ys[0], ys[2], uv[1]),   lerp(xs[1], xs[3], uv[1]), lerp(ys[1], ys[3], uv[1])  );
  
  println  ( mouseX +"  "+ mouseY+"  -->  "+ uv[0]+" "+uv[1] +"  -->  "+ xy[0]+" "+xy[1] );
  //bilerp  ( uv[2], uv[3],       xs[0], xs[1], xs[2], xs[3],    ys[0], ys[1], ys[2], ys[3],  xy );
  //println( mouseX +"  "+ mouseY+"  -->  "+ uv[2]+" "+uv[3] +"  -->  "+ xy[0]+" "+xy[1] );
}
