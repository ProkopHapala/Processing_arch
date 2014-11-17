

class Train{
  int nCars;
  float timeOnRoad;
  float posOnRoad;
  City from;
  Train after;
  Road road;
  float [] carriedCommodity;
  
  
  Train( int nCars_, City from_, Road road_, float [] carriedCommodity_ ){
    nCars=nCars_;     road = road_;     carriedCommodity=carriedCommodity_; from=from_;
    road.nCars+=nCars;
    from.nCars-=nCars;
    City to;
    if(road.B==from){
      to=road.A;
      road.lastToA.after=this;
      road.lastToA=this;
    }else{
      to=road.B;
      road.lastToB.after=this;
      road.lastToB=this;
    }
    for (int i=0;i<nComodities; i++ ){ 
      from.commodities[i].stored -= carriedCommodity[i];
      to.commodities[i].onTheWay += carriedCommodity[i];
    }
  }
  
void update(float dt){
    timeOnRoad+=dt;
    posOnRoad +=road.velocity*dt/road.distance;
    if(posOnRoad>1.0){posOnRoad=1.0; // arrived
      unLoad();      
  }
} 
  
  void unLoad(){
    City to;
    if(road.B==from){
      to=road.A;      
      road.firstToA = after;  // delete reference to this train  
    }else{   
      to=road.B;
      road.firstToB = after;
    };
    road.nCars  -= nCars;
    to.nCars+= nCars;
    for (int i=0;i<nComodities; i++ ){ 
      to.commodities[i].stored   += carriedCommodity[i];
      to.commodities[i].onTheWay -= carriedCommodity[i];
    }
  }
  
  void updateRecursive(float dt){
    update(dt);
    if(after!=null){after.updateRecursive(dt);}
  }
  
  void paint(){
   ellipse( road.xOn(posOnRoad), road.yOn(posOnRoad) , 3, 3 );
  };
  
  
  void paintRecursive(){
    paint();
    if(after!=null){after.paintRecursive();}
  }
  
}


