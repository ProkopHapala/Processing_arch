  

int nStatistics = 1000;
  
int iter_max=0;
int iter_min=100000000;
int iter_average=0;

void relax( float x, float y ){  
  nEvaluations = 0;
  R.init(  x,  y  );
  stroke(255,0,0);
  for (int i=0; i<maxIter;i++){
    R.move();
    //println("R.E="+R.E);
    R.paint();
    if(R.E<Econdition){
     fill(0,0,255);
     ellipse(  R.x*sz+sz,R.y*sz+sz,   5,5 );
     //println (R.E+"  "+nEvaluations);
     break;
    }
  }  
}

void RelaxStatistics(){
  iter_max=0;
  iter_min=10000000;
  iter_average=0;
  for (int i=0; i<nStatistics; i++){
     relax( 0.8, -0.5);
     if(nEvaluations > iter_max) iter_max = nEvaluations;
     if(nEvaluations < iter_min) iter_min = nEvaluations;
     iter_average+=nEvaluations;
  }
  iter_average/=nStatistics;
}
