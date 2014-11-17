
final int sz = 400;
final int sz2 = 2*sz;
final float pixsz = 1.0/(float)sz;


final void paintCell(Cell C){
  //noStroke();
  ellipse ( C.Pos[0]*sz +sz , C.Pos[1]*sz + sz  ,4,4);
}

final void  paintAllCells(){
  //println( "BEGIN paintAllCells  " );
  for ( int i=0; i<SampledCells.size(); i++){
    Cell C = (Cell) SampledCells.get(i);
    if(C.aLive){fill(255);}else{fill(128);}
    paintCell(C);
    //println("   "+C);
  }
    //println( "END paintAllCells  " );
    //println();
}


