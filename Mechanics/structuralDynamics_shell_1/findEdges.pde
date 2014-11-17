

void findEdges( double rmax ){
  int id;
  ArrayList<Edge>               edge_list = new ArrayList<Edge>( 3*verticles.length );
  for (int i=0; i<verticles.length; i++){
    verticles[i].neighbors = new ArrayList<Vertex>(10);
  }
  
  // find edges a-b
  int id_edge = 0;
  for (int i=0; i<verticles.length; i++){
    Vertex a = verticles[i];
    for (int j=0; j<i; j++){
      Vertex b = verticles[j];
      double dx = a.x-b.x;
      double dy = a.y-b.y;
      double dz = a.z-b.z;
      double r2 = dx*dx + dy*dy + dz*dz; 
      if( r2 < (rmax*rmax) ){
        println( " i,j,r2,rmax2 "+i+""+j+" "+r2+" "+(rmax*rmax) );
        Edge ed   = new Edge( id_edge,  a,b, null, null, k, kBend, 0 );
        edge_list.add( ed ); 
        a.neighbors.add( b );
        b.neighbors.add( a );
      }
    }
  }
  edges = edge_list.toArray( new Edge[ edge_list.size() ]);
  
  
  // find c,d for given edge (if exists)
  for( int i=0; i<edges.length; i++ ){
    Edge ed =  edges[i];
    Vertex a = ed.a;
    Vertex b = ed.b;
    int ia = ed.a.id; 
    int ib = ed.b.id;
    for ( Vertex aneig : a.neighbors ){
      if( (aneig!=b)&&(aneig!=a) ){
        for ( Vertex bneig : b.neighbors ){
          if(aneig==bneig){
            if( ed.c == null ){ ed.c = aneig; }
            else              { ed.d = aneig; break;  }
          }
        } 
      }
    }
  }
  
  
  /*
  // find c,d for given edge (if exists)
  for( int i=0; i<eges.length; i++ ){
    Edge ed =  edges[i];
    Vertex a = ed.a;
    Vertex b = ed.b;
    int ia = ed.a.id; 
    int ib = ed.b.id;
    for ( Edge eda : veredges[ia] ){
      Vertex aa = eda.a; if((aa==a)&&(aa==b)){aa=null;}
      Vertex ab = eda.b; if((ab==a)&&(ab==b)){ab=null;}
      for ( Edge edb : veredges[ib] ){
        Vertex aa = eda.a;  if((ba==a)&&(ba==b)){ba=null;}
        Vertex ab = eda.b;  if((bb==a)&&(bb==b)){bb=null;}
        if(aa!=null){
          if      ( aa==ba ){ if( ed.c==null ){ ed.c=aa; }else{ ed.d=aa; }  }
          else if ( aa==bb ){ if( ed.c==null ){ ed.c=aa; }else{ ed.d=aa; }  }
        }
        if(ab!=null){
          if      ( ab==ba ){ if( ed.c==null ){ ed.c=ab; }else{ ed.d=ab; }  }
          else if ( ab==bb ){ if( ed.c==null ){ ed.c=ab; }else{ ed.d=ab; }  }
        }
      }
    }
  }
  */
}
