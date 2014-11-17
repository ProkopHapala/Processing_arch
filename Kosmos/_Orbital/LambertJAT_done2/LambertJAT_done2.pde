
static double [] R1 = {    0,   1.00d,   0  };
static double [] R2 = { 0.50d,  0.00d,   0  };

static double [] V1 = {    0,  0, 0 };
static double [] V2 = {    0,  0, 0 };



int nsamp = 300;
int sz = 800;
float dx = sz/(float)nsamp;

void setup(){
  size(sz,sz);
  
  Lambert lambert = new Lambert(1); 
  //double dv = lambert.compute( R1, V1, R2, V2, 1);
  
  //println( "dv = "+dv);
  noStroke();
  
  //double dvtot = lambert.compute( R1, V1, R2, V2, 1.0 );
  //println( " dvtot = "+ dvtot );
  
  /*
  // this does fit to lambert problem in pyKEP
  lambert.init( R1, R2);
  double a = lambert.compute_a( 1.0 );
  println( " a= "+ a );
  */
  
  lambert.matIters = 1000;
  
  for (int ix=0; ix<nsamp; ix++){
    for (int iy=0; iy<nsamp; iy++){
      R2[0] = 5*(ix-nsamp*0.5)/(float)nsamp;
      R2[1] = 5*(iy-nsamp*0.5)/(float)nsamp;

      //double dv = lambert.compute( R1, V1, R2, V2, 0.5);
      
      lambert.init( R1, R2);
      
      double a = lambert.compute_a( 0.49 );
      
      if(a>0){
        fill((float)a*50); 
      } else {
        if     (a == -1){         fill(0,0,255);  }
        else if(a == -2){         fill(0,255,0);  }
        else if(a == -3){         fill(255,0,0);  }
        else if(a == -4){         fill(255,0,255);  }
      }  
      rect( ix*dx, iy*dx,dx, dx  );
    }
  }
  
}


