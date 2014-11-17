
final int n = 512;
final int iterChunk = 10000;
final int maxParticles = 1000000;
final int diffmax = 100;

int nparticles = 0;
int iters = 0;
int [][] F;

void setup(){
  size(n,n);  
  //colorMode(RGB,1.0);
  colorMode(HSB,1.0);
  F = new int[n][n];
  for (int i=0;i<40;i++){     F [int(random(n))][int(random(n))] = 1;   }
}

void draw(){
  for (int i=0;i<iterChunk;i++){
    trace( int(random(n)),int(random(n)) );
  }
  if (nparticles>maxParticles) noLoop();
  println(" nparticles: "+nparticles);
  paintField(F);
}
