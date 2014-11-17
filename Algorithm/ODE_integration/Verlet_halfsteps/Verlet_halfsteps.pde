
static int sz = 300;
static float zoom = 100;
int perFrame = 5000;

static float rscale    = 10;
static float tscale    = 0.001;
  static float turnscale = 0.01;
static float Tscale    = 20;
static float logTscale    = 20;

//double dt = 0.115;
//double dt = 0.001;
//

OrbitIntegrator euler,leapFrog,verlet,verletHS;

// Orbital parameters see here: 
// http://en.wikipedia.org/wiki/Orbital_period
// http://en.wikipedia.org/wiki/Apsis
double a  = 1.0;  // semi major axis
//double e  = 0.6;  double dt = 0.01;
double e  = 0.9;  double dt = 0.001;

double T  = 2*Math.PI*Math.sqrt(a*a*a);
double x0 = (1+e)*a;  
double v0=Math.sqrt( (1-e)/x0 ); 

void setup(){
  size(2*sz,2*sz);
  euler    = new Euler    ( x0, 0, 0, v0 );
  leapFrog = new LeapFrog ( x0, 0, 0, v0 );
  verlet   = new Verlet   ( x0, 0, 0, v0 );
  verletHS = new VerletHS ( x0, 0, 0, v0 );
}


void draw(){
  //background(255);
  for(int i=0; i<perFrame; i++){
   // stroke(255,0,0);  euler    .move( dt );   euler   .plot( );
   // stroke(0,128,0);  leapFrog .move( dt );  leapFrog .plot( );
    stroke(0,0,255);    verlet   .move( dt );      verlet .plot( );
    stroke(255,0,255);  verletHS .move( dt*4 );   verletHS.plot( );
  }
  println(frameCount+" "+verlet.eval_per_turn+" "+verletHS.eval_per_turn );
  //println(frameCount+" "+verletTC.x+" "+verletTC.x );
  //println( frameCount+" "+T+" "+euler.period+" "+leapFrog.period+" "+verlet.period );
  
}
