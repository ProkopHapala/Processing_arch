
// =========== Setup

double dt = 0.1;   // time step
double mu = 0.5;  // velocity damping

double function_to_learn( double x, double y ){
  
  double xa = x+2*y+1.5;
  double ya = 2*x-y-1.5;
  double wa = 0.5;
  double La=2*wa/(wa+0.25*xa*xa + ya*ya); 
  double xb = x+0.5;
  double yb = y-0.8;
  double wb = 0.2;
  double Lb=2*wb/(wb + xb*xb + yb*yb); 
  return  La + Lb - 1.0;
  /*
  double r2 = x*x + y*y;
  return 2*r2/(0.25+r2*r2)-1.0;
  */
}

// ============= Variables

BPNN3L myNN;
GenNN3L genBest,genNew;
double [][] examples_in, examples_out;
double [][] correlation;
VectorByMaxAbs [] corelComp;



int ntrain = 500;
int epoch  = 0;

int sz = 300; int sz2 = 2*sz;
float zoom = 50.0; 
boolean viewDots = true;
PFont myFont; 

double oerr;

// ============= Initialization

void setup(){
  size(sz2,300);
  myFont= createFont("Georgia", 10);
  
  genExamples( 800 , 1.8 );
  myNN = new BPNN3L( 2,10,1 );
  correlation  = new double[ myNN.Wih[0].length ][ myNN.Wih[0].length ];
  corelComp    = new VectorByMaxAbs[ myNN.Wih[0].length ];
  for(int i=0; i<corelComp.length; i++ ){  corelComp[i]=new VectorByMaxAbs();  }
  
  genBest = new GenNN3L();
  genNew  = new GenNN3L();

  // ========= Gen1
  randomMatrix( -1.0, 1.0, myNN.Wih );  
  randomMatrix( -2.0, 2.0, myNN.Who );
  println( " training new gen ...." );
  for (int i=0;i<ntrain;i++){
    genBest.fitness  = -myNN.train_epoch( examples_in, examples_out );
  }
  genBest.Wih   = myNN.Wih;
  genBest.Who   = myNN.Who;
  println( "genBest.fittness "  +genBest.fitness );
  myNN.eval ();
  myNN.plot ();
  
  frameRate(1);

}

// ============= Main loop

void draw(){
  
  if(frameCount>1){
  // ========= Gen2
  myNN.Wih=new double [myNN.Wih.length][myNN.Wih[0].length];
  myNN.Who=new double [myNN.Who.length][myNN.Who[0].length];
  randomMatrix( -1.0, 1.0, myNN.Wih );  
  randomMatrix( -2.0, 2.0, myNN.Who );
  println( " training new gen ...." );
  for (int i=0;i<ntrain;i++){
    genNew.fitness = -myNN.train_epoch( examples_in, examples_out );
  }
  genNew.Wih   = myNN.Wih;
  genNew.Who   = myNN.Who;
  println( "genNew.fittness "  +genNew.fitness );
  myNN.eval ( );
  myNN.plot ();
  
  compare_hidden( genNew.Wih, genBest.Wih, correlation );
  //println( " hidden basis correlation: "  );
  //printMat( correlation );
  //plotMat(300,250,5, correlation  );
  makeMap( correlation );
  
  if( genNew.fitness > genBest.fitness ){
    println( " New is better => swaping "  );
    GenNN3L swap = genBest; genBest = genNew; genBest = swap; 
    println( " Best fittness: "  +genBest.fitness );
  }
  
  // noLoop();
  }
  
}

// ============= GUI

void End(){
    noLoop();
    //myNN.test( examples_in );
    myNN.plot();
}


void keyPressed(){
  if(key=='d'){ viewDots=!viewDots; println(" d pressed "); }
}
