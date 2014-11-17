
int time=0;

 
void setup() {
size(1000,380,P2D);
colorMode(RGB,1.0);
background(0);
stroke(1,0,0);
line (250,1000,250,0);
line (500,1000,500,0);
line (750,1000,750,0);

}
 
void draw(){
  
stroke(1,0.25);
  
for(int i=0; i<10;i++){
float x = halton(time,2);
float y = halton(time,3);
float z = halton(time,5);
rect(0,0,1000,10);
rect(0,20,1000,10);
rect(0,40,1000,10);
line (x*1000,0 ,x*1000,20);
line (y*1000,20,y*1000,40);
line (z*1000,40,z*1000,60);
point(    x*250, 80+y*250);
point(250+x*250, 80+z*250);
point(500+y*250, 80+z*250);

float rx = random(0,1.0); float ry = random(0,1.0);
rect(0,60,1000,10);
line (rx*1000,60 ,rx*1000,80);
point(750+rx*250, 80+ry*250);
time++;
}

}
