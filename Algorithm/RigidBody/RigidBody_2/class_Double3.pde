class double3{
  
  double x,y,z;

  // constructors
  double3 ( ){};
  double3 ( double   f ){set(f); }
  double3 ( double3  b ){set(b); }
  double3 ( double   x, double y, double z ){ set(x,y,z); }
  double3 ( double  [] xs ){ set(xs); }

  // setting rutines
  final void set ( double  f ){   x=f;   y=f;   z=f;   }
  final void set ( double3 b ){   x=b.x; y=b.y; z=b.z; }
  final void set ( double  x, double y, double z ){   this.x=x;   this.y=y;   this.z=z;   }
  final void set ( double [] xs ){   this.x=xs[0];   this.y=xs[1];   this.z=xs[2];   }
  
  
  // set to multipliction
  final void set_add   ( double3 a, double  f            ){  x=a.x+ f;       y=a.y+f;        z=a.z+f;        }
  final void set_add   ( double3 a, double3 b            ){  x=a.x+b.x;      y=a.y+b.y;      z=a.z+b.z;      }
  final void set_sub   ( double3 a, double3 b            ){  x=a.x-b.x;      y=a.y-b.y;      z=a.z-b.z;      }
  final void set_mul   ( double3 a, double  f            ){  x=a.x*f;        y=a.y*f;        z=a.z*f;        }
  final void set_mul   ( double3 a, double3 b            ){  x=a.x*b.x;      y=a.y*b.y;      z=a.z*b.z;      }
  final void set_div   ( double3 a, double3 b            ){  x=a.x/b.x;      y=a.y/b.y;      z=a.z/b.z;      }
  final void set_fma   ( double3 a, double3 b, double  f ){  x=a.x+b.x*f;    y=a.y+b.y*f;    z=a.z+b.z*f;    }
  final void set_fma   ( double3 a, double3 b, double3 c ){  x=a.x+b.x*c.x;  y=a.y+b.y*c.y;  z=a.z+b.z*c.z;  }
  final void set_fda   ( double3 a, double3 b, double3 c ){  x=a.x+b.x/c.x;  y=a.y+b.y/c.y;  z=a.z+b.z/c.z;  }
  final void set_cross ( double3 a, double3 b  )          {  x=a.y*b.z-a.z*b.y;    y= a.z*b.x-a.x*b.z;    z= a.x*b.y-a.y*b.x; }
  
  // add multipliction
  final void add ( double  f                       ){  x+=f;           y+=f;           z+=f;           }
  final void add ( double3 b                       ){  x+=b.x;         y+=b.y;         z+=b.z;         }
  final void sub ( double3 b                       ){  x-=b.x;         y-=b.y;         z-=b.z;         }
  final void mul ( double  f                       ){  x*=f;           y*=f;           z*=f;           }
  final void mul ( double3 b                       ){  x*=b.x;         y*=b.y;         z*=b.z;         }
  final void div ( double3 b                       ){  x/=b.x;         y/=b.y;         z/=b.z;         }
  final void add_mul ( double3 b, double3 c            ){  x+=b.x*c.x;     y+=b.y*c.y;     z+=b.z*c.z;     }
  final void add_mul ( double3 b, double  f            ){  x+=b.x*f;       y+=b.y*f;       z+=b.z*f;       }
  final void add_div ( double3 b, double3 c            ){  x+=b.x/c.x;     y+=b.y/c.y;     z+=b.z/c.z;     }
  
  final void set_lincomb ( double3 a, double3 b, double fa, double fb                       ){   x=fa*a.x+fb*b.x; y=fa*a.y+fb*b.y; z=fa*a.z+fb*b.z;  }
  final void set_lincomb ( double3 a, double3 b, double3 c, double fa, double fb, double fc ){   x=fa*a.x+fb*b.x+fc*c.x; y=fa*a.y+fb*b.y+fc*c.y; z=fa*a.z+fb*b.y+fc*c.z; }
  final void set_lincomb ( double3 a, double3 b, double3 c, double3 fs                      ){   x=fs.x*a.x+fs.y*b.x+fs.z*c.x; y=fs.x*a.y+fs.y*b.y+fs.z*c.y; z=fs.x*a.z+fs.y*b.y+fs.z*c.z; }
  
  final double dot       ( double3 b          ){ return x*b.x + y*b.y + z*b.z;  }
  final double norm2     (                    ){ return x*x+y*y+z*z;            }
  final double normalize (                    ){ double r=Math.sqrt(x*x+y*y+z*z);  x/=r; y/=r; z/=r; return r; }
  
  final String toString() { return x + ", " + y + ", " + z; }
  
}
