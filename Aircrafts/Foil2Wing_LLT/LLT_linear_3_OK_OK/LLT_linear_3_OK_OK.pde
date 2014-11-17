

Wing W;


void setup(){
  size(800,800);
  textFont(createFont("LucidaConsole",11));
 // W = new Wing( 50, 10, 1.0, 0.3 );
};

void draw(){
  int ialfa=2;
  // for (int ialfa=0;ialfa<4;ialfa++){
  //  double c0=0.1; 
 for (float c0=0.05;c0<0.5;c0+=0.05){  
    W = new Wing( 50, 11, 1.0, c0 );  
    fill(255,50); rect(0,0,800,800);
    W.Solve_LLT( ialfa);
    W.plot( ialfa);
  }
  noLoop();
};
