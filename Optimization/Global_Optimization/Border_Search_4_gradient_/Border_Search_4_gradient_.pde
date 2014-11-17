
int nEvaluations;
float E_min = -100000000;
float step = 0.1;
float halfstep = step*0.5;


PImage Eimage;
ArrayList SampledCells = new ArrayList();
boolean stop=false;
int ibest=0;
Cell Best;


Relaxator2D R;

void setup(){
size(sz2,sz2,P2D);
frameRate(10);
initEmap();
//paintEmap();
nEvaluations = 0;
SampledCells.add(new Cell(new float[]{0,0}));
println( "CellInit: "+ SampledCells.get(0));
Eimage = get();

R = new Relaxator2D();
R.init( 0.25,0,   0,0.0001 );

Best = (Cell)SampledCells.get(0);
}

void draw(){
//image(Eimage, 0, 0);
  
if (!stop){   
Cell New = Best.getFreeNeigh(step);         // Find Free(not yet sampled) place arround and sample it
updateNeighs(New, step);                    // inform cells arround about new neighbor, kill the surrounded 
SampledCells.add(New);

// RELAXATION
  println(New);
  R.init( New.Pos[0], New.Pos[1],    0.0, 0.0001  );
  for(int i=0; i<20; i++){
    New.fitness = getEnergy( R.x, R.y );
    line( New.Pos[0]*sz +sz , New.Pos[1]*sz + sz,   R.x*sz +sz , R.y*sz +sz  );
    
    R.MDstepPROKOP1( fx, fy ); 
    R.paint();
    float dx = R.x - New.Pos[0];   float dy = R.y - New.Pos[1];
    if ((  abs(dx)>halfstep )||(  abs(dy)>halfstep )){         // crossed cell border
       Cell New_ = cellInPos (R.x, R.y);    // passed to already sampled?
       println ( "dx,dy:"+dx+"  "+dy+"  " + New_ );  
       if ( New_ == null ){                          // if not sample New_
         float [] newPos = new float[2]; newPos[0]= step*round( R.x/step );   newPos[1]= step*round(R.y/step );
         New_ = new Cell( newPos );
         println("New cell created");
         updateNeighs(New_, step);                 
         SampledCells.add(New_);
         New.relaxTo = New_;
         New = New_; 
       }else{
         New.relaxTo = New_;
         break;
       }
    }
    if(R.done){ break; }
  }

ibest = getBestCell();                 // Find Best aLive(not fully surrounded) cell 
Best  = (Cell)SampledCells.get(ibest);   

//exit();
//println(SampledCells.size()+" "+New);
println("n= "+nEvaluations + " Best: "+ibest+" "+ ((Cell)SampledCells.get(ibest)).fitness+ "   "+ SampledCells.size());
paintAllCells();
fill(255,0,0);  paintCell(New);
fill(0,255,0);  paintCell(Best);

stop=true;
}

/*
stroke(255,0,0);
getEnergy( (mouseX-sz)/(float)sz, (mouseY-sz)/(float)sz );
//println(fx+" "+fy);
line( mouseX, mouseY,   mouseX + fx*10, mouseY+fy*10 );
*/

/*
getEnergy( R.x, R.y );

if(!R.done){
  fill(0,0,0); 
  R.MDstepPROKOP1( fx, fy ); 
  if(R.done){
    fill(0,255,0); println("CONVERGED");
  } 
  R.paint();
};
*/






if(keyPressed){
if(key==' '){ stop=!stop; // image(Eimage, 0, 0); 
}
if(key=='s'){ save( year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".png" );}

}

//if(nEvaluations>1000)noLoop();   //exit();

}

void mousePressed(){
  R.init( (mouseX-sz)/(float)sz, (mouseY-sz)/(float)sz,    0,0.0001 );

}
