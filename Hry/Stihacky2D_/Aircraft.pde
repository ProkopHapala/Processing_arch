float drag = 0.001;
float dt = 0.01;

class Aircraft{
float life = 100.0;
float yaw = 0;
final float Asize = 5.0;
float x,y;
float vx,vy;

boolean left;
boolean right;
boolean fire;
float Power=10;

Aircraft(float x_,float y_, float vx_,float vy_){x=x_;y=y_;vx=vx_;vy=vy_;}

void move(){
x+=vx*dt;
y+=vy*dt;
// if(left)  { vx+=vy*dt; vy-=vx*dt; /*print ("left");*/}
// if(right) { vx-=vy*dt; vy+=vx*dt; /*print ("right");*/}
vx+=yaw*vy*dt; vy-=yaw*vx*dt;
float vr2 = vx*vx + vy*vy;
float vr = sqrt(vr2);
float nvx = vx/vr;  float nvy = vy/vr;
vx-=nvx*vr2*drag*dt;  vy-=nvy*vr2*drag*dt;
vx+=nvx*Power*dt;     vy+=nvy*Power*dt;

if (x<0)x=width; if (x>width)x=0;
if (y<0)y=width; if (y>width)y=0;

if(right) if(yaw< 2.0) yaw+=0.2;
if(left)  if(yaw>-2.0) yaw-=0.2;
yaw*=0.98;
}

void paint(){
ellipse(x,y,Asize,Asize);
line(x,y,x-0.1*vx,y-0.1*vy);
//print(x+" "+y);

}

}
