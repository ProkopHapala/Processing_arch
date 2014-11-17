//Ray Tracing & Photon Mapping
//Grant Schindler, 2007

// ----- Scene Description -----
int szImg = 256;                  //Image Size
int nrObjects = 5;          //2 Spheres, 5 Planes
float[] gOrigin = {0.0,0.0,0.0};  //World Origin for Convenient Re-Use Below (Constant)

float[][] spheres = {
{ 0.0,0.0,  0.0, 4},  // Bounding box
{ 1.0, 0.0, 2.5,0.4}, // G
{-1.0, 0.0, 2.5,0.4}, // B
{ 0.0, 2.0, 2.5,0.5}, // light
{ 0.0, 0.0, 2.5,0.4}, // R
};         

// ----- Raytracing Globals -----
boolean gIntersect = false;       //For Latest Raytracing Call... Was Anything Intersected by the Ray?
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

boolean view_depth=false;

void setup(){
  size(szImg,szImg, P2D);
}

void draw(){ 
 //MC();
 SMC();
 findexpo();
 expo *= 0.5;
 renderbuff();
 if(view_depth)renderdepth();
}



void renderdepth(){
for (int x = 0;x<szImg;x++){
for (int y = 0;y<szImg;y++){
float d = depth[x][y];
d = (255.0*d)/ibmax;
stroke(d+1);
point(x,y);
}
}
  
  
};


void keyPressed(){
if(key == 'i')save("test");
if(key == ' ')view_depth=!view_depth;
}
