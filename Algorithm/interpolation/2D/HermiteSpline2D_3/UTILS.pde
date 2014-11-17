void plotInterpolation(){
  for (int i=1; i<ps.length; i++ ){
    for (int j=1; j<ps[0].length; j++ ){
      float [] p00 = ps[i-1][j-1];
      float [] p01 = ps[i-1][j  ];
      float [] p10 = ps[i  ][j-1];
      float [] p11 = ps[i  ][j  ];
      
      for (int iu=0; iu<nsub; iu++ ){
        for (int iv=0; iv<nsub; iv++ ){
          hermite2D( iu*d,iv*d, p00, p10, p01, p11, pout );
          set( iu+nsub*i, iv+nsub*j, color(pout[0]*255,pout[1]*255,pout[2]*255) );
        }
      }  
      
    }
  }
}


void plotPoints(){
  noStroke();
  for (int i=0; i<ps.length; i++ ){
    for (int j=0; j<ps[0].length; j++ ){
      float y = ps[i][j][0] * 255;
      fill( y,y,y); ellipse((i+1)*nsub,(j+1)*nsub,10,10);
    }
  }
}

/*
void plotXscan(){
  int j0 = int(float(mouseY)/nsub); int iv0 = int(mouseY - j0*nsub);
  if((j0>0)&&(j0<n)){
    //println( " xscan; y: "+j0+" "+iv0 );
    line( nsub, mouseY , nsub*n, mouseY  );
    float ox = nsub;  float oy = 0;
    for (int i=1; i<ps.length; i++ ){ 
      float [] p00 = ps[i-1][j0-1];
      float [] p01 = ps[i-1][j0  ];
      float [] p10 = ps[i  ][j0-1];
      float [] p11 = ps[i  ][j0  ];
      for (int iu=0; iu<nsub; iu++ ){ 
        float y = 600-hermite2D( iu*d,iv0*d, p00, p10, p01, p11, pout );
        float x = iu+nsub*i;
        line(ox,oy,x,y);
        ox=x; oy=y;
      }
    } 
  }
}  

void plotYscan(){
  int i0 = int(float(mouseX)/nsub); int iu0 = int(mouseX - i0*nsub);
  if((i0>0)&&(i0<n)){
    //println( " xscan; y: "+j0+" "+iv0 );
    line( mouseX, nsub, mouseX, nsub*n  );
    float oy = nsub;  float ox = 0;
    for (int j=1; j<ps.length; j++ ){ 
      float [] p00 = ps[i0-1][j-1];
      float [] p01 = ps[i0-1][j  ];
      float [] p10 = ps[i0  ][j-1];
      float [] p11 = ps[i0  ][j  ];
      for (int iv=0; iv<nsub; iv++ ){ 
        float x = 600-hermite2D( iu0*d,iv*d, p00, p10, p01, p11, pout );
        float y = iv+nsub*j;
        line(ox,oy,x,y);
        ox=x; oy=y;
      }
    } 
  }
}  
*/
  
