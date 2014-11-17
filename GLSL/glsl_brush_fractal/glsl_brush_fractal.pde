
import java.io.*;
 
int iShader = 0;
PShader shader;

void setup() {
  size(800, 800, P2D);
  noStroke();
  shader = loadShader("simple.glsl");
}

void draw() {
  //background(0);
  shader(shader); 
  shader.set("resolution", float(width), float(height));
  shader.set("mouse", float(mouseX), float(mouseY));
  shader.set("time", (float)(millis()/1000.0));
  //rect(0, 0, width, height);
  /*
  beginShape(TRIANGLES);
    vertex(0, 0);
    vertex(mouseX, mouseY);
    vertex(0, 200);
  endShape();
  */
  //ellipse(mouseX, mouseY, 350, 200);
   
  translate( mouseX, mouseY    );
  rotate   ( frameCount*0.01   ); 
  ellipse  ( 0,    0, 350, 100 );
  
  frame.setTitle("frame: " + frameCount + " - fps: " + frameRate);     
}

