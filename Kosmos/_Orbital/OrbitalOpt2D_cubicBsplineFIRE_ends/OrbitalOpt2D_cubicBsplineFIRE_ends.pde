

/*
Nodes   [s/step]       [step/s]      [s/node]       [node/s]
25      1.3080177E-5     76451.56     5.2320706E-7   1.9112891E6
20      2.8022083E-7   3568614.0      1.4011041E-8   7.137228E7
15      2.3726595E-7   4214680.0      1.581773E-8    6.3220196E7
10      1.7109762E-7   5844616.5      1.7109762E-8   5.8446164E7
*/


int   nseg  = 20;
int   ncoef = nseg+3;
int   nsub = 5;
float yzoom = 200;
int      sz = 400;

double [][] Cs    = new double[2][ncoef];
double [][] FCs   = new double[2][ncoef];
double [][] VCs   = new double[2][ncoef];
//double usamp = 1.0/(Cs[0].length-3);

final double [] xstart = {  1.0, 0 };
final double [] vstart = { 0,  1.0      };

final double [] xend   = { -0.5, 0 };
final double [] vend   = { 0,  -sqrt(2) };

//final double [] xend   = { 0, -0.5   };
//final double [] vend   = { sqrt(2),0 };

/*
final double [] xstart = {  1,  0 };
final double [] xend   = { -1,  0 };
final double [] vstart = {  0, +1 };
final double [] vend   = {  0, -1 };
*/

double T      = PI*0.25; 
double u_t    = nseg/T;
//double u_t    = T/nseg;
double t_u    = 1.0/u_t;
double u_t2   = u_t*u_t;

double T2tot   = 0;

PGraphics overlay;

void setup(){
  size(2*sz,2*sz);
  //frameRate(5);
  overlay = createGraphics(width, height);;
  init_tranjectory(  );
  println( vec2str( Cs[0] ) );
  println( vec2str( Cs[1] ) );
  
  boundaryLeft ( Cs[0], xstart[0], vstart[0] * t_u );
  boundaryRight( Cs[0], xend  [0], vend  [0] * t_u );
  boundaryLeft ( Cs[1], xstart[1], vstart[1] * t_u );
  boundaryRight( Cs[1], xend  [1], vend  [1] * t_u );
  
  background(255);
  plotSpline();
  //frameRate(4);
}


int perFrame      = 10;
//int perFrame    = 100000;
int iter=0;
double tolerance = 0.5;

boolean pause=false;

double ologf=0,ologT; 

void draw(){
  overlay.beginDraw();
  //fill(255,255,255,50); rect(0,0,400,400);
  
  if(!pause){
  background(255);
  long t1 = System.nanoTime();
  
  boolean plot=true;
  double f2=0;

  for (int i=0; i<perFrame; i++){
    getDerivs(       Cs, FCs, plot    ); plot=false;
    
    //f2 = move_FIRE     ( Cs, FCs, VCs );
    f2 = move_FIREtrue   ( Cs, FCs, VCs );
    //f2 = move_FIREortho   ( Cs, FCs, VCs );
    //f2 = move_PROKOP     ( Cs, FCs, VCs );
    
    boundaryLeft ( Cs[0], xstart[0], vstart[0] * t_u );
    boundaryRight( Cs[0], xend  [0], vend  [0] * t_u );
    boundaryLeft ( Cs[1], xstart[1], vstart[1] * t_u );
    boundaryRight( Cs[1], xend  [1], vend  [1] * t_u );
    
    iter++;

    if(f2<(tolerance*tolerance)){
      println( " |grad|= " + Math.sqrt(f2) + " is lower than tolerance"+ tolerance+" -> FINISHED !!! " );
      println( " |T^2| = " + T2tot );
      println( " Steps = " + iter );
      noLoop();
      break;
    }  
  }
  double logf =10*Math.log(f2);
  double logT =20*Math.log(T2tot);
  overlay.stroke(255,0,0); overlay.line( frameCount-1, sz-(float)ologf, frameCount, sz-(float)logf );
  overlay.stroke(0,0,255); overlay.line( frameCount-1, sz-(float)ologT, frameCount, sz-(float)logT );
  ologf = logf; ologT = logT;
  //long t12 = System.nanoTime() - t1; float tpstep = ( (t12*1e-9)/perFrame );
  //println( "[s/step]\t\t[step/s]\t\t[s/node]\t\t[node/s]");
  //println( tpstep +" \t"+ (1.0/tpstep) +" \t\t"+ (tpstep/nseg)+" \t"+ (nseg/tpstep) );
  //noLoop();
  println( "iter "+iter+" |T^2|= "+T2tot+" |grad|= "+f2 );
  plotSpline();
  }
  overlay.endDraw();
  image(overlay,0,0);
}


void keyPressed(){
  pause = !pause;
}
