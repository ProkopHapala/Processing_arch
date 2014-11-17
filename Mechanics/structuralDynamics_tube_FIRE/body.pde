
/*
  Basic body :    is massive point in space with dynamics but without internal structure nor rotation 
*/

class BasicBody{
  boolean fixed;
  double3 x;      // position
  double3 v;      // velocity
  double3 f;      // force 
  double   m;     // mass of body
  //double  r;        // bounding sphere  
  void move(){
     if (!fixed){
       //f.fma( v, -damp );   // damping force proportional to velocity
       //f.y-=m*Gaccel;
       v.fma( f, dt/m  );   //  
       x.fma( v, dt    );   //
     }  
     f.set(0);
  }
  BasicBody(){};
  BasicBody( double m , double3 x, boolean fixed, double3 v ){
    this.fixed = fixed; this.m = m; this.x = x; this.v = v;
    f = new double3();
  }
  void paint(){
    point( (float)x.x, (float)x.y, (float)x.z );
    //line( );
  };
}

