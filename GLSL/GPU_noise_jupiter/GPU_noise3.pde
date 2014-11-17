
import java.io.*;
PShader myShader; 

//final String name = "noise_bilinear.glsl";   // 30 fps 100 iteraci
final String name = "noise_sin.glsl";      // 20 fps 300 iteraci

void setup() {
  size(800, 800, P2D);
  String [] src_head  = loadStrings("head.glsl"); 
  String [] src_noise = loadStrings(name);
  String []src_main   = loadStrings("main.glsl");
  String [] output    = concat(src_head, src_noise);   output=concat(output,src_main);
  saveStrings("noise_test.glsl",output); 
  noStroke();
  myShader = loadShader( "noise_test.glsl" );
}

int n = 13;
float scaleFactor = 2.0;

void draw() {
  background(0);
  shader(myShader); 
  myShader.set("resolution", float(width), float(height));
  myShader.set("mouse", float(mouseX), float(mouseY));
  myShader.set("time", (float)(millis()/100000.0));
  myShader.set("niter",             n  );
  myShader.set("scaleFactor",       scaleFactor  );
  myShader.set("amplitudeFactor",   0.9  );
  myShader.set("amplitude0",        0.05  );
  myShader.set("distRange2",        sq(0.8)  );
  myShader.set("ColorAmp",          5.0  );
  //myShader.set("rescale",           10.0/(pow(scaleFactor,n))  );
  myShader.set("rescale",           2.0  );
  rect(0, 0, width, height);
  frame.setTitle("frame: " + frameCount + " - fps: " + frameRate);     
}


void keyPressed(){
  if(key=='s'){save(year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+" "+second()+".png");}
}
