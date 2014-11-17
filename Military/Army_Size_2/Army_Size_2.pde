/*
divize 20 000

Contubernium = 8
Centuria = 80  10*8
Cohorts = 480  6*80
Legion = 4800 10*480
*/


int nLegions      = 5;
int nCohorts      = 10;
int nCenturias     = 6;
int nContuberniums = 10;
int nMens          = 8;

int LLegion      =  250;
int LCohort      =  120;
int LCenturia     = 20;
int LContubernium = 16;


float zoom=1.0;

void setup(){
size (1600,500,P3D);
//smooth();
}

void draw(){
  /* Army */
background(200);

translate(800,250);
scale(zoom);
rotateY(mouseX*0.01);
rotateX(PI*0.5);
//rotateX(mouseY*0.01);
translate(-800,-250,-40);  

float step = 1500.0/(float)nLegions;
for (int i=0;i<nLegions;i++){
Legion(i*step+50,0,LLegion);
}  

if(keyPressed){
if(key=='+')zoom*=1.1;
if(key=='-')zoom/=1.1;
}
  
//noLoop();
}

void Legion(float x,float y, float L){
float step = L/(float)nCohorts;
for (int i=0;i<nCohorts;i++){
fill(20*i,0,255-20*i,50);
Cohort(x+i*step,y,LCohort);
}
};

void Cohort(float x,float y, float L){
float step = L/(float)nCenturias;

for (int i=0;i<nCenturias;i++){
noStroke();
//rect(x,y+i*step,LCenturia,LContubernium);
stroke(0,i*20,0);
Centuria(x,y+i*step,LCenturia);
}

};


void Centuria(float x,float y, float L){
float step = L/(float)nContuberniums;
for (int i=0;i<nContuberniums;i++){
Contubernium(x+i*step,y,LContubernium);
}
};

void Contubernium(float x,float y, float L){
float step = L/(float)nMens;
for (int i=0;i<nMens;i++){
//point (x,y+i*step);

line ( x,y+i*step,0,   x,y+i*step,2 );
}
};


