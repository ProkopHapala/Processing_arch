void paintField( int [][] f ){
  for (int ix=0;ix<f.length;ix++){
      for (int iy=0;iy<f[0].length;iy++){        
        float c = f[ix][iy]/(float)nparticles;
       // float c = f[ix][iy];
        float tile=FF[(ix>>pn) + 2][(iy>>pn) + 2]*0.5;
        set(ix,iy, color( 1-tile,c, f[ix][iy] ) );
      }
  }    
} 
