


double [][] genBandMat( int ni, float crand, float casym, double [] template ){
 int nj = template.length-1;
 double [][] A = new double [ni][2*nj+1]; 
 for(int i=0; i<ni; i++){
   A[i][nj] = template[0]*( 1 + random(-crand,crand) );
   for(int j=1; j<=nj; j++){
     double val = template[j]*( 1 + random(-crand,crand) );   double asym = template[j]*random(-casym,casym);
     //println( "i:"+i+"   j: "+j+" nj-j: "+(nj-j)+" nj+j: "+(nj+j)+"  val "+val  );
     A[i][nj-j] = val + asym;
     A[i][nj+j] = val - asym;
   }
 }  
 return A;
}

void removePBC( double [][] A ){
  int nj = A[0].length;
  int nk = nj>>1; 
  for(int i=0; i<nk; i++){
    double [] Ai  = A[i];
    for (int j=i;j<nk;j++){ Ai [ nk - j -1 ] = 0;  }
    double [] Ami = A[ A.length - i - 1 ];
    for (int j=i;j<nk;j++){ Ami[ nk + j +1 ] = 0;  }
  }
}


String vec2string(double [] a){
  String s = "";
  for(int i=0; i<a.length; i++) {     
    //s+=nf((float)a[i],2,4)+" ";  
    s+=String.format("%2.2f ", a[i] );  
  }
  return s;
}

void plotMat( int ix, int iy, int pixsz,  double [][] A ){ 
 int nj = A[0].length; 
 for(int i=0; i<A.length; i++){
   //println( "i:"+i+" "+vec2string( A[i]  )  );
   for(int j=0; j<nj; j++){
     float f = (float ) A[i][j];
     color c;
     if(f<0){ c=color(-f,0,0); }else{ c=color(0,f,0); }   // linear scale
     //if(f<0){ c=color(0.05*0.4342944819*log(-f+1e-10)+0.5,0,0); }else{ c=color(0,0.05*0.4342944819*log(f+1e-10)+0.5,0); }
     //println( i+" "+j+" "+f );
     if  (pixsz>1){  fill(c); rect( ix + pixsz*j, iy + pixsz*i,pixsz,pixsz); }
     else         {  set( ix + j, iy +iy, c );    }  
   }
 }  
}


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

final static void mul( final double [][] A, double f,      double [][] C ){ for(int i=0; i<A.length; i++)       { mul( A[i], f,    C[i] ); }  }
final static void mul( final double [][] A, final double [] b,   double [][] C ){ for(int i=0; i<A.length; i++) { mul( A[i], b,    C[i] ); }  }
final static void mul( final double [][] A, final double [][] B, double [][] C ){ for(int i=0; i<A.length; i++) { mul( A[i], B[i], C[i] ); }  }

final static void add( final double [][] A, double f,      double [][] C ){ for(int i=0; i<A.length; i++)       { add( A[i], f,    C[i] ); }  }
final static void add( final double [][] A, final double [] b,   double [][] C ){ for(int i=0; i<A.length; i++) { add( A[i], b,    C[i] ); }  }
final static void add( final double [][] A, final double [][] B, double [][] C ){ for(int i=0; i<A.length; i++) { add( A[i], B[i], C[i] ); }  }

final static void sub( final double [][] A, double f,      double [][] C ){ for(int i=0; i<A.length; i++)       { sub( A[i], f,    C[i] ); }  }
final static void sub( final double [][] A, final double [] b,   double [][] C ){ for(int i=0; i<A.length; i++) { sub( A[i], b,    C[i] ); }  }
final static void sub( final double [][] A, final double [][] B, double [][] C ){ for(int i=0; i<A.length; i++) { sub( A[i], B[i], C[i] ); }  }

/*
final static void fma( final double [][] A, double f,      double [][] C ){ for(int i=0; i<A.length; i++) { mul( A[i], f,    C[i] ); }  }
final static void fma( final double [][] A, final double [] b,   double [][] C ){ for(int i=0; i<A.length; i++) { mul( A[i], b,    C[i] ); }  }
final static void fma( final double [][] A, final double [][] B, double [][] C ){ for(int i=0; i<A.length; i++) { mul( A[i], B[i], C[i] ); }  }
*/

