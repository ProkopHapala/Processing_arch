
class Segment{
  Regiment of;
  int ith; 
  float N;          // number of active soldiers
  DamageBuffer dmg;
  float ranks;
  float span;
  
  Segment( Regiment of, int i, float N ){
    this.of=of; this.N=N; ith = i;
    //DamageBuffer = new DamageBuffer(); 
  }
  
  void update(){
    span = of.nods[ith].pos.dist(of.nods[ith+1].pos);
    ranks = N / (span*of.type.width);
  }
  
  void paint(){
   float depth = ceil(ranks)*of.type.depth*of.facing;
   PVector L = of.nods[ith].pos;  PVector R = of.nods[ith+1].pos; 
   float nx = (L.y - R.y)/span;  float ny = (R.x - L.x)/span;    
  // println( " paint: "+ith+" " + L +"  "+ R +" "+ nx+"  "+ny +"  | "+ N +" "+ ranks +" "+ depth  );
   beginShape();
    vertex(L.x, L.y);
    vertex(R.x, R.y);
    vertex(R.x+ nx*depth, R.y + ny*depth );
    vertex(L.x+ nx*depth, L.y + ny*depth );
   endShape(CLOSE);
  }

} 
