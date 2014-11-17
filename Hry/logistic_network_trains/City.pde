

float demandoffset;

class City{
  String name;
  PVector pos;
 
  int nCars;
  CommodityState [] commodities;
  ArrayList<Road> roads;
    
  void update(){
    float totalStored = 0;
    for (int i=0; i<nComodities; i++){
      commodities[i].update();    
    }
    
    /*
    
    There Should be algorithm how City decides 
    how many of excess commodities send to which 
    neighbor
    
    */
    
    
  }
   
  
City(String name_, PVector pos_, float storeCapacity_){
    name=name_;
    pos = pos_;
    float storeCapacity=storeCapacity_;
    commodities = new CommodityState[nComodities];
    for (int i=0; i<nComodities; i++){
      commodities[i] = new CommodityState(commodityTypes[i], 0.0);
    }    
    roads = new ArrayList();
}
  
  void paint(){
   ellipse( pos.x, pos.y, 10, 10 );
   // println( "*"+name +"*  " +pos.x +"  "+ pos.y  );
   // text(name, pos.x, pos.y);
   //text( commodities[0].stored , pos.x, pos.y);
   for (int i=0; i<nComodities; i++){
     text( commodities[i].demand , pos.x, pos.y+i*10);
   }
  }
  
}


