
class Rod{
//parameters
Nod a,b; // between points
boolean fixed;
boolean visible;

double stiffness;
double maxF;

// constant variables
double lx,ly;    // vector 
double nlx,nly;  // normalized vector
double L0;       // length of rod

// working variables
double dL,L;
double F;        // stress force value
double Fx,Fy;    // stress force vector

Rod(Nod a,Nod b,double stiffness, double maxF, boolean visible, boolean fixed ){
  this.a=a;this.b=b; this.stiffness = stiffness; this.visible=visible; this.fixed=fixed; this.maxF=maxF;
  init();
}

void init(){
 lx = b.x - a.x;        ly = b.y - a.y;
 L0= Math.sqrt(lx*lx+ly*ly);
 nlx = lx/L0; nly = ly/L0;
}

void update(){
  lx = b.x - a.x; ly = b.y - a.y; 
  L = Math.sqrt(lx*lx + ly*ly);
  dL = L - L0;
  F = stiffness*dL;
  //println(F);
  F = constrain(F,-maxF, maxF);
  nlx = lx/L;     nly = ly/L;
  Fx  = nlx * F;   Fy = nly * F;
 // println(dL+" "+F+" "+ L +" "+nlx+" "+nly);
 
 b.Fx-=Fx; b.Fy-=Fy;
 a.Fx+=Fx; a.Fy+=Fy;
}


void view( World W ){
  //println(visible);
  /*
  if (visible){  
    strokeWeight(10);
    line (W.x(a.x),W.y(a.y),W.x(b.x),W.y(b.y));
  }else{
    strokeWeight(1);
    line (W.x(a.x),W.y(a.y),W.x(b.x),W.y(b.y));
  }  
  */
  strokeWeight((float)stiffness/2000);
  line (W.x(a.x),W.y(a.y),W.x(b.x),W.y(b.y));
  
}


}



