
int nvertex=0;

class SubQuad{
  Area a,b,c,d;
  SubQuad(){};
  SubQuad(Area a, Area b, Area c, Area d ){ set(a,b,c,d); }
  void set( Area a, Area b, Area c, Area d  ){ this.a=a; this.b=b; this.c=c; this.d=d;}
  boolean checkNull(){  return (a==null)&&(b==null)&&(c==null)&&(d==null);  }
  
  void setButNull( Area a, Area b, Area c, Area d  ){ if(a!=null)this.a=a; if(b!=null)this.b=b; if(c!=null)this.c=c; if(d!=null)this.d=d; }
  
  void plot( float x1, float y1, float x2, float y2 ){
    //println( x1+" "+y1+" "+x2+" "+y2 );
    float x3 = 0.5*(x1+x2);
    float y3 = 0.5*(y1+y2);
    if(a!=null){ fill(a.clr); triangle( x1, y1,    x1, y2,    x3, y3 ); }
    if(b!=null){ fill(b.clr); triangle( x1, y1,    x2, y1,    x3, y3 ); }
    if(c!=null){ fill(c.clr); triangle( x2, y2,    x2, y1,    x3, y3 ); }
    if(d!=null){ fill(d.clr); triangle( x2, y2,    x1, y2,    x3, y3 ); }
  };
  
  void toShape( PShape shape, float x1, float y1, float x2, float y2 ){
    //println( x1+" "+y1+" "+x2+" "+y2 );
    float x3 = 0.5*(x1+x2);
    float y3 = 0.5*(y1+y2);
    if(a!=null){ shape.fill(a.clr);  shape.vertex( x1, y1 ); shape.vertex( x1, y2 ); shape.vertex( x3, y3 ); nvertex+=3; } 
    if(b!=null){ shape.fill(b.clr);  shape.vertex( x1, y1 ); shape.vertex( x2, y1 ); shape.vertex( x3, y3 ); nvertex+=3; }
    if(c!=null){ shape.fill(c.clr);  shape.vertex( x2, y2 ); shape.vertex( x2, y1 ); shape.vertex( x3, y3 ); nvertex+=3; }
    if(d!=null){ shape.fill(d.clr);  shape.vertex( x2, y2 ); shape.vertex( x1, y2 ); shape.vertex( x3, y3 ); nvertex+=3; }
  };
}
