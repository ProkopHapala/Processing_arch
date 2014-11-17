
class GenNN3L{
  double fitness=Double.NEGATIVE_INFINITY;
  double [][] Wih,Who;
}

void compare_hidden( double [][] w1, double [][] w2, double [][] correlation  ){
  //println( "shape w1   :" + w1.length +" "+ w1[0].length );
  //println( "shape w2   :" + w2.length +" "+ w2[0].length );
  //println( "shape corr :" + correlation.length +" "+ correlation[0].length );
  for(int ih1=0; ih1<w1[0].length; ih1++ ){
    for(int ih2=0; ih2<w2[0].length; ih2++ ){
      double c12=0,c11=0,c22=0;
      for(int ii=0; ii<w1.length; ii++ ){
        double wi1 = w1[ii][ih1];
        double wi2 = w2[ii][ih2];
        c12 = wi1*wi2;
        c11 = wi1*wi1;
        c22 = wi2*wi2;
      }
      double cosi12       = c12/Math.sqrt( c11*c22 );
      double lengthcorrel = 1 - Math.abs( (c11-c22)/(c11+c22 ) );
      correlation[ih1][ih2] = cosi12*lengthcorrel;
    }
  }
}

void makeMap( double [][] correlation ){
  for(int i=0; i<correlation.length; i++ ){  corelComp[i].set( i, correlation[i] );   }
  plotMat(300,250,5, correlation  );
  java.util.Arrays.sort( corelComp );
  for(int i=0; i<corelComp.length; i++ ){  correlation[i] = corelComp[i].arr;  }
  plotMat(370,250,5, correlation  );
}




