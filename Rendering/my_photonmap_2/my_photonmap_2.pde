//Ray Tracing & Photon Mapping
//Grant Schindler, 2007

// ----- Scene Description -----
int szImg = 256;                  //Image Size
int nrTypes = 2;                  //2 Object Types (Sphere = 0, Plane = 1)
int[] nrObjects = {2,5};          //2 Spheres, 5 Planes
float gAmbient = 0.00;             //Ambient Lighting
float[] gOrigin = {0.0,0.0,0.0};  //World Origin for Convenient Re-Use Below (Constant)
float[] Light = {0.0,1.2,3.75};   //Point Light-Source Position
float[][] spheres = {{1.0,0.0,4.0,0.5},{-0.6,-1.0,4.5,0.5}};         //Sphere Center & Radius
float[][] planes  = {{0, 1.5},{1, -1.5},{0, -1.5},{1, 1.5},{2,5.0}}; //Plane Axis & Distance-to-Origin

// ----- Raytracing Globals -----
boolean gIntersect = false;       //For Latest Raytracing Call... Was Anything Intersected by the Ray?
int gType;                        //... Type of the Intersected Object (Sphere or Plane)
int gIndex;                       //... Index of the Intersected Object (Which Sphere/Plane Was It?)
float gSqDist, gDist = -1.0;      //... Distance from Ray Origin to Intersection
float[] gPoint = {0.0, 0.0, 0.0}; //... Point At Which the Ray Intersected the Object

//---------------------------------------------------------------------------------------
// User Interaction and Display ---------------------------------------------------------
//---------------------------------------------------------------------------------------
boolean empty = true, view3D = false; //Stop Drawing, Switch Views
PFont font; PImage img1, img2, img3;  //Fonts, Images
int pRow, pCol, pIteration, pMax;     //Pixel Rendering Order
boolean odd(int x) {return x % 2 != 0;}

void setup(){
  size(szImg,szImg, P2D);
   emitPhotons();
   resetRender(); 
   background(0);
}

void draw(){ 
 if(frameCount == 1)  prerender();
 if(frameCount == 2)  render();
 if(frameCount == 3) noLoop();
}


void prerender(){
noStroke();
for (int x = 0;x<szImg;x+=4){
for (int y = 0;y<szImg;y+=4){
float[] rgb = mul3c( computePixelColor(x,y), 255.0);
fill(rgb[0],rgb[1],rgb[2]);
rect(x,y,4,4);
}
}
}

void render(){
for (int x = 0;x<szImg;x++){
for (int y = 0;y<szImg;y++){
float[] rgb = mul3c( computePixelColor(x,y), 255.0);
stroke(rgb[0],rgb[1],rgb[2]);
point(x,y);
}
}
}

void resetRender(){ //Reset Rendering Variables
  pRow=0; pCol=0; pIteration=1; pMax=2; frameRate(9999);
  empty=true; if (lightPhotons && !view3D) emitPhotons();}

 
void keyPressed(){
if (key=='i')save(hex(int(random(2000000))));
};

