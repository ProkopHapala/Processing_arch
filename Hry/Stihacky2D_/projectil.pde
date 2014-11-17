final int npr = 100;

float muzzlev = 800;

class Projectiles{
int ip=0;
float [] x,y,vx,vy;
boolean [] live;

Projectiles(){
 x = new float [npr];  y = new float [npr];
vx = new float [npr]; vy = new float [npr];
live = new boolean [npr];
}

void move(){
for (int i=0; i<npr;i++){
if(live[i]){
x[i]+=vx[i]*dt;
y[i]+=vy[i]*dt;
if ((x[i]<0)||(x[i]>width ))live[i]=false; 
if ((y[i]<0)||(y[i]>height))live[i]=false; 
}}}

void fire(Aircraft A ) {
 if (ip<npr){
  //print ("bum");
  live[ip]=true;
  x[ip]=A.x; y[ip]=A.y;                        // Place at aircraft
  vx[ip]=A.vx; vy[ip]=A.vy;                    // Add aircraft velocity
  float vr = sqrt(A.vx*A.vx + A.vy*A.vy);
  float nvx = A.vx/vr;  float nvy = A.vy/vr;
  vx[ip]+=nvx*muzzlev; vy[ip]+=nvy*muzzlev;    // Add muzzle velovity
  ip++;
 }
 // debug 
 if(ip>=npr)ip=0;
 
} 

void paint(){
for (int i=0; i<npr;i++){
if(live[i]){
point(x[i],y[i]);}}} 


void hit(Aircraft A){
for (int i=0; i<npr;i++){
if(live[i]){
float dx = A.x - x[i]; float dy = A.y - y[i];
float r=sqrt(dx*dx+dy*dy);  
if (r<A.Asize){ print (" BUM !! \n "); A.life-=1.0; }
}}}

}
