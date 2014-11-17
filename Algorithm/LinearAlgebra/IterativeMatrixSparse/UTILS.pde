
// ================ Matrix Vector ops

final static double  dot( final double [] a, final double [] b ){  double sum = 0;   for(int i=0; i<a.length; i++) { sum+=a[i]*b[i]; } return sum;}

final static double dist2( double [] a, double [] b ){  double sum = 0;  for(int i=0; i<a.length; i++) { double dx=a[i]-b[i]; sum+=dx*dx; }  return sum;}

final static void  div( final double [] a, final double f, double [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]/f; }  }
final static void  mul( final double [] a, final double f, double [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]*f; }  }
final static void  add( final double [] a, final double f, double [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]+f; }  }
final static void  sub( final double [] a, final double f, double [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]-f; }  }

final static void  div( final double [] a, final double [] b, double [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]/b[i]; }  }
final static void  mul( final double [] a, final double [] b, double [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]*b[i]; }  }
final static void  add( final double [] a, final double [] b, double [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]+b[i]; }  }
final static void  sub( final double [] a, final double [] b, double [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]-b[i]; }  }
final static void  fma( final double [] a, final double [] b, double f, double [] c ){ for(int i=0; i<a.length; i++) { c[i]=a[i]+f*b[i]; }  }

final static void copy( final double [][] A, double [][] B ){  for(int i=0; i<A.length; i++) System.arraycopy( A[i], 0, B[i], 0, A[i].length );    }
final static void mmul( final double [][] A, final double [] b, double [] c ){ for(int i=0; i<A.length; i++) { c[i]=dot( A[i], b ); }  }
final static void mmul_SIMD( final double [][] A, final double [] b, double [] c ){ for(int i=0; i<A.length; i++) { c[i]=dot_SIMD( A[i], b ); }  }

final static void mul( final double [][] A, double f,      double [][] C ){ for(int i=0; i<A.length; i++) { mul( A[i], f,    C[i] ); }  }
final static void mul( final double [][] A, final double [] b,   double [][] C ){ for(int i=0; i<A.length; i++) { mul( A[i], b,    C[i] ); }  }
final static void mul( final double [][] A, final double [][] B, double [][] C ){ for(int i=0; i<A.length; i++) { mul( A[i], B[i], C[i] ); }  }



// ================ Random 

final void set( double c, double [] a ){
  for(int i=0; i<a.length; i++) {  a[i] = c; }
}

final void set( double c, double [][] A ){
  for(int i=0; i<A.length; i++) {  set(c,A[i]); }
}

final void addRandomVec( double c, double r, double [] a){
  for(int i=0; i<a.length; i++) {  a[i] += c + r*rnd.nextDouble();   }
}

final void addRndDiag( double c, double r, double [][] A ){
  for(int i=0; i<A.length; i++) {  A[i][i] += c + r*rnd.nextDouble(); }
}

final void addRndPosSym( double c, double r, double [][] A ){
 for(int i=0; i<A.length; i++) { 
   int j = rnd.nextInt(A.length-1);    if (j>=i) j++;
   double Aij = c + r*rnd.nextDouble(); 
   A[i][j] += Aij; A[j][i] += Aij;
 }
}

final void addRndNoiseSym( double c, double r, double [][] A ){
 for(int i=0; i<A.length; i++) { 
    for(int j=0; j<i; j++) {
      double Aij = c + r*rnd.nextDouble(); 
      A[i][j] += Aij; A[j][i] += Aij;
    }  
 }
}

String vec2string(double [] a){
  String s = "";
  for(int i=0; i<a.length; i++) {     s+=a[i]+" ";   }
  return s;
}

void printMat(double [][] A){
  for(int i=0; i<A.length; i++) {  println( vec2string(A[i]) );   };
}


