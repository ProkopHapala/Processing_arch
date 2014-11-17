class double3{
  
  double x,y,z;

  // constructors
  double3 ( ){};
  double3 ( double   f ){set(f);}
  double3 ( double3  b ){set(b);}
  double3 ( double  x, double y, double z ){set(x,y,z);}

  // setting rutines
  final void set ( double  f ){   x=f;   y=f;   z=f;   }
  final void set ( double3 b ){   x=b.x; y=b.y; z=b.z; }
  final void set ( double  x, double y, double z ){   this.x=x;   this.y=y;   this.z=z;   }
  
  // set result
  final void add ( double3 a, double  f            ){  x=a.x+ f;       y=a.y+f;        z=a.z+f;        }
  final void add ( double3 a, double3 b            ){  x=a.x+b.x;      y=a.y+b.y;      z=a.z+b.z;      }
  final void sub ( double3 a, double3 b            ){  x=a.x-b.x;      y=a.y-b.y;      z=a.z-b.z;      }
  final void mul ( double3 a, double  f            ){  x=a.x*f;        y=a.y*f;        z=a.z*f;        }
  final void mul ( double3 a, double3 b            ){  x=a.x*b.x;      y=a.y*b.y;      z=a.z*b.z;      }
  final void div ( double3 a, double3 b            ){  x=a.x/b.x;      y=a.y/b.y;      z=a.z/b.z;      }
  final void fma ( double3 a, double3 b, double  f ){  x=a.x+b.x*f;    y=a.y+b.y*f;    z=a.z+b.z*f;    }
  final void fma ( double3 a, double3 b, double3 c ){  x=a.x+b.x*c.x;  y=a.y+b.y*c.y;  z=a.z+b.z*c.z;  }
  final void fda ( double3 a, double3 b, double3 c ){  x=a.x+b.x/c.x;  y=a.y+b.y/c.y;  z=a.z+b.z/c.z;  }
  
  // acum result
  final void add ( double  f                       ){  x+=f;           y+=f;           z+=f;           }
  final void add ( double3 b                       ){  x+=b.x;         y+=b.y;         z+=b.z;         }
  final void sub ( double3 b                       ){  x-=b.x;         y-=b.y;         z-=b.z;         }
  final void mul ( double  f                       ){  x*=f;           y*=f;           z*=f;           }
  final void mul ( double3 b                       ){  x*=b.x;         y*=b.y;         z*=b.z;         }
  final void div ( double3 b                       ){  x/=b.x;         y/=b.y;         z/=b.z;         }
  final void fma ( double3 b, double3 c            ){  x+=b.x*c.x;     y+=b.y*c.y;     z+=b.z*c.z;     }
  final void fma ( double3 b, double  f            ){  x+=b.x*f;       y+=b.y*f;       z+=b.z*f;       }
  final void fda ( double3 b, double3 c            ){  x+=b.x/c.x;     y+=b.y/c.y;     z+=b.z/c.z;     }
  
  final void lin ( double3 a, double3 b, double fa, double fb  ){   x=fa*a.x+fb*b.x; y=fa*a.y+fb*b.y; z=fa*a.z+fb*b.z;  }
  final void lin ( double3 a, double3 b, double3 c, double3 fs ){   
    x=fs.x*a.x+fs.y*b.x+fs.z*c.x; 
    y=fs.x*a.y+fs.y*b.y+fs.z*c.y; 
    z=fs.x*a.z+fs.y*b.y+fs.z*c.z; 
  }
  
  final double dot     ( double3 b            ){ return x*b.x + y*b.y + z*b.z;  }
  final double dot     (                      ){ return x*x+y*y+z*z;            }
  final void normalize (                      ){ double r=Math.sqrt(x*x+y*y+z*z);  x/=r; y/=r; z/=r; }
  final void cross3( double3 a, double3 b  ){ x= a.y*b.z-a.z*b.y;    y= a.z*b.x-a.x*b.z;    z= a.x*b.y-a.y*b.x; }
  
  String toString(){
    return x+" "+y+" "+z;
  }

}
