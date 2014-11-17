final int sz = 500;

PGraphics gui;
PGraphics canvas;
Brush brush;
 
void setup() {
  size(sz, sz, JAVA2D);
  brush = new Brush();
  canvas = createGraphics(width, height, JAVA2D);
  canvas.beginDraw();
  canvas.smooth();
  canvas.noStroke();
  canvas.fill(0,0,255,128);
  canvas.background(255);
  canvas.endDraw();
  gui = createGraphics(width, height, JAVA2D);
  gui.beginDraw();
  gui.smooth();
  gui.endDraw();
}
 
void draw() {
  background(255);   
   image(canvas , 0, 0);
   image(gui    , 0, 0);

}

void mousePressed(){
brush.start();
}

void mouseDragged(){
brush.go();
}

void mouseReleased(){
brush.finish();
}
