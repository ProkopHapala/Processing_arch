

final static double dot( double [] a, double [] b ){
  double sum = 0;
  for(int i=0; i<a.length; i++){ double ai = a[i]; double bi = b[i]; sum+=ai*bi; }
  return sum; 
}


void orthogonalize( boolean normalize, double [][] Ain, double [] norms2 ){
  
    // compute norms
    for(int i=0; i<Ain.length ;i++){
      double [] ai = Ain[i];
      
      // normalization
      norms2[i]    = dot( ai, ai ); 
      if(normalize){
        double inv_norm = 1/Math.sqrt( norms2[i] );
        for(int j=0; j<ai.length; j++ ){  ai[j]*=inv_norm; }     
      }
         
      for(int k=i+1; k<Ain.length;k++){
        double [] ak = Ain[k];
        double cik = dot( ai, ak );
        if(!normalize) cik/=norms2[i];
        for(int j=0; j<ak.length; j++ ){  ak[j] -= cik*ai[j]; }
      }
    }
}

/*
void orthogonalize( boolean normalize, double [][] Ain, double [][] Aout, double [] norms2 ){
  
    // compute norms
    for(int i=0; i<Ain.length ;i++){
      double [] ai = Ain[i];
      norms2[i]    = dot( ai, ai ); 
      if(normalize){
        double inv_norm = 1/Math.sqrt(norms2[i]);
        for(int j=0; j<ai.length; j++ ){  ai[j]*=inv_norm; }     
      }
    }

    // compute 
    for(int i=0; i<Aout.length ;i++){
      double [] ai = Ain [i];
      double [] ui = Aout[i];
      System.arraycopy( ai, 0, ui, 0, ui.length );      
      for(int k=0; k<i;k++){
        double [] uk = Aout[k];
        double cik = dot( ai, uk );
        if(!normalize) cik/=norms2[i];
        for(int j=0; j<ui.length; j++ ){  ui[j] -= cik*uk[j]; }
      }
    }
}
*/


void orthoTest( double [][] A ){
    // compute 
    for(int i=0; i<A.length ;i++){ 
      for(int k=0; k<=i;k++){
         print( dot( A[i], A[k] )+" " );  
      }
      println(  );  
    }
}
