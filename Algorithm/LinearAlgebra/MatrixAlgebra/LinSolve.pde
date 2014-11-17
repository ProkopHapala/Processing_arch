

// =============================================================
// ****************     SOLVE    ******************************
// Method to solve the equation A[][] x[] = b[] with
// the partial-pivoting Gaussian elimination.
// ================================================================
  public static double[] solve(double A[][],double b[], int index[]) {
    int n = b.length;
    double x[] = new double[n];

 // Transform the matrix into an upper triangle
    gaussian(A, index);

 // Update the array b[i] with the ratios stored
    for(int i=0; i<n-1; ++i) {
      for(int j =i+1; j<n; ++j) {
        b[index[j]] -= A[index[j]][i]*b[index[i]];
      }
    }

 // Perform backward substitutions
    x[n-1] = b[index[n-1]]/A[index[n-1]][n-1];
    for (int i=n-2; i>=0; --i) {
      x[i] = b[index[i]];
      for (int j=i+1; j<n; ++j) {
        x[i] -= A[index[i]][j]*x[j];
      }
      x[i] /= A[index[i]][i];
    }
    return x;
  }
  
