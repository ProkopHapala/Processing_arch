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
  
  final void lin ( double2 a, double2 b, double fa, double fb  ){   x=fa*a.x+fb*b.x; y=fa*a.y+fb*b.y;  }
  
  final double dot     ( double2 b            ){ return x*b.x + y*b.y;  }
  final double dot     (                      ){ return x*x+y*y;        }
  final void normalize (                      ){ double r=Math.sqrt(x*x+y*y);  x/=r; y/=r; }
  double cross( double2 a ){ return x*a.y - y*a.x; }

  String toString(){  return " "+x+" "+y;  }
}
