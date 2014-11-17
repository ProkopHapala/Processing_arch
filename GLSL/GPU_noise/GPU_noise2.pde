
import java.io.*;
PShader myShader; 


//final String name = "a08_logisticMap.glsl";
//final String name = "logmap_1.glsl";
final String name = "bilinearNoise.glsl";

void setup() {
  size(800, 800, P2D);
  noStroke();
  myShader = loadShader( name );
}

void draw() {
  background(0);
  shader(myShader); 
  myShader.set("resolution", float(width), float(height));
  myShader.set("mouse", float(mouseX), float(mouseY));
  myShader.set("time", (float)(millis()/1000.0));
  rect(0, 0, width, height);
  frame.setTitle("frame: " + frameCount + " - fps: " + frameRate);     
}
