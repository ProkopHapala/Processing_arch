
final static int m  = 2;
final static int mm = 31-m;
final static int n  = 1<<m; 

class Branch2D{
Branch2D [][] subs; // = new Nod[n][n];
LinkedList leafs;

LinkedList getLeafsInt(int ix,int iy){
    nBranchOps++; // debug
  iRec++;
  println();
  print( binIntend(iRec) + toBin(ix) );  
  if(subs!=null){
    int iix = ix>>mm;
    ix = (ix<<m)&0x7FFFFFFF; 
    int iiy = iy>>mm; 
    iy = (iy<<m)&0x7FFFFFFF; 
    //println( toBin(iix)+" "+toBin(ix) );
    if(   subs[iix][iiy]!=null  ){
      return subs[iix][iiy].getLeafsInt(ix,iy);
    }else {return leafs;}
  } else {return leafs;}
}








//LinkedList<LinkedList> 
void getLeafsRangeInt( int ixmin, int iymin, int ixmax, int iymax, LinkedList<LinkedList> out ){
    nBranchOps++;   // debug
    iRec++;
    println();
    print( binIntend(iRec) + toBin(ixmin)+" "+ toBin(ixmax) );

  if (leafs!=null) out.add(leafs);
  if(subs!=null){
    int iixmin = ixmin>>mm;
    int iixmax = ixmax>>mm;
      int iiymin = iymin>>mm;
      int iiymax = iymax>>mm;
    //print( binIntend(5-iRec)+ " "+ iix+" "+iixmax );
    
    ixmin = (ixmin<<m)&0x7FFFFFFF; 
    ixmax = (ixmax<<m)&0x7FFFFFFF;     
      iymin = (iymin<<m)&0x7FFFFFFF; 
      iymax = (iymax<<m)&0x7FFFFFFF; 
    
    int iix    = iixmin; 
    int ixmin_ = ixmin;
    int ixmax_ = 0x7FFFFFFF;
    boolean loopX=true;
    print( " xloop " ); 
    do{
     // print (" "+iix+"-"+iixmax);
      if (iix>=iixmax){   ixmax_ = ixmax; loopX=false;}
    
      int iiy = iiymin;
      int iymin_ = iymin;
      int iymax_ = 0x7FFFFFFF;
      boolean loopY=true; 
      print( " yloop " ); 
      do{  
          print( " | "+iix + "  " + iiy );
          if (iiy>=iiymax){    iymax_ = iymax;  loopY=false;}              
          if(   subs[iix][iiy]!=null  )
            subs[iix][iiy].getLeafsRangeInt(ixmin_,iymin_,ixmax_,iymax_, out );
          iiy++;
          iymin_ = 0;  
        }while (loopY);
        
      iix++;
      ixmin_ = 0;
    }while(loopX);
  }
  iRec--;
  print( " return"+iRec );
  //return out;
}










void addObject( Object o, int ix, int iy, int depth){
  println( binIntend(5-depth) + toBin(ix) );
  if (depth>0){
    if(subs==null) { subs=new Branch2D[n][n];
       nFields+=(n*n);   //debug;
       //println( "new Branch2D[n][n] " + nFields );
    } 
    int iix = ix>>mm;
    ix = (ix<<m)&0x7FFFFFFF; 
    int iiy = iy>>mm; 
    iy = (iy<<m)&0x7FFFFFFF; 
    if( subs[iix][iiy]==null  ) subs[iix][iiy]=new Branch2D();
    subs[iix][iiy].addObject(o,ix,iy,depth-1);
  }else{
   if (leafs==null) leafs=new LinkedList();
   leafs.add(o);
   nPoints++;
  }
}

void setBranch( Branch2D b, int ix, int iy, int depth ){
  if(subs==null){ subs=new Branch2D[n][n];
      nFields+=(n*n);   //debug;
  } 
  int iix = ix>>mm;
  int iiy = iy>>mm; 
  if (depth>1){
    ix = (ix<<m)&0x7FFFFFFF; 
    iy = (iy<<m)&0x7FFFFFFF;
    if( subs[iix][iiy]==null  )subs[iix][iiy]=new Branch2D();
    subs[iix][iiy].setBranch(b,ix,iy, depth-1);
  }else{
    subs[iix][iiy] = b;
  }  
}


Branch2D(){
 nBranches++;
}


}
