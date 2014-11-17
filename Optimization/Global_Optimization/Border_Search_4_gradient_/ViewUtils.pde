
final int sz = 400;
final int sz2 = 2*sz;
final float pixsz = 1.0/(float)sz;


final void paintCell(Cell C){
  //noStroke();
  ellipse ( C.Pos[0]*sz +sz , C.Pos[1]*sz + sz  ,8,8);
  if(C.relaxTo!=null){  line( C.Pos[0]*sz +sz , C.Pos[1]*sz + sz,  C.relaxTo.Pos[0]*sz +sz , C.relaxTo.Pos[1]*sz + sz   );  };
  
}

final void  paintAllCells(){
      println(  "=================" );
  //println( "BEGIN paintAllCells  " );
  for ( Object O : SampledCells ){
    Cell C = (Cell)O;
    //println(  C.Pos[0]+" "+ C.Pos[1]);
    if(C.aLive){
      //fill(255);
      fill(255,0,0);
      stroke(128);
    }else{
      fill(0);
      stroke(128);
      }
    paintCell(C);
    //println("   "+C);
  }
    //println( "END paintAllCells  " );
    //println();
}


