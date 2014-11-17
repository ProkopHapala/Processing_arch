
import java.util.Map;

double stiff_scale=0.1;    // lower the number to get more stable simulation at long timestep, the distortion of links would be extragerated by this factor

double damp_Big = 5.0;

double arrow_mass = 0.150;

double damp_glob = damp_Big;
//double Gaccel   = 9.81d;
double Gaccel   = 0.0d;
double dt       = 0.0001d;
int    perFrame = 1;

double2 double2tmp, refPoint;

HashMap<String,StructuralMatrial> materials;
BasicBody2D [] bodies;
Link      [] links;

PGraphics overlay;

float camStep=PI/10.0, camRoll, camPitch,camYaw=PI/2;

void setup(){
  size(800,800);
  frameRate(60);
  overlay = createGraphics(width, height);
  overlay.beginDraw();
    overlay.colorMode(RGB,1.0);
    overlay.background(1.0,0.0);
  overlay.endDraw();
  //noSmooth();
  colorMode(RGB,1.0);
  background(1.0);
  double2tmp = new double2();
  refPoint = new double2();
  loadMaterials("Materials.csv");
  loadBodies("Bodies.csv");
  loadLinks("Links.csv");
  for ( Link lnk : links)    { 
     lnk.kTens*=stiff_scale; lnk.kComp*=stiff_scale; 
   //lnk.fTens*=stiff_scale; lnk.fComp*=stiff_scale; 
     lnk.addMass();
  }
}

void draw(){
  // move
  
  for (int i=0; i<perFrame; i++){
    for ( Link lnk : links)    { if(!lnk.broken) lnk.assertForce();  }
    //if( bodies[0].x.x>-0.1 ){ println(" ARROW RELEASED !!! "); bodies[0].m-=arrow_mass; }
    for ( BasicBody2D b : bodies){ b.move();  b.f.set(0);            }
  }

  
  //println( " body.fy= "+bodies[1].f.y +" link.fy= "+ links[0].f.y  );
  // paint
  background(1.0);
  //if( (frameCount%10)==0 ) { noStroke(); fill(1.0,1.0,1.0,0.1); rect(-400,-400,1600,1600); }
  
  // find COG
  pushMatrix();
  translate(400,400);
  scale(-200,-200);
  //translate(-(float)refPoint.x,-(float)refPoint.y);
  //stroke(0.0,0.0,0.0,0.1); strokeWeight(0.01); 
  stroke(0,0,0);
  for ( Link lnk : links)    { if(!lnk.broken) lnk.paint(); }
  //println("============");
  //stroke(0.0,0.0,1.0);     strokeWeight(0.03); 
  for ( BasicBody2D b : bodies){ b.paint();  }
  popMatrix();
  
  /*
  overlay.beginDraw();
    overlay.stroke(0,0,1); overlay.line( frameCount/4,200,frameCount/4, (float)links[0].f.y+200 );
    overlay.stroke(1,0,0); overlay.line( frameCount/4,200,frameCount/4, (float)links[1].f.y+200 );
    //println( links[0].f.y +" "+ links[1].f.y );
  overlay.endDraw();
  image(overlay,0,0);
  */

}


void keyPressed(){
  if(key==' '){ bodies[0].fixed = false;  damp_glob = 0.0; }
}

void mouseReleased(){
  bodies[0].fixed = false;  damp_glob = 0.0; 
}

void mousePressed(){
  bodies[0].fixed = true;  damp_glob = damp_Big; // bodies[0].m+=arrow_mass;
}

void mouseDragged(){
  bodies[0].x.x = (400.0-mouseX)/200.0;
  bodies[0].x.y = (400.0-mouseY)/200.0;
  //println(" bodies[0].x.x =  "+bodies[0].x.x);
}
