float sc=1.0;
final int n=100;

float [] upy;    float [] upx;
float [] downy;  float [] downx;

float [] pupx = new float [n];
float [] pupy = new float [n];
float [] pdownx =new float [n];
float [] pdowny = new float [n];

BezierN myBezier;
String name;

void setup (){
size(800,800);
smooth();
frameRate(10);

//Generate_3digit();
Generate_4digit();
//Generate_5digit();
//Generate_7digit();

myBezier = new BezierN(upx.length);

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
  if(key=='s'){savefoil(name);}
  }

paint_spline_points(200,400 ,sc*400,sc*400, pupx,pupy);
paint_spline_ellipse(200,400 ,sc*400,sc*400, upx,upy);
paint_spline_points(200,400 ,sc*400,sc*400, pdownx,pdowny);
paint_spline_ellipse(200,400 ,sc*400,sc*400, downx,downy);

//noLoop();



}




void paint_spline_points(float x0, float y0, float sx,float sy, float [] px, float [] py ){
  for(int i=0; i<px.length; i++){
  point(px[i]*sx+x0,-py[i]*sy+y0);
  }
};

void paint_spline_ellipse(float x0, float y0, float sx,float sy, float [] px, float [] py ){
  for(int i=0; i<px.length; i++){
  ellipse(px[i]*sx+x0,-py[i]*sy+y0,5,5);
  }
};

