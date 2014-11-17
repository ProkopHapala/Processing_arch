
final int [] xs = {-1,+1, 0, 0,  -1,+1 };
final int [] ys = { 0, 0,-1,+1,  -1,+1 };

class PosBuff{
  int n;
  int [] x,y;
  PosBuff(){};
  PosBuff(int nn){x=new int[nn]; y=new int[nn]; n=0;}
  void put(int ix, int iy){x[n]=ix;y[n]=iy;n++;}
}

void swap(Object A, Object B){ Object C; C = A; A = B; B = C; };

class DistMap{
float [][] fromA, PosTimes;
PosBuff lastPos, newPos;
float MinNewTime, TimeMax;
int MaxSteps=20;

DistMap( PosBuff starts, float [][] PosTimes ){
  this.PosTimes=PosTimes;
  this.lastPos=starts;
  fromA = new float [PosTimes.length][PosTimes[0].length];
  newPos = new PosBuff( lastPos.x.length );
  reset(); // fill fromA by POSITIVE_INFINIT; 
  for (int i=0; i<lastPos.n; i++){ fromA[lastPos.x[i]][lastPos.y[i]]=0.0;  } //fill start pos by zero 
}
void reset( ){ for (int ix=0; ix<fromA.length; ix++){  for (int iy=0; iy<fromA[0].length; iy++){ fromA[ix][iy]=Float.POSITIVE_INFINITY; }}; };

void Propagate( ){
for (int istep=0; istep<MaxSteps; istep++){
  PropagateStep();
  if (lastPos.n==0) break; // no new position found
}
}

void PropagateStep( ){
  //println(lastPos.n);
  newPos.n=0;
  for (int ii=0; ii<lastPos.n; ii++){
    expandPoint( lastPos.x[ii], lastPos.y[ii] );
  }
  //println (" newPos.n =  "+ newPos.n );
  PosBuff temp = lastPos; lastPos=newPos; newPos=temp; 
}

void expandPoint( int ix, int iy ){
 //println (" -- "+ix+" "+iy+" "+fromA[ix][iy] +" "+ PosTimes[ix][iy]  );
 float timeX =  fromA[ix][iy] + PosTimes[ix][iy]; // total time taken by this road   
 if (timeX<TimeMax){ 
   for (int ii=0; ii<xs.length; ii++){ // go arround neighborhood
     int iix = ix+xs[ii]; int iiy = iy+ys[ii];
     //println (" ---- "+iix+" "+iiy+" "+fromA[iix][iiy] +" "+ timeX );
     if ( fromA[iix][iiy] > timeX ){
       //println(" ------ put ");
       fromA[iix][iiy] = timeX;
       newPos.put(iix,iiy); // update list of new positions
     }
   }
 }
}

}
