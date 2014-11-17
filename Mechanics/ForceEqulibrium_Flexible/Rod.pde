class Rod{
//parameters
int a,b; // between points
float stiffness;
float strength;
//float strength_tension
//float strength_compression
//float stiffness_tension
//float stiffness_compression
//float Weight

// constant variables
float lx,ly;    // vector 
float nlx,nly;  // normalized vector
float L0;       // length of rod

// working variables
float dL,L;
float F;        // stress force value
float Fx,Fy;    // stress force vector

Rod(int a_,int b_,float stiffness_,float strength_){
  a=a_;b=b_;stiffness = stiffness_; strength = strength_;
}

void view(){
stroke(stresscolor(F));
line (sc*Nods[a].x+cx,sc*Nods[a].y+cy,sc*Nods[b].x+cx,sc*Nods[b].y+cy);}

void init(){
 lx = Nods[b].x - Nods[a].x;        ly = Nods[b].y - Nods[a].y;
 L0= sqrt(lx*lx+ly*ly);
 nlx = lx/L0; nly = ly/L0;
}

void update(){
  lx = Nods[b].x - Nods[a].x; ly = Nods[b].y - Nods[a].y; 
  L = sqrt(lx*lx + ly*ly);
  dL = L - L0;
  F = stiffness*dL;
  nlx = lx/L;     nly = ly/L;
  Fx  = nlx * F;   Fy = nly * F;
 // println(dL+" "+F+" "+ L +" "+nlx+" "+nly);
 
 Nods[b].Fx-=Fx; Nods[b].Fy-=Fy;
 Nods[a].Fx+=Fx; Nods[a].Fy+=Fy;
}

color stresscolor(float F){
//println("STRESS "+F);
color clr;
if(F<0){  clr = color(255*((-F)/strength),0,0);  }else
       {  clr = color(0, 0, 255*(F/strength) );  };
return(clr);
};

}



