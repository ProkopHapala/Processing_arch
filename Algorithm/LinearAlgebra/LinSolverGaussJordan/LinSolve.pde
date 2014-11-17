

// =============================================================
// ****************     SOLVE    ******************************
// Method to solve the equation a[][] x[] = b[] with
// the partial-pivoting Gaussian elimination.
// ================================================================
  public static void solve(double a[][],double b[], double x[], int index[]) {
    int n = b.length;
    //double x[] = new double[n];

 // Transform the matrix into an upper triangle
    gaussian(a, index);

 // Update the array b[i] with the ratios stored
    for(int i=0; i<n-1; ++i) {
      for(int j =i+1; j<n; ++j) {
        b[index[j]] -= a[index[j]][i]*b[index[i]];
      }
    }

 // Perform backward substitutions
    x[n-1] = b[index[n-1]]/a[index[n-1]][n-1];
    for (int i=n-2; i>=0; --i) {
      x[i] = b[index[i]];
      for (int j=i+1; j<n; ++j) {
        x[i] -= a[index[i]][j]*x[j];
      }
      x[i] /= a[index[i]][i];
    }
   // return x;
  }
  

// =============================================================
// ****************     gaussian   ****************************
// Method to carry out the partial-pivoting Gaussian
// elimination.  Here index[] stores pivoting order.
// =============================================================

  public static void gaussian(double a[][], int index[]) {
    int n = index.length;
    double c[] = new double[n];

 // Initialize the index
    for (int i=0; i<n; ++i) index[i] = i;

 // Find the rescaling factors, one from each row
    for (int i=0; i<n; ++i) {
      double c1 = 0;
      for (int j=0; j<n; ++j) {
        double c0 = Math.abs(a[i][j]);
        if (c0 > c1) c1 = c0;
      }
      c[i] = c1;
    }

 // Search the pivoting element from each column
    int k = 0;
    for (int j=0; j<n-1; ++j) {
      double pi1 = 0;
      for (int i=j; i<n; ++i) {
        double pi0 = Math.abs(a[index[i]][j]);
        pi0 /= c[index[i]];
        if (pi0 > pi1) {
          pi1 = pi0;
          k = i;
        }
      }

      // Interchange rows according to the pivoting order
      int itmp = index[j];
      index[j] = index[k];
      index[k] = itmp;
      for (int i=j+1; i<n; ++i) {
        double pj = a[index[i]][j]/a[index[j]][j];

       // Record pivoting ratios below the diagonal
        a[index[i]][j] = pj;

       // Modify other elements accordingly
        for (int l=j+1; l<n; ++l)
          a[index[i]][l] -= pj*a[index[j]][l];
      }
    }
  }
