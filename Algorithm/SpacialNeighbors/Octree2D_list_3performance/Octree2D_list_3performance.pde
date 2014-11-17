
final static int sz=900;
final static int sz2int = Integer.MAX_VALUE/sz;


//Branch2D A = new Branch2D();

Tree2D myTree;


LinkedList<PVector> simpleList; 

int max_depth = 2;


int nPoints=0;
int nBranches=0;
int nFields=0;
int nBranchOps=0;
int nPointsGot=0;

int iRec = 0;

int nComparisons=0;

/*
float xmin = 200;  float ymin = 200;
float xmax = 300;  float ymax = 300;
*/

/*
float xmin = 128;  float ymin = 128;
float xmax = 353;  float ymax = 256;
*/

float xmin, ymin, xmax,ymax;

/*
float xmin = 128;  float ymin = 128;
float xmax = 395;  float ymax = 395;
*/


void setup(){
  
 size(sz,sz);
 smooth();
 frameRate(10);
 background(255);
 myTree = new Tree2D( 0, 0,   sz,sz,  max_depth);
 simpleList = new LinkedList();
 
 randomSeed(16); 
 xmin = random(sz);       ymin = random(sz);
 xmax = random(xmin,sz);  ymax = random(ymin,sz);
 //myTree.addObject(new PVector(200,200),200,200 );
 
 PVector o =new PVector(xmin,ymin);
 myTree.addObject( o,o.x,o.y );
 for (int i=0;i<5000;i++){
   
   PVector temp = new PVector(   
   constrain (o.x + random(-5,5)   , 0,  myTree.Lx ) ,
   constrain (o.y + random(-5,5)   , 0,  myTree.Ly ) 
   );
 
 
   //PVector temp = new PVector(random(sz),random(sz) );
   myTree.addObject( temp,temp.x,temp.y );
   simpleList.add(temp);
   point( temp.x,temp.y);
   o = temp;
   println();
 }
}

void draw(){
nBranchOps=0;
//background(200);

PaintGrid();

/*
println("==== getLeafs ====");
noStroke();
ellipse(xmin,ymin,5,5);
stroke(0);
strokeWeight(5);
LinkedList<PVector> pointList = myTree.getLeafs( xmin,ymin );
if (pointList!=null){
  beginShape(POINTS);
  //print( " got:  ");
  for (PVector p : pointList){
    //print( "  "+p );
    vertex(p.x,p.y);
  }
  //println( "");
endShape(); 
}else{
 //println( " got Null ");
}
*/

nPointsGot=0;
println();
println("==== getLeafsRange ====");
 noFill();
 stroke(0,0,255);
 strokeWeight(1);
rect(xmin,ymin, xmax-xmin, ymax-ymin);
 stroke(255,0,0);
 strokeWeight(2);
LinkedList<LinkedList> listList = new LinkedList();
//myTree.getLeafsRange( 0.0,0.0, sz,sz, listList );
myTree.getLeafsRange( xmin,ymin, xmax,ymax, listList );
for (LinkedList<PVector> pointList2 : listList){
    beginShape(POINTS);
    //print( " got:  ");
    for (PVector p : pointList2){
      //print( "  "+p );
      nPointsGot++;
      vertex(p.x,p.y);
    }
    //println( "");
  endShape(); 
}


println();
println( 
" n " +n+
" nPoints " +nPoints+
" nBranches " +nBranches+
" nFields " +nFields+
" of " + sq(1<<(m*myTree.depth))+ 
" nBranchOps " +nBranchOps +
" nPointsGot " +nPointsGot
);


nComparisons=0;
int start = millis();
int pair_count=countInRange_simple(simpleList, 5);
int end = millis();
println(" Simple:  pair_count "+  pair_count +" nComparisons "+nComparisons+" time "+(end-start)   + " time/comparisons [ns] " +  ( 1000000.0*(end-start)/ nComparisons )  );


nComparisons=0;
start = millis();
pair_count=countInRange(myTree, 5);
end = millis();
println(" Tree  :  pair_count "+  pair_count +"  nComparisons "+nComparisons+" time "+(end-start)    + "   time/comparisons [ns] " +   ( 1000000.0*(end-start)/ nComparisons )  );


noLoop();

}
