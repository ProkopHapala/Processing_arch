
float c = 0.1;

float dt = 10.0;

//bezier 1
PVector a1 = new PVector(80, 0);
PVector b1 = new PVector(80, 75);
PVector start = new PVector(30, 20);

//bezier 2
PVector a2 = new PVector(50, 80);
PVector b2 = new PVector(60, 25);
PVector end = new PVector(30, 75);

PVector a = new PVector(0,0);
PVector b = new PVector(0,0);

PVector v1 = new PVector(0,0);
PVector v2 = new PVector(0,0);

void setup(){
size(500,500);
smooth();

}

void draw(){
background(200);

a.x = (2.0*start.x +     end.x)/3.0; a.y = (2.0*start.y +     end.y)/3.0;
b.x = (    start.x + 2.0*end.x)/3.0; b.y = (    start.y + 2.0*end.y)/3.0;

v1.set(a); v1.sub(start); v1.normalize();
v2.set(b); v2.sub(a);     v2.normalize();
v1.add(v2); v1.normalize();
v1.mult(10);
a1.set(a); a1.add(v1.y,-v1.x,0);
a2.set(a); a2.sub(v1.y,-v1.x,0);

v1.set(b);   v1.sub(a); v1.normalize();
v2.set(end); v2.sub(b); v2.normalize();
v1.add(v2); v1.normalize();
v1.mult(10);
b1.set(b); b1.add(v1.y,-v1.x,0);
b2.set(b); b2.sub(v1.y,-v1.x,0);


strokeWeight(1);
beginShape();
vertex(start.x, start.y);
bezierVertex(a1.x, a1.y,  b1.x, b1.y,    end.x, end.y);
bezierVertex(b2.x, b2.y,  a2.x, a2.y,    start.x, start.y);
endShape();

//bezier(start.x,start.y,  a.x, a.y,     b.x, b.y,          end.x,end.y );
strokeWeight(3);
point (a1.x,a1.y);
point (b1.x,b1.y);
point (a2.x,a2.y);
point (b2.x,b2.y);

//point (a.x,a.y);

};

void mouseDragged(){end.x=mouseX; end.y=mouseY;};
void mousePressed(){start.x=mouseX; start.y=mouseY;};


