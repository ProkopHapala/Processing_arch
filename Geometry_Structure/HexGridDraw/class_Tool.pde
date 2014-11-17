
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
  int oia,oib; 
  int oBUTTON=0;
  
  float lw=1;
  int iclr;
  
  void clicked( ){
    switch(oBUTTON){
      case 0:
        oia = grid.mouse_ia; oib = grid.mouse_ib;
        oBUTTON=mouseButton; break;
      case LEFT:
        if ( mouseButton==oBUTTON ){ GridLine line = new GridLine( oia, oib, grid.mouse_ia, grid.mouse_ib, colors[iclr] , lw ); grid.lines.add(line); }
        oBUTTON=0; break;
      case RIGHT: 
        if ( mouseButton==oBUTTON ){ removeLine( oia, oib, grid.mouse_ia, grid.mouse_ib ); }
        oBUTTON=0; break;
    }
  }
  
  void removeLine( int ia,int ib, int ja,int jb ){
    for(Iterator<GridLine> it=grid.lines.iterator(); it.hasNext(); ) {
      GridLine line = it.next();
      if( (line.ia==ia)&&(line.ib==ib)&&(line.ja==ja)&&(line.jb==jb) ){ it.remove(); break; }; 
      if( (line.ia==ja)&&(line.ib==jb)&&(line.ja==ia)&&(line.jb==ib) ){ it.remove(); break; }; 
    } 
  }
  
  void plot(){ 
    stroke( colors[iclr] ); strokeWeight(lw);
    if(oBUTTON!=0){   grid.drawLine( oia,oib, grid.mouse_ia, grid.mouse_ib ); }   
  }
  
  void onKey( char key ){
    switch (key) {
      case '[': if(lw>1 ){lw--;}; break;
      case ']': if(lw<10){lw++;}; break;
      case 'c': iclr++; if( iclr>=colors.length ){ iclr = iclr%colors.length;  }; break;
     }
  }
  
}
