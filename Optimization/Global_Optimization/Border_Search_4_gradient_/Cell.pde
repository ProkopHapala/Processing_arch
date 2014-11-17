
int lgen = 2;   // 2D dimensional genes

class Cell{

float   [] Pos;
Cell relaxTo;
Cell [] NeighSampled;
boolean aLive;
float fitness;

Cell( float[] Pos_ ){
Pos = Pos_;
aLive = true;
NeighSampled = new Cell[Pos.length*2];
fitness = getEnergy(Pos[0], Pos[1]);
}






//                            //
//          UTILS             //
//                            //

final int getFreeDirection(){
  int direction=-1;
  for(int i=0;i<NeighSampled.length;i++){
    // println(NeighSampled[i]);
     if (NeighSampled[i]==null){ direction=i; break; }
  }
  return  direction;
}

Cell getFreeNeigh(float dx){
 int direction = getFreeDirection();
 //println ("Free direction: "+direction);
 if (direction>=0){
   float [] newPos = new float[Pos.length];
   arraycopy(Pos,newPos);
   if (direction<Pos.length){
      newPos[direction           ]+=dx;
   }else{
      newPos[direction-Pos.length]-=dx;
   }
   Cell New = new Cell(newPos);
   return New;
 }
 else {return null;}
}

final int isNeigh(Cell Of, float step){
  boolean bol = true;
  float r1 = 0.5*step;
  float r2 = 1.5*step;
  int direction=-1;                   // -1 if Cells are identical
  for(int i=0;i<Pos.length;i++){
    float dx=Pos[i]-Of.Pos[i];
    //print ("dx("+i+")="+dx+" ");
    float absdx = abs(dx);
    if (absdx>r2){return -3;}               //  -3 if too far?
    else if(absdx>r1){                      //  is this the direction?
        if(direction>=0){return -2;}        //  is there any other direction? 
        else{
          if (dx>0){
            direction=i;
          }else{
            direction=i+Pos.length;
          }
        }
    }
 } 
  return direction;
}

final boolean isAlive(){
  boolean bol = false;
  for(int i=0;i<NeighSampled.length;i++){
    if (NeighSampled[i]==null){bol = true;break;}
  }
  return bol;
}

////////////////////////////////
////////////////////////////////

/*
String toString(){
 String s = " "+fitness+ " | " + aLive + " | ";
 for(int i=0;i<Pos.length; i++ ){
 s = s + " " + Pos[i]; }
 s = s + " | ";
 for(int i=0;i<NeighSampled.length;i++){
   if (NeighSampled[i]!=null){
    s = s + " true "; 
   }else{
     s = s + " false "; 
   }
 }
 return s;
}
*/

}


