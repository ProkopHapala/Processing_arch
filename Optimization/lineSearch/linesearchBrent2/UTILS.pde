
float sX(double x){  return (float)((x/xzoom)*sz+sz); }
float sY(double y){  return (float)(800-(y*sz+sz)); }

void paintPoly( double [] cs ){
 float oy = sY(testfunc(  xzoom*(-sz)/float(sz)   )); 
  for (int i=1; i<width; i++){ 
     float y = sY(testfunc(  xzoom*(i-sz)/float(sz)   ));
   //println (E+" "+y);
   line( i-1, oy , i, y  );
   oy = y;
  }
}
