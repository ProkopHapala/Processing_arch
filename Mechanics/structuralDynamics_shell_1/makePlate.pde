
void makePlate( double L1, double L2, int n1, int n2 ){
  println( "makePlate n1,n2: "+n1+" "+n2 );
  verticles = new Vertex[ n1*n2 ];
  double mass = 1.0/(n1*n2);
  double dL1 = L1/(n1-1);
  double dL2 = L2/(n2-1); 
  int id = 0;
  for ( int i1=0; i1<n1; i1++ ){
    for ( int i2=0; i2<n2; i2++ ){
      double x = dL1*i1 +  0.5d*dL2*i2;
      double y = 0.86602540378d*dL2*i2;
      verticles[ i2 + i1*n2 ] = new Vertex( id, mass, x,y,0 );
      id++;
    }
  }
  //edges     = new Edge[ (n1-1)*n2 + (n2-1)*n1 + (n2-1)*(n1-1) ];
  //makeEdgesPlate( n1, n2 );
   findEdges( 1.2*dL1 );
}

void makeEdgesPlate( int n1, int n2 ){
  int ii=0;
  for ( int i1=0; i1<n1; i1++ ){
    for ( int i2=0; i2<n2; i2++ ){
      Vertex a =  verticles[ i2 + i1*n1 ];
      boolean backedge = true;
      
      // sticks along L1
      if( i1<(n1-1) ) { 
        Vertex b = verticles[  i2 +(i1+1)*n2 ];
        Vertex c=null,d=null;
        if((i2>0)&&(i2<(n2-1))){
          c = verticles[  i2-1 +(i1+1)*n2 ];
          d = verticles[  i2+1 +   i1 *n2 ];
        }
        edges[ii] = new Edge( ii, a, b, c, d , k, kBend, 0); 
        ii++;
      }else{ backedge = false;  }
      
      // sticks along L2
      if( i2<(n2-1) ) { 
        Vertex b = verticles[  (i2+1) +i1*n2 ];
        Vertex c=null,d=null;
        if((i1>0)&&(i1<(n1-1))){
          c = verticles[  i2    +(i1+1)*n2 ];
          d = verticles[  i2+1  +(i1-1)*n2 ];
        }
        edges[ii] = new Edge( ii, a, b, c, d , k, kBend, 0); 
        ii++;
      }else{ backedge = false;  }
      
      // back sticks
      if( backedge ) { 
        Vertex aa = verticles[  i2    + (i1+1)*n2 ];
        Vertex bb = verticles[ (i2+1) +  i1   *n2 ];
        Vertex d  = verticles[ (i2+1) + (i1+1)*n2 ];
        edges[ii] = new Edge( ii, aa, bb, a, d , k, kBend, 0); 
        ii++;
      }else{ backedge = false;  }
    }
  }  
}
