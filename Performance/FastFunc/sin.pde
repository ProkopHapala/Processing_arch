
// sin[x] and cos[x] for 16 discrete values

float si[] = {
 0.0,
 0.38268346,
 0.70710677,
 0.9238795,
 1.0,
 0.9238795,
 0.70710677,
 0.38268328,
 0.0,
 -0.38268343,
 -0.7071069,
 -0.9238797,
 -1.0,
 -0.92387944,
 -0.70710653,
 -0.38268343,
};

float ci[] = {
 1.0,
 0.9238795,
 0.70710677,
 0.38268343,
 -4.371139E-8,
 -0.38268352,
 -0.70710677,
 -0.9238796,
 -1.0,
 -0.9238795,
 -0.70710665,
 -0.38268313,
 1.1924881E-8,
 0.3826836,
 0.707107,
 0.92387956,
};




// interpolate from table using
// taylor expansion of sin(dx)
// using formula sin(x0+dx) = sin(x0)*cos(dx) + cos(x0)*sin(dx)

float sintab(float x){
final int T = (int)(x*0.159154943);   // T = x/2*Pi
x-=(T*TWO_PI);
//println("x: "+x);
final int i = (int)(x*2.54647909);     // i = 16 * x/2*Pi - tabulated   part
x-=(i*0.392699082);                   // x-2Pi/16*i      - diferencial part
//println(i);
float px = x;
float c=1;                     // order 0
float s=x;                     // order 1
px*=x; c-=px*0.5;              // order 2
px*=x; s-=px*0.166666666666;   // order 3
px*=x; c+=px*0.041666666666;   // order 4
px*=x; s+=px*0.008333333333;   // order 5
//px*=x; c+=px*0.001388888888; // order 6
//px*=x; s+=px*0.000198412698; // order 7
final float s2=si[i]*c+ci[i]*s;   // sin(x0+dx) = sin(x0)*cos(dx) + cos(x0)*sin(dx)
return s2;
}





