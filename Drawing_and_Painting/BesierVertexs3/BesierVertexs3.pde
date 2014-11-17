
// vertex
PVector x0 = new PVector(30, 20);

//bezier 1
PVector a1 = new PVector(80, 0);
PVector b1 = new PVector(80, 75);
PVector x1 = new PVector(30, 75);

//bezier 2
PVector a2 = new PVector(50, 80);
PVector b2 = new PVector(60, 25);
PVector x2 = new PVector(30, 20);

PVector [] pt = new PVector[6];
PVector my;

void setup(){
size(500,500);
smooth();

// vertex
pt[0] = new PVector(150, 100);
//bezier 1
pt[1] = new PVector(400, 50);
pt[2] = new PVector(400, 350);
pt[3] = new PVector(150, 350);
//bezier 2
pt[4] = new PVector(250, 300);
pt[5] = new PVector(250, 125);
// pt[0] = pt[7]
}

void draw(){
background(200);

strokeWeight(1);
beginShape();
vertex(pt[0].x, pt[0].y);
bezierVertex(pt[1].x, pt[1].y,  pt[2].x, pt[2].y,    pt[3].x, pt[3].y);
bezierVertex(pt[4].x, pt[4].y,  pt[5].x, pt[5].y,    pt[0].x, pt[0].y);
endShape();

strokeWeight(3);
for(int i=0; i<6; i++){
point(pt[i].x,pt[i].y);
}

};

void mouseDragged(){my.x=mouseX; my.y=mouseY;};
void mousePressed(){
float rmin = 100000;
for(int i=0; i<6; i++){
float dx = pt[i].x - mouseX; float dy = pt[i].y - mouseY; float r = sqrt(dx*dx+dy*dy);
if(r<rmin){rmin=r;my=pt[i]; println("Selected: "+i);}
}
};

