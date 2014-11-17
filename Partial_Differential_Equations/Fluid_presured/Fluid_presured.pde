/**
 * Fluid 
 * by Glen Murphy. 
 * 
 * Click and drag the mouse to move the simulated fluid.
 * Adjust the "res" variable below to change resolution.
 * Code has not been optimised, and will run fairly slowly.
 */
 
float frict=0.9999; //flow friction
float relax=0.9; //pressure relaxation

float anizo=0.5; // anizotrypy of pressure
float visco1=0.5; //viscosity of flow
float visco2=0.00; //viscosity of flow

float vscale = 1.0;

int lwidth;
int lheight; 
int res = 3;
int pnum = 15000;

int penSize = 30;

vsquare[][] v;
particle[] p = new particle[pnum];
int frame = 0;

int mouseXvel = 0;
int mouseYvel = 0;


///////////////////////
///    vsquere     ////
///////////////////////


class vsquare {
  int x;
  int y;
  float xvel;
  float yvel;
  
  float inx = 0;
  float iny = 0;
  float in = 0;

  vsquare(int xIn,int yIn) {
    x = xIn;
    y = yIn;
    }
  
  void income(int i, int u) {
    if (i>0 && i<lwidth && u>0 && u<lheight) {
      
      inx= (v[i-1][u].xvel-v[i+1][u].xvel); //tlak umerny rychlosti?
      iny= (v[i][u-1].yvel-v[i][u+1].yvel);
      in+= (inx + iny)*0.5;
      
      /*
      inx = (v[i-1][u-1].xvel*0.5
           + v[i-1][u].xvel 
           + v[i-1][u+1].xvel*0.5 
           - v[i+1][u-1].xvel*0.5 
           - v[i+1][u].xvel 
           - v[i+1][u+1].xvel*0.5);
      iny = (v[i-1][u-1].yvel*0.5 
           + v[i][u-1].yvel 
           + v[i+1][u-1].yvel*0.5 
           - v[i-1][u+1].yvel*0.5 
           - v[i][u+1].yvel 
           - v[i+1][u+1].yvel*0.5);
      in+= (inx + iny)*0.25;
      */
      
      }
      in*=relax;
    }
  
  void outcome(int i, int u) {
    if (i>0 && i<lwidth && u>0 && u<lheight) {
      //vytok umerny vtoku
      
      xvel += (+v[i-1][u].in-v[i+1][u].in)*0.5;
      yvel += (+v[i][u-1].in-v[i][u+1].in)*0.5;
      
      
      /*
      xvel += (v[i-1][u-1].in*0.5
              +v[i-1][u].in
              +v[i-1][u+1].in*0.5
              -v[i+1][u-1].in*0.5
              -v[i+1][u].in
              -v[i+1][u+1].in*0.5
              )*0.25;
      yvel += (v[i-1][u-1].in*0.5
              +v[i][u-1].in
              +v[i+1][u-1].in*0.5
              -v[i-1][u+1].in*0.5
              -v[i][u+1].in
              -v[i+1][u+1].in*0.5
              )*0.25;
      */
      
      // VISKOZITA
            
      xvel*=(1-visco1);
      xvel+= ( v[i][u+1].xvel  
              +v[i][u-1].xvel
              )*0.5*visco1;
              
      yvel*=(1-visco1);
      yvel+= ( v[i+1][u].yvel  
              +v[i-1][u].yvel
              )*0.5*visco1;
      
      
      }
       xvel*=frict;
       yvel*=frict;
    }

}





///////////////////////
///    particle     ///
///////////////////////



class particle {
  float x;
  float y;
  float xvel;
  float yvel;
  int pos;
  particle(float xIn, float yIn) {
    x = xIn;
    y = yIn;
  }

  void update() {
    if (x > 0 && x < width && y > 0 && y < height) {
      int vi = (int)(x/res);
      int vu = (int)(y/res);
      
      float ax = (x%res)/res;
      float ay = (y%res)/res;
      
      //interpolace rychlosti podle polohy v mrizce
      xvel += (1-ax)*v[vi][vu].xvel*vscale;
      yvel += (1-ay)*v[vi][vu].yvel*vscale;
      xvel += ax*v[vi+1][vu].xvel*vscale;
      yvel += ax*v[vi+1][vu].yvel*vscale;
      xvel += ay*v[vi][vu+1].xvel*vscale;
      yvel += ay*v[vi][vu+1].yvel*vscale;

      x += xvel;
      y += yvel;
     
    }

if (random(0,20)<1) {
      x = random(0,width);
      y = random(0,height);
      xvel = 0;
      yvel = 0;
}
    xvel *= 0.5;
    yvel *= 0.5;
  }
}






///////////////////////
///    runtime     ///
///////////////////////

void setup() 
{
  size(600, 600,P2D);
  noStroke();
  frameRate(100);
  lwidth = width/res;
  lheight = height/res;
  v = new vsquare[lwidth+1][lheight+1];
  for (int i = 0; i < pnum; i++) {
    p[i] = new particle(random(res,width-res),random(res,height-res));
  }
  for (int i = 0; i <= lwidth; i++) {
    for (int u = 0; u <= lheight; u++) {
      v[i][u] = new vsquare(i*res,u*res);
    }
  }
}

void draw() 
{
 
  for (int i = 0; i < lwidth; i++) {
    for (int u = 0; u < lheight; u++) {
      v[i][u].income(i,u);
    }
  }
  
  for (int i = 0; i < lwidth; i++) {
    for (int u = 0; u < lheight; u++) {
      v[i][u].outcome(i, u);
    }
  }
/*
  fill(255,20);
  rect(0,0,600,600);
*/
  if (frame%5==0){
  noStroke();
  for (int i = 0; i <= lwidth; i++) { 
    for (int u = 0; u <= lheight; u++) {
      fill(v[i][u].in*10,0,-v[i][u].in*10,255);
      rect(v[i][u].x,v[i][u].y,res,res);
    }
  }
  }
  
  //strokeWeight(2);
  stroke(255);
  for (int i = 0; i < pnum-1; i++) {
    p[i].update();
    point(p[i].x,p[i].y);
  }
  
 
  int axvel = mouseX-pmouseX;
  int ayvel = mouseY-pmouseY;
  mouseXvel = (axvel != mouseXvel) ? axvel : 0;
  mouseYvel = (ayvel != mouseYvel) ? ayvel : 0;
}


void mouseDragged() 
{
  for (int i = 0; i < lwidth; i++) {
    for (int u = 0; u < lheight; u++) {
      float adj = v[i][u].x - mouseX;
      float opp = v[i][u].y - mouseY;
      float dist = sqrt(opp*opp + adj*adj);
      if (dist < penSize) {
        v[i][u].xvel = mouseXvel;
        v[i][u].yvel = mouseYvel;
        }
      } 
  }
}

void mousePressed() 
{
  if (mouseButton == RIGHT){
  for (int i = 0; i < lwidth; i++) {
    for (int u = 0; u < lheight; u++) {
      float adj = v[i][u].x - mouseX;
      float opp = v[i][u].y - mouseY;
      float dist = sqrt(opp*opp + adj*adj);
      if (dist < penSize) {
        v[i][u].in+=100;
        }
      } 
  }
  }
}


