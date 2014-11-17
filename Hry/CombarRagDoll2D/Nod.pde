
class Nod{
//parameters
double x,y;      // position vector
double F0x,F0y;  // external force
double mass; 

//variables
double dx,dy;    // verlet velocity of displacement
double vx,vy;    // verlet velocity of displacement
double Fx,Fy;    // rest force

// view variables
//float Fx_view, Fy_view;

Nod(double x, double y, double mass  ){
 this.x=x;this.y=y; this.mass=mass;
}

/*
void checkGround(){
  if (y<0){
   if (vy<0){vy=-vy;}
   if (Fy<0){Fy=0;}
  }
}
*/

void ground(){
 if(y<0){ 
   if (Fy<0){     Fx*=(0.1-y);  println(y);        }     
   Fy-=ground_stiffess*y;  
 }
}

void gravity(){
 Fy-=g*mass;
}

void update(double dt){
  gravity();
  ground();
  Fx+= F0x;   Fy+= F0y;      // apply external force
  vx*=damp;   vy*=damp;   // damping friction
  vx+=dt*Fx/mass;  vy+=dt*Fy/mass;   // velicity update
  dx=vx*dt;   dy=vy*dt;
  //checkGround();
  x+=dx;       y+=dy;   // displacement update
 // Fx_view=Fx; Fy_view=Fy;
  Fx=0; Fy=0;
}

void view(World W){
  noStroke();
  ellipse( W.x(x),W.y(y),5,5);
  //stroke(255,0,255); // force
  //line((float)(sc*x+cx),(float)(sc*y+cy),(float)(sc*x+cx+Fx_view),(float)(sc*y+cy+Fy_view));
}


}


