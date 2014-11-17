class Nod{
//parameters
float x,y;      // position vector
boolean fixed;  // is this anchor point?
float F0x,F0y;  // external force

// Rods
//int nrod;
//int [] Rodsi;

//variables
float dx,dy;    // verlet velocity of displacement
float vx,vy;    // verlet velocity of displacement
float Fx,Fy;    // rest force

// view variables
float Fx_view, Fy_view;

Nod(float x_, float y_,boolean fixed_){
 x=x_;y=y_;fixed=fixed_;
}
void view(){
  noStroke();
  ellipse(sc*x+cx,sc*y+cy,5,5);
  
  stroke(0,255,0);   // displacement
  line(sc*x+cx,sc*y+cy,sc*(x+dx)+cx,sc*(y+dy)+cy);
  stroke(255,0,255); // force
  line(sc*x+cx,sc*y+cy,sc*x+cx+Fx_view,sc*y+cy+Fy_view);
}

void update(){
  Fx+= F0x; Fy+= F0y;        // apply external force
  if(!fixed){              // evaluate displacement
  vx*=damp;    vy*=damp;   // damping friction
  vx+=dt*Fx;  vy+=dt*Fy;   // velicity update
  float ddx=vx*dt;   float ddy=vy*dt;
  if(abs(dx)>maxd){
  dx = constrain(dx,-maxd,+maxd);
  vx = constrain(vx,-maxd/dt,+maxd/dt);
  }
  if(abs(dy)<maxd){
  dy = constrain(dy,-maxd,+maxd);
  vy = constrain(vy,-maxd/dt,+maxd/dt);
  }
  dx+=ddx;  dy+=ddy;   // displacement update
  }
  Fx_view=Fx; Fy_view=Fy;
  Fx=0; Fy=0;
}

}
