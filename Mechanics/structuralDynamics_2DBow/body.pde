
/*
  Basic body :    is massive point in space with dynamics but without internal structure nor rotation 
*/

class BasicBody2D{
  boolean fixed;
  double2 x;      // position
  double2 v;      // velocity
  double2 f;      // force 
  double   m;     // mass of body
  //double  r;        // bounding sphere  
  void move(){
     if (!fixed){
       f.fma( v, -damp_glob );   // damping force proportional to velocity
       //v.mul( damp_glob );
       f.y-=m*Gaccel;
       v.fma( f, dt/m  );   
       x.fma( v, dt    );  
     }  
  }
  BasicBody2D(){};
  BasicBody2D( double m , double2 x, boolean fixed, double2 v ){
    this.fixed = fixed; this.m = m; this.x = x; this.v = v;
    f = new double2();
  }
  void paint(){
    point( (float)x.x, (float)x.y );
    //line( );
  };
}

