
int nEvaluations;
float E_min = -100000000;
float step = 0.04;

ArrayList SampledCells = new ArrayList();

void setup(){
size(sz2,sz2,P2D);
frameRate(10);
initEmap();
//paintEmap();
nEvaluations = 0;
SampledCells.add(new Cell(new float[]{0,0}));
}

void draw(){
int ibest  = getBestCell();                 // Find Best aLive(not fully surrounded) cell 
Cell Best  = (Cell)SampledCells.get(ibest);    
Cell New = Best.getFreeNeigh(step);         // Find Free(not yet sampled) place arround and sample it
updateNeighs(New, step);                    // inform cells arround about new neighbor, kill the surrounded 
SampledCells.add(New);
//exit();

//println(SampledCells.size()+" "+New);
println("n= "+nEvaluations + " Best: "+ibest+" "+ ((Cell)SampledCells.get(ibest)).fitness );
paintAllCells();
fill(255,0,0);  paintCell(New);
fill(0,255,0);  paintCell(Best);
if(nEvaluations>1000)noLoop();   //exit();
}
