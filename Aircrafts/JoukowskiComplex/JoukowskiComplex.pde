


float x0 = 0.1;
float y0 = 0.1;

int N = 1000;


float [] Cre = new float [N];    float [] Cim = new float [N];
float [] Zre = new float [N];   float [] Zim = new float [N];




void setup(){
size (800,800);

float step = 1.0/Zre.length;
for (int i=0; i<Zre.length; i++){
   float t = TWO_PI*i*step;
   Cre[i] = cos( t );  Cim[i] = sin( t );
}

}


void draw(){
background(255);
Jtrans( x0, y0 );
line(0,400,800,400);
line(400,800,400,0);
ellipse(x0*200 + 400, y0*200+400, 5 ,5);
for (int i=0; i<Zre.length; i++){
  point( Zre[i]*200 + 400, Zim[i]*200+400 );
}
};

void mouseDragged(){
  x0 = (mouseX-400.0) / 200.0;
  y0 = (mouseY-400.0) / 200.0;
  println(x0+"   "+ y0);
}




