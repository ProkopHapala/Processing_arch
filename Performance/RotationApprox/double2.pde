class double2{
  
  double x,y;

  // constructors
  double2 ( ){};
  double2 ( double   f ){set(f);}
  double2 ( double2  b ){set(b);}
  double2 ( double  x, double y ){set(x,y);}

  // setting rutines
  final void set ( double  f ){   x=f;   y=f;    }
  final void set ( double2 b ){   x=b.x; y=b.y;  }
  final void set ( double  x, double y){   this.x=x;   this.y=y; }
  
  // set result
  final void add ( double2 a, double  f            ){  x=a.x+ f;       y=a.y+f;        }
  final void add ( double2 a, double2 b            ){  x=a.x+b.x;      y=a.y+b.y;      }
  final void sub ( double2 a, double2 b            ){  x=a.x-b.x;      y=a.y-b.y;      }
  final void mul ( double2 a, double  f            ){  x=a.x*f;        y=a.y*f;        }
  final void mul ( double2 a, double2 b            ){  x=a.x*b.x;      y=a.y*b.y;      }
  final void div ( double2 a, double2 b            ){  x=a.x/b.x;      y=a.y/b.y;      }
  final void fma ( double2 a, double2 b, double  f ){  x=a.x+b.x*f;    y=a.y+b.y*f;    }
  final void fma ( double2 a, double2 b, double2 c ){  x=a.x+b.x*c.x;  y=a.y+b.y*c.y;  }
  final void fda ( double2 a, double2 b, double2 c ){  x=a.x+b.x/c.x;  y=a.y+b.y/c.y;  }
   
  // acum result
  final void add ( double  f                       ){  x+=f;           y+=f;          }
  final void add ( double2 b                       ){  x+=b.x;         y+=b.y;        }
  final void sub ( double2 b                       ){  x-=b.x;         y-=b.y;        }
  final void mul ( double  f                       ){  x*=f;           y*=f;          }
  final void mul ( double2 b                       ){  x*=b.x;         y*=b.y;        }
  final void div ( double2 b                       ){  x/=b.x;         y/=b.y;        }
  final void fma ( double2 b, double2 c            ){  x+=b.x*c.x;     y+=b.y*c.y;    }
  final void fma ( double2 b, double  f            ){  x+=b.x*f;       y+=b.y*f;      }
  final void fda ( double2 b, double2 c            ){  x+=b.x/c.x;     y+=b.y/c.y;    }
  
  final void cplx_mul(                      ){ double tmp=x*x-y*y;     y=2*x*y;       x=tmp; };
  final void cplx_mul( double2 a            ){ double tmp=x*a.x-y*a.y; y=x*a.y+y*a.x; x=tmp; };
  final void cplx_mul( double2 a, double2 b ){      x=a.x*b.x-a.y*b.y; y=a.x*b.y+a.y*b.x;    };
  
  final void rotate   ( double a){ double x_=x; double ca=Math.cos(a); double sa=Math.sin(a); x=ca*x_-sa*y; y=sa*x_+ca*y; }
  final void rotate_verlet( double a){ x-=a*y; y+=a*x; }
  final void rotate_verlet2( double a){ double a2=a*0.5;    x-=a2*y; y+=a2*x; x-=a2*y; y+=a2*x; }
  final void rotate_d1( double a){ double x_=x; x-=a*y; y+=a*x_; }
  final void rotate_d3( double a){ double x_=x;
                                   double a2=a*a;
                                   //double ca=1.0d-a2/2.0;
                                   //double sa=a-a2*a/6.0d; 
                                   double ca= 1.0d - a2  *0.5d;
                                   double sa=   a  - a2*a*0.1666666666666666666d;
                                   //double ca = (-0.5000000000000000000d*a2 + 1.0d);
                                   //double sa = (-0.1666666666666666666d*a2 + 1.0d) * a;  
                                   x=ca*x_-sa*y; y=sa*x_+ca*y; 
                                 }
    final void rotate_d3v( double a){
                                   double a2=a*a; 
                                   double ca= 1.0d - a2  *0.5d;
                                   //double ca= 1.0d;
                                   //double sa=   a  - a2*a*0.1666666666666666666d;
                                   //double ca = (-0.5000000000000000000d*a2 + 1.0d);
                                   //double sa = (-0.1666666666666666666d*a2 + 1.0d) * a;  
                                   x=ca*x-a*y; y=a*x+ca*y; 
                                 }
  final void rotate_d5( double a){ double x_=x;
                                   double a2=a*a;
                                   //double a4=a2*a2;
                                   //double ca= 1.0d - a2  /2.0d + a4  /24.0d  ;
                                   //double sa=   a  - a2*a/6.0d + a4*a/120.0d ; 
                                   //double ca= 1.0d - a2  *0.5d + a4  *0.0416666666666666666d;
                                   //double sa=   a  - a2*a*0.1666666666666666666d + a4*a*0.0083333333333333333d;  
                                   double ca = ((0.0416666666666666666d*a2 - 0.5000000000000000000d) * a2 + 1.0d);
                                   double sa = ((0.0083333333333333333d*a2 - 0.1666666666666666666d) * a2 + 1.0d) * a;  
                                   x=ca*x_-sa*y; y=sa*x_+ca*y; 
                                 }
  final void rotate_d7( double a){ double x_=x;
                                   double a2=a*a;
                                   //double a4=a2*a2;
                                   //double a6=a4*a2;
                                   //double ca= 1.0d - a2  /2.0d + a4  /24.0d  - a6/720.0d;
                                   //double sa=   a  - a2*a/6.0d + a4*a/120.0d - a6*a/5040.0d;
                                   //double ca= 1.0d - a2  *0.5d + a4  *0.0416666666666666666d  - a6*0.001388888888888888d;
                                   //double sa=   a  - a2*a*0.1666666666666666666d + a4*a*0.0083333333333333333d - a6*a*0.0001984126984126984d;
                                   double ca = (((-0.0013888888888888888d * a2 + 0.0416666666666666666d) * a2 - 0.5000000000000000000d) * a2 + 1.0d);
                                   double sa = (((-0.0001984126984126984d * a2 + 0.0083333333333333333d) * a2 - 0.1666666666666666666d) * a2 + 1.0d) * a;            
                                   x=ca*x_-sa*y; y=sa*x_+ca*y; 
                                 }          

    final void rotate_tan1( double a){ double x_=x;
                                   //double ta   =1.0d/((2.0d/a)-0.333333333333333333d);
                                   double ahalf = a/2.0d;
                                   double ta = ahalf + ahalf*ahalf*ahalf/3.0d;
                                   double ta2  =ta*ta;
                                   double ta2p1=1.0d+ta2;  
                                   double ca = (1.0d-ta2)/ta2p1;
                                   double sa = 2.0d*ta2/ta2p1;
                                   x=ca*x_-sa*y; y=sa*x_+ca*y; 
                                 }
  
  final void lin ( double2 a, double2 b, double fa, double fb  ){   x=fa*a.x+fb*b.x; y=fa*a.y+fb*b.y;  }
  
  final double dot     ( double2 b            ){ return x*b.x + y*b.y;  }
  final double dot     (                      ){ return x*x+y*y;        }
  final void normalize (                      ){ double r=Math.sqrt(x*x+y*y);  x/=r; y/=r; }
  double cross( double2 a ){ return x*a.y - y*a.x; }

  String toString(){  return " "+x+" "+y;  }
}
