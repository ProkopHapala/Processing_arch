
/*
static double [] R1 = {0,0,   0.1d    };
static double [] R2 = {0.0d,  0.99d,0 };
*/

static double [] R1 = {0,0,   0.5d    };
static double [] R2 = {0.0d,  0.99d,0 };

double mu = 1.0d; double imu_sqrt = 1.0d/Math.sqrt(mu);
double dt = 1.0d;

  double r0  = Math.sqrt(sq(R1[0]) + sq(R1[1]) + sq(R1[2]));
  double r1  = Math.sqrt(sq(R2[0]) + sq(R2[1]) + sq(R2[2]));
  double r12 = Math.sqrt(sq(R2[0]-R1[0]) + sq(R2[1]-R1[1]) + sq(R2[2]-R1[2]));

  double c = r12;
  double s = (r0+r1+c)/2;
  
  //double s_alpha = 0.5d*s;
  //double s_beta  = 0.5d*(s-c);
  
  double s_alpha = s;
  double s_beta  = (s-c);
  
  
  double amin = 0.02;
  double amax = 3.98;
  
  EvalSlow evalSlow;
  EvalFast evalFast;
  
  void setup(){
    println(" c = "+c+" s = "+s);
    println(" s_alpha = "+s_alpha+" s_beta = "+s_beta);
    println("===========================");
    evalSlow = new EvalSlow();
    evalFast = new EvalFast();
    size(800,800);
    line(0,400,800,400 );
    line(400,0,400,800 );
    stroke(0      ); plot( amin, amax, 10000, evalSlow );
    stroke(255,0,0); plot( amin, amax, 10000, evalFast );
  }
