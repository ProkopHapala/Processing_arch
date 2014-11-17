static class matrix{

public static void write( double A[][]){
	        int numRows = A.length;
	        int numCols = A[0].length;
                for (int i = 0; i < numRows; i++){ 
	            for (int j = 0; j < numCols; j++){ 
                        print(" "+A[i][j]);}
                println();
                }
                println();
}  
  
///// ------- Clone Matrix B:= A ----------------  
  
public double [][] clon( double A[][]){
	        int numRows = A.length;
	        int numCols = A[0].length;
                double B[][] = new double[numRows][numCols];
                for (int i = 0; i < numRows; i++) 
	            for (int j = 0; j < numCols; j++) 
                        B[i][j] = A[i][j];
           return B; 
}

///// ------- Copy Matrix B:= A ---------------- 

public static void cp( double A[][], double B[][]){
	        int numRows = A.length;
	        int numCols = A[0].length;
                for (int i = 0; i < numRows; i++) 
	            for (int j = 0; j < numCols; j++) 
                        B[i][j] = A[i][j];
}

///// ------- Zero Matrix B:= A ---------------- 

public static void zero( double A[][]){
	        int numRows = A.length;
	        int numCols = A[0].length;
                for (int i = 0; i < numRows; i++) 
	            for (int j = 0; j < numCols; j++) 
                        A[i][j] = 0;
}

///// -------- Identity -----------------------

public static void identity( double A[][]){
	        int numRows = A.length;
	        int numCols = A[0].length;
                for (int i = 0; i < numRows; i++) 
	            for (int j = 0; j < numCols; j++) 
                        A[i][j] = 0;
                for (int i = 0; i < numRows; ++i) 
                        A[i][i] = 1.0;
}


///// ------- Transpose Matrix B:= Transpose(A) ---------------- 

public static void transpose( double A[][], double B[][]){
	        int numRows = A.length;
	        int numCols = A[0].length;
                for (int i = 0; i < numRows; i++) 
	            for (int j = 0; j < numCols; j++) 
                        B[j][i] = A[i][j];
}

///// ------- Multiply Matrix C:= A*B ---------------- 
public static void mul( double A[][], double B[][],double C[][]){
  	int ni = A.length;
        int nj = B[0].length;
	int nk = A[0].length;
        for (int i = 0; i < ni; i++)
            for (int j = 0; j < nj; j++)
                for (int k = 0; k < nk; k++)
                    C[i][j] += (A[i][k] * B[k][j]);
}


///// ------- Multiply Matrix times vector C:= A*b ---------------- 
public static void vec( double A[][], double b[],double c[]){
  	int ni = A.length;
	int nk = A[0].length;
        for (int i = 0; i < ni; i++)
                for (int k = 0; k < nk; k++)
                    c[i] += (A[i][k] * b[k]);
}
                    

// --------- Gauss Jordan Eliminaton ----------------

public static void gaussJordan(double a[][], double b[]){
	        int i, j, k, m;
	        double temp;
	        int numRows = a.length;
	        int numCols = a[0].length;
	        int index[][] = new int[numRows][2];
	        partialPivot(a, b, index);
	        for (i = 0; i < numRows; ++i) {
	            temp = a[i][i];
	            for (j = 0; j < numCols; ++j) {
	                a[i][j] /= temp;
	            }
	            b[i] /= temp;
	            a[i][i] = 1.0 / temp;
	            for (k = 0; k < numRows; ++k) {
	                if (k != i) {
	                    temp = a[k][i];
	                    for (j = 0; j < numCols; ++j) {
	                        a[k][j] -= temp * a[i][j];
	                    }
	                    b[k] -= temp * b[i];
	                    a[k][i] = -temp * a[i][i];
	                }
	            }
	        }
	        for (j = numCols - 1; j >= 0; --j) {
	            k = index[j][0];
	            m = index[j][1];
	            if (k != m) {
	                for (i = 0; i < numRows; ++i) {
	                    temp = a[i][m];
	                    a[i][m] = a[i][k];
	                    a[i][k] = temp;
	                }
	            }
	        }
	        return;
	    }


// --------- Partial Pivoting ----------------

	    private static void partialPivot(
	            double mt[][], double v[], int index[][]) {
	        double temp;
	        double tempRow[];
	        int i, j, m;
	        int numRows = mt.length;
	        int numCols = mt[0].length;
	        double scale[] = new double[numRows];
	        for (i = 0; i < numRows; ++i) {
	            index[i][0] = i;
	            index[i][1] = i;
	            for (j = 0; j < numCols; ++j) {
	                scale[i] = Math.max(scale[i], Math.abs(mt[i][j]));
	            }
	        }
	        for (j = 0; j < numCols - 1; ++j) {
	            m = j;
	            for (i = j + 1; i < numRows; ++i) {
                if (Math.abs(mt[i][j]) / scale[i] >
	                        Math.abs(mt[m][j]) / scale[m]) {
	                    m = i;
	                }
	            }
	            if (m != j) {
	                index[j][0] = j;
	                index[j][1] = m;
	                tempRow = mt[j];
	                mt[j] = mt[m];
	                mt[m] = tempRow;
	                temp = v[j];
	                v[j] = v[m];
	                v[m] = temp;
	                temp = scale[j];
	                scale[j] = scale[m];
	                scale[m] = temp;
	            }
	        }
	    }
	 
// --------- inverse Matrix ----------------

	    public static void invert(double a[][]) {
	        int i, j, k, m;
	        double temp;
	 
	        int numRows = a.length;
	        int numCols = a[0].length;
	        int index[][] = new int[numRows][2];
	        partialPivot(a, new double[numRows], index);
	        for (i = 0; i < numRows; ++i) {
	            temp = a[i][i];
	            for (j = 0; j < numCols; ++j) {
	                a[i][j] /= temp;
	            }
	            a[i][i] = 1.0 / temp;
	            for (k = 0; k < numRows; ++k) {
	                if (k != i) {
	                    temp = a[k][i];
	                    for (j = 0; j < numCols; ++j) {
	                        a[k][j] -= temp * a[i][j];
	                    }
	                    a[k][i] = -temp * a[i][i];
	                }
	            }
	        }
	        for (j = numCols - 1; j >= 0; --j) {
	            k = index[j][0];
	            m = index[j][1];
	            if (k != m) {
	                for (i = 0; i < numRows; ++i) {
	                    temp = a[i][m];
	                    a[i][m] = a[i][k];
	                    a[i][k] = temp;
	                }
	            }
	        }
            }
	

}
