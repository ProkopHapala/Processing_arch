
import java.util.Random;

final static int n = 500;

final static int maxIters = 8*n;
static int iters=0;
final static double maxErr = 1e-9d;
final static double maxErr2 = maxErr*maxErr;
static double err2;

Random rnd; //= new Random(seed);

 double [][] A     = new double[n][n];
 double []   b     = new double[n];
 //double []   b     = new double[]{ 1,1,1,1,1,1,1,1,1 };
 double []   x     = new double[n];
 double []   xold  = new double[n];
 double []   xx    = new double[n];
 
 // ========== GaussPivoting (it affects the input A, b )
 double [][] A2    = new double[n][n]; 
 double []   b2    = new double[n];
 double []  xTrue  = new double[n]; 
 int    []  index  = new int[n];  
 
 SparseMatrix ASparse;
 
 long t1,t2;
 
void setup(){  
 println( " problem dimension = "+n  );
 rnd = new Random( 158 );
 addRandomVec( 0, 1.0d,b );
 println ( " b    = "+vec2string(b) );
 
 println( "dot(b,b)      "+dot(b,b) );
 println( "dot_SIMD(b,b) "+dot_SIMD(b,b) );
 
 frameRate( 1);
}

void draw(){
 println( " >>>>> Frame:"+frameCount ); 
 
 
 set( 0, A ); 
 addRndDiag( 1, 0, A );
 addRndPosSym  ( 0.0d, 0.3d, A );
 addRndPosSym  ( 0.0d, 0.3d, A );
 addRndPosSym  ( 0.0d, 0.3d, A );
 //addRndNoiseSym( 0.0d, 0.01d, A );
 

 //addRndPosSym( 0.0d, 0.2d, A ); 
 if( ASparse==null ){ ASparse=new SparseMatrix(A); }else{    ASparse.fromMat(A);  }
 
 //println( " A= "); printMat( A );
 //println( " ASparse= "); ASparse.printFull();

 //println("=========== Gauss pivoting ");
 System.arraycopy( b, 0, b2, 0, b.length );
 copy(A,A2 );
 t1 = System.nanoTime(); 
 solve(A2, b2, xTrue, index);
 t2 = System.nanoTime();
 println( "Gauss elimination  time:"+((t2-t1)*1.0e-6d )+" [ms] " );
 
 //println( "=========== Gauss-Seidel "  );
 t1 = System.nanoTime();  
 diagonalEstimate( A, b, x, 1e-6 );
 //println ( " xEstimate = "+vec2string(x) );
 for (iters=0; iters<maxIters; iters++){
   gaussSeidelStep( A, b, x );
   //err2 = dist2( x, xold );
   err2 = dist2( x, xTrue );
   //println ( i+" err       = "+ Math.sqrt(err2) );
   //println ( i+" xGS       = "+ vec2string(x)    );
   if( err2<maxErr2) break;
   //System.arraycopy(x,0,xold,0,x.length );
 }
 t2 = System.nanoTime();
 //println ( " xGS       = "+vec2string(x) );
 println( "GS       iter:"+iters+" time: "+((t2-t1)*1.0e-6d )+" [ms] err: "+Math.sqrt(err2) );
 
 double omega = 1.20d;
 //println( "=========== Successive Over-Relaxation (SOR) omega="+omega  );
 t1 = System.nanoTime();
 diagonalEstimate( A, b, x, 1e-6 );
 //println ( " xEstimate = "+vec2string(x) );
 for (iters=0; iters<maxIters; iters++){
   SORStep( A, b, x, omega);
   //err2 = dist2( x, xold );
   err2 = dist2( x, xTrue );
   //println ( i+" err       = "+ Math.sqrt(err2) );
   //println ( i+" xGS       = "+ vec2string(x)    );
   if( err2<maxErr2) break;
   //System.arraycopy(x,0,xold,0,x.length );
 }
 t2 = System.nanoTime();
 //println ( " xGS       = "+vec2string(x) );
 println( "SOR("+omega+") iter:"+iters+" time: "+((t2-t1)*1.0e-6d )+" [ms] err: "+Math.sqrt(err2) );
 
 //println( "=========== CG "  );
 t1 = System.nanoTime();
 diagonalEstimate( A, b, x, 1e-6 ); 
 CG(  A, b, x );
 t2 = System.nanoTime();
 //println ( " xGS       = "+vec2string(x) );
  println( "CG       iter:"+iters+" time: "+((t2-t1)*1.0e-6d )+" [ms] err: "+Math.sqrt(err2) );
  
 //println( "=========== CG "  );
 t1 = System.nanoTime();
 diagonalEstimate( A, b, x, 1e-6 ); 
 CG_SIMD(  A, b, x );
 t2 = System.nanoTime();
 //println ( " xGS       = "+vec2string(x) );
  println( "CG_SIMD iter:"+iters+" time: "+((t2-t1)*1.0e-6d )+" [ms] err: "+Math.sqrt(err2) );
 
 t1 = System.nanoTime();
 diagonalEstimate( A, b, x, 1e-6 );
 ASparse.CG( b, x, maxIters, maxErr2 );
 t2 = System.nanoTime();
 println( "CGsparse iter:"+iters+" time: "+((t2-t1)*1.0e-6d )+" [ms] err: "+Math.sqrt(err2) );

 //noLoop();
}

