

PShader shader;
PImage srcImage;
PGraphics Layer;

float omX,omY;

void setup() {
  size(800, 800, P2D);
  noStroke();
  srcImage = loadImage("leaves.jpg");
  Layer = createGraphics(width*2, height*2, P2D); // oversampled offscreen layer
  Layer.beginDraw();
    Layer.image(srcImage,0,0,Layer.width,Layer.height); 
  Layer.endDraw();
  //shader = loadShader("textured_IFS.glsl");
  shader = loadShader("smudge.glsl");
  shader.set("resolution", float(Layer.width), float(Layer.height));
  shader.set("background", Layer);
  omX=mouseX; omY=mouseY;
}

void draw() {
  //background(0);
   
  Layer.beginDraw(); // we paint everything to some offscreen layer
    Layer.shader(shader); 
    shader.set("mouse"   , float(mouseX*2), float(mouseY*2));
    shader.set("mouseOld", omX*2, omY*2 );
    shader.set("time", (float)(millis()/1000.0));
    Layer.translate( mouseX*2, mouseY*2 );
    Layer.rotate   ( frameCount*0.01    ); 
    Layer.ellipse  ( 0, 0, 350, 100     );
    Layer.noStroke ( );
  Layer.endDraw();
  omX=mouseX; omY=mouseY;
  image(Layer, 0, 0, width, height); // output to screen
  frame.setTitle("frame: " + frameCount + " - fps: " + frameRate);     
}

