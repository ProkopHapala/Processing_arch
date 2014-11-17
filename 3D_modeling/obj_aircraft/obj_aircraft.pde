
import saito.objloader.OBJModel;

Model M,M1,M2,M3,M4;
PApplet main;

float zoom = 40.0;

String [] names1 = {"wings.main", "wings.elevator", "rudder",  "hull", "cockpit", "tank", "engine_radial.duct", "engine_radial.nose"           };
String [] names2 = {"wings.main", "wings.elevator", "rudder",  "hull", "cockpit", "tank", "engine_V.duct"     , "engine_V.nose"     , "cooler" };

void setup(){
  size(800,800,P3D);
  ortho(-400, 400, -400, 400, -10000, +10000);
  main = this;
  M1=new Model( names1 ,"hi_",".obj" );
  M2=new Model( names2 ,"hi_",".obj" );
  M3=new Model( names1 ,"lo_",".obj" );
  M4=new Model( names2 ,"lo_",".obj" );
  M = M1;
}

void draw(){
  background(200, 220, 250);
  //lights();
   stroke(0x20000000);
   fill(200, 200, 200); 
   ambientLight(100, 120, 150);
   lightSpecular(255, 255, 255);
   directionalLight(255, 240, 200, 0.5, 0.5, -1);
   specular(255, 255, 255);
   shininess(50.0);
  translate(width/2, height/2, 0);
  scale(zoom);
  //rotateX(radians(frameCount)/2);
  //rotateY(radians(frameCount)/2);
  rotateX((400-mouseY)*0.01);
  rotateY((mouseX-400)*0.01);
  M.draw();
}

void keyPressed(){
  if(key=='+'){ zoom*=1.2; }
  if(key=='-'){ zoom/=1.2; } 
  if(key=='1'){M=M1;}
  if(key=='2'){M=M2;}
  if(key=='3'){M=M3;}
  if(key=='4'){M=M4;}
  if(key=='s'){ String name =millis()+".png";  save(name); println("saved : "+name);}
}
