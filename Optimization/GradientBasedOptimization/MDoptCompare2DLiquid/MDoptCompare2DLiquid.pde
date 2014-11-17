
static int sz = 400;

static float zoom   = 20;
static float fscale = 1.0;
static float vscale = 0.2;

float   dt_start = 0.03;
float damp_start = 0.1;

PFont myFont;

OptMD    optMD,optFIRE,optFIRE_2,optFIRE_3,optFIRE_o,optFIRE_sd,optMDp,   optFocused;

OptProblem problem;
float [] xs0;
int natoms = 200;

boolean stop=false;

float ftol = 0.001;     float f2tol = ftol*ftol;
int iter=0;

float EminGlob;
int perFrame = 5; 

PGraphics overlay;

void setup() { 
  size(800, 800);
  //size(sz*2, sz*2);
  colorMode(RGB,1.0);	
  frameRate(10);
  overlay = createGraphics(width,height);
  
  xs0              = new float [natoms*2];
  float [] fs_test = new float [xs0.length];
  problem          = new Problem_Argon2D();
  problem.genInitialState( xs0  );
  problem.evaluate  ( xs0,      fs_test );
  problem.plotState ( 0,0,xs0, xs0, fs_test );
  
  noFill();
  
  optMD      = new OptMD      ( dt_start, damp_start, xs0, problem  );  optMD     .kickStart( dt_start );  optMD    .clr=color(1.0,0,0  ); 
  optFIRE    = new Opt_FIRE   ( dt_start, damp_start, xs0, problem    );  optFIRE   .kickStart( dt_start );  optFIRE  .clr=color(0.0,0.5,0); 
  optFIRE_o  = new Opt_FIRE_o ( dt_start, damp_start, xs0, problem    );  optFIRE_o .kickStart( dt_start );  optFIRE_o.clr=color(0.5,0.5,0); 
  optFocused = optMD;
  
  myFont = createFont("Georgia", 10);
}

void draw() {
  background(1.0);

  if(!stop){ 
    for (int i=0;i<perFrame;i++){
      iter++;    
      optMD    .move();                  
      optFIRE  .move();  
      optFIRE_o.move();   
      EminGlob=min(EminGlob,optMD.E); 
      EminGlob=min(EminGlob,optFIRE.E); 
      EminGlob=min(EminGlob,optFIRE_o.E);  
      if (optFocused.f2 < f2tol ){
        println( " Coverged !!! " );
        println( " Emin : "+optFocused.E+" F rest: "+sqrt(optFocused.f2)  );
        noLoop();
      }
    }
  overlay.beginDraw();
  optFIRE_o.plot( );   problem.plotState ( +200,-200, optFIRE_o );  
  optFIRE  .plot( );   problem.plotState ( +200, 100, optFIRE ); 
  optMD    .plot( );   problem.plotState ( -200, 100, optMD );
  overlay.endDraw();
  image(overlay,0,0);
  }
} 

void keyPressed(){
 if(key==' ')stop=!stop;
};



