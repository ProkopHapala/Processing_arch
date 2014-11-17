void paintField( int [][] f ){
  for (int ix=0;ix<f.length;ix++){
      for (int iy=0;iy<f[0].length;iy++){
        float c = f[ix][iy]/(float)nparticles;
        set(ix,iy, color( (c*2.0)%1.0, 1, 1.0-c ) );
      }
  }    
} 
