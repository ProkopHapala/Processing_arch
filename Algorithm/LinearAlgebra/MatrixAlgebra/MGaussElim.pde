// =============================================================
// ****************     gaussian   ****************************
// Method to carry out the partial-pivoting Gaussian
// elimination.  Here index[] stores pivoting order.
// =============================================================

  public static void gaussian(double A[][], int index[]) {
    int n = index.length;
    double c[] = new double[n];

 // Initialize the index
    for (int i=0; i<n; ++i) index[i] = i;

 // Find the rescaling factors, one from each row
    for (int i=0; i<n; ++i) {
      double c1 = 0;
      for (int j=0; j<n; ++j) {
        double c0 = Math.abs(A[i][j]);
        if (c0 > c1) c1 = c0;
      }
      c[i] = c1;
    }

 // Search the pivoting element from each column
    int k = 0;
    for (int j=0; j<n-1; ++j) {
      double pi1 = 0;
      for (int i=j; i<n; ++i) {
        double pi0 = Math.abs(A[index[i]][j]);
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
        double pj = A[index[i]][j]/A[index[j]][j];

       // Record pivoting ratios below the diagonal
        A[index[i]][j] = pj;

       // Modify other elements accordingly
        for (int l=j+1; l<n; ++l)
          A[index[i]][l] -= pj*A[index[j]][l];
      }
    }
  }
