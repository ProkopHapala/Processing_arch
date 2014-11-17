
/*
performance
nodes   [s/step]    [step/s]    [s/node]    [node/s]
5.5   3.9739487E-7   2516388.8     7.225361E-8   1.3840138E7
5.5   3.988533E-7   2507187.5     7.251878E-8   1.3789531E7


*/


static double [][] pos = { { -3.0,-2.0,-1.0, 0.0, 1.0, 2.0, 3.0 },
                           { -2.0,-1.0,-0.4, 0.0,-0.4,-1.0,-2.0 }};
                        //   { -1, 1,-1, 1,-1, 1,-1 }};
                           
static double [] kl  = {  1.0d, 1.0d, 1.0d, 1.0d, 1.0d, 1.0d };
static double [] l0s = {  1.0d, 1.0d, 1.0d, 1.0d, 1.0d, 1.0d };

//static double [] c0s = {  0.0d, 0.0d, 0.0d, 0.0d, 0.0d}; 
static double   [] c0s = {  0.5d,-0.5d,-0.0d,-0.5d, 0.5d }; 
static double   [] kc  = {  0.1d, 0.1d, 0.1d, 0.1d, 0.1d};

float nseg = 0.5*(kl.length + kc.length); // it is hard to say if should consider kings or sticks

double [][] fs = new double [2][pos[0].length];
double [][] vs = new double [2][pos[0].length];

float zoom=100;
int sz = 400; 

float fzoom = 25;

double dt       = 0.5; 
double friction = 0.0;

int perFrame = 10;

void setup(){
  size(sz*2,sz*2);
  rotate( 1.0, pos );
}

void draw(){
  background(255);
  
  //long t1 = System.nanoTime();
  
  for(int i=0; i<perFrame; i++){
    getForceStick1D( pos, vs, fs,  l0s, c0s, kl, kc, 0.5, 0.8, true );
    if(i==(perFrame-1)){
      plot( pos,  fs  );
    }  
    moveVerlet(dt,friction,pos[0],vs[0],fs[0]);
    moveVerlet(dt,friction,pos[1],vs[1],fs[1]);
  }
  /*
  long t12 = System.nanoTime() - t1; float tpstep = ( (t12*1e-9)/perFrame );
  println( "nodes \t[s/step]\t\t[step/s]\t\t[s/node]\t\t[node/s]");
  println( nseg+" \t"+tpstep +" \t"+ (1.0/tpstep) +" \t\t"+ (tpstep/nseg)+" \t"+ (nseg/tpstep) );
  noLoop();
  */
}

