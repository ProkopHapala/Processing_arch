
final float xzoom=4;
final int sz=400;


final float xtolerance=0.001;
int nEvals=0;
float xmin = -3;
float xmax = +3;


void setup(){
  size (sz*2,sz*2);
  float oy = sY(testfunc(  xzoom*(-sz)/float(sz)   ));   
  for (int i=1; i<width; i++){ 
   float y = sY(testfunc(  xzoom*(i-sz)/float(sz)   ));
   //println (E+" "+y);
   line( i-1, oy , i, y  );
   point(i,sz);
   oy = y;
  }
  
  stroke(255,0,0);
  line(sX(xmin),0,sX(xmin),sz);
  line(sX(xmax),0,sX(xmax),sz);
  nEvals=0;
  //lineSearch_golden     ( xmin,0.5*(xmin+xmax),xmax,testfunc(0.5*(xmin+xmax)),xtolerance);
  lineSearch_brent_prokop ( xmin, xmax, xtolerance);
  print ("nEvals = "+nEvals);
  
}


double t=1.5;

void draw(){
 
}
