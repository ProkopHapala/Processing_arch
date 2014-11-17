
void evolve_randomWalk(){
 for(int i=0;i<ngens;i++){
   temp.mutate_random(population[i], 0.5);
   while(!temp.reasonable()){
        temp.mutate_random(population[i], 0.5);
   }
   stroke(0,255,0);
   point( toSc(temp.DNA[0]) , toSc(temp.DNA[1]) );
   evalFitness(temp);
   if (temp.fitness > population[i].fitness ){
       stroke (255,0,0);
       lineGene(population[i],temp);
       population[i].clone(temp);
       println ("Evaulations: " + nEvaluations + "  E = " + population[0].fitness );
     }
 }
}


void init_random(){
 for(int i=0;i<ngens;i++){
   population[i] = new Gen(new float[lgen]); 
   population[i].combine_random(mingen,maxgen);
   evalFitness(population[i]);
 }
}

