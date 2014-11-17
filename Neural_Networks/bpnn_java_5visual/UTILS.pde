

double s2x( float  sx ) { return (sx-zoom*2)/zoom; }
float  x2s( double  x ) { return  ((float)x)*zoom+zoom*2; }

float toClr( double x ){
  return constrain( 128*(float)x+128 ,0,255 );
}


String vec2string( double [] xs){
  String s = "";
  for (int i= 0; i<xs.length; i++)  s = s +xs[i]+" "; 
  return s;
}

void printMat( double [][] mat ){
    for(int i=0;i<mat.length;i++){
      double [] mati = mat[i];
      println( vec2string( mati ) );
    }
}

void randomMatrix(float min, float max, double [][] mat){
    for(int i=0;i<mat.length;i++){
      double [] mati = mat[i];
      for(int j=0;j<mati.length;j++) mati[j] = random( min, max );
    }
}

void copyMatrix( double [][] from, double [][] to ){
    for(int i=0;i<to.length;i++){
      for(int j=0;j<to[i].length;j++) to[i][j] = from[i][j];
    }
}


void genExamples( int n, float radius ){
  examples_in  = new double [n][2];
  examples_out = new double [n][1];
  for (int i=0; i<n; i++){
    double x = random(-radius,radius);
    double y = random(-radius,radius);
    examples_in  [i][0]=x;
    examples_in  [i][1]=y;
    examples_out [i][0]=function_to_learn( x, y );
  }
}

