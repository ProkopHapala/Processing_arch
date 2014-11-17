
  public static double[][] invert(double A[][]) {
    int n = A.length;
    double x[][] = new double[n][n];
    double b[][] = new double[n][n];
    int index[] = new int[n];
    for (int i=0; i<n; ++i) b[i][i] = 1;

 // Transform the matrix into an upper triangle
    gaussian(A, index);

 // Update the matrix b[i][j] with the ratios stored
    for (int i=0; i<n-1; ++i)
      for (int j=i+1; j<n; ++j)
        for (int k=0; k<n; ++k)
          b[index[j]][k] -= A[index[j]][i]*b[index[i]][k];

 // Perform backward substitutions
    for (int i=0; i<n; ++i) {
      x[n-1][i] = b[index[n-1]][i]/A[index[n-1]][n-1];
      for (int j=n-2; j>=0; --j) {
        x[j][i] = b[index[j]][i];
        for (int k=j+1; k<n; ++k) {
          x[j][i] -= A[index[j]][k]*x[k][i];
        }
        x[j][i] /= A[index[j]][j];
      }
    }
  return x;
  }

