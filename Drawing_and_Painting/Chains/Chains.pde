
final int nchain = 10;
float sl = 50;

float dinamic = 0.1;


void setup(){
size(1000,1000,JAVA2D);
stroke(0,255);
fill(255,10);
smooth();
}

void draw(){
//background(200);
rect(0,0,1000,1000);
//chainSimple.paint();
//chainRail.paint();
chainChaotic.paint();

}
