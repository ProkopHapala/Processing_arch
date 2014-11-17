
static int    sz       = 400;
static float  zoom     = 100;

static double vscale = 0.1; 
static double fscale = 100.0; 

static int    npoints  = 4;
static int    perFrame = 1;

static double dt      =  0.2d; 
static double gravity = -1.0d; 
static double airDrag =  0.10d;

RigidBody_points body1;

double [][] points;
double [] masses;
double [] areas;

Matrix3x3 camera;
Matrix3x3 tmpMat;
double3   tmpVec;

double3   vWind;

void setup(){
  size(sz*2,sz*2);
  tmpMat = new Matrix3x3();
  tmpVec = new double3();
  vWind  = new double3( 0.75,-1.254,1.8478 );
  //vWind  = new double3( 0,0,0 );
  //camera = new Matrix3x3( new double[][]{{1,0,0},{0,1,0},{0,0,1}} );
  camera = new Matrix3x3( new double[][]{{vWind.x,vWind.y,vWind.z},{0,1,0},{0,0,1}} );
  camera.ortonormalize();
  println( " camera ortonormality: " );
  testOrthogonality( camera );
  /*
  points = new double [npoints][3];
  masses = new double [npoints];
  areas  = new double [npoints];
  for (int i=0;i<npoints; i++){
    masses[i]    = random(   0.2, 1.0 );
    areas [i]    = random(   0.2, 1.0 );
    points[i][0] = random(  -1.0, 1.0 );
    points[i][1] = random(  -1.0, 1.0 );
    points[i][2] = random(  -1.0, 1.0 );
  }
  */
  
  //masses  = new double []  {1,1,1,1,1,1};
  masses  = new double []  {0.5,0.5,0.7,0.7,1,1};
  //areas   = new double []  {0,0,0,0,0,1};
  areas   = new double []  {0.1,0.1,0.1,0.1,0.1,1};
  points  = new double [][]{{1,0,0},{-1,0,0}, {0,1,0},{0,-1,0},{0,0,1},{0,0,-1} };
  
  body1 = new RigidBody_points( points, masses, areas );
  //println( body1.invIbody );
  body1.L.set( new double []{1,0.7,0.5} );
  //body1.L.set( new double []{0,0,0} );
  
}

void draw(){
  //background(255);
  fill(255,10);
  rect(0,0,width,height);
  println( "========= "+frameCount );
  for (int i=0; i<perFrame; i++){
    body1.evalForce();
    body1.move();
  }
  //noLoop();
  
  stroke(128,128,128);
  plotLineInRotation( 0, 0, 0,    vWind.x, vWind.y, vWind.z, camera );
  stroke(0,0,0);
  body1.plotPoints();  // plot full body
  //body1.plotRotation();  // plot just orientation vectors
  
  if( Double.isNaN(body1.Q.w) ) noLoop();
              
  //if(frameCount>=2)noLoop();
}

