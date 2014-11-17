
Body_RKF Bship,Btmp;

Trajectory Tr1;

final float  zoom = 1e+11;
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
  setVec( 40, 0.1, Xacc );
  Bship = new Body_RKF( 0, new double[6], 0.0d, 0.001d );
  Bship.X[0] = 149598261000.0d;        // [m]     // Earth distance from Sun
  Bship.X[4]=29780.0d;  // [m/s]   // Earth speed arround Sun
  
  Btmp = new Body_RKF( 1, new double[6], 0.0d, 0.001d );
  Tr1 = new Trajectory( 100 , 0x08FFFFFF );
  println( GM);
  size(800,800, P3D);
  background(0);
  myFont = createFont("ArialMT", 10);
  textFont(myFont);
}

int sc = 50;

void draw(){
  fill(0,5); rect(0,0,800,800);
  translate(400,400);
  scale(200,200);  
  strokeWeight(1); 
  for (int i=0; i<1; i++){ 
    t_glob +=dt_glob;
    Bship.move(t_glob);  Bship.paint();
    //strokeWeight(3); line( 20+6*B.id, 20, 20+6*B.id, 20+ (float)( B.nevals/(B.t/Tperiod) )/sc  );
  }
  if(frameCount%10==0)makeTrj();
  if(Tr1.mesh!=null){ shape(Tr1.mesh); }
  stroke(255); fill(255); 
  //strokeWeight(1);   paintAxis( 20, 20, sc );
  strokeWeight(10);  point(0,0);
}

void makeTrj(){
    Btmp.beLike( Bship );  Btmp.t=0; Btmp.t_old=0;
    Btmp.setThrust( -0.001d, 0, 0 );
    Tr1.genLinearTime( Tperiod*0.5, Btmp );
    //Tr1.genShape(1/zoom,POINTS);    
    Tr1.genShape(zoom,0); 
    //Tr1.mesh.stroke(Tr1.c);
    //Tr1.mesh.strokeWeight(1);
};

void keyPressed(){
  if(key==' '){
    makeTrj();
  };
}
