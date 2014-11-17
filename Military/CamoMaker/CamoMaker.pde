
float x=0;
float y=0;
float r=0;


float aspectRatio = 0.5;


float ncluster = 20000;

//color Back = #4F6F2F;

color Back = #FF00FF; // unnatural color for debuging

color [] colors = {
#FFFF8F,
#000000,
#4F6F2F,
#8F7F20,
};

float [] mapping = {
0.02,
0.18,
0.4,
0.4,
};

RndPow rSelector;   // select 
RndPow nSelector;   // 

void setup(){
  size (800,800);
  //smooth();
  frameRate(1);
  rSelector = new  RndPow( -2.5 , 5.0, 30 );   // this will make spots from 5 to 100 pixesl;
  nSelector = new  RndPow( -1.0 , 5, 50 );   // this will make spots from 5 to 100 pixesl;
};

void draw(){
 noStroke();
 background(Back);
 
 noLoop();
 for (int icluster = 0; icluster < ncluster; icluster++){
  int nspots = int (nSelector.rnd());
  fill(rndColor(colors,mapping));
  newPos();
 for (int ispot=0; ispot<nspots; ispot++ ){
  r = rSelector.rnd();  
  // newPos();     // random position
  mutatePos(r);  // if(!inScreen()){newPos(); }
  //fill(rndColor(colors,mapping));
  spot(r);
 };
 }
 
 save("camo.png");
}
