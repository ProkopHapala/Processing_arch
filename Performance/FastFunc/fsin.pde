
// sin() using recursive aplication of formula sin(2x)
// x is splited to 8*y
// sin(x) = sin(8*y)
// sin(y) is small arround zero and converge well

float fsin(float x){
final int T = (int)(x*0.159154943);   // T = x/2*Pi
x-=(T*TWO_PI);
x*=0.125;

float px = x;
float c=1;                   // order 0
float s=x;                   // order 1
px*=x; c-=px*0.5;            // order 2
px*=x; s-=px*0.166666666666; // order 3
px*=x; c+=px*0.041666666666; // order 4
px*=x; s+=px*0.008333333333; // order 5
px*=x; c+=px*0.001388888888; // order 6
px*=x; s+=px*0.000198412698; // order 7
final float s2=2.0*s*c;
final float c2=c*c-s*s;
final float s4=2.0*s2*c2;
final float c4=c2*c2-s2*s2;
final float s8=2.0*s4*c4;
//final float c8=c*c-s*s;
return s8;
}


/*

float ffsin(float x){
final int T = (int)(x*0.159154943);   // T = x/2*Pi
x-=(T*TWO_PI);
x*=0.5;

float px = x;
float c=1;                   // order 0
float s=x;                   // order 1
px*=x; c-=px*0.5;            // order 2
px*=x; s-=px*0.166666666666; // order 3
px*=x; c+=px*0.041666666666; // order 4
px*=x; s+=px*0.008333333333; // order 5
px*=x; c+=px*0.001388888888; // order 6
px*=x; s+=px*0.000198412698; // order 7
final float s2=2.0*s*c;
//final float c2=c*c-s*s;
return s2;
}

*/
