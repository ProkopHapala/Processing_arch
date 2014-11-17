
final static int m  = 2;
final static int mm = 31-m;
final static int n  = 1<<m; 

class Nod{
boolean filled = false;
Nod [][][] subs; // = new Nod[n][n];

int isIn(int ix, int iy){
  ops++; 
  if(subs!=null){
    int depth = Integer.MAX_VALUE;
    int iix = ix>>mm;
    ix = (ix<<m)&0x7FFFFFFF; 
    int iiy = iy>>mm; 
    iy = (iy<<m)&0x7FFFFFFF; 
    int iiz;
    for (iiz=0;iiz<n;iiz++){
      if( subs[iix][iiy][iiz]!=null ){  
        int d = subs[iix][iiy][iiz].isIn(ix,iy); 
        if (d<Integer.MAX_VALUE){     
          depth = ( iiz<<mm )  +  ( subs[iix][iiy][iiz].isIn(ix,iy)>>m );
          break;
        }        
      } else { 
        if( filled ){  
          depth = iiz<<mm ;
          break; 
        }
      }
    }
    return depth;
  }else{
    if (filled){
      return  0;
    } else{
      return  Integer.MAX_VALUE;
    }
  }
}






Nod(){
nNods++;
};

}
