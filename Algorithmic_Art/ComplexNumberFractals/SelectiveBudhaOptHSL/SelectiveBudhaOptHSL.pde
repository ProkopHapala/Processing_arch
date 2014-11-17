// Buddhabrot
// j.tarbell   January, 2004
// Albuquerque, New Mexico
// complexification.net

// based on code by Paul Bourke
// astronomy.swin.edu.au/~pbourke/

// Processing 0085 Beta syntax update
// j.tarbell   April, 2005

int dim = 800;             // screen dimensions (square window)
int orbmax = 100;         // number of iterations before bail
int orbmin = 20; 
int orbs;

float d=1.0;

int plots = 500000;        // number of plots to execute per frame (x30 = plots per second)

float x,y;
float x0, y0;


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
    //x = x0+ random(-d,d);
    //y = y0+ random(-d,d);
    //x= x0+ random(-d,d)*random(-d,d);
    //y= y0+ random(-d,d)*random(-d,d);
    
    // try close points with higher probability
    x=x0 + random(-d,d)*random(-d,d)*random(-d,d)*random(-d,d); 
    y=y0 + random(-d,d)*random(-d,d)*random(-d,d)*random(-d,d);

    // count iteration until escape
    orbs = test();
    
    // trace for orbs in orbmin..orbmax
    if (orbs>orbmin){
      trace();
      x0=x;y0=y; // if success move to point
    }
  }
}

int test(){
float a = 0; float b = 0;
for (int i=0;i<orbmax;i++){
float a_ = a * a - b * b + x;
float b_ = 2 * a * b + y;
if ((a_*a_ + b_*b_) > 4) { return i; }
a = a_;
b = b_;
}
return 0;
};

void trace(){
//println(x+" "+y);
float a = 0; float b = 0;
for (int i=0;i<orbs;i++){
float a_ = a * a - b * b + x;
float b_ = 2 * a * b + y;
int ix = int(dim * (a_ + 2.0) / 3.0);
int iy = int(dim * (b_ + 1.5) / 3.0);
if (ix >= 0 && iy >= 0 && ix < dim && iy < dim){ 
  float da = a - a_;
  float db = b - b_;
  float dr = sqrt(da*da + db*db);
  
  //A[ix*dim+iy]+=orbmax-orbs;
  //C[ix*dim+iy]+=orbs-orbmin;
  
  A[ix*dim+iy]+=(0.01+dr);
  B[ix*dim+iy]+=1;
  C[ix*dim+iy]+=1/(0.01+dr);
  
  
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
      float cA = sqrt(A[i*dim+j] / expo);
      float cB = sqrt(B[i*dim+j] / expo);
      float cC = sqrt(C[i*dim+j] / expo);
      color c = color(cA, cB, cC);
      set(j,i,c);
    }
  }
}


void keyPressed(){
if(key=='i'){save(year()+"_"+month()+"_"+day()+"_"+minute()+"_"+second());}
};
