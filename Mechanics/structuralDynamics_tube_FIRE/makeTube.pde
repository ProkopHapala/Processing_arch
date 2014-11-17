

void makeTube( double D, double R, double L, int nR, int nL){
  
  double mass = 10.0d;
  double S    = 1.0e-6d;
  
  bodies = new BasicBody[2*nR*nL];
  links  = new Link     [4*nR*nL + 4*nR*(nL-1) ];
  
  double dL = L/nL;
  
  for ( int il=0; il<nL; il++ ){
    for ( int ir=0; ir<nR; ir++ ){
      double alfa,ca,sa;
      alfa = (2*Math.PI*ir)/nR;
      ca = Math.cos( alfa );
      sa = Math.sin( alfa );
      bodies[ 2*(ir + il*nR)     ] = new BasicBody( mass, new double3( ca*R, sa*R, il*dL ),    false, new double3() );
      alfa = (2*Math.PI*(ir+0.5d))/nR;
      ca = Math.cos( alfa );
      sa = Math.sin( alfa );
      bodies[ 2*(ir + il*nR) + 1 ] = new BasicBody( mass, new double3( ca*(R+D), sa*(R+D), (il+0.5d)*dL ), false, new double3() );
    }
  }
  for ( int ir=0; ir<nR; ir++ ){
    bodies[ 2*ir    ].fixed = true;
    bodies[ 2*ir +1 ].fixed = true;
  }
  makeTube_Links( nR, nL );  
}



void makeTube_Conical( double D, double R, double L, int nR, int nL){
  double mass = 10.0d;
  bodies = new BasicBody[2*nR*nL];
  double dL = L/nL;  
  for ( int il=0; il<nL; il++ ){
    for ( int ir=0; ir<nR; ir++ ){
      double alfa,ca,sa;
      alfa = (2*Math.PI*ir)/nR;
      ca = Math.cos( alfa );
      sa = Math.sin( alfa );
      bodies[ 2*(ir + il*nR)     ] = new BasicBody( mass, new double3( ca*R, sa*R, il*dL ),    false, new double3() );
      alfa = (2*Math.PI*(ir+0.5d))/nR;
      ca = Math.cos( alfa );
      sa = Math.sin( alfa );
      bodies[ 2*(ir + il*nR) + 1 ] = new BasicBody( mass, new double3( ca*(R+D), sa*(R+D), (il+0.5d)*dL ), false, new double3() );
    }
  }
  for ( int ir=0; ir<nR; ir++ ){
    bodies[ 2*ir    ].fixed = true;
    bodies[ 2*ir +1 ].fixed = true;
  }
  makeTube_Links( nR, nL );  
}


void makeTube_Links( int nR, int nL ){
  double S    = 1.0e-6d;
  links  = new Link     [4*nR*nL + 4*nR*(nL-1) ];
  int ii=-1;
  for ( int il=0; il<nL; il++ ){
    for ( int ir=0; ir<nR; ir++ ){
      // inner shell
      ii++; if( ir<(nR-1) ) { links[ii] = new Link( bodies[ 2*(ir + il*nR)  ],   bodies[ 2*((ir+1) + il*nR) ], mat1, S, -1 ); }
      
            else            { links[ii] = new Link( bodies[ 2*(ir + il*nR)  ],   bodies[ 2*(    0  + il*nR) ], mat1, S, -1 ); }
      if( il<(nL-1) ) { ii++; links[ii] = new Link( bodies[ 2*(ir + il*nR)  ],   bodies[ 2*(ir + (il+1)*nR) ], mat1, S, -1 ); }
      // outer shell
      
      ii++; if( ir<(nR-1) ) { links[ii] = new Link( bodies[ 2*(ir + il*nR) +1 ], bodies[ 2*((ir+1) + il*nR) +1 ], mat1, S, -1 ); }
            else            { links[ii] = new Link( bodies[ 2*(ir + il*nR) +1 ], bodies[ 2*(    0  + il*nR) +1 ], mat1, S, -1 ); }
      if( il<(nL-1) ) { ii++; links[ii] = new Link( bodies[ 2*(ir + il*nR) +1 ], bodies[ 2*(ir + (il+1)*nR) +1 ], mat1, S, -1 ); }
      
      // inter connection
      ii++;                          links[ii] = new Link( bodies[ 2*(  ir    + il    *nR)  ],   bodies[ 2*(ir + il*nR)+1 ], mat1, S, -1 );
      ii++; if( ir<(nR-1) )        { links[ii] = new Link( bodies[ 2*( (ir+1) + il    *nR)  ],   bodies[ 2*(ir + il*nR)+1 ], mat1, S, -1 ); }
            else                   { links[ii] = new Link( bodies[ 2*(  0     + il    *nR)  ],   bodies[ 2*(ir + il*nR)+1 ], mat1, S, -1 ); }
            if( il<(nL-1) )  { ii++; links[ii] = new Link( bodies[ 2*(  ir    + (il+1)*nR)  ],   bodies[ 2*(ir + il*nR)+1 ], mat1, S, -1 ); }
            if( il<(nL-1) )  { ii++; if( ir<(nR-1) ) {  links[ii] = new Link( bodies[ 2*( (ir+1) + (il+1)*nR)  ],   bodies[ 2*(ir + il*nR)+1 ], mat1, S, -1 );  } 
                                     else            {  links[ii] = new Link( bodies[ 2*(    0   + (il+1)*nR)  ],   bodies[ 2*(ir + il*nR)+1 ], mat1, S, -1 );  } }                            
    }
  }

} 
