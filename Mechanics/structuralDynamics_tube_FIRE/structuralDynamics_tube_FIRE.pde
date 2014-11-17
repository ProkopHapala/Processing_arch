
import java.util.*;

//double Gaccel   = 9.81d;
//static double Gaccel   = 0.0d;
//static  double damp     = 100.0d; 
static double dt       = 0.001d;
static int    perFrame = 50;

double3 double3tmp;

static int sz = 400;
static float zoom = 50;
static float rotspeed = PI/50;
static float  pitch =PI/2;
static float  yaw =0;

StructuralMatrial mat1;

HashMap<String,StructuralMatrial> materials;
BasicBody [] bodies;
Link      [] links;
//ArrayList links;

int nR = 40;
int nL = 50;

double3 fend; 

void setup(){
  size(sz*2,sz*2,P3D);
  ortho();
  smooth();
  colorMode(RGB,1.0);
  double3tmp = new double3();
  
  hint(DISABLE_DEPTH_TEST);
  
  //fend = new double3( 0,0,-3000 );
  fend = new double3( 0,400,0);
  //loadMaterials("Materials.csv");
  //loadBodies("Bodies.csv");
  //loadLinks("Links.csv");
  //mat1 = new StructuralMatrial( 0.00001d, 1.0d, 1.0d, 1.0d, 1.0d );
  mat1 = new StructuralMatrial( 0,200e+9,200e+9,580e+6,260e+6 );
  makeTube( 0.1, 0.75, 15.0, nR, nL);

  //for(int i=0; i<bodies.length; i++) {   println( bodies[i].x );   }

}

void draw(){
  // move
  translate(50,sz,sz);
  scale(zoom,-zoom,zoom);
  rotateX( yaw );
  rotateY( pitch   );
  
  for (int i=0; i<perFrame; i++){
    /*
    for ( Link lnk : links)    { lnk.assertForce();    }
    // boundary conditions 
    for ( int ir=0; ir<nR; ir++ ){
      bodies[ 2*( ir + (nL-1)*nR )    ].f.add( fend );
      bodies[ 2*( ir + (nL-1)*nR ) +1 ].f.add( fend );
     }
    for ( BasicBody b : bodies){ b.move();             }
    */
    move_FIRE();
  }
  
  // paint
  //noStroke(); fill(1.0,1.0,1.0,0.1); rect(-400,-400,1600,1600);
  background(1.0);
  strokeWeight(0.02); for ( Link lnk : links)    { lnk.paint(); }
  stroke(0,0,0,1); strokeWeight(3.0); for ( BasicBody b : bodies){ b.paint();   }
}


void keyPressed(){
  if(key=='4'){ pitch+=rotspeed; }
  if(key=='6'){ pitch-=rotspeed; }
  if(key=='8'){ yaw+=rotspeed; }
  if(key=='2'){ yaw-=rotspeed; }
  if(key=='+'){ zoom*=1.1; }
  if(key=='-'){ zoom/=1.1; }
}
