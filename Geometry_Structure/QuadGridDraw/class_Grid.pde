
class Grid{
  int nnodes = 40;
  float zoom,step,sstep,isstep;
  float sx0, sy0;
  int mouse_ix,mouse_iy;
  
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
  
  void updateCursor(){ mouse_ix = s2x(mouseX);  mouse_iy = s2y(mouseY);  }
  void plotCursor  (){ ellipse( x2s(mouse_ix), y2s(mouse_iy), 3,3 );  }
  
  float x2s(int   ix){ return ix*sstep+sx0;  }
  float y2s(int   iy){ return iy*sstep+sy0;  }
  int   s2x(float x ){ return (int)( (x-sx0)*isstep );  }
  int   s2y(float y ){ return (int)( (y-sy0)*isstep );  }
  
  void drawLine( int ix, int iy, int jx, int jy ){ line( x2s( ix ), y2s( iy ), x2s( jx ), y2s( jy ) );  }
  
  void plot(){
    plotNodes( nnodes );
    for( GridLine line : lines ){ line.plot(); }
  }
  void plotNodes(int n){ stroke(0,0,0,255); strokeWeight(1);  for(int ix=-n; ix<=n; ix++ ){   for(int iy=-n; iy<=n; iy++ ){ set( (int)( x2s(ix) ), (int)( y2s(iy) ), 0xFF000000 );  } }  }

}
