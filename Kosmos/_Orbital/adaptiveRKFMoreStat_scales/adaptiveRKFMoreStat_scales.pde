
ArrayList<Body_RKF> Bodies;
Derivatives   Sun_Gravity;   // derivatives object

final float  zoom = 200/1e+11;
final int    MAX_ITER = 30;

final double M  = 1.98855E+30; 
final double G  = 6.67384e-11;
final double GM = M*G;

double [] Xacc = new double[6]; // scales for error metric 

double Tperiod = 365 * 24 * 3600;
      
double dt_glob = 3600*12;
double t_glob = 0;
double tmax = 1000.0;

PFont myFont;

void setup(){
  Sun_Gravity = new EulerVelPos3D();
  Bodies = new ArrayList();
  setVec( 40, 0.1, Xacc );
  for (int i=0;i<20;i++){
    Body_RKF B = new Body_RKF( i, new double[6], 0.0d, 0.001d );
    //B.X[0] = random(0.2,1.2);
    B.X[0] = 149598261000.0d;        // [m]     // Earth distance from Sun
    //B.X[4] = random(0.1,1.5);
    B.X[4]=(0.1 + 0.05*i)*29780.0d;  // [m/s]   // Earth speed arround Sun
    Bodies.add( B ); 
  }
  println( GM);
  size(800,800);
  background(0);
  myFont = createFont("ArialMT", 10);
  textFont(myFont);
}

int sc = 50;

void draw(){
  fill(0,5); rect(0,0,800,800);
  strokeWeight(1); 
  for (int i=0; i<1; i++){ 
    t_glob +=dt_glob;
    for( Body_RKF B : Bodies ){
      B.move(t_glob);
      B.paint();
      strokeWeight(3); line( 20+6*B.id, 20, 20+6*B.id, 20+ (float)( B.nevals/(B.t/Tperiod) )/sc  );
    }
  }
  stroke(255); fill(255); 
  strokeWeight(1);   paintAxis( 20, 20, sc );
  strokeWeight(10);  point(400,400);
}
