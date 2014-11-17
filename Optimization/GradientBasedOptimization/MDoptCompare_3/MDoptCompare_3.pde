
static int sz = 400;

static float zoom   = 150;
static float fscale = 0.2;

float wE  =   0.4;
float xk0 =  -1.8;
float k   =   0.025;

float xl0 = 0.0;
float wl  = 0.4;

float   dt_start = 0.15;
float damp_start = 0.1;

final float [] xs0 = { 1.8, 1.0 };
//final float [] xs0 = { 0.5, 0.0 };

PImage img_val, img_grad; 
PFont myFont;

OptMD    optMD,optFIRE,optFIRE_2,optFIRE_3,optFIRE_o,optFIRE_sd,optMDp,   optFocused;
ScalarFunction func;
ScalarFunctionLine testFuncLine;

boolean stop=false;

float ftol = 0.001;     float f2tol = ftol*ftol;
int iter=0;

float Emin;



void setup() { 
  size(800, 800);
  //size(sz*2, sz*2);
  colorMode(RGB,1.0);	
  frameRate(5);
  img_val  = new PImage ( width, height );
  img_grad = new PImage ( width, height );
  //func   = new testFunc_invRad(); 
  //func   = new testFunc_Rosenbrok();
  //func   = new testFunc_LambertValley         ( wE,xk0,k,  xl0, wl        );
  //func   = new testFunc_PolyLambertValley     ( wE,xk0,k                  );
  //func   = new testFunc_SinLambertValley             ( wE,xk0,k,   xl0, wl, 4.0  );
  func   = new testFunc_HermiteSplineValley   ( wE,xk0,k, 100             );
    
  func.toImage( img_val, img_grad );
  optMD      = new OptMD      ( dt_start, damp_start, xs0, func  );   optMD     .kickStart(0.1);     stroke(0.5,0,0);   optMD  .plot( );
  optFIRE    = new Opt_FIRE   ( dt_start, damp_start, xs0, func  );   optFIRE   .kickStart(0.1);     stroke(0,0.5,0);   optFIRE.plot( );
  optFIRE_o  = new Opt_FIRE_o ( dt_start, damp_start, xs0, func  );   optFIRE_o .kickStart(0.1);     stroke(1,0.5,0);   optFIRE_o.plot( );
  optFocused = optFIRE;
  
  image( img_val, 0, 0 ); 
  myFont = createFont("Georgia", 10);
  fill(1,0,0); text(" damped MD"  ,   20,20 );
  fill(0,0.5,0); text(" FIRE MD"    , 20,40 );
  fill(1,0.5,0); text(" FIRE ortho" , 20,60 );
  
  // finding global minimum by linesearch
  testFuncLine = new ScalarFunctionLine ( func, 2 );
  testFuncLine.x0 = new float[]{xk0,-4};
  testFuncLine.dx = new float[]{ 0,  8};
  stroke(1,0,0); 
  float abest  = lineSearch_brent_prokop ( 0, 1, 0.00001 );
  //float amin    = 0; float amax = 1; float astart=0.5*(amin+amax);
  //float Estart  = testFuncLine.eval( astart );
  //float abest   = lineSearch_golden( amin,astart,amax,Estart,0.00001);
  Emin    = testFuncLine.eval( abest );
  println( " amin "+abest+" Emin "+Emin+" xs_min "+testFuncLine.xs[0]+" "+testFuncLine.xs[0] );
}

void draw() {

  if(!stop){ 
    iter++;    
    stroke(1.0); point( iter, 100 );
    //optMD    .move();   stroke(1,0,0);   optMD    .plot( );                
    optFIRE  .move();   stroke(0,0.5,0);   optFIRE  .plot( );  
    optFIRE_o.move();   stroke(1,0.5,0); optFIRE_o.plot( );    
    //println( iter+"  "+optMD.f2+" "+optMD.fs[0]+" "+optMD.fs[1] );   
    //println( iter+"  "+optFIRE_o.f2+" "+optFIRE_o.fs[0]+" "+optFIRE_o.fs[1] );     
    if (optFocused.f2 < f2tol ){
      println( " Coverged !!! " );
      println( " Emin : "+optFocused.E+" F rest: "+sqrt(optFocused.f2)  );
      noLoop();
    }
  }
 
} 

void keyPressed(){
 if(key==' ')stop=!stop;
 if(key=='v')image( img_val,  0, 0 );
 if(key=='g')image( img_grad, 0, 0 );
};

void mousePressed(){
  stroke(255,255,0); 
  func.plotGrad(mouseX, mouseY);
}



