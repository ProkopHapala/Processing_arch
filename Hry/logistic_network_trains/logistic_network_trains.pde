
final static int nComodities = 2;
CommodityType [] commodityTypes = new CommodityType[2];

int nGrid = 5;
ArrayList<City> cities = new ArrayList();
ArrayList<Road> roads = new ArrayList();

void setup(){

size (800,800);
//smooth();
frameRate(1);
textFont(loadFont("ArialMT-10.vlw")); 
//textFont(loadFont("LucidaConsole-10.vlw")); 
//textFont(loadFont("Arial-BoldMT-10.vlw")); 
//textFont(loadFont("DejaVuSansMono-10.vlw")); 
//textFont(loadFont("SansSerif.bold-10.vlw")); 

for (int i = 0; i<commodityTypes.length; i++){
  commodityTypes[i] = new CommodityType();
  commodityTypes[i].name = "Commodity_"+i;
}


float dx= (width-100)/(float)nGrid;
float dy= (height-100)/(float)nGrid;
for (int ix = 0; ix<nGrid; ix++){
  for (int iy = 0; iy<nGrid; iy++){
    City temp = new City( "City_"+ix+"_"+iy ,   new PVector ( ix*dx+50, iy*dy+50),   100  );
    for (int ic=0; ic<temp.commodities.length; ic++){
      temp.commodities[ic].stored = random(10000);
    }
    cities.add( temp);
  }
}


for (int ix = 1; ix<nGrid; ix++){
    addRoadToGrid(cities, roads, ix,0 , ix-1,0  );  
    addRoadToGrid(cities, roads, 0,ix , 0,ix-1  );
};

for (int ix = 1; ix<nGrid; ix++){
  for (int iy = 1; iy<nGrid; iy++){
    addRoadToGrid(cities, roads, ix,iy,  ix-1,iy  );
    addRoadToGrid(cities, roads, ix,iy,  ix,iy-1  );
  }
}

}

void draw(){
background(200);  
for(int i=0; i<roads.size();i++){
  Road temp = roads.get(i);
  temp.paint();
  temp.update(1.0);
}; 

for(int i=0; i<cities.size();i++){  
  City temp = cities.get(i);
  temp.paint();
  temp.update();
}; 
};
