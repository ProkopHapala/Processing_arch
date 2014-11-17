
static float exp1(float x){

x*=1.44269504;             // e^x  ->  2^x
int y = (int) x;           // integer part in 2^y basis
long ie = ((long)1)<<y;  // 2^y
x-=y;                      // fractional part in e^x basis
x*=0.693147181;            // 2^x  ->  e^x

x*=0.25;                   // exp(x) = exp(x/4)^4   // increase order for better convergence range
float px = x; 
float e = 1 + px;                // Taylor 1st order
px*=x; e+=px*0.5;                // Taylor 2nd order
px*=x; e+=px*0.1666666666666;    // Taylor 3rd order 
// px*=x; e+=px*0.0416666666666; // increase order // increase order for better results aroud zero

e*=e; // (1+x/4)^2
e*=e; // (1+x/4)^4

return ie*e;    // exp(x) = exp(integr(x))*exp(fractional(x))
}


static float smallexp(float x){
x*=0.25;                   // exp(x) = exp(x/4)^4   // increase order for better convergence range
float px = x; 
float e = 1 + px;                // Taylor 1st order
px*=x; e+=px*0.5;                // Taylor 2nd order
px*=x; e+=px*0.1666666666666;    // Taylor 3rd order 
// px*=x; e+=px*0.0416666666666; // increase order // increase order for better results aroud zero
e*=e; // (1+x/4)^2
e*=e; // (1+x/4)^4
return e;    // exp(x) = exp(integr(x))*exp(fractional(x))
}
