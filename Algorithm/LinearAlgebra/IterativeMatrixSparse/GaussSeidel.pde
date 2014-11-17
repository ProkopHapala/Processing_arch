
final static void diagonalEstimate( final double [][] A, final double [] b, double [] x, double softening ){
  for(int i=0; i<A.length; i++) {
     double Aii = A[i][i];
     if ( Aii<0 ) {  x[i] = b[i]/( Aii - softening ); 
     }else{          x[i] = b[i]/( Aii + softening );      }
  }
}

final static void gaussSeidelStep( final double [][] A, final double [] b, double [] x ){
  for(int i=0; i<A.length; i++) {
    double sum = 0;
    double [] Ai = A[i];
    //for(j=0; j<n; j++) if(j!=i) sum += Ai[j]*x[j];
    for(int j=0;   j<i; j++) sum += Ai[j]*x[j]; // uper triangular
    for(int j=i+1; j<Ai.length; j++) sum += Ai[j]*x[j]; // lower triangular
    x[i] = (-sum + b[i])/A[i][i];
  }
}

final static void SORStep( final double [][] A, final double [] b, double [] x, double alfa ){
  double beta = 1 - alfa;
  for(int i=0; i<A.length; i++) {
    double sum = 0;
    double [] Ai = A[i];
    //for(j=0; j<n; j++) if(j!=i) sum += Ai[j]*x[j];
    for(int j=0;   j<i; j++) sum += Ai[j]*x[j]; // uper triangular
    for(int j=i+1; j<Ai.length; j++) sum += Ai[j]*x[j]; // lower triangular
    //x[i] = (b[i]-sum)/A[i][i];
    x[i]=beta*x[i] + alfa*( b[i]-sum )/A[i][i];
  }
}


