
int dim = 900;             // screen dimensions (square window)
int bailout = 50;         // number of iterations before bail

float xmin = -2; 
float ymin = -2; 
float xmax = 2;
float ymax = 2;

int n = 300000; //Number of walkers
float[] as;
float[] bs;
float[] as_;
float[] bs_;
float[] xs;
float[] ys;

float a, b, a_,b_;

// 2D array to hold exposure values
float[] exposure;
float maxexposure;           // maximum exposure value
int time = 0;
int exposures = 0;

boolean drawing;

//  MAIN ----------------------------------------------------------------
void setup() {
  size(dim,dim,P2D);
  background(0);
  as = new float[n];
  bs = new float[n];
  as_ = new float[n];
  bs_ = new float[n];
  xs = new float[n];
  ys = new float[n];
  exposure = new float[dim*dim];
  for(int i = 0;  i < n; i++) {kill(i);}
}

void kill(int i){
     a=0;b=0;
     xs[i]=random(xmin,xmax);
     ys[i]=random(ymin,ymax);
};


void draw() {
  iter();
  time++;
  if (time%10==1) {
    renderBrot();
  }
}

void iter(){
   for(int i = 0;  i < n; i++) {
     a = as[i];
     b = bs[i];
     a_ = as_[i];
     b_ = bs_[i];
     
     // Kill escaped ?
     float rr = a*a+b*b;
     //if((rr>16.0)||(rr<0.0001)){
     if(rr>16.0){
     kill(i);
     }; 
     
     // Kill stationar ?
     float dr = abs(a-a_)+abs(b-b_);
     if(dr<0.000001){
     kill(i);
     };
     
     //random kill?
     if(random(0,1)<0.01){
     kill(i);
     };
     
     as_[i] = as[i];
     bs_[i] = bs[i];  
          
     //float zz= a*a + b*b;
     /*
     float dt = 0.1;
     float na = a*a - b*b - a + xs[i];
     float nb = 2*a*b     - b - ys[i];
     as[i] += na*dt;
     bs[i] += nb*dt;
     */
     
     float na = a*a - b*b +b + xs[i];
     float nb = 2*a*b     -a - ys[i];
     as[i] = na;
     bs[i] = nb;
     

     //if((a<xmax)&&(a>xmin)&&(b<ymax)&&(b>ymin)){
     int x = int(map(a,xmin,xmax,0,dim));
     int y = int(map(b,ymin,ymax,0,dim));
     if((x<dim)&&(x>0)&&(y<dim)&&(y>0)){
     //exposure[x*dim+y]++;
     exposure[x*dim+y]+=10;
     }

 }
}

void renderBrot() {
  // draw to screen
  for (int i=0;i<dim;i++) {
    for (int j=0;j<dim;j++) {     
      float ramp = sqrt(exposure[i*dim+j]);
      color c = color(int(ramp), int(ramp), int(ramp));
      set(j,i,c);
    }
  }
}

void keyPressed(){
if(key=='i'){save(year()+"_"+month()+"_"+day()+"_"+minute()+"_"+second());}
};

