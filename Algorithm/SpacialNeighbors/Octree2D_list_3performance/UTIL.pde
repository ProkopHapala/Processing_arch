String toBin(int ii){
 String s = "";
 for (int i=0; i<32; i++){
  if((ii&0x01)==0){s="0"+s;}else{s="1"+s;}
  ii=ii>>1;
 };
 return s;
};


String binIntend(int depth){
  char[]arr = new char[depth*m];
  //Arrays.fill(arr, ' ');
  Arrays.fill(arr, '_');
  return new String( arr ).intern();
}

void PaintGrid(){
for(int j=max_depth;j>0;j--){
  int nn = 1<<(j*m);
  stroke (80*j, 80*j);
  float dx = sz/( float )nn;
  for (int ix=0; ix<nn; ix++){
    float xx=dx*ix;
    line (0,xx,sz,xx);
    line (xx,0,xx,sz);
  }
}
}


int countInRange_simple( LinkedList <PVector> myList, float range){
  int c=0;
  for (PVector p1 : myList){
     for (PVector p2 : myList){
       if (p1!=p2){
          nComparisons++;
          if(p1.dist(p2)<range) c++;
        }  }  }
  return  c;
}


int countInRange(Tree2D myTree, float range ){
int c=0;
int n=1<<(m*myTree.depth);
int di = 0x7FFFFFFF/n; 
LinkedList<LinkedList> toLists = new LinkedList(); 
for (int ix=di; ix<(0x7FFFFFFF-di); ix+=di){
  for (int iy=di; iy<(0x7FFFFFFF-di); iy+=di){
    LinkedList<PVector> from = myTree.getLeafsInt( ix,iy  ); 
    if (from!=null){   
      toLists.clear();
      myTree.getLeafsRangeInt( ix-di,iy-di,   ix+di,iy+di,    toLists );
      for (LinkedList<PVector> to : toLists)
        for (PVector p1 : from){
         for (PVector p2 : to){
           if (p1!=p2){
              nComparisons++;
              if(p1.dist(p2)<range) c++;
      }  }  } 
    }   
  }
}   
return c;
}


