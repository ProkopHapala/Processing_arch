

int   nEvals=0;
int   nSteps=0;
float Econdition = 0.01;
int maxIter=1000;

PrintWriter out;
boolean stop=false;
Relaxator R;

void setup(){
size(sz2,sz2);
//Xmap = X0.clone();
initEmap();
//paintEmap();
Eimage = get();

//R = new Relaxator(  X0.clone() );
R = new Relaxator_2(  X0.clone()  );
nEvals = 0;


}

int perframe = 10;
void draw(){  
  if ( !stop ){ 
    for (int i=0; i<perframe; i++){
      if ( R.move() ){
        nSteps++;        
        println( " nEval "+nEvals+" nSteps "+nSteps+" E= "+ R.E );
      }else{
        //println( " nEval "+nEvals+" nSteps "+nSteps+" E= "+ R.E );
      }
      if (R.E<Econdition)stop=true;
    }
  } 
}

