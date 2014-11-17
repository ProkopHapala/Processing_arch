
class Relaxator2D{

boolean done=false;  
  
int nSteps;
int last_neg=0;

int nmin_neg = 3;
int maxiter = 100;

float a;

float a_start = 0.8;
float f_inc   = 1.61803399;

float dt_max  = 0.3; // for fire
float dt = 0.1;
float Fconv   = 0.001;

float vx,vy;
float x,y;

Relaxator2D(float Fconv, float dt_max, float f_inc, float a_start){
 this.Fconv=Fconv; this.dt_max=dt_max; this.f_inc = f_inc; this.a_start=a_start;
};

Relaxator2D(){
};

void init(float x, float y, float vx, float vy){
this.x=x;this.y=y; this.vx=vx; this.vy=vy;
  nSteps=0;
 // dt= dt_max*0.5;
  a = a_start;
  done=false;
}


void MDstepPROKOP1(float fx, float fy){
  float fnorm = sqrt(fx*fx+fy*fy);
  float vnorm = sqrt(vx*vx+vy*vy);   
  if(fnorm > Fconv){
    nSteps++;
    float P = fx*vx + fy*vy;
    float Pnorm = P/(vnorm*fnorm);
  //  print(" nSteps= "+nSteps+" Pnorm= "+Pnorm + " Fnorm= "+fnorm);
    if(Pnorm>0){ 
      vx*=Pnorm; vy*=Pnorm;
    } else {
      vx=0; vy=0;
    };
    vx+=fx*dt; vy+=fy*dt;
     x+=vx*dt;  y+=vy*dt;
  }else{
    done = true;
  }
 // println();
}



void MDstepPROKOP2(float fx, float fy){
  float fnorm = sqrt(fx*fx+fy*fy);
  float vnorm = sqrt(vx*vx+vy*vy);   
  if(fnorm > Fconv){
    nSteps++;
    float P = fx*vx + fy*vy;
    float Pnorm = P/(vnorm*fnorm);
  //  print(" nSteps= "+nSteps+" Pnorm= "+Pnorm + " Fnorm= "+fnorm);
    if(Pnorm>0){
      float vfx=fx*vnorm/fnorm; float vfy=fy*vnorm/fnorm;
      vx = vx*Pnorm +  (1-Pnorm)*vfx;
      vy = vy*Pnorm +  (1-Pnorm)*vfy;
    } else {
      vx=0; vy=0;
    };
    vx+=fx*dt; vy+=fy*dt;
     x+=vx*dt;  y+=vy*dt;
  }else{
    done = true;
  }
 // println();
}



void MDstepFIRE(float fx, float fy){
float fnorm = sqrt(fx*fx+fy*fy);
float vnorm = sqrt(vx*vx+vy*vy);   
//println(fx+" "+fy+" "+fnorm);
if(fnorm > Fconv){
  nSteps++;
  float P = fx*vx + fy*vy;
//  print(nSteps +" "+P+" a= "+a+" dt= "+dt);
  if(P<=0){ 
    last_neg = nSteps;
    dt = dt/f_inc;
    //a=a_start;
    //vx=0;vy=0;
    vx=dt*fx; vy=dt*fy;
  } else {
    vx = vx*(1.0-a) + a*vnorm*fx/fnorm;
    vy = vy*(1.0-a) + a*vnorm*fy/fnorm;
    if ((nSteps-last_neg)>nmin_neg) { // if at least nmin_neg steps OK increase time step
      dt = min(dt*f_inc,dt_max); 
    //  // a = a / f_inc;
    };
    x+=vx*dt;  y+=vy*dt;
  }
}else{
  done = true;
}
//println( nSteps  +" dt="+dt   +" fnorm "+fnorm);
}

float ERelaxed(float x, float y){
  float E=0;
  R.init( x, y,    0.0, 0.0001  );
  for(int i=0; i<maxiter; i++){
    E = getEnergy( R.x, R.y );
    R.MDstepPROKOP1( fx, fy ); 
    if(R.done){ break; }
  };
  return E;
};

void paint(){
  noStroke();
 ellipse(  x*sz+sz,y*sz+sz, 3,3 );
  stroke(0,0,255);
 //line ( x*sz+sz,y*sz+sz,  x*sz+sz + 10*fx, y*sz+sz  + 10*fy );
  stroke(255,0,0);
 //line ( x*sz+sz,y*sz+sz,  x*sz+sz + 100*vx, y*sz+sz  + 100*vy );
};

}
