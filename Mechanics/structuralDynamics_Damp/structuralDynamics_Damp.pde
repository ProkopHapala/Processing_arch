
import java.util.Map;

double Gaccel   = 9.81d;
//double damp     = 1000000.0d; 
double dt       = 0.0001d;
int    perFrame = 200;

double3 double3tmp;

HashMap<String,StructuralMatrial> materials;
BasicBody [] bodies;
Link      [] links;

void setup(){
  size(800,800,P3D);
  smooth();
  colorMode(RGB,1.0);
  double3tmp = new double3();
  loadMaterials("Materials.csv");
  loadBodies("Bodies.csv");
  loadLinks("Links.csv");
}

void draw(){
  // move
  translate(400,400,400);
  scale(100,-100,100);
  for (int i=0; i<perFrame; i++){
    for ( Link lnk : links)    { lnk.assertForce();    }
    for ( BasicBody b : bodies){ b.move();             }
  }
  // paint
  //noStroke(); fill(1.0,1.0,1.0,0.1); rect(-400,-400,1600,1600);
  background(1.0);
  stroke(0.0,0.0,0.0); strokeWeight(0.01); for ( Link lnk : links)    { lnk.paint(); }
  stroke(0.0,0.0,0.0); strokeWeight(5); for ( BasicBody b : bodies){ b.paint();   }
}

