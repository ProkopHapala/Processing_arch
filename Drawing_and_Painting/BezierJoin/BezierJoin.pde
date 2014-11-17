// BezierJoins.pde
// Marius Watz - http://workshop.evolutionzone.com


void setup() {
  size(500,500);
  smooth();
}



void draw() {
  float x0=width/2.0;
  float y0=height/2.0;
  
  //println (x0+" "+y0);
  background(200);
  noFill();

  float xD=x0-mouseX;
  float yD=x0-mouseY;      
  
  stroke(0,0,0);
  bezier(
    0,0,
    300,100,
    x0-xD,x0-yD,
    x0,y0);

  bezier(
    x0,y0,
    x0+xD,x0+yD,
    400,300,
    400,400);  
    
    
    stroke(255,0,0);
    line(0,0,300,100);
    line(300,100,x0-xD,y0-yD);
    line(x0,y0,x0-xD,y0-yD);
    line(400,300,400,400);
    line(400,300,x0+xD,x0+yD);
    line(x0,x0,x0+xD,x0+yD);

    
}
