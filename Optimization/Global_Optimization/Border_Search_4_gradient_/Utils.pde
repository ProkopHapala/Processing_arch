
/*
void getEmin(){
 stroke(255,0,0);
  for(int i=0;i<ngens;i++){
    E_min = max(E_min, population[i].fitness);
 }
}
*/

final int getBestCell(){
  float Emin = 100000000;
  int iBest = -1;
  //println (SampledCells.size());
  for ( int i=0; i<SampledCells.size(); i++){
    Cell C = (Cell) SampledCells.get(i);
    //println ("===" + C.aLive + " " + C.fitness);
   // println("  getBest: "+i+" "+C.fitness);
    if ( C.aLive )                                              // is alive?
       if ( C.fitness < Emin ){ iBest=i;  Emin=C.fitness; }     // is Better?
  }
  return iBest;
}


final void updateNeighs(Cell Of, float step){
  for ( int i=0; i<SampledCells.size(); i++){
    Cell C = (Cell) SampledCells.get(i);
    int direction=Of.isNeigh(C, step);    // is Neighbor? in Which direction?
    //println(" isNeigh: "+direction+"   New( "+Of+" )    Old["+i+"]( "+C+" )");
    if (direction>=0){                   // If is Neighbor
      if (direction<Of.Pos.length){
        Of.NeighSampled[direction+Of.Pos.length]=C;
        C .NeighSampled[direction              ]=Of;    // oposite direction
      }else{
        Of.NeighSampled[direction-Of.Pos.length]=C;
        C .NeighSampled[direction              ]=Of;    // oposite direction
      }
    }
  }
  for ( int i=0; i<SampledCells.size(); i++){   // kill the surrounded
    Cell C = (Cell)SampledCells.get(i);
    C.aLive = C.isAlive();
  }
}


Cell cellInPos( float x, float y ){
 // println("   "+x+"  "+y);
  for ( Object O :  SampledCells){
    Cell C = (Cell)O;
    float dx = x - C.Pos[0];
    float dy = y - C.Pos[1];
    //println("      "+C.Pos[0]+"  "+C.Pos[0]+" "+dx+" "+dy);
    if ((  abs(dx)<halfstep )&&(  abs(dy)<halfstep )){ 
      //    println( "Ret");
      return C;
    }
  }
  return null;
}
