
final int pm=5;
final int pn=5;
final int m = 1<<pm;
final int n = m<<pn;
final int iterChunk = 250;
final int maxParticles = 1000000;
final int diffmax = 10000;

int nparticles = 0;
int iters = 0;
int [][] F   = new int[n][n];
int [][] FF  = new int[m+4][m+4];
int [][] tilelist = new int[(m+4)*(m+4)][2];
int nlisted = 0;

void setup(){
  size(n,n);  
  colorMode(RGB,1.0);
  //for (int i=0;i<40;i++){     F [int(random(n))][int(random(n))] = 1;   }
  for (int i=0;i<50;i++){  int ix=F.length/2+5; int iy = F[0].length/2+i+5;   F [ix][iy] = 1;  update_tiles( ix,iy ); }
}

void draw(){
  enlistTiles();
  paintField(F);
  for (int i=0;i<iterChunk;i++){
    int irnd = int( random(nlisted) );
    int ix = (tilelist[irnd][0]<<pn) + int( random(1<<pn) ); 
    int iy = (tilelist[irnd][1]<<pn) + int( random(1<<pn) ); 
    //println( "start ix, iy:"+ix+" "+iy+" "+irnd+" "+tilelist[irnd][0]+" "+tilelist[irnd][1] );
    trace( iy, ix );
    set(ix,iy,0xFFFFFF);
    //ellipse( ix, iy, 3,3 );
  }
  if (nparticles>maxParticles) noLoop();
  //println(" nparticles: "+nparticles);
}
