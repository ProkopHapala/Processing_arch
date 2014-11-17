
//static double [] template = { 1e+3, -1.0, +1e-2, -1e-4  };

static double [] template = { 1, +0.5, +0.4, +0.3  };

double [][] Afull,Atest;

void setup(){
  
  int pixsz = 5; 
  size(800,400);
  colorMode(RGB,1.0);
  double [][] A     = genBandMat( 10, 0.00,0.00, template);
  double [] b       = new double[A.length];
  double [] x       = new double[A.length];
  Afull = new double[A.length][A.length];
  Atest = new double[A.length][A[0].length];
  println( " Afull.length : "+Afull.length );
  noStroke();
  
  removePBC( A );
  
  /*
  plotMat( 0       ,0, pixsz,  A     );
  Band2Full  ( A, Afull );
  plotMat(  6*pixsz,0, pixsz,  Afull );
  Full2Band  ( Afull,Atest );
  plotMat( 22*pixsz,0, pixsz,  Atest     );
  sub( Atest, A  , Atest );
  plotMat( 28*pixsz,0, pixsz,  Atest     );
  */
   
  SolveBand( A, b  );
}
