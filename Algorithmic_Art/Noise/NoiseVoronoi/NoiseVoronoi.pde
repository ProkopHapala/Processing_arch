final int n = 800;

final int perframe = 10;

void setup(){
  size(n,n);
  for(int ix=0;ix<n;ix++){ for(int iy=0;iy<n;iy++){
    float f  = 128*VoronoiNoise( ix*0.01, iy*0.01 );
          f +=  64*VoronoiNoise( ix*0.02, iy*0.02 );
          f +=  32*VoronoiNoise( ix*0.04, iy*0.04 );
    set(ix,iy, color(f,f,f) );
  } }
  println(" -- DONE -- ");
}
