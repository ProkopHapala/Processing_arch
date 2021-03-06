
// matrix euation   Ax=b 
//double x[] = new double[n];
/*
double b[] = {1,-1,0,0,0};
double A[][]= {{  1.0,  0.5,  0.0,  0.0,  0.0 },
               {  0.5,  1.0,  0.0,  0.0,  0.0 },
               {  0.0,  0.0,  1.0,  0.0,  0.0 },
               {  0.0,  0.0,  0.0,  1.0,  0.0 },
               {  0.0,  0.0,  0.0,  0.0,  1.0 }};  
*/

// random problem generated by numpy:
double A[][]={
{ 1.01698343d, -0.14246943d, -0.11791678d, -0.04396157d},
{-0.08687366d,  1.09049695d, -0.14765638d,  0.09512103d},
{ 0.03397267d,  0.04099586d,  0.77393738d,  0.24739418d},
{ 0.16394002d,  0.03013492d,  0.19541535d,  0.92849503d}
};
double b[] = {-0.07126881d,  0.27510421d,  0.46426129d, -0.467357d  };
// solution should be: b = { 0.05184081  0.42484878  0.79693668 -0.69401796};


int index[] = new int[b.length];
double x[] = new double[b.length];               
/*               
 double A[][]= {{ 1,  0,  0},
               { 0,  0,  1},
               { 0,  1,  0}};                
*/               
/*
double A[][]= {{ 100,  100,  100},
               {-100,  300, -100},
               {-100, -100,  300}};  
*/

void setup(){

solve(A, b, x, index);

for (int i=0; i<x.length; i++)
println("I_" + index[i] + " = " + x[i]);

}







