


void SolveBand( double [][] A, double [] b  ){
  int nj = A[0].length;
  int nk = nj>>1; 
  
  println( "nk: "+nk);
  int pixsz = 5;
  
  for(int i=0; i<A.length-nk; i++){
    double [] Ai  = A [i ];
    double    iaii = 1.0d/Ai[nk];
    for(int k=1; k<=nk; k++){
      double [] Ak    = A [ i+k]     ;
      double factor   = Ak[nk-k]*iaii ;
              b[i+k] -= b [i]*factor ;
      for(int j=nk; j<nj; j++){     Ak[j-k] -= Ai[j]*factor;      }
            
      Band2Full  ( A, Afull );
      int ix =   ( i*(A.length+1)     +1    ) *pixsz;
      int iy =   ( (k-1)*(A.length+1) +1    ) *pixsz;
      plotMat( ix, iy, pixsz, Afull );
      
    }  
  }
  
  
  for(int ii=0; ii<nk-1; ii++){
    int i = A.length + ii - nk;
    //println( " ii "+ii+" i "+i );
    double [] Ai  = A [ i ];
    double    iaii = 1.0d/Ai[nk];
    for(int k=1; k<nk-ii; k++){
      //println( " ii "+ii+" i "+i+" k "+k+" (i+k) "+(i+k) ); 
      double [] Ak    = A [ i+k ]       ;
      double factor   = Ak[nk-k]*iaii    ;
              b[i+k] -= b [i]*factor ;
      //println( " i "+i+" k "+k+" (i+k) "+(i-k)+" factor "+factor );          
      for(int j=nk; j<nj-ii; j++){     Ak[j-k] -= Ai[j]*factor;      }
            
      Band2Full  ( A, Afull );
      int ix =   ( i*(A.length+1)     +1  ) *pixsz;
      int iy =   ( (k-1)*(A.length+1) +1    ) *pixsz;
      plotMat( ix, iy, pixsz, Afull );
      
    }  
  }
  
  
  //println(" BACK : START ");
  //for(int ii=0; ii<A.length; ii++){ println( vec2string( A[ii]  )  );    }
  //println();
  
  for(int i=A.length-1; i>=nk; i--){
    double [] Ai  = A [i ];
    double    iaii = 1.0d/Ai[nk];
    for(int k=1; k<=nk; k++){
      double [] Ak    = A [ i-k]        ;
      double factor   = Ak[nk+k]*iaii    ;
             Ak[nk+k] = 0;
              b[i-k] -= b [i]*factor ;
                           
      Band2Full  ( A, Afull );
      int ix =   ( (i-1)*(A.length+1)     +1    ) *pixsz;
      int iy =   ( (k-1)*(A.length+1) +4  + 3*A.length   ) *pixsz;
      plotMat( ix, iy, pixsz, Afull );
    }  
    b[i] *= iaii;
  }
  
  for(int i=nk; i>=0; i--){
    double [] Ai  = A [i ];
    double    iaii = 1.0d/Ai[nk];
    for(int k=1; k<=i; k++){
      double [] Ak    = A [ i-k]        ;
      double factor   = Ak[nk+k]*iaii    ;
             Ak[nk+k] = 0;
              b[i-k] -= b [i]*factor ;
                           
      Band2Full  ( A, Afull );
      int ix =   ( (i-1)*(A.length+1)     +1    ) *pixsz;
      int iy =   ( (k-1)*(A.length+1) +4  + 3*A.length   ) *pixsz;
      plotMat( ix, iy, pixsz, Afull );
    }  
    b[i] *= iaii;
  }
  
  
  
}


// ================= Band2Full

void Band2Full( double [][] band, double [][] full ){
  int nk = (band[0].length>>1); 
  //println(" LOWER nk: "+nk );
  for(int i=0; i<nk; i++ ){
    double [] bandi =  band[i];
    double [] fulli =  full[i];
    //println(" i: "+i );
    for(int j=-nk; j<=nk; j++ ){
      int jj = i+j;
      int jjj = (jj>=0) ? jj : (fulli.length + jj );
      //println( " i "+i+" "+jj+" "+jjj );
      fulli[ jjj ] = bandi[ nk + j ]; 
    }
  }
  for(int i=nk; i<band.length-nk; i++ ){
    double [] bandi =  band[i];
    double [] fulli =  full[i];
    for(int j=-nk; j<=nk; j++ ){ fulli[i+j] = bandi[ nk + j ]; }
  }
  //println(" UPPER   nk: "+nk );
  for(int i=band.length-nk; i<band.length; i++ ){
    //println(" i: "+i );
    double [] bandi =  band[i];
    double [] fulli =  full[i];
    for(int j=-nk; j<=nk; j++ ){
      int jj = i+j;
      int jjj = ( jj>=fulli.length ) ? ( jj-fulli.length ) : jj ;
      //println( " i "+i+" "+jj+" "+jjj );
      fulli[ jjj ] = bandi[ nk + j ]; 
    }
  }
}


// ================= Full2Band

void Full2Band( double [][] full, double [][] band ){
  int nk = (band[0].length>>1); 
  //println(" LOWER nk: "+nk );
  for(int i=0; i<nk; i++ ){
    double [] bandi =  band[i];
    double [] fulli =  full[i];
    //println(" i: "+i );
    for(int j=-nk; j<=nk; j++ ){
      int jj = i+j;
      int jjj = (jj>=0) ? jj : (fulli.length + jj );
      //println( " i "+i+" "+jj+" "+jjj );
      bandi[ nk + j ] = fulli[ jjj ]; 
    }
  }
  for(int i=nk; i<band.length-nk; i++ ){
    double [] bandi =  band[i];
    double [] fulli =  full[i];
    for(int j=-nk; j<=nk; j++ ){ bandi[ nk + j ] = fulli[i+j]; }
  }
  //println(" UPPER   nk: "+nk );
  for(int i=band.length-nk; i<band.length; i++ ){
    //println(" i: "+i );
    double [] bandi =  band[i];
    double [] fulli =  full[i];
    for(int j=-nk; j<=nk; j++ ){
      int jj = i+j;
      int jjj = ( jj>=fulli.length ) ? ( jj-fulli.length ) : jj ;
      println( " i "+i+" "+jj+" "+jjj );
      bandi[ nk + j ] = fulli[ jjj ]; 
    }
  }
}











