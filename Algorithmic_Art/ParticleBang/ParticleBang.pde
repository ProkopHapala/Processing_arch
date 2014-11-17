float B = 0.01;
float A = 0.001;
float dt = 0.1;

class walker{
float x,y;
float px,py;

float m=1; // mass
float e=0; //charge

walker(float x_, float y_, float px_,float py_){
x = x_;y = y_; px = px_;py = py_;
}

void move(){
px*=(1-A);
py*=(1-A);

px+=B*py*e; 
py-=B*px*e;

x += (px*dt)/m;
y += (py*dt)/m;

};

void paint(){
point(x+400,y+400);
}

void decay(){
float dm = random(0,0.5*m); dm*=dm;
float m1 = 0.5*m + dm;
float m2 = 0.5*m - dm;
float de = random(0,1); de*=de;
float e1 = 0.5*e + de;
float e2 = 0.5*e - de;
float dpx = random(0,1); dpx*=dpx;
float px1 = 0.5*px + dpx;
float px2 = 0.5*px - dpx;
float dpy = random(0,1); dpy*=dpy;
float py1 = 0.5*py + dpy;
float py2 = 0.5*py - dpy;

m = m1; e = e1; px = px1; py =py1;
walker nw = new walker(x,y,px2,py2);
nw.e = e2; nw.m = m2;
walkers.add(nw);
}

}

walker test;
ArrayList walkers;

void setup(){
  test = new walker(0,0,0,0);
  walkers = new ArrayList();
  walkers.add(test);
  size(800,800,P2D);

};

void draw(){
//test.move();
//test.paint();

for (int i = walkers.size()-1; i >= 0; i--) { 
    walker w = (walker) walkers.get(i);
    w.move();
    w.paint();
    if(((random(0,1)/w.m)<0.05)&&(walkers.size()<1000)){w.decay();}
  }  


};
