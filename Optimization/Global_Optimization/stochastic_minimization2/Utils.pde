

void getEmin(){
 stroke(255,0,0);
  for(int i=0;i<ngens;i++){
    E_min = max(E_min, population[i].fitness);
 }
}

final float randomsq (float a){
 return random(-1,1)*random(-1,1)*a;  
};
