
class Tool{
  void clicked (){};
  void pressed (){};
  void dragged (){};
  void released(){};
  void moved   (){};
  void onKey( char key ){};
  void plot(){};
}

class OctTool extends Tool {
  int nsize=2;
  int nbevel=1;
  int iarea;
  
  void clicked( ){
    switch(mouseButton){
      case LEFT:  putToGrid( false ); break; 
      case RIGHT: putToGrid( true  ); break; 
        //if ( mouseButton==oBUTTON ){ removeLine( oix, oiy, grid.mouse_ix, grid.mouse_iy ); }
        //oBUTTON=0; break;
    }
  }

  void onKey( char key ){
    switch (key) {
      case '[':  if( nsize>1     ){ nsize--; if(nbevel>nsize)nbevel=nsize; }; break;
      case ']':  if( nsize<10    ){ nsize++;  }; break;
      case '\'':  if( nbevel>0   ){ nbevel--; }; break;
      case ';': if( nbevel<nsize ){ nbevel++; }; break;
      case 'c': iarea++; if( iarea>=areas.length ){ iarea = iarea%areas.length;  }; break;
     }
  } 
  
  void putToGrid( boolean erase ){
    Area area = areas[iarea];
    //int nbeveld = nsize-nbevel;
    int nedge   = 2*nsize-nbevel-1; 
    int ix0 = grid.mouse_ix; 
    int iy0 = grid.mouse_iy;
    for( int ix=0; ix<nsize; ix++  ){
       for( int iy=0; iy<nsize; iy++  ){
         if      ( ( ix+iy )<nedge ){
           putQuad( ix0+ix, iy0+iy, area, area, area, area,     erase );
           putQuad( ix0+ix, iy0-iy-1, area, area, area, area,   erase );
           putQuad( ix0-ix-1, iy0+iy, area, area, area, area,   erase );
           putQuad( ix0-ix-1, iy0-iy-1, area, area, area, area, erase );
         }else if( (ix+iy )==nedge ){
           putQuad( ix0+ix,   iy0+iy,   area, area, null, null, erase );
           putQuad( ix0+ix,   iy0-iy-1, area, null, null, area, erase );
           putQuad( ix0-ix-1, iy0+iy,   null, area, area, null, erase );
           putQuad( ix0-ix-1, iy0-iy-1, null, null, area, area, erase );
         }
       }
    }
    grid.quads2Shape();
  }
  
  void putQuad( int ix_, int iy_, Area a, Area b, Area c, Area d, boolean erase ){
    int ix = ix_ + grid.iqx0; int iy = iy_ + grid.iqy0;
    if( ( ix>=0 )&&( ix<grid.quads.length )&&( iy>=0 )&&( iy<grid.quads[0].length ) ){
      if( erase ){
        if ( grid.quads[ix][iy]!=null ){
          SubQuad quad = grid.quads[ix][iy];
          if(a!=null) quad.a=null;
          if(b!=null) quad.b=null;
          if(c!=null) quad.c=null;
          if(d!=null) quad.d=null;
          if( quad.checkNull() ) grid.quads[ix][iy]=null;
        }
      }else{
        if   ( grid.quads[ix][iy]==null ){  grid.quads[ix][iy] = new SubQuad( a,b,c,d ); }
        else                             {  grid.quads[ix][iy].setButNull   ( a,b,c,d ); }
      }
    }
  }
  
  void plot(){ 
    //noStroke();
    fill( areas[iarea].clr & 0x7FFFFFFF ); 
    stroke( 0xFFFFFFFF ); 
    int nbeveld = nsize-nbevel;
    int ix = grid.mouse_ix; 
    int iy = grid.mouse_iy;
    //println( "plotting  OctTool "+ix+" "+iy );
    beginShape();
    vertex( grid.x2s( ix-nbeveld ), grid.y2s( iy-nsize  )  ); // 1
    vertex( grid.x2s( ix+nbeveld ), grid.y2s( iy-nsize  )  ); // 2
    vertex( grid.x2s( ix+nsize   ), grid.y2s( iy-nbeveld)  ); // 3
    vertex( grid.x2s( ix+nsize   ), grid.y2s( iy+nbeveld)  ); // 4
    vertex( grid.x2s( ix+nbeveld ), grid.y2s( iy+nsize  )  ); // 5
    vertex( grid.x2s( ix-nbeveld ), grid.y2s( iy+nsize  )  ); // 6
    vertex( grid.x2s( ix-nsize   ), grid.y2s( iy+nbeveld)  ); // 7
    vertex( grid.x2s( ix-nsize   ), grid.y2s( iy-nbeveld)  ); // 8
    endShape(CLOSE);
  }
  
}










/*

class LineTool extends Tool {
  int oix,oiy; 
  int oBUTTON=0;
  
  float lw=1;
  int iclr;
  
  void clicked( ){
    switch(oBUTTON){
      case 0:
        oix = grid.mouse_ix; oiy = grid.mouse_iy;
        oBUTTON=mouseButton; break;
      case LEFT:
        if ( mouseButton==oBUTTON ){ GridLine line = new GridLine( oix, oiy, grid.mouse_ix, grid.mouse_iy, colors[iclr] , lw ); grid.lines.add(line); }
        oBUTTON=0; break;
      case RIGHT: 
        if ( mouseButton==oBUTTON ){ removeLine( oix, oiy, grid.mouse_ix, grid.mouse_iy ); }
        oBUTTON=0; break;
    }
  }
  
  void removeLine( int ix,int iy, int jx,int jy ){
    for(Iterator<GridLine> it=grid.lines.iterator(); it.hasNext(); ) {
      GridLine line = it.next();
      if( (line.ix==ix)&&(line.iy==iy)&&(line.jx==jx)&&(line.jy==jy) ){ it.remove(); break; }; 
      if( (line.ix==jx)&&(line.iy==jy)&&(line.jx==ix)&&(line.jy==iy) ){ it.remove(); break; }; 
    } 
  }
  
  void plot(){ 
    stroke( colors[iclr] ); strokeWeight(lw);
    if(oBUTTON!=0){   grid.drawLine( oix,oiy, grid.mouse_ix, grid.mouse_iy ); }   
  }
  
  void onKey( char key ){
    switch (key) {
      case '[': if(lw>1 ){lw--;}; break;
      case ']': if(lw<10){lw++;}; break;
      case 'c': iclr++; if( iclr>=colors.length ){ iclr = iclr%colors.length;  }; break;
     }
  } 
}

*/
