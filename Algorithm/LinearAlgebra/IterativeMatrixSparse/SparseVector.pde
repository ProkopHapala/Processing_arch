
class SparseVector{
  int n;
  double [] val;
  int    [] ind;
  SparseVector(){};
  SparseVector(              int n             ){ this.n=n;         val=new double[n]; ind=new int[n];                   }
  SparseVector( double [] a                    ){ this.n=a.length;  val=new double[n]; ind=new int[n];  fromVec(a);      }
  SparseVector( double [] a,        double tol ){ this.n=a.length;  val=new double[n]; ind=new int[n];  fromVec(a,tol);  }
  SparseVector( double [] a, int n             ){ this.n=n;         val=new double[n]; ind=new int[n];  fromVec(a);      }
  SparseVector( double [] a, int n, double tol ){ this.n=n;         val=new double[n]; ind=new int[n];  fromVec(a,tol);  }
  
  final void fromVec( double [] a ){
    int j = 0;
    for( int i =0; i<a.length; i++ ){ double ai = a[i]; if (ai!=0.0d){ val[j]=ai; ind[j]=i; j++; }  }
    n = j;
  }
  
  final void fromVec( double [] a, double tol ){
    int j = 0;
    for( int i =0; i<a.length; i++ ){ double ai = a[i]; if (Math.abs(ai)>tol){ val[j]=ai; ind[j]=i; j++; }  }
    n = j;
  }
  
  final void minMem( ){
    double [] val_ = new double [n];
    int    [] ind_ = new int    [n];
    for( int i =0; i<n; i++ ){ val_[i]=val[i]; ind_[i]=ind[i]; }
    val=val_; ind=ind_;
  }
  
  
  String toString( )    {    String s=""; for( int i =0; i<n; i++ ){ s+= ind[i]+":"+val[i] + " "; };   return s;  }
  String toStringFull( ){    
    String s=""; 
    int j = 0;
    for( int i =0; i<n; i++ ){
      int ii=ind[i];
      while(j<ii){ s+= 0 + " "; j++; } 
      s+= val[i] + " "; j++;
    };   
    return s; 
  }
  
  
  final void toVec  ( double [] a ){ for( int i =0; i<n; i++ ){ a[ind[i]]  = val[i];   } }
  final void add2Vec( double [] a ){ for( int i =0; i<n; i++ ){ a[ind[i]] += val[i];   } }
  //final void mul2Vec( double [] a ){ for( int i =0; i<n; i++ ){ a[ind[i]] *= val[i];   } }
  
  final double mag2(                ){ double sum = 0; for( int i =0; i<n; i++ ){ sum+=val[i]*val[i];      } return sum;  }
  final double dot ( double []    a ){ double sum = 0; for( int i =0; i<n; i++ ){ sum+=val[i]*a[ind[i]];   } return sum;  }
  final void   mul ( double f ){ for( int i =0; i<n; i++ ){ val[i] *= f; }    }

  // ========= operation for vector which share index array
  final boolean isSameIndexing( SparseVector a ){ 
    if ( this.ind==a.ind )return true;
    if ( this.n!=a.n ) return false;
    for( int i =0; i<n; i++ ){ if( this.ind[i]!=a.ind[i] ) return false; }
    return true;
  }
  final boolean tryShareIndexing( SparseVector a ){  boolean possible = isSameIndexing( a );   this.ind=a.ind;    return possible;   }
  
  final double dotSame  ( SparseVector a                 ){ double sum = 0; for( int i =0; i<n; i++ ){ sum+=val[i]*a.val[i];       } return sum;  }
  
  final void mulSame    ( SparseVector a ){  for( int i =0; i<n; i++ ){ val[i]*= a.val[i]; }  }
  final void addSame    ( SparseVector a ){  for( int i =0; i<n; i++ ){ val[i]+= a.val[i]; }  }
  final void subSame    ( SparseVector a ){  for( int i =0; i<n; i++ ){ val[i]-= a.val[i]; }  }
  
  final void mulSame    ( SparseVector a, double f       ){  for( int i =0; i<n; i++ ){ val[i] = a.val[i]*f;        }  }
  final void mulSame    ( SparseVector a, SparseVector b ){  for( int i =0; i<n; i++ ){ val[i] = a.val[i]*b.val[i]; }  }
  final void addSame    ( SparseVector a, SparseVector b ){  for( int i =0; i<n; i++ ){ val[i] = a.val[i]+b.val[i]; }  }
  final void subSame    ( SparseVector a, SparseVector b ){  for( int i =0; i<n; i++ ){ val[i] = a.val[i]-b.val[i]; }  }
  
  final void fmaSame    ( SparseVector a, double f )                { double sum = 0; for( int i =0; i<n; i++ ){ val[i]+= f* a.val[i];             }  }
  final void fmaSame    ( SparseVector a, SparseVector b, double f ){ double sum = 0; for( int i =0; i<n; i++ ){ val[i] = f* b.val[i] + a.val[i];  }  }
  
}
