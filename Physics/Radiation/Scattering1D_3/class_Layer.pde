

class Layer{
  Cell [] cells;
  double x0,x1,dx;
  
  Layer( double z,   double x0, double x1, int ncell,  int nscatter, double [] mask ){
    println( " ==== New Layer ");
    cells = new Cell[ ncell ];
    this.x0 = x0; this.x1=x1;
    double xspan = x1-x0;
    dx = xspan/ncell;
    for(int i=0; i<cells.length; i++){
      double x = x0 + dx*( i + 0.5d );
      println( "i,x: "+i+" "+x );
      Cell cell = new Cell( x,  z,   nscatter,   mask );
      cells[i] = cell;
    }
  }
  
  void trace_source( Layer source ){
    for (int i=0; i<cells.length; i++ ){
      for (int j=0; j<source.cells.length; j++ ){
        //println( "i,j: "+i+" "+j );
        cells[i].getRay( source.cells[j] );
      } 
    }
  }
  
  void scatter( ){ for (int i=0; i<cells.length; i++ ){ cells[i].scatter(); } }
  void plot(){ for (int i=0; i<cells.length; i++ ){ cells[i].plot(); }  } 
  void plotRayOut( boolean byPoint ){ for (int i=0; i<cells.length; i++ ){ cells[i].plotRayOut( byPoint ); } }
  void plotRayIn ( boolean byPoint ){ for (int i=0; i<cells.length; i++ ){ cells[i].plotRayIn ( byPoint ); } }
  
  
  void printCheckSum ( ){ 
    double insum=0,outsum=0; 
    for (int i=0; i<cells.length; i++ ){   println( i+" "+cells[i].totalIn+" "+cells[i].totalOut); insum+=cells[i].totalIn;  outsum+=cells[i].totalOut;       } 
    println( " total sums "+insum+" "+outsum );
  }
  
}
