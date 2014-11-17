
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


// 2D array to hold exposure values
float[] A = new float[dim*dim];
float[] B = new float[dim*dim];
float[] C = new float[dim*dim];
float expo = 10000.0;

boolean drawing;

//  MAIN ----------------------------------------------------------------

void setup() {
  size(dim,dim,P2D);
  background(0);
  colorMode(RGB, 1.0);
  
  as = new float[n];
  bs = new float[n];
  as_ = new float[n];
  bs_ = new float[n];
  xs = new float[n];
  ys = new float[n];
}

void draw() {
  iter();
  //findMaxExposure();
  renderBrot();
}

void iter(){
   for(int i = 0;  i < n; i++) {
     float a = as[i];
     float b = bs[i];
     float a_ = as_[i];
     float b_ = bs_[i];
     
     // Kill escaped ?
     float rr = a*a+b*b;
     //if((rr>16.0)||(rr<0.0001)){
     if(rr>16.0){
     a=0;b=0;
     xs[i]=random(xmin,xmax);
     ys[i]=random(ymin,ymax);
     }; 
     
     // Kill stationar ?
     float da = a-a_;
     float db = b-b_;
     float dr = sqrt(da*da+db*db);
     
     if(dr<0.0001){
     a=0;b=0;
     xs[i]=random(xmin,xmax);
     ys[i]=random(ymin,ymax);
     };
     
     //random kill?
     if(random(0,1)<0.003){
     a=0;b=0;
     xs[i]=random(xmin,xmax);
     ys[i]=random(ymin,ymax);
     };
          
     float aa = a*a;
     float bb = b*b;
     float ab = a*b;
     as_[i] = as[i];
     bs_[i] = bs[i];   
     as[i] = aa-bb+xs[i];
     bs[i] = 2.0*ab+ys[i];

     //if((a<xmax)&&(a>xmin)&&(b<ymax)&&(b>ymin)){
     int x = int(map(a,xmin,xmax,0,dim));
     int y = int(map(b,ymin,ymax,0,dim));
     if((x<dim)&&(x>0)&&(y<dim)&&(y>0)){
     //A[x*dim+y]+=1;
     //C[x*dim+y]+=1/(1+dr);
     
     //A[x*dim+y]+=log(1+dr);
     A[x*dim+y]+=(0.2+dr);
     B[x*dim+y]+=1;
     C[x*dim+y]+=(1/(0.2+dr));
     }

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
      //float cA = sqrt(A[i*dim+j] / expo);
      //float cB = sqrt(B[i*dim+j] / expo);
      //float cC = sqrt(C[i*dim+j] / expo);
      
      float cA = A[i*dim+j] / expo;
      float cB = B[i*dim+j] / expo;
      float cC = C[i*dim+j] / expo;
      
      color c = color(cA, cB, cC);
      set(j,i,c);
    }
  }
}

void keyPressed(){
if(key=='i'){save(year()+"_"+month()+"_"+day()+"_"+minute()+"_"+second());}
};

