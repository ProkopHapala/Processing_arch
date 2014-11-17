float sc=1.0;



//float [] downx = {0.0, 0.0,   0.33,  0.66 , 1.0};
float [] upx = {0.0,  0.0,   0.33,   0.66, 1.0};
float [] downx = upx;


/*
// profil 1
float [] upy   = {0.0,  2.0,  2.0,  0.66,  0.0};
float [] downy = {0.0, -1.0,  -1.0,  -0.33,  0.0};
*/

/*
profil 2
float [] upy   = {0.0, 1.0,  2.0,   1.0,  0.0};
float [] downy = {0.0, -0.5,  1.0,   1.0,  0.0};
*/


//profil 2
float [] upy   = {0.0, 1.0,   2.0,   1.5,  0.0};
float [] downy = {0.0, -1.0,  1.0,  1.0,  0.0};



float [] pupx = new float [200];
float [] pupy = new float [200];
float [] pdownx =new float [200];
float [] pdowny = new float [200];

BezierN myBezier;

void setup (){
size(800,800);
smooth();
frameRate(10);

myBezier = new BezierN(upx.length);

Generate_2();

myBezier.interpolate(upx,pupx);
myBezier.interpolate(upy,pupy);
myBezier.interpolate(downx,pdownx);
myBezier.interpolate(downy,pdowny);

}

void draw(){

  background(200);
  
  if(keyPressed){
  if(key=='+'){sc*=1.1;}
  if(key=='-'){sc/=1.1;}
  }

paint_spline_points(200,400 ,sc*400,sc*400, pupx,pupy);
paint_spline_ellipse(200,400 ,sc*400,sc*400, upx,upy);
paint_spline_points(200,400 ,sc*400,sc*400, pdownx,pdowny);
paint_spline_ellipse(200,400 ,sc*400,sc*400, downx,downy);

//noLoop();
}




void paint_spline_points(float x0, float y0, float sx,float sy, float [] px, float [] py ){
  for(int i=0; i<pupx.length; i++){
  point(px[i]*sx+x0,-py[i]*sy+y0);
  }
};

void paint_spline_ellipse(float x0, float y0, float sx,float sy, float [] px, float [] py ){
  for(int i=0; i<px.length; i++){
  ellipse(px[i]*sx+x0,-py[i]*sy+y0,5,5);
  }
};

