

final static double Bspline( double u, double c0, double c1, double c2, double c3 ){
  final double i6 = 1.0d/6.0d;  
  return i6*(         c1 + 4*c2 +   c3       
        + u*(       3*c1        - 3*c3
        + u*(       3*c1 - 6*c2 + 3*c3
        + u*(  c0 - 3*c1 + 3*c2 -   c3   ))));  
} 

final static double dBspline( double u, double c0, double c1, double c2, double c3 ){
  final double i6 = 1.0d/6.0d;  
  return i6*(         3*c1          -  3*c3
        + u*(         6*c1 -  12*c2 +  6*c3
        + u*(  3*c0 - 9*c1 + 9*c2 - 3*c3   )));  
} 

final static double ddBspline( double u, double c0, double c1, double c2, double c3 ){
  final double i6 = 1.0d/6.0d;  
  return i6*(          6*c1 - 12*c2 + 6*c3
        + u*(  6*c0 - 18*c1 + 18*c2 - 6*c3   )); 
}

void boundaryLeft( double [] Cs, double y, double dy ){
  final double  B0 = 2.0d/3.0d;
  final double  B1 = 1.0d/6.0d;
  double c2 = Cs[2];
  double c0 = -( dy*2 - c2 );
  //double c1 =  ( y -  B1 * (c0+c2) )/B0; 
  double c1 =  ( y -  2*B1*( c2 - dy ) )/B0; 
  Cs[1] = c1; Cs[0] = c0;
};

void boundaryRight( double [] Cs, double y, double dy ){
  final double  B0 = 2.0d/3.0d;
  final double  B1 = 1.0d/6.0d;
  double c2 = Cs[Cs.length - 3];
  double c0 = ( dy*2 + c2 );
  //double c1 = ( y -  B1 * (c0+c2) )/B0; 
  double c1 = ( y -  2*B1*( c2 + dy ) )/B0; 
  Cs[Cs.length-2] = c1; Cs[Cs.length-1] = c0;
};



