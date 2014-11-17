
static double ca2max = 1.0;

class Bond{
  
  // 2D strain
  double r0;
  double k;
  Atom a,b;  
  
  // supplementary state variables
  double dx,dy;
  double r,ir;
  
  void assertForce(){
    double dx = b.x - a.x;
    double dy = b.y - a.y;
    //r = Math.sqrt( dx*dx + dy*dy );
    //ir = 1/r;
    //dx *= ir; dx *= ir; dx *= ir;
    //double fr = k*(r - r0);
    double r2 = dx*dx + dy*dy;
    double fr = ( r2 - r0*r0 )*k; // very fast approximation
    double fx = fr*dx;
    double fy = fr*dy;
    //println( "force "+fr+" "+fx+" "+fy  );
    a.acumForce(  fx, fy );
    b.acumForce( -fx,-fy );
  }
  
  Bond( Atom a, Atom b, double r0, double k ){ this.a=a; this.b=b;  this.r0 = r0; this.k  = k; }
  
  void plot(){    line( x2s(a.x), x2s(a.y),  x2s(b.x), x2s(b.y)  );  }
  
}
