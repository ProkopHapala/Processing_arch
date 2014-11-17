
//  ring valley
final float Aa     =  0.0;
final float Ar2    =  4.0;
final float Ax     = -0.25;
final float Ay     = -0.25;
final float Aconst = -0.5;
final float GaussK    = 10;
final float GaussA    = 4.0;
final float SpiralA   = 0.0;
final float omega     = 3*TWO_PI;
final float omegaWave  = 2.0*TWO_PI;
final float AWave      = 0.0;

/*
// spiral valey
final float Aa     =  0.1;
final float Ar2    =  0.0;
final float Ax     =  0.0;
final float Ay     =  0.0;
final float Aconst =  0.5;
final float GaussK    = 100;
final float GaussA    = 0.0;
final float SpiralA   = 0.5;
final float omega     = 2.5*TWO_PI;
final float omegaWave  = 1.0*TWO_PI;
final float AWave      = 1.0;
*/

void Potential(float x,float y){
float r2 = x*x+y*y;
float r  = sqrt(r2);
float a  = atan2(x,y);

float   Gauss  =  GaussA*exp(-GaussK*r2);
float  dGauss  = -GaussK*Gauss;

float  Wave =            AWave*cos(omegaWave*a);
float dWave = -omegaWave*AWave*sin(omegaWave*a);

float   Spiral = SpiralA*cos( omega*r + a + Wave );
float  dSpiral = SpiralA*sin( omega*r + a + Wave );

 E    = Spiral  + Aa*a*a +  Gauss + Ar2*r2 +  Ax*x + Ay*y + Aconst;
 F[0] = dSpiral * (  omega*x/r  +  (1.0+dWave)* y/r2 ) - 2*Aa*a*y/r2  - (dGauss + Ar2)*2*x - Ax;
 F[1] = dSpiral * (  omega*y/r  -  (1.0+dWave)* x/r2 ) + 2*Aa*a*x/r2  - (dGauss + Ar2)*2*y - Ay;

}
