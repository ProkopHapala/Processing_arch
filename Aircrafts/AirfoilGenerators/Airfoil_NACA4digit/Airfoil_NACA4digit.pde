float sc=1.0;
final int n=250;




float [] px = new float [n];
float [] pupx = new float [n];
float [] pdownx = new float [n];

float [] pcamber = new float [n];
float [] pthickness = new float [n];

float [] pupy = new float [n];
float [] pdowny = new float [n];

String name;

void setup (){
size(800,800);
smooth();
frameRate(10);

genNACA(0.05,0.4,0.5);
}

void draw(){

  background(200);
  
  if(keyPressed){
  if(key=='+'){sc*=1.1;}
  if(key=='-'){sc/=1.1;}
  if(key=='s'){savefoil(name);}
  }

stroke(0,0,0);
paint_spline_points(200,400 ,sc*400,sc*400, pupx,pupy);
paint_spline_points(200,400 ,sc*400,sc*400, pdownx,pdowny);

stroke(255,0,0);
paint_spline_points(200,400 ,sc*400,sc*400, px,pcamber);
stroke(0,0,255);
paint_spline_points(200,400 ,sc*400,sc*400, px,pthickness);


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

