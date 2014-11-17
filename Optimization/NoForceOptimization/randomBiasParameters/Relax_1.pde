
class Relaxator{

float E;
float x,y;

Relaxator(float x, float y){
init(x,y);
};

Relaxator(){
};

void init(float x, float y){
this.x=x;this.y=y; this.E = +100000000;
}

void move(){
  float dx = random(-step,step);  float dy = random(-step,step);
  float dR = sqrt(dx*dx+dy*dy);
  float resc = random(1.0)*step/dR;
  float newX=x+dx*resc;
  float newY=y+dy*resc;
  line(  x*sz+sz,y*sz+sz, newX*sz+sz,newY*sz+sz );
  float newE = getE(newX, newY);
  if(newE<E){
    x=newX; y=newY; E=newE;
  }
};


void paint(){
  ellipse(  x*sz+sz,y*sz+sz,   5,5 );
  //point(  x*sz+sz,y*sz+sz );
};

}
