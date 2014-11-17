


float x0 = 0.0;
float y0 = 0.0;

int N = 1000;


float [] Cre = new float [N];    float [] Cim = new float [N];
float [] Zre = new float [N];   float [] Zim = new float [N];


float cx=0,cy=0;

float vx,vy;

float alfa  = 0.0;
float RCirc;
float Gamma;

void setup(){
size (800,800);
float step = 1.0/Zre.length;
for (int i=0; i<Zre.length; i++){
   float t = TWO_PI*i*step;
   Cre[i] = cos( t );  Cim[i] = sin( t );
}
fill(0);
}


void draw(){
background(255);
Jtrans( x0, y0 );
line(0,400,800,400);
line(400,800,400,0);
ellipse(x0*200 + 400, y0*200+400, 10 ,10);

ellipse( x0*200 + 400, y0*200+400  ,400,400);

alfa  = 0.5;
RCirc = RCirc_Func();
Gamma = Gamma_Func();
for (float x =-2; x<2;x+=0.1){
  for (float y =-2; y<2;y+=0.1){
    VCircle( x, y );
    println( x+"  "+y+"  "+vx+"  "+vy);
    ellipse(x*200+400, y*200+400, 3, 3);
    if((vx*vx+vy*vy)<16){
      line ( x*200+400, y*200+400,    x*200+400   +vx*10, y*200+400+  vy*10   );
    }
  }
}

noLoop();



/*
for (int i=0; i<Zre.length; i++){
  point( Zre[i]*200 + 400, Zim[i]*200+400 );
}
*/

};

void mouseDragged(){
  x0 = (mouseX-400.0) / 200.0;
  y0 = (mouseY-400.0) / 200.0;
  println(x0+"   "+ y0);
}




