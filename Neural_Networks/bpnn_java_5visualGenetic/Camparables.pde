


class VectorByMaxAbs implements Comparable < VectorByMaxAbs > {
    int     i,j;
    double  max;
    double [] arr;
    
    VectorByMaxAbs( ){    }
    
    VectorByMaxAbs( int i, double [] arr){
      set( i, arr );
    }
    
    void set( int i, double [] arr ){
      this.i = i; 
      this.arr = arr; 
      int jmax = 0; double amax = arr[0]*arr[0];
      for (int j=1;j<arr.length;j++){
        double aj = arr[j]; aj=aj*aj;
        if( aj > amax ){ jmax=j; amax=aj; }
      }
      this.max = amax; this.j=jmax;
    }

    @Override
    int compareTo( VectorByMaxAbs other ){
        double omax = other.max; 
        if       ( max>omax ){ return    1;
        }else if ( max<omax ){ return   -1;      
        }else                { return    0; }
    }
}
