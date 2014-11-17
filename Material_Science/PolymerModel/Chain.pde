

void getF_intra( double [] xs, double [] d0, double [] Fs ){
  for (int i = 0; i<xs.length; i++){ Fs[i] = 0; }
  for (int i = 1; i<xs.length; i++){
    double dx = xs[i] - xs[i-1] - d0[i];  
    double f =  k_intra*dx; 
    //double f = k_intra[i]*dx;
    //double f = f_intra( dx );
    Fs[i-1]  +=  f;  
    Fs[i  ]  += -f;  

  }
}

void getF_inter( int [] crosslinks, double [][] xs, double [][] Fs ){
  for (int ilink = 0; ilink<crosslinks.length; ilink+=4){ 
    int ichain = crosslinks[ilink     ]; 
    int i      = crosslinks[ilink + 1 ]; 
    int jchain = crosslinks[ilink + 2 ]; 
    int j      = crosslinks[ilink + 3 ];
   
    double dx = ( xs[ichain][i] - xs[jchain][j] );
    double f =  k_inter * dx;
    // Fs[i] = k_inter[i]*dx;
    // Fs[i] = f_inter( dx );
    
    Fs[ichain][i] += -f;
    Fs[jchain][j] += +f;
  }
}

void move_MD( double [] xs, double [] vs, double [] fs ){
  for (int i = 0; i<xs.length; i++){
    vs[i]  = damp*vs[i] + iMass*fs[i]*dt;
    xs[i] += vs[i]*dt;  
  }
}

void step(  ){
  
  for (int ichain = 0; ichain<Xs.length; ichain++){  getF_intra( Xs[ichain], Ds[ichain], Fs[ichain] );  }
  getF_inter( crosslinks, Xs, Fs );
  boundary_F();
  for (int ichain = 0; ichain<Xs.length; ichain++){  move_MD   ( Xs[ichain], Vs[ichain], Fs[ichain] );  }
  boundary_X();
}


