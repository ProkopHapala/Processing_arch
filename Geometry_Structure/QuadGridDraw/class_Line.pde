
class GridLine{
  int ix,iy, jx,jy;
  color clr;
  float lw;
  GridLine( int ix, int iy, int jx, int jy, color clr, float lw ){  this.ix=ix; this.iy=iy; this.jx=jx; this.jy=jy; this.clr=clr; this.lw=lw; }
  GridLine( String sline ){ 
    String [] words = splitTokens(sline);
    ix = int( words[0] ); iy = int( words[1] ); jx = int( words[2] ); jy = int( words[3] ); clr=unhex(words[4]);  lw=float( words[5] );
    //println( " check: ");
    //println( sline );
    //println( this.toString() );
  }
  
  void plot(){  stroke(clr); strokeWeight(lw); grid.drawLine( ix, iy, jx, jy ); }
  String toString(  ){    return ix+" "+iy+" "+jx+" "+jy+" "+hex(clr)+" "+lw;   }
}
