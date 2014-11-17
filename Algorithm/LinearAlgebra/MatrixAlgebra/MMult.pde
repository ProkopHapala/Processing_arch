
public static double [][] MMult( double A[][], double B[][], double C[][] )  {  
  int ni = A.length;
  int nj = B.length;
  int nk = B[0].length;
  for(int i=0;i<ni;i++) {
      for(int j=0;j<nj;j++){
          C[i][j] = 0.0;
        for(int k=0;k<nk;k++){
          C[i][j] += A[i][k]*B[k][j];
     }
   }  
 }
return C;
}



public static double [][] MfAdd(double f, double A[][], double B[][]  ){
 int ni = A.length;
 int nj = A[0].length;
 for(int i=0;i<ni;i++) {
      for(int j=0;j<nj;j++){
          B[i][j] += f*A[i][j];
     }
   }  
   return B;
}


public static double [][] MfMult(double f, double A[][]){
 int ni = A.length;
 int nj = A[0].length;
 for(int i=0;i<ni;i++) {
      for(int j=0;j<nj;j++){
          A[i][j] *= f;
     }
   }
 return A;  
 
}

// Method to calculate the trace of a matrix.
public static double tr(double a[][]) { 
    int n = a.length;
    double sum = 0;
    for (int i=0; i<n; ++i) sum += a[i][i];
    return sum;
  }






void printMat( double A[][]){
int ni = A.length;
int nj = A[0].length;
for(int i=0;i<ni;i++) {
    for(int j=0;j<nj;j++){
          print (A[i][j]+" ");
     }
     println();
   }
   println();
}
