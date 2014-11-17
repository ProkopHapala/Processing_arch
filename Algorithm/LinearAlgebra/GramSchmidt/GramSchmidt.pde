
int n = 5;

double [][] Ain,Aout;
double []   norms2;

void setup(){

  Ain   = new double[n][n];
  Aout  = new double[n][n];
  norms2 = new double[n];
  
  randomMat( 1.0, Ain );
  
  println(  );
  println( " Input matrix: " );
  printMat( Ain );
  
  //orthogonalize( true, Ain, Aout, norms2 );
  orthogonalize( false, Ain, norms2 );
  
  println(  );
  println( " norms2: " );
  println( vec2string( norms2) );
  
  println(  );
  println( " Output matrix: " );
  printMat( Ain );
  
  println(  );
  println( " Testing orthogonality: " );
  orthoTest( Ain );


}
