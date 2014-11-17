
final static color [] colors = { 0xFF000000, 0xFFFF0000, 0xFF00FF00, 0xFF0000FF }; 


class Tool{
  void clicked (){};
  void pressed (){};
  void dragged (){};
  void released(){};
  void moved   (){};
  void onKey( char key ){};
  void plot(){};
}

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
