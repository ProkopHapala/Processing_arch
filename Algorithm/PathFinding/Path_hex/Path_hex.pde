
int N=200;
float [][] world = new float[N][N];


PosBuff starts;
DistMap myDistMap;

float [][] PosTimesMap;

void setup(){
  size( 4*N,N);
//frameRate(10);
starts = new PosBuff(N*N);
starts.put(N/2,N/2);
PosTimesMap = new float[N][N];
for (int ix=0; ix<PosTimesMap.length; ix++){  for (int iy=0; iy<PosTimesMap[0].length; iy++){ 
  //PosTimesMap[ix][iy] = 1.0 + random(1.0);
  PosTimesMap[ix][iy] = 1.0 ;
}}
for (int ix=N/2-50; ix<N/2+50; ix++){ PosTimesMap[ix][N/2-10] = Float.POSITIVE_INFINITY;  }
myDistMap = new DistMap( starts, PosTimesMap );
myDistMap.TimeMax = 90.0;
}

void draw(){
 background(200);
 myDistMap.PropagateStep();
 println(frameCount +"    lastPos.n: "+ myDistMap.lastPos.n);
 PaintGrid(N/2,0,myDistMap.fromA, myDistMap.TimeMax);
 PaintPosBuff(N/2,0, myDistMap.lastPos );
 if (myDistMap.lastPos.n==0) noLoop();
};

