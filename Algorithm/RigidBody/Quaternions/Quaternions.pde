final static int sz = 200;
final static float zoom = 100;



final static double       dt = 0.5;
static       double [] omega = { dt*0.25, dt*0.5, dt    };

static       double [][] cam     = {  { omega[0], omega[1]+1, omega[2] }, {1,0,0}, {0,1,0}  }; 

static       double [][] R     = {  { 1, 0, 0 }, {0,1,0}, {0,0,1}  }; 

static double [] q = {0,0,0,0};

double angle = 0;
static double [] qomega = {0,0,0,0};

double [][] vs, vsR;

int perFrame=1;


void setup(){
  size(sz*2,sz*2);
      
  ortonormalize     ( cam );
  
  vs  = new double [50][3];
  vsR = new double [vs.length][3];
  for ( int i=0; i<vs.length; i++ ){ rand_vec( 1.0, vs[i] );  vsR[i][0]=vs[i][0];  vsR[i][1]=vs[i][1]; vsR[i][2]=vs[i][2];    }
  
  
  rand_vec( 1.0, R[0] );
  rand_vec( 1.0, R[1] );
  rand_vec( 1.0, R[2] );
  ortonormalize     ( R );
  println();
  println( " R :" );
  printMat( R );
  println();
  println( " R orthogonality:" );
  testOrthogonality( R );
  matrix_to_quaternion( R, q );
  println();
  println( " q = " + vec2string( q ) );
  double qnorm = qnormalize( q );
  println( " q = " + vec2string( q ) );
  println( " qnorm = " + qnorm );
  quaternion_to_matrix(  q, R );
  println();
  println( " R :" );
  printMat( R );
  println();
  println( " R orthogonality:" );
  testOrthogonality( R );

/*
  println( "  omega = " + vec2string(  omega ) );
  angle  = normalize( omega );
  AngleAxis_to_quaternion ( angle, omega, qomega );
  println( "  omega = " + vec2string(  omega ) );
  println( " qomega = " + vec2string( qomega ) );
  println( "  angle = " + angle );
*/  
}




void draw(){
  //background(255);
  
  
  
  for (int istep=0; istep<perFrame; istep++){
    // applyOmegaVecsExact( vsR,  omega );
         
    // Qmul( qomega, q , q  );
    //  println( vec2string( omega ) );
    //  rotate_quaternion_by_omega_vec ( omega, q );
      rotate_quaternion_by_omega_vec_Fast ( omega, q );
    //  println( vec2string( q ) );
      quaternion_to_matrix(  q, R );

     //applyOmegaVecsExact( R,  omega );
     matXvecs( R, vs, vsR );
  }
  
  for ( int i=0; i<vs.length; i++ ){ plotVecInRotation( vsR[i], cam ); }


  
 
}
