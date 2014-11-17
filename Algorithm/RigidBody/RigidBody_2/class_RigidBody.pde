
// according to 
// An Introduction to Physically Based Modeling:
// Rigid Body Simulation I—Unconstrained Rigid
// Body Dynamics
// David Baraff
// https://www.cs.cmu.edu/~baraff/sigcourse/notesd1.pdf

class RigidBody {

  // parameters
  double     imass; 
  Matrix3x3  invIbody; 
  // State variables 
  double3    pos;         
  Quaternion Q;   
  double3    v;              
  double3    L;            
  // auxiliary variables
  Matrix3x3  R;           
  Matrix3x3  invI;        
  double3 omega; 
  double3 force;
  double3 torque; 
  
  RigidBody(){
    // parameters
    invIbody  = new Matrix3x3();
    // State variables 
    pos       = new double3();
    Q         = new Quaternion();   //Q.diffRot_exact( new double3(1.5,-1.2,2.0), 1 );
    println( " new Q: "+Q );
    v         = new double3();
    L         = new double3();
    // auxiliary variables
    R         = new Matrix3x3();   
    invI      = new Matrix3x3();
    omega     = new double3();
    force     = new double3();
    torque    = new double3();
    // initialize rotation temporary
    Q.toRotationMatrix       ( R       );
  }
  
  void move(){
    // update state variables ( by verlet = update velocities first, switch that if you do Runge-Kutta )
    //v   .add_mul (  force, dt*imass );
    //pos .add_mul (      v, dt       );
    //println( " v:          "+v );
    //println( " L:          "+L );
    L   .add_mul ( torque, dt       );  // we have to use angular momentum as state variable, omega is not conserved
    //println( " L+tq*dt:    "+L );
    invI.transform( L, omega );
    //println( " omega:      "+omega );
    //Q.diffRot_exact( omega, dt );
    Q.diffRot_taylor2( omega, dt );
    //println( " Q: "+Q+" norm2 "+Q.norm2() );
    // recompute auxiliary variables
    Q.toRotationMatrix ( R       );
    //println( " R: " );
    //println(   R );
    //R.similarityTransform    ( invIbody, invI );
    R.similarityTransform_T    ( invIbody, invI );
    //R.mmul_T ( invIbody, invI ); R.mmul   ( invI    , invI );
    //R.mmul   ( invIbody, invI );   R.mmul_T   ( invI    , invI );
    println( " invI: " );
    println(   invI );
  }
  
  void plotRotation(){
    //println( pos );
    //println( R   );
    stroke(255,0,0); plotLineInRotation( pos.x, pos.y, pos.z,    pos.x + R.m00, pos.y + R.m01, pos.z + R.m02, camera );
    stroke(0,255,0); plotLineInRotation( pos.x, pos.y, pos.z,    pos.x + R.m10, pos.y + R.m11, pos.z + R.m12, camera );
    stroke(0,0,255); plotLineInRotation( pos.x, pos.y, pos.z,    pos.x + R.m20, pos.y + R.m21, pos.z + R.m22, camera );
    
    //stroke(255,0,0); plotPointInRotation( pos.x + R.m00, pos.y + R.m01, pos.z + R.m02, camera );
    //stroke(0,255,0); plotPointInRotation( pos.x + R.m10, pos.y + R.m11, pos.z + R.m12, camera );
    //stroke(0,0,255); plotPointInRotation( pos.x + R.m20, pos.y + R.m21, pos.z + R.m22, camera );
  }
  
}




