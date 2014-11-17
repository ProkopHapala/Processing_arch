
class Grid{
  int nnodes = 40;
  float zoom,step,sstep,isstep;
  float sx0, sy0;
  int mouse_ia,mouse_ib;
  
  List<GridLine> lines;
  
  void scaleZoom( float sc ){
    zoom=zoom*sc;
    sstep=zoom*step; isstep=1/sstep;
  }
  
  Grid( float zoom, float step, float sx0, float sy0 ){
    this.zoom=zoom; this.step=step; this.sx0=sx0; this.sy0=sy0;
    scaleZoom( 1 );
    lines = new LinkedList<GridLine>();
  }
  
  void updateCursor(){ mouse_ia = xy2a(mouseX,mouseY);  mouse_ib = xy2b(mouseX,mouseY);  }
  void plotCursor  (){ ellipse( ab2x(mouse_ia,mouse_ib), ab2y(mouse_ia,mouse_ib), 3,3 );  }
  
  //        x     y
  //   a =  1.0  0.0
  //   b =  0.5  0.86602540378 
  float ab2x(int   ia,int   ib){ return ( ia+0.5*ib        )*sstep+sx0;  }
  float ab2y(int   ia,int   ib){ return ( ib*0.86602540378 )*sstep+sy0;  }
  int   xy2a(float x ,float y ){ return (int)( ( (x-sx0)-0.5*(y-sy0)    )*isstep );  }
  int   xy2b(float x ,float y ){ return (int)( ( (y-sy0)*1.15470053838  )*isstep );  }
  
  void drawLine( int ia, int ib, int ja, int jb ){ line( ab2x( ia,ib ), ab2y( ia,ib ), ab2x( ja,jb ), ab2y( ja,jb ) );  }
  
  void plot(){
    plotNodes( nnodes );
    for( GridLine line : lines ){ line.plot(); }
  }
  void plotNodes(int n){ stroke(0,0,0,255); strokeWeight(1);  for(int ia=-n; ia<=n; ia++ ){   for(int ib=-n; ib<=n; ib++ ){ set( (int)( ab2x(ia,ib) ), (int)( ab2y(ia,ib) ), 0xFF000000 );  } }  }

}
