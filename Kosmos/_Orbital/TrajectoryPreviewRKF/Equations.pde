
void G_acceleartion( double[] X, double [] as ){
 double x = X[0]; double y = X[1]; double z = X[2];
 double r2 = x*x+y*y+z*z;
 double r  = Math.sqrt(r2);
 double aa  = -GM/ (r2*r);
 as[0]=x*aa; as[1]=y*aa; as[2]=z*aa; 
}






