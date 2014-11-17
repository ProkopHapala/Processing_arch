


void PolynomRegression( double vx[], double vy[], double poly[] ){

final int n = poly.length;   // polynom order
final int m = vx.length;  // fitted values

println (n+" "+m);

double [][] X  =   new double [m][n];
double [][] XT =   new double [n][m];
double [][] XTX  = new double [n][n];

double [] XTvy = new double [n];

 vector.write(vx);
 
 
for(int j = 0;j<m; j++){
  X[j][0]=1.0;
  for(int i = 1; i<n; i++){
  X[j][i] = X[j][i-1]*vx[j]; }
}

matrix.write(X);

//println ( X.length+" "+X[0].length);
//println (XT.length+" "+XT[0].length);

matrix.transpose(X,XT);
matrix.write(XT);
matrix.mul(XT,X,XTX);
matrix.write(XTX);
matrix.invert(XTX);
matrix.write(XTX);

matrix.vec(XT,vy,XTvy);
matrix.vec(XTX,XTvy,poly);
}
