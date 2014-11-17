class SparseMatrix{
  SparseVector [] rows;
  
  SparseMatrix(){};
  SparseMatrix( int m, int n ){ rows=new SparseVector[m]; for(int i=0; i<m; i++) rows[i] = new SparseVector(n);  }
  
  SparseMatrix( double [][] A                    ){ rows=new SparseVector[A.length]; for(int i=0; i<A.length; i++) rows[i] = new SparseVector( A[i]         );  }
  SparseMatrix( double [][] A,        double tol ){ rows=new SparseVector[A.length]; for(int i=0; i<A.length; i++) rows[i] = new SparseVector( A[i],    tol );  }
  SparseMatrix( double [][] A, int n             ){ rows=new SparseVector[A.length]; for(int i=0; i<A.length; i++) rows[i] = new SparseVector( A[i], n      );  }
  SparseMatrix( double [][] A, int n, double tol ){ rows=new SparseVector[A.length]; for(int i=0; i<A.length; i++) rows[i] = new SparseVector( A[i], n, tol );  }
  
  final void fromMat( double [][] A             ){  for(int i=0; i<A.length; i++) {  rows[i].fromVec( A[i]     );} }
  final void fromMat( double [][] A, double tol ){  for(int i=0; i<A.length; i++) rows[i].fromVec( A[i],tol ); }  
  
  final void toMat  ( double [][] A ){ for(int i=0; i<rows.length; i++) rows[i].toVec( A[i] );                 }
  final void minMem( ){ for(int i=0; i<rows.length; i++) rows[i].minMem( ); }
  
  void printns     (  ){ for(int i=0; i<rows.length; i++) println( rows[i].n+" "+rows[i].ind.length );         }
  void printSparse (  ){ for(int i=0; i<rows.length; i++) println( rows[i].toString() );         }
  void printFull   (  ){ for(int i=0; i<rows.length; i++) println( rows[i].toStringFull() );     }
  
  final void mmul( double [] a, double [] c ){  for(int i=0; i<a.length; i++){ c[i] = rows[i].dot( a );  } }
  
  final void CG( final double [] b, double [] x, int maxIters, double maxErr2 ){
    this.mmul(x,r);
    sub( b, r, r );
    System.arraycopy( r, 0, p, 0, r.length );
    double rho = dot(r,r);
    double alpha = 0;
    for (iters =0; iters<maxIters; iters++) {
        this.mmul( p, Ap);
        alpha = rho / dot(p,Ap);
        fma( x, p ,  alpha,   x );
        fma( r, Ap, -alpha,   r2 );
        err2 = dot(r2,r2);
      if (err2 < maxErr2 ) break;
      double rho2 = dot(r2,r2);
      double beta = rho2 / rho;
      fma( r2, p, beta, p );
      rho = rho2;
      double [] swap = r; r = r2; r2 = swap;
    }
  }  
  
}
