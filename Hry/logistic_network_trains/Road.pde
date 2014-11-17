
class Road{
  int nCars=0;
  float distance;
  float velocity;
  float timecost;
  City A;
  City B;
  Train firstToA;
  Train firstToB;
  Train lastToA;
  Train lastToB;
  
  float newTrans;
  
float xOn( float u ){
  return (A.pos.x+B.pos.x)*0.5;
}

float yOn( float u ){
  return (A.pos.y+B.pos.y)*0.5;
}
  
void update(float dt){
  timecost=distance/velocity;
  if( firstToA!=null){   firstToA.updateRecursive(dt); }
  if( firstToB!=null){   firstToB.updateRecursive(dt); }
}

Road( City A_,City B_, float velocity_ ){
     A=A_; B=B_; velocity = velocity_;
     nCars = 0;     
     float distance = A.pos.dist(B.pos);
     A.roads.add(this);
     B.roads.add(this);
}
   
   void paint( ){
     line (A.pos.x, A.pos.y, B.pos.x, B.pos.y );
   }
   
}

