

void moveVerlet( double dt, double friction,   double [] xs, double [] vs, double [] fs  ){
  double damp = (1.0-dt*friction);
  for (int i=0; i<xs.length;i++ ){
    double v  = vs[i]*damp + fs[i]*dt;
    xs[i] += v*dt;
    vs[i]  = v; 
  }
}
