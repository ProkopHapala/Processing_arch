
// =========== Setup

double dt = 0.1;   // time step
double mu = 0.5;  // velocity damping

float perturb_Wih = 0.5;

double function_to_learn( double x, double y ){
  /*
  double xa = x+2*y+1.5;
  double ya = 2*x-y-1.5;
  double wa = 0.5;
  double La=2*wa/(wa+0.25*xa*xa + ya*ya); 
  double xb = x+0.5;
  double yb = y-0.8;
  double wb = 0.2;
  double Lb=2*wb/(wb + xb*xb + yb*yb); 
  return  La + Lb - 1.0;
  */
  double r2 = x*x + y*y;
  return 2*r2/(0.5+r2*r2*r2)-1.0;
}

// ============= Variables


boolean viewDots = true;

int perFrame  = 30;
int maxFrames = 1000000; 
int epoch     = 0;

double oerr;

BPNN3L myNN;
double [][] examples_in, examples_out;

int sz = 300; int sz2 = 2*sz;
float zoom = 50.0; 


// ============= Initialization

void setup(){
  size(sz2,300);
  genExamples( 800 , 1.8 );
  myNN = new BPNN3L( 2,12,1 );
  myNN.init();
  //copyMatrix( init_Wih, myNN.Wih );
  //copyMatrix( init_Who, myNN.Who );
  //copyMatrix( start_wi, myNN.Wih );
  //copyMatrix( start_wo, myNN.Who );
  
  /*
  randomMatrix( -0.5, 0.5, myNN.Wih );  
  randomMatrix( -2.0, 2.0, myNN.Who );  
  */
  
  randomMatrix( -1.0, 1.0, myNN.Wih );  
  randomMatrix( -2.0, 2.0, myNN.Who );  
  
  myNN.eval ( );
  myNN.plot();
  
  println ( " initial Whi : "  );
  printMat( myNN.Wih );
  println ( " initial Who : "  );
  printMat(  myNN.Who );
  
  //randomMatrix( -0.5, 0.5, myNN.Wih );
  //randomMatrix( -4.0, 4.0, myNN.Who );

}

// ============= Main loop

void draw(){
  
  /*
  frameRate(5);
  randomMatrix( -0.5, 0.5, myNN.Wih );  
  randomMatrix( -2.0, 2.0, myNN.Who );  
  myNN.eval ( );
  myNN.plot();
  */
  
  //myNN.test( inputs );
  //println ( "ai= "+ vec2string( myNN.ai)  );
  //println ( "ah= "+vec2string( myNN.ah)  );
  //println ( "ao= "+vec2string( myNN.ao)  );
  //println(" Input weights: ");
  //printMat(  myNN.Wih ); 
  //println(" output weights: ");
  //printMat(  myNN.Who ); 
  //noLoop();
  
  /*
  for (int i=0; i<examples_in[5].length; i++) myNN.ai[i] = examples_in[5][i];
  println( " input: "+vec2string( myNN.ai)+" -> "+examples_out[5][0]  );
  myNN.eval ( );
  println ( "ah= "+vec2string( myNN.ah)  );
  myNN.cleanDeltas();
  myNN.getDeltas( examples_out[5] );
  println( "delta_o= "+vec2string( myNN.delta_o ) );
  println( "delta_h= "+vec2string( myNN.delta_h ) );
  myNN.move( );
  myNN.eval ( );
  println( " vWho: ");
  printMat( myNN.vWho );
  println( " Who: ");
  printMat( myNN.Who );
  println( " vWih: ");
  printMat( myNN.vWih );
  println( " Wih: ");
  printMat( myNN.Wih );
  println ( "ah= "+vec2string( myNN.ah)  );
  
  //myNN.plot();
  noLoop();
  */
  
  
  double errMax=0;
  for (int i=0;i<perFrame;i++){
    errMax = Math.max(errMax, myNN.train_epoch( examples_in, examples_out ) );
    epoch++;
  }
  myNN.plot();
  //stroke(255,0,0); line(  frameCount-1,275 - 5*log((float)oerr),frameCount, 275 - 5*log((float)errMax)  );
  stroke(255,0,0); line(  frameCount-1,300 - 100*(float)oerr,frameCount, 300 - 100*(float)errMax );
  oerr = errMax;
  
  println( " epoch: "+epoch+" errMax: "+errMax );
  if (errMax<0.01){ 
    println( " Success errMax="+errMax );
    End();
  }
  //println(err);
  if(frameCount>maxFrames){
    println( " FAILS in 100 iterations; errMax="+errMax);
    End();
  }
  
}

void End(){
    noLoop();
    //myNN.test( examples_in );
    myNN.plot();
}


void keyPressed(){
  if(key=='d'){ viewDots=!viewDots; println(" d pressed "); }
  if(key=='p'){ 
    println( " Perturbing: " );
    println( " shape Wih: "+ myNN.Wih.length+" "+ myNN.Wih[0].length );
    //int ii = (int)random(  myNN.Wih[0].length );
    int ii=0; double min_importance = myNN.ah_importance[0];
    for ( int i=1; i<myNN.ah_importance.length; i++ ){ double impo = myNN.ah_importance[i];  if(impo<min_importance){ min_importance=impo; ii=i; }   }
    for ( int i=0; i<myNN.Wih.length; i++ ){   
      myNN.Wih[i][ii] = random(-perturb_Wih,perturb_Wih);
    }
  }
}
