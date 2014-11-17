PGraphics canvas, temp;
float opacity = 100;
PImage t;
 
void setup() {
  size(1000, 1000);
  noFill();
  smooth();
 
  canvas = createGraphics(width, height, JAVA2D);
  canvas.beginDraw();
  canvas.smooth();
  canvas.background(0, 0);
  canvas.tint(255, 255, 255, opacity);
  canvas.endDraw();
 
  temp = createGraphics(width, height, JAVA2D);
  temp.beginDraw();
  temp.fill(255, 0, 0);
  temp.noStroke();
  temp.smooth();
  temp.endDraw();
 
  t = createImage(width, height, ARGB);
}
 
void draw() {
  background(200);
  noTint();
  image(canvas, 0, 0);
  if (mousePressed) {
    t.pixels = temp.pixels;
    t.updatePixels();
    tint(255, 255, 255, opacity);
    image(t, 0, 0); // using the temp image directly screws things up
  }
  ellipse(mouseX, mouseY, 50, 50);
}
 
void mousePressed() {
  temp.beginDraw();
  temp.background(0, 0); // this DOES work, so that is not the problem
  temp.endDraw();
}
 
void mouseDragged() {
  temp.beginDraw();
  temp.ellipse(mouseX, mouseY, 50, 50);
  temp.endDraw();
}
 
void mouseReleased() {
  canvas.beginDraw();
  canvas.image(temp, 0, 0);
  canvas.endDraw();
}

