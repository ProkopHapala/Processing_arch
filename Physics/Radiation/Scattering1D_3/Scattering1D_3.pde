
Cell A, B1,B2,B3;

Layer L1, L2, L3;

static float pointScale = 5;
static float rayScale   = 5;

final static double [] mask = { 1.0d,2.0d,1.0d };

void setup(){
  size(800,800);
  noSmooth();
  tempRay = new double [nPhi];

 
  L1 = new Layer(   0, -10,10,    3,  5, mask  );
  L2 = new Layer( 200, -50,50,   11,  5, mask  );
  L3 = new Layer( 400, -50,50,   11,  5, mask  );
 
  for(int i=0; i<L1.cells.length; i++){ L1.cells[i].rayIn[15] = 100; }
  L1.scatter();
  L2.trace_source( L1 );   L2.scatter();
  L3.trace_source( L2 );   L3.scatter();
  
  translate(400,100);
  
  L1.plot();  L2.plot();  L3.plot();
  
  boolean byPoint = false;
  
  stroke(255,0,0); L1.plotRayIn(byPoint);   L2.plotRayIn(byPoint);  L3.plotRayIn(byPoint);  
  stroke(0,0,255); L1.plotRayOut(byPoint);  L2.plotRayOut(byPoint); L3.plotRayOut(byPoint);
  
  //println( vec2string(L2.cells[5].ray) );
  
  
  println( "======== L1 " );
  L1.printCheckSum ( ); 
  println( "======== L2 " );
  L2.printCheckSum ( ); 
  println( "======== L3 " );
  L3.printCheckSum ( );
   
}


