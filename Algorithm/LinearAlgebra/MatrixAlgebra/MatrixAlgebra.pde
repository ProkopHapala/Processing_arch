int n = 5;

// matrix euation   Ax=b 
double x[] = new double[n];
int index[] = new int[n];
double b[] = {1,2,3,4,5};
double A[][]= {{ 1,  0,  0, 0, 0},
               { 0,  1,  6, 0, 0},
               { 0,  3,  2, 1, 0},
               { 0,  0,  0, 1, 0},
               { 0,  0,  0, 0, 1}};  

double B[][]= {{ 1,  0,  0, 0, 0},
               { 0,  1,  0, 0, 0},
               { 0,  0,  1, 0, 0},
               { 0,  0,  0, 1, 0},
               { 0,  0,  0, 0, 1}};                 

double C[][];


void setup(){
/*
x = solve(A, b, index);
for (int i=0; i<n; i++)
println("I_" + (i+1) + " = " + x[i]);
*/

/*
printMat( A);
printMat( B);
C=MMult(A,B,new double[n][n]);
printMat(C);
*/

printMat(A);
C=invert(A);
printMat(C);



}







