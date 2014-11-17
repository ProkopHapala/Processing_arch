
/////////////////////
//    Aglorithm    //
/////////////////////


void evolve_randomWalk(){
 for(int i=0;i<ngens;i++){
   if (population[i].aLive){
      mutate_local(population[i]);
   }else {   // not aLive
      mutate_global(population[i]);                        
   }                                                       println ("Evaulations: " + nEvaluations + "  E = " + population[0].fitness );
 }                               
  KillWorse();
}


void mutate_local(Gen Old){
   float frustration = (maxFitness - Old.fitness)/dFitness;
   float stepLength  = stepMin + frustration*stepRange;
   temp.mutate_random(Old, stepLength);
   while(!temp.reasonable()){
        temp.mutate_random(Old, 0.5);
   }                                                       stroke(0,255,0);  point( toSc(temp.DNA[0]) , toSc(temp.DNA[1]) );
   evalFitness(temp);
   if (temp.fitness > Old.fitness ){                       stroke (255,0,0); paintGeneConection(Old,temp);
       Old.clone(temp);                          
     }
}

void mutate_global(Gen Old){
   temp.combine_random( mingen,maxgen);          
   while(!temp.reasonable() || CloseToAny( temp )){     // New gene must be 1) reasonable 2) not to close to any other
        temp.combine_random( mingen,maxgen);
   }                                                       stroke (0,0,255); paintGeneConection(Old,temp);
   Old.clone(temp);
   evalFitness(Old);
}


///////////////////
//     Utils     //
///////////////////

void init_random(){
 for(int i=0;i<ngens;i++){
   population[i] = new Gen(new float[lgen]); 
   population[i].combine_random(mingen,maxgen);
   evalFitness(population[i]);
 }
}

final void KillWorse(){
   for(int i=0;i<ngens;i++){         
     if (population[i].fitness <  (maxFitness - dFitness) ){    // kill agent of to High Energy
         population[i].aLive = false;                  println ("kill "+i+" E="+(-population[i].fitness)+" E_min="+(-maxFitness) );
     }else{
        for(int j=0;j<i;j++){
           if(population[i].toClose(population[j])){
             if(population[i].fitness>population[j].fitness){
                population[j].aLive=false;
             }else{
                population[i].aLive=false;
             }
           }
        }
     }   
   }
}

final boolean CloseToAny( Gen Of ){
  boolean Is=false;
   for(int i=0;i<ngens;i++){
     if( Of.toClose(population[i]) ){Is=true; break; }    
   }
  return Is;
}

