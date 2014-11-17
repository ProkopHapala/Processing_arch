

/*
usefull for narrow valley
for unifor well not (much) better than simple Monte Carlo


there are 2 versions

version 1:
   newX = oldX +    ( X_rnd * scale  )  +   dx_old;

version 2:   
   newX = oldX +    ( X_rnd + dx_old )* scale;

version 2 provide better resuls -  130 iterstion vs. 160 (  230 iterations simple MC )

for  
E = 5*(cos(x*6-1.0)-y*2) + x*x*5;

recomand use without rescaling
but with variable step length
*/

float dir_decay=0.7;
float dir_comp=1.5;

class Relaxator_2 extends Relaxator{

float odx,ody;

Relaxator_2(float x, float y){
init(x,y);
};

void init(float x, float y){
this.x=x;this.y=y; this.E = +100000000;
}

void move(){
  //float dx = random(-step,step);  float dy = random(-step,step);                               // version 1
  float dx = random(-step,step)  + odx*dir_comp;  float dy = random(-step,step) + ody*dir_comp;      // version 2
  float dR = sqrt(dx*dx+dy*dy);
  //float resc = random(1.0)*step/dR;
  float resc=1.0;
  //float newX=x+dx*resc + odx*dir_comp;   float newY=y+dy*resc + ody*dir_comp;                      // version 1
  float newX=x+dx*resc;   float newY=y+dy*resc;                                                    // version 2
  //line(  x*sz+sz,y*sz+sz, newX*sz+sz,newY*sz+sz );
  float newE = getE(newX, newY);
  if(newE<E){
    line(  x*sz+sz,y*sz+sz, newX*sz+sz,newY*sz+sz );
    x=newX; y=newY; E=newE;
    odx = dx; ody=dy;
  } else {
    odx*=dir_decay;  ody*=dir_decay;
  }
};


void paint(){
  //stroke(0,255,255);
  //ellipse(  x*sz+sz,y*sz+sz,   5,5 );
  point(  x*sz+sz,y*sz+sz );
};

}
