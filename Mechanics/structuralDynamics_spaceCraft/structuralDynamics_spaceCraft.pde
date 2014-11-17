
import java.util.Map;

double stiff_scale=0.1;    // lower the number to get more stable simulation at long timestep, the distortion of links would be extragerated by this factor

//double Gaccel   = 9.81d;
double Gaccel   = 0.0d;
double dt       = 0.0001d;
int    perFrame = 30;

double3 double3tmp, refPoint;

HashMap<String,StructuralMatrial> materials;
BasicBody [] bodies;
Link      [] links;

PGraphics overlay;

float camStep=PI/10.0, camRoll, camPitch,camYaw=PI/2;

void setup(){
  size(800,800,P3D);
  frameRate(60);
  overlay = createGraphics(width, height, P2D);
  overlay.beginDraw();
    overlay.colorMode(RGB,1.0);
    overlay.background(1.0,0.0);
  overlay.endDraw();
  colorMode(RGB,1.0);
  background(1.0);
  double3tmp = new double3();
  refPoint = new double3();
  loadMaterials("Materials.csv");
  loadBodies("Bodies.csv");
  loadLinks("Links.csv");
  for ( Link lnk : links)    { 
    lnk.kTens*=stiff_scale; lnk.kComp*=stiff_scale; 
    //lnk.fTens*=stiff_scale; lnk.fComp*=stiff_scale; 
  }
}

void draw(){
  // move
  for (int i=0; i<perFrame; i++){
    for ( Link lnk : links)    { if(!lnk.broken) lnk.assertForce();  }
    for ( BasicBody b : bodies){ b.move();  b.f.set(0);              }
  }
  //println( " body.fy= "+bodies[1].f.y +" link.fy= "+ links[0].f.y  );
  // paint
  //background(1.0);
  if( (frameCount%10)==0 ) { noStroke(); fill(1.0,1.0,1.0,0.1); rect(-400,-400,1600,1600); }
  
  // find COG
  refPoint.set(0);
  double massSum=0.0d;
  for ( BasicBody b : bodies){ refPoint.add(b.x);  massSum+=b.m; }
  refPoint.mul( 1.0d/massSum );
  
  pushMatrix();
  translate(400,400,400);
  scale(100,-100,100);
  rotateX(camPitch);
  rotateY(camYaw);
  rotateZ(camRoll);
  stroke(1,0,0); line( 0,0,0, 0.1,0.0,0.0 );
  stroke(0,1,0); line( 0,0,0, 0.0,0.1,0.0 );
  stroke(0,0,1); line( 0,0,0, 0.0,0.0,0.1 );
  translate(-(float)refPoint.x,-(float)refPoint.y,-(float)refPoint.z);
  stroke(0.0,0.0,0.0,0.1); strokeWeight(0.01); for ( Link lnk : links)    { if(!lnk.broken) lnk.paint(); }
  stroke(0.0,0.0,1.0); strokeWeight(0.03); for ( BasicBody b : bodies){ b.paint();   }
  popMatrix();
  
  overlay.beginDraw();
    overlay.stroke(0,0,1); overlay.line( frameCount/4,200,frameCount/4, (float)links[0].f.y+200 );
    overlay.stroke(1,0,0); overlay.line( frameCount/4,200,frameCount/4, (float)links[1].f.y+200 );
    println( links[0].f.y +" "+ links[1].f.y );
  overlay.endDraw();
  image(overlay,0,0);
}

void keyPressed(){
  if(key=='8'){ camPitch+=camStep; background(1.0); }
  if(key=='5'){ camPitch-=camStep; background(1.0); }
  if(key=='4'){ camYaw  +=camStep; background(1.0); }
  if(key=='6'){ camYaw  -=camStep; background(1.0); }
  if(key=='7'){ camRoll +=camStep; background(1.0); }
  if(key=='9'){ camRoll -=camStep; background(1.0); }
}

