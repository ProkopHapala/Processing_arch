// Buddhabrot
// j.tarbell   January, 2004
// Albuquerque, New Mexico
// complexification.net

// based on code by Paul Bourke
// astronomy.swin.edu.au/~pbourke/

// Processing 0085 Beta syntax update
// j.tarbell   April, 2005

int dim = 800;             // screen dimensions (square window)
int orbmax = 60;         // number of iterations before bail
int orbmin = 50; 
int orbs;

float d=0.5;

int plots = 250000;        // number of plots to execute per frame (x30 = plots per second)

float x,y;
float x0, y0;

int bad;

// 2D array to hold exposure values
float[] A = new float[dim*dim];
float[] B = new float[dim*dim];
float[] C = new float[dim*dim];
float expo = 1.0;

boolean success;

//  MAIN ----------------------------------------------------------------

void setup() {
  size(dim,dim,P3D);
  //colorMode(HSB, 1.0);
  colorMode(RGB, 1.0);
  background(0);
}

void draw() {
  MonteCarlo();
  findMaxExposure();
  renderBrot();
}

void MonteCarlo() {
  for (int n=0;n<plots;n++) {
    
    // if not success many times try from cratch
    if(bad>50){
      x0 = random(-2,+2); 
      //x0=0;
      y0 = random(-2,+2);
      //y0 = 0;
      bad=0;
    };
    
    x = x0+ random(-d,d);
    y = y0+ random(-d,d);
    
    //x= x0+ random(-d,d)*random(-d,d);
    //y= y0+ random(-d,d)*random(-d,d);
    
    // try close points with higher probability 
    //x=x0 + random(-d,d)*random(-d,d)*random(-d,d)*random(-d,d); 
    //y=y0 + random(-d,d)*random(-d,d)*random(-d,d)*random(-d,d);
    
    
    // count iteration until escape
    orbs = test();
    //println("------"+orbs);
    // trace for orbs in orbmin..orbmax
    if (orbs>orbmin){
      trace();
      x0=x;y0=y; // if success move to point
    }else{bad++;}
  }
}

int test(){
float a = x; float b = y;
for (int i=0;i<orbmax;i++){

//float a_ = a * a - b * b + x;
//float b_ = 2 * a * b + y;
  
float na = a*(1-a) + b*b;
float nb = b - 2*a*b;
float a_ = na * x - nb * y;
float b_ = na*y + nb*x;
if ((a_*a_ + b_*b_) > 4) { return i; }

//println(a_*a_ + b_*b_);
a = a_;
b = b_;
}
return 0;
};

void trace(){
float a = x; float b = y;
for (int i=0;i<orbs;i++){

//float a_ = a * a - b * b + x;
//float b_ = 2 * a * b + y;
  
float na = a*(1-a) + b*b;
float nb = b - 2*a*b;
float a_ = na * x - nb * y;
float b_ = na*y + nb*x;

//println(a_*a_ + b_*b_);

int ix = int(dim * (a_ + 1.0) *0.5);
int iy = int(dim * (b_ + 1.0) *0.5);
if (ix >= 0 && iy >= 0 && ix < dim && iy < dim){ 
  //A[ix*dim+iy]+=orbmax-orbs;
  //C[ix*dim+iy]+=orbs-orbmin;
  
  float da = a - a_;
  float db = b - b_;
  float dr = sqrt(da*da + db*db);
  A[ix*dim+iy]+=db*db/(da*da+0.01);
  B[ix*dim+iy]+=1;
  C[ix*dim+iy]+=da*da/(db*db+0.01);
}
a = a_;
b = b_;
}
}
  
void findMaxExposure() {
  expo=0;
  for (int i=0;i<dim;i++) {  for (int j=0;j<dim;j++) {
  expo = max(expo,A[i*dim+j]);
  expo = max(expo,B[i*dim+j]);
  expo = max(expo,C[i*dim+j]); 
  }  }   }
  
void renderBrot() {
  // draw to screen
  for (int i=0;i<dim;i++) {
    for (int j=0;j<dim;j++) {
      /*
      float cA = sqrt(A[i*dim+j] / expo);
      float cB = sqrt(B[i*dim+j] / expo);
      float cC = sqrt(C[i*dim+j] / expo);
      */
      /*
      float cA = exp((A[i*dim+j]-expo)/expo );
      float cB = exp((B[i*dim+j]-expo)/expo );
      float cC = exp((C[i*dim+j]-expo)/expo );
      //println(cA);
      */
      float cA = sqrt(sqrt(A[i*dim+j] / expo));
      float cB = sqrt(sqrt(B[i*dim+j] / expo));
      float cC = sqrt(sqrt(C[i*dim+j] / expo));
      /*
      float cA = atan(10*A[i*dim+j]/expo)/HALF_PI;
      float cB = atan(10*B[i*dim+j]/expo)/HALF_PI;
      float cC = atan(10*C[i*dim+j]/expo)/HALF_PI;
      */
      color c = color(cA, cB, cC);
      set(j,i,c);
    }
  }
}


void keyPressed(){
if(key=='i'){save(year()+"_"+month()+"_"+day()+"_"+minute()+"_"+second());}
};
