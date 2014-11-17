
void makeTube( double L, double R0, int nL, int nR ){
  println( "makePlate n1,n2: "+nR+" "+nL );
  verticles = new Vertex[ nR*nL ];
  double mass = 1.0/(nR*nL);
  double dL = L/(nL-1);
  int id = 0;
  for ( int il=0; il<nL; il++ ){
    for ( int ir=0; ir<nR; ir++ ){
      double alfa,ca,sa;
      alfa = ( 2*Math.PI*(ir+0.5d*il) )/nR;
      ca = Math.cos( alfa );
      sa = Math.sin( alfa );
      double z = 0.86602540378d*dL*il;
      //double R = R0 * ( 1.0d + 0.2*Math.cos( 5*(alfa+z) )   );
      double R = R0; 
      verticles[ ir + il*nR ] = new Vertex( id, mass, R*ca,R*sa,z );
      id++;
    }
  }
  //edges     = new Edge[ (nL-1)*nR + (nR-1)*nL + (nL-1)*(nR-1)    + (nL-1) + nL  ];
  //makeEdgesPlate( nL, nR );
  findEdges( 1.7*dL );
}





/*
void makeEdgesTube( int nR, int nL ){
  edges     = new Edge[ (nL-1)*nR ];
  
  // edges     = new Edge[ 3*(nL-1)*nR + nR ];
  int ii=0;
  for ( int il=0; il<(nL-1); il++ ){
    for ( int ir=0; ir<nR; ir++ ){
      Vertex a =  verticles[ ir + il*nR ];
      boolean backedge = true;
      
      // sticks along L
      Vertex b = verticles[ ir +(il+1)*nR ];
      Vertex c=null,d=null;
      if      (ir==0    ){
        c = verticles[  1   +  il   *nR ];
        d = verticles[  nR-1 + (il+1)*nR ];
      }else if(ir==(nR-2)){
        c = verticles[  0   +  il   *nR ];
        d = verticles[  nR-2 + (il+1)*nR ];
      }else{
        c = verticles[  ir+1  +  il   *nR ];
        d = verticles[  ir-1  + (il+1)*nR ];
      }
      edges[ii] = new Edge( a, b, c, d , k, kBend, 0); 
      ii++;
      
      
      
      
      
      // sticks along L1
      if( i1<(n1-1) ) { 
        Vertex b = verticles[  i2 +(i1+1)*n2 ];
        Vertex c=null,d=null;
        if((i2>0)&&(i2<(n2-1))){
          c = verticles[  i2-1 +(i1+1)*n2 ];
          d = verticles[  i2+1 +   i1 *n2 ];
        }
        edges[ii] = new Edge( a, b, c, d , k, kBend, 0); 
      }else{
      
      
      }
      

      
      // back sticks
      if( backedge ) { 
        Vertex aa = verticles[  i2    + (i1+1)*n2 ];
        Vertex bb = verticles[ (i2+1) +  i1   *n2 ];
        Vertex d  = verticles[ (i2+1) + (i1+1)*n2 ];
        edges[ii] = new Edge( aa, bb, a, d , k, kBend, 0); 
        ii++;
      }else{ backedge = false;  }
      
    }
    
  }  
}

*/

