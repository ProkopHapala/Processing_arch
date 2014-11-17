
int iters_before_view=2;

double damp = 0.95;
double maxd = 1.0;
double dt   = 0.01;
double g    = 9.81;
double ground_stiffess=10000;
double friction=100.0;

Body B1;
World W;

boolean [] keys = new boolean[2000];

void setup(){
  size(800,800);
  smooth();
  frameRate(30);
  B1 = new Body(0,0);
  W  = new World( 0, -2.0, 50 );
}

void draw(){
 background(200);
 stroke(0);
 line ( W.x(-100),W.y(0), W.x(100),W.y(0) );
 for (int i=0; i<iters_before_view; i++) B1.update(dt); 
 B1.view(W); 
 if (keys[50  ]){B1.arm.L0=1;}else{B1.arm.L0=0.5;}
 if (keys[1037]){B1.leg1.L0=2;}else{B1.leg1.L0=1.0;}
 if (keys[1039]){B1.leg2.L0=2;}else{B1.leg2.L0=1.0;}
 //println( keys[50] );
}

void keyPressed(){
   int k = 0; if ( (int)key<1000 ){ k=(int)key;  } else { k=keyCode+1000; }
   if (k<2000){ keys[k] = true;  };
   println(k);
}

void keyReleased() {
   int k = 0; if ( (int)key<1000 ){ k=(int)key;  } else { k=keyCode+1000; }
   if (k<2000){ keys[k] = false;  };
}

