
class CommodityState{

boolean insufficient = false;
CommodityType type;

float stored       =0;
float onTheWay     =0;
float should_store =10000;

float demand       =0;
float excess       =0;

float production   =0;
float consumption  =0;

void update(){
  demand = max(0, should_store-(stored+onTheWay) );
  excess = max(0, should_store- stored           );
}

CommodityState(CommodityType type_, float stored_){
  type = type_;
  stored = stored_;
} 

}


