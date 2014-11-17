
class Lattice2D{
  float ax,ay;
  float bx,by;
  
  Lattice2D( float ax, float  ay, float bx , float by  ){
    this.ax=ax; this.ay=ay; this.bx=bx; this.by=by;
  }
  
  Lattice2D( float r, float alfa ){
    float ca = cos(alfa);
    float sa = sin(alfa);
    this.ax=r; this.ay=0; this.bx=r*ca; this.by=r*sa;
  }
  
  Lattice2D( Lattice2D olat, float ia, float ib ){
    ax=olat.ax*ia + olat.bx*ib;
    ay=olat.ay*ia + olat.by*ib;
    // compute   (a/b) as complex number
    float ora   = olat.ax*olat.ax + olat.ay*olat.ay;
    float oabRe = ( olat.bx*olat.ax + olat.by*olat.ay ) / ora;
    float oabIm = ( olat.by*olat.ax - olat.bx*olat.ay ) / ora; 
    // test
    float obx=olat.ax*oabRe - olat.ay*oabIm;
    float oby=olat.ax*oabIm + olat.ay*oabRe;
    println( "olat.b: "+ olat.bx +" " + olat.by );
    println( "oby   : "+ obx     +" " + oby );
    // compute b vector
    bx=ax*oabRe - ay*oabIm;
    by=ax*oabIm + ay*oabRe;
  }
  
  void rotate(float alfa){
    float ca = cos(alfa);
    float sa = sin(alfa);
    float ax_=ax;
    float ay_=ay;
    float bx_=bx;
    float by_=by;
    ax = ca*ax - sa*ay;
    ay = sa*ax + ca*ay;
    bx = ca*bx - sa*by;
    by = sa*bx + ca*by;
  }
  
  void scale(float sc){ ax*=sc; ay*=sc; bx*=sc; by*=sc; }
  
  void plotLines(    ){ plotLines( ngrid, ngrid );  }
  void plotLines( int na, int nb ){
    for (int ia=-na;ia<na;ia++){      line( -1000*bx+zoom*ia*ax,-1000*by+zoom*ia*ay, 1000*bx+zoom*ia*ax,1000*by+zoom*ia*ay );     }
    for (int ib=-nb;ib<nb;ib++){      line( -1000*ax+zoom*ib*bx,-1000*ay+zoom*ib*by, 1000*ax+zoom*ib*bx,1000*ay+zoom*ib*by );     }
  }
  
  void plotTriGrid(    ){ plotTriGrid( ngrid);  }
  void plotTriGrid( int n ){
    for (int i=-n;i<n;i++){       
      line( -1000*bx+zoom*i*ax,-1000*by+zoom*i*ay, 1000*bx+zoom*i*ax,1000*by+zoom*i*ay );   
      line( -1000*ax+zoom*i*bx,-1000*ay+zoom*i*by, 1000*ax+zoom*i*bx,1000*ay+zoom*i*by );
      line(  1000*(ax-bx)  +zoom*i*0.5*(bx+ax),
             1000*(ay-by)  +zoom*i*0.5*(by+ay), 
             1000*(bx-ax)  +zoom*i*0.5*(bx+ax),
             1000*(by-ay)  +zoom*i*0.5*(by+ay) 
          );
    }
  }
  
  void plotPoints(    ){ plotPoints( ngrid, ngrid );  }
  void plotPoints( int na, int nb ){
    for (int ia=-na;ia<na;ia++){      
      for (int ib=-nb;ib<nb;ib++){      
        point( zoom*(ax*ia+bx*ib), zoom*(ay*ia+by*ib) );     
      } 
    }
  }
  
  void plotVecs( ){
    line( 0,0, zoom*ax,zoom*ay );     
    line( 0,0, zoom*bx,zoom*by );     
  }
  
  
}
