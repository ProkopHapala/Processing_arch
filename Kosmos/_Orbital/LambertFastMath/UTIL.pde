
final static double sq(double x){return x*x;}

void plot ( double xmin, double xmax, int n, ScalarFunc f){
  double dx=(xmax-xmin)/n;
  for (int i=0; i<n; i++){
    double x=xmin+i*dx; 
    double y = f.eval(x);
    //println(i+" "+x+" "+y); 
    point((float)(x*100+400), (float)(400-y*100)  );
  }
}

