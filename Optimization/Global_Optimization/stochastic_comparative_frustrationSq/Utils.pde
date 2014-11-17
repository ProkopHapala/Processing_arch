

void getMaxFitness(){
  for(int i=0;i<ngens;i++){
    if (population[i].fitness > maxFitness){
      iBest=i; maxFitness=population[i].fitness;
    }
  }
  println("iBest: "+iBest);
  noStroke(); fill(0,255,0); paintGenne( population[iBest]);
}

final float rndSq(){
float r = random(-1.0,1.0);
if(r>0){
  return r*r;
}else{
  return -r*r;
}
}
