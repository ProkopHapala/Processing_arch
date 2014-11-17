
final int sz=500;
final int maxn = 10000;
int n=0;
int kkaleido=6;

float x0=sz/2;
float y0=sz/2;

float [] xs = new float[maxn];
float [] ys = new float[maxn];

void setup(){
background(255);
fill(0,64);
size(500,500);
noStroke();
smooth();
}


void draw(){
  
}


void mousePressed() { xs[n]=mouseX; ys[n]=mouseY; n++; }
void mouseDragged() { xs[n]=mouseX; ys[n]=mouseY; n++; }
void mouseReleased(){ xs[n]=mouseX; ys[n]=mouseY; n++;

for (int j=0;j<kkaleido;j++){
paintRotated(j*TWO_PI/kkaleido);
}


//paintRotated(0.0);

n=0;
}


void paintRotated(float angle){
  float s = 250;
translate (x0,y0);  
rotate(angle);
translate (-x0,-y0);
beginShape();  // standard poly;
for (int i=0;i<n; i++){
vertex(xs[i],ys[i]);
}
endShape();
translate (x0,y0);
rotate(-angle);
translate (-x0,-y0);
};

void keyPressed(){
if(key==' '){x0=mouseX; y0=mouseY;}
if(key=='p'){color clr=get(mouseX,mouseY); fill(red(clr),green(clr),blue(clr),64);}
}
