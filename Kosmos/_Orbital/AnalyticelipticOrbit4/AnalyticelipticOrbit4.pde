
// http://www.braeunig.us/space/orbmech.htm
// http://en.wikipedia.org/wiki/Vis-viva_equation
// http://en.wikipedia.org/wiki/Kepler_orbit // Determination of the Kepler orbit that corresponds to a given initial state

final float G = 1;
final float M = 1;
final float GM = G*M;

PVector V0;
PVector P0;


Analytic_Orbit Orb1;


void setup(){
  size(800,800,P3D);
  
  translate(400,400);
  scale(100,100);
  
  V0 = new PVector( 0.5 ,0.5,0 );
  P0 = new PVector( 1.0 ,-0.2  ,0 );
  
  Orb1 = new Analytic_Orbit();
  Orb1.fromStatePoint( P0, V0 );
  
  stroke(0,0,255); Orb1.plot(1000);
  stroke(255,0,0); Orb1.plot_fast(1000);

}
