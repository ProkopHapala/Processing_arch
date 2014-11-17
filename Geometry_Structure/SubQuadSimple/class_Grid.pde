
class SubQuadGrid{
  
  int nnodes = 40;
  float zoom,step,sstep,isstep;
  float sx0, sy0;
  int mouse_ix,mouse_iy;
  
  int iqx0,iqy0;
  
  SubQuad [][] quads;
  PShape quads_shape, grid_shape;
  
  void scaleZoom( float sc ){
    zoom=zoom*sc;
    sstep=zoom*step; isstep=1/sstep;
  }
  
  SubQuadGrid( int nx, int ny,  float zoom, float step, float sx0, float sy0 ){
    this.zoom=zoom; this.step=step; this.sx0=sx0; this.sy0=sy0;
    scaleZoom( 1 );
    quads = new SubQuad[nx][ny];
    iqx0 = nx/2; iqy0 = ny/2; 
    /*
    for( int ix=0; ix<nx; ix++ ){ 
      for( int iy=0; iy<ny; iy++ ){ 
        //quads[ix][iy]=new SubQuad( areas[ int(4*random(1)) ], areas[ int(4*random(1)) ], areas[ int(4*random(1)) ] ,areas[ int(4*random(1)) ] );
        quads[ix][iy]=new SubQuad( areas[ 1 ],areas[ 1 ],areas[ 1 ],areas[ 1 ] );
      }
    }
    */
    quads2Shape();
    grid2Shape(nnodes);
  }
  
  void updateCursor(){ mouse_ix = s2x(mouseX);  mouse_iy = s2y(mouseY);  }
  void plotCursor  (){ noStroke(); fill(0); ellipse( x2s(mouse_ix), y2s(mouse_iy), 3,3 );  }
  
  float x2s(int   ix){ return ix*sstep+sx0;  }
  float y2s(int   iy){ return iy*sstep+sy0;  }
  int   s2x(float x ){ return (int)( (x-sx0)*isstep );  }
  int   s2y(float y ){ return (int)( (y-sy0)*isstep );  }
  
  void drawLine( int ix, int iy, int jx, int jy ){ line( x2s( ix ), y2s( iy ), x2s( jx ), y2s( jy ) );  }
  
  void plot(){
    //plotNodes( nnodes );
    //plotQuads();
    pushMatrix();
    translate( sx0, sy0 );
    scale( sstep );
    shape( grid_shape );
    shape( quads_shape );
    popMatrix();
    //for( GridLine line : lines ){ line.plot(); }
  }
  
    
  void plotGrid  (int n){ for(int ix=-n; ix<=n; ix++ ){   for(int iy=-n; iy<=n; iy++ ){ set( (int)( x2s(ix) ), (int)( y2s(iy) ), 0xFF000000 );  } }  }
  void grid2Shape(int n){ 
    nvertex=0;
    grid_shape = createShape();
    grid_shape.beginShape(POINTS);
    grid_shape.stroke( 0xFF000000 ); grid_shape.strokeWeight(1.0);
    for(int ix=-n; ix<=n; ix++ ){  for(int iy=-n; iy<=n; iy++ ) { grid_shape.vertex( ix, iy ); nvertex++; } }  
    grid_shape.endShape(); 
    println( " created grid_shape of "+nvertex+" vertexes " );
  }
  
  void plotQuads(){
    noStroke();  
    for( int ix=0; ix<quads.length; ix++ ){ 
      SubQuad [] quadsi = quads[ix]; 
      for( int iy=0; iy<quadsi.length; iy++ ){  
      SubQuad quad = quadsi[iy]; 
      if(quad!=null) { quad.plot( x2s(ix-iqx0),x2s(iy-iqy0),x2s(ix-iqx0+1),x2s(iy-iqy0+1) ); }
     } 
   } 
 }
 public void quads2Shape(){
   nvertex=0;
   quads_shape = createShape();
   quads_shape.beginShape(TRIANGLES);
   quads_shape.noStroke();
   for( int ix=0; ix<quads.length; ix++ ){ 
      SubQuad [] quadsi = quads[ix]; 
      for( int iy=0; iy<quadsi.length; iy++ ){  
      SubQuad quad = quadsi[iy]; 
      //if(quad!=null) { quad.toShape( quads_shape, x2s(ix-iqx0),x2s(iy-iqy0),x2s(ix-iqx0+1),x2s(iy-iqy0+1) ); }
      if(quad!=null) { quad.toShape( quads_shape, ix-iqx0, iy-iqy0, ix-iqx0+1, iy-iqy0+1 ); }
     } 
   } 
   quads_shape.endShape();
   println( " created quads_shape of "+nvertex+" vertexes " );
 }

}
