
class GridLine{
  int ia,ib, ja,jb;
  color clr;
  float lw;
  GridLine( int ia, int ib, int ja, int jb, color clr, float lw ){  this.ia=ia; this.ib=ib; this.ja=ja; this.jb=jb; this.clr=clr; this.lw=lw; }
  GridLine( String sline ){ 
    String [] words = splitTokens(sline);
    ia = int( words[0] ); ib = int( words[1] ); ja = int( words[2] ); jb = int( words[3] ); clr=unhex(words[4]);  lw=float( words[5] );
    //println( " check: ");
    //println( sline );
    //println( this.toString() );
  }
  
  void plot(){  stroke(clr); strokeWeight(lw); grid.drawLine( ia, ib, ja, jb ); }
  String toString(  ){    return ia+" "+ib+" "+ja+" "+jb+" "+hex(clr)+" "+lw;   }
}
