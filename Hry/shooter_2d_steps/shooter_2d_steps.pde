int targets=15;
int decals=150;
int frame=0;
int step=0;

float x,y;
float cX,cY,cZ;
float fov=150;
float vx,vy;
float fireOn=0;


float dX,dZ,dY;
float ddrag=0.02;
float krok=0.25;
float runX,runZ;
float G = 0.25;

float incline=0.15;
float drag=0.01;
float km=0.01;
float off=3;
float recoil=1;


float[][] decal=new float[decals][2];

class scene{
 float[][] Target=new float[targets][5];
 
 void gen(){
 for (int i=0;i<targets;i++){
 float xx=random(-400,400);
 float zz=random(0,100);
 Target[i][0]=xx;
 Target[i][1]=0;
 Target[i][2]=zz;
 Target[i][3]=10;
 Target[i][4]=50;
 }
 }
 
 void paint(){
     
  fill(128);
  strokeWeight(1); 
  stroke(0); 
  
 float d=250;
 for (int i=0;i<20;i++){
 float x1=(i-10)*d;
 float x2=(i-10)*d;
 float z1=0;
 float z2=20*d;
 float xx1=x1*fov/(fov+z1+cZ);
 float xx2=x2*fov/(fov+z2+cZ);
 float yy1=100*fov/(fov+z1+cZ);
 float yy2=100*fov/(fov+z2+cZ);
 line(xx1+cX,yy1+cY,xx2+cX,yy2+cY);
 }
 
 for (int i=0;i<20;i++){
 float x1=-10*d;
 float x2=10*d;
 float z1=i*d;
 float z2=i*d;
 float xx1=x1*fov/(fov+z1+cZ);
 float xx2=x2*fov/(fov+z2+cZ);
 float yy1=25*fov/(fov+z1+cZ);
 float yy2=25*fov/(fov+z1+cZ);
 line(xx1+cX,yy1+cY,xx2+cX,yy2+cY);
 }
 
  
  for (int i=0;i<targets;i++){
  float xx=Target[i][0]*fov/(fov+Target[i][2]+cZ);
  float yy=(Target[i][1]+25)*fov/(fov+Target[i][2]+cZ);
  float w=Target[i][3]*fov/(fov+Target[i][2]+cZ);
  float h=Target[i][4]*fov/(fov+Target[i][2]+cZ);
  //println(xx+" "+yy+" "+w+" "+h);
  rect(xx+cX,cY+yy,w,-h);
 }
 }
 
 
}


scene scene1 = new scene();

void setup() 
{ 
  frameRate(60);
  size(1000,600);
  cX=width/2;
  cY=height/2;
  smooth();
  scene1.gen();
}

void draw() 
{ 
  frame++;  
  background(255); 
  scene1.paint();
  stroke(255,0,0);
  fill(0,0);
  strokeWeight(1); 
  ellipse(mouseX, mouseY, 10, 10); 
  
  if((fireOn==1)&&(frame%3==0)){
  vy-=recoil;
  vx+=random(-recoil,recoil);
  vy+=random(-recoil,recoil);
  decal[frame%decals][0]=x;
  decal[frame%decals][1]=y;
  };
  
  x=x*(1-incline)+mouseX*incline;
  y=y*(1-incline)+mouseY*incline;

  vx*=(1-drag);
  vy*=(1-drag);

  vx-=(x-mouseX)*km;
  vy-=(y-mouseY)*km;

  vx+=random(-0.2,0.2);
  vy+=random(-0.2,0.2);
  
  x+=vx;
  y+=vy;
  
  stroke(255,0,0);
  strokeWeight(5); 
  point(x,y);
  
  cX+=dX;cZ+=dZ;cY+=dY;
  dX*=(1-ddrag);dZ*=(1-ddrag);dY*=(1-ddrag);
  if(cY>200){dY-=G;} else {dY=0;}
  
  
 stroke(0);
 strokeWeight(2); 
 for (int i=0;i<decals;i++){
  point(decal[i][0],decal[i][1]);
 }
 
 //if(frame%10==0)
 if(dY==0){
     step++;
     float stepLeft = (step%2)*2-1;
     if(runX==0){dX+=20*G*stepLeft;}
     //vy+=random(1,1)*off;
     dZ-=5*G*runZ;dX-=5*G*runX;
     if((runX!=0)||(runZ!=0))dY=20*G;
     if(cZ<-fov/2){dZ=1;}
 }
  
}

void keyPressed() {
  /*
  step++;
  float stepUp = (step%2)*2-1;
  float stepLeft = ((step/2)%2)*2-1;
  println(stepUp+" "+stepLeft);
*/  
  {
  if (key == 'w') {runZ=+1; }
  if (key == 's') {runZ=-1; }
  if (key == 'd') {runX=+1; }
  if (key == 'a') {runX=-1; }
  }
}

void keyReleased() {
  if ((key == 'w')&&(runZ==+1)) {runZ=0;}
  if ((key == 's')&&(runZ==-1)) {runZ=0; }
  if ((key == 'd')&&(runX==+1)) {runX=0; }
  if ((key == 'a')&&(runX==-1)) {runX=0; }
}

void mousePressed(){
if(mouseButton == LEFT){fireOn=1;}
};

void mouseReleased(){
if(mouseButton == LEFT){fireOn=0;}
};


