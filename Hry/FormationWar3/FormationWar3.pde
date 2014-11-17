
// === Time Handling 
float dt = 1.0;
float timeZoomRate = 2.0;
boolean stopped=false;

// === Graphics
int cX=400; int cY=400;
float zoom = 1.0;

// === Combat Model
float melee_hit_ratio;  // how many swings 
float lethality;        // how many wounds is deadly?

// === Movement model
float slopeEffect = 3.0;




// === Terrain maps
int mapN = 40;
//float mapScale=20.0;
float mapScale = 800.0/mapN;
float mapX0=0.5*mapN; float mapY0=mapX0; 
Map altitude;   // terrain height   ( sea level or such                                   )
Map cover;      // terrain cover    ( based on vegetation and so                          )
Map rughness;   // terrain rughness ( determine size of detailde irebular terain features )  noise function or random used for detailed structure
PShape mapView;
PImage mapTexture;
final float [][] fq = { {1.0,0.0,1.0,0.0},  {0.0,2.0,0.5,1.5},  {2.0,3.0,0.25,0.1}, {3.0,2.0,0.25,0.0}  };   //  frequencies for generating terain { freq.x, freq.y, amplitude, pahseShift }


// === Temporary PVectros
PVector p1,p2;

PFont font1;

ArrayList<Type> type_list;
ArrayList<Regiment> myArmy,Army1, Army2;
Regiment myReg;

// === setup

void setup(){
  size(cX*2,cY*2, P3D);
  //smooth();
  colorMode(RGB,1.0);
  mouse = new Mouse();
  font1 = createFont("Georgia", 32);
  textFont(font1);
  p1 = new PVector(); p2 = new PVector();
  
  // === Generate Army
  type_list = new ArrayList();
  type_list.add(new Type());
  Army1 = new ArrayList();  Army2 = new ArrayList();
  myArmy = Army1;
  for (int i=0; i<10; i++){
    Army1.add(   new Regiment(type_list.get(0) , 5, 320 ,  new PVector(-200+45*i,-100,0), new PVector(-200+45*i+40,-100,0) ,0) );
    Army2.add(   new Regiment(type_list.get(0) , 5, 320 ,  new PVector(-200+45*i,+100,0), new PVector(-200+45*i+40,+100,0) ,1) );
  }
  myReg = Army1.get(0);
  
  // === Generate Trrain
  altitude = new Map( mapN,mapN );  
  //altitude.fillRandom( 0.0, 1.0,  2.0/mapN );  
  altitude.fillWave( fq );  
  altitude.findRange(); altitude.autoPaintRange();
  mapTexture = altitude.toTexture();  //  mapView = altitude.toShape(); 
};



