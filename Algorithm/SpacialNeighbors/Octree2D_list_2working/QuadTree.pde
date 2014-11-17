
class Tree2D extends Branch2D{
 
float offx = 0.0;
float offy = 0.0;
float Lx = 1.0;
float Ly = 1.0;
int depth=3;

final int x2int ( float x ){
  return int (  ((x - offx)/Lx)*0x7FFFFFFF    );
};

final int y2int ( float y ){
  return int (  ((y - offy)/Ly)*0x7FFFFFFF    );
};

LinkedList getLeafs(float x, float y){
  //float xx = (y - offy);
  //float yy = (y - offy);
  //if ((xx>0.0)&&(xx<Lx)&&(yy>0.0)&&(y<Lx)){
   return getLeafsInt( x2int(x),  y2int(y));
  //}
}

//LinkedList<LinkedList> 
void getLeafsRange(float xmin, float ymin, float xmax, float ymax, LinkedList<LinkedList> out ){
//return 
iRec = 0;
getLeafsRangeInt(
x2int(xmin),y2int(ymin),
x2int(xmax),y2int(ymax),
out );
}


void addObject(Object o, float x, float y){
 addObject(o,x2int(x),y2int(y),depth);
}

void setBranch(Branch2D b, float x, float y){
 setBranch( b,x2int(x),y2int(y), depth );
}

Tree2D(float offx, float offy, float Lx, float Ly, int depth){
this.Lx=Lx; this.Ly=Ly; this.offx=offx; this.offy=offy; this.depth=depth;
}

  
}


