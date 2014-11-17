final int maxn = 10000;
int n=0;

/*
float mx1,my1;
*/

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
/*
  beginShape(TRIANGLES);
  vertex(mouseX,mouseY);
  vertex(mouseX,mouseY+10);
  vertex(mouseX+10,mouseY);
  endShape();
*/


  
}



void mousePressed(){
//beginShape(TRIANGLES);
xs[n]=mouseX;
ys[n]=mouseY;
n++;
}

void mouseDragged(){
//vertex(mouseX, mouseY);
xs[n]=mouseX;
ys[n]=mouseY;
n++;
}

void mouseReleased(){
//endShape();
xs[n]=mouseX;
ys[n]=mouseY;
n++;


beginShape();  // standard poly;
//beginShape(TRIANGLES);
for (int i=0;i<n; i++){
vertex(xs[i],ys[i]);
}
endShape();

beginShape();  // standard poly;
//beginShape(TRIANGLES);
for (int i=0;i<n; i++){
vertex(500-xs[i],ys[i]);
}
endShape();


n=0;
}


void keyPressed(){
if(key==' '){color clr = get(mouseX,mouseY); fill(red(clr),green(clr),blue(clr),64);}
}
