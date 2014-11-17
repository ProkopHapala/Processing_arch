

double testfunc(double t){
  double E=0; nEvals++;
  E+=func_poly(t, testPolyCoef);
  //E+=func_spline(t,testSplineCoef);
  return E*0.5;
}

// =================== spline ===============================

// bad assymetric
//final double [] testSplineCoef = { 3.00, 2.00,  1.00, -1.50, -1.25,  -1.0, -0.7,  -0.5, +0.5, 1.00,  2.00, 3.0 };

// nice symmetric
final double [] testSplineCoef = { 3.00, 2.00,  1.00, -0.5, -1.0, -1.50, -1.25, -0.7, +0.5, 1.00,  2.00, 3.0 };

double func_spline(double t, double [] cs){
  int it = (int)(t-0.5+1000000)-1000000;
  double dt = t-it-0.5;
  it+=cs.length/2;
  double E = curvePoint( (float)cs[it-1],(float)cs[it],(float)cs[it+1],(float)cs[it+2], (float)dt);
 // println( " it "+it+" t " +t+" dt "+dt+" E "+E);
  return E;
}

// =================== POLYGON ===============================

//                                1       x       x^2    x^3    x^4      x^5   x^6
// double well
//final double [] testPolyCoef = { 0.00, -0.100,  0.200, 0.000, -0.060,  0.000, 0.004 };

// bad asymetric
final double [] testPolyCoef = { 0.00, -0.1,  0.000, -0.1, 0.000,  0.00, 0.005 };

// nice parabola
//final double [] testPolyCoef = { 0.00, 0.5,  0.2, 0.0, 0.000,  0.00, 0.0 };

double func_poly(double t, double [] cs){
  double tt = 1;
  double E= cs[0];
  for(int i=1; i<cs.length; i++ ){
    tt *= t;
     E += tt*cs[i];
  }
  return E;
}



