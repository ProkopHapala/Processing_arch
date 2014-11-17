//class Druh;
//class Unit;
//class Vojak;

///------------------////
///--- settingas ----////
///------------------////

float dt = 0.05;
int kolo = 0;

float vmax = 1;
float att = 0.1;

float roff = 1;
float moff = 10;

int player = 1;
Unit chosen;
Unit[] friend;
Unit[] enemy;
String mode="move";

PVector Up = new PVector(0,0,1);
PVector mouse = new PVector();

class Unit{
  int clr = 0xFF000000;
  PVector p = new PVector(); // poloha
  PVector dp = new PVector(); // vektro rychlosti
  Unit T; // cil
  int fighting;

  float s = 100; //veliskost
  //float v = 0.1; //max rychlost

  Unit(PVector p_,int clr_){
    p = p_;
    clr = clr_;
  };

  void move(){
    if (T!=null){
    dp.set(T.p); 
    dp.sub(p); 
    //c = min(dp.mag()/(2*dt*D.v),1); // dumping kdyz je blizko
    //print (" "+c);
    if (dp.mag()>roff) {
      dp.normalize(); 
      dp.mult(dt*vmax);
      p.add(dp);
    }else{if(fighting==1)fight();}
    }
  };
  
  void fight(){
    T.T=this;T.fighting =1;
    if ((T.s>0)&&(s>0)){
    T.s-=s*att*dt;} else {
      T.fighting =0;
      fighting =0;
      T.T=null;
      T=null;
    }
  };

  void paint(){
    stroke(clr,100);
    strokeWeight(15); // sirka cary
    point(p.x,p.y);
    //strokeWeight(10); // sirka cary
    //point(T.p.x,T.p.y);
    strokeWeight(3);
    if (T!=null)line(T.p.x,T.p.y,p.x,p.y);
    fill(clr);
    text(s,p.x,p.y);
  };
};


Unit[] u1 = new Unit[10];
Unit[] u2 = new Unit[10];

//////////////////////////////
////// --- RUNTIME ---- //////
//////////////////////////////


void setup() {
  PFont fontA = loadFont("serif.vlw");
  textFont(fontA, 10);
  size(800, 800);
  smooth(); 


  // predator
  for(int i = 0;i<u1.length;i++){
    u1[i] = new Unit( new PVector(random(0,800),random(0,400),0),0xFFFF0000);
    u2[i] = new Unit( new PVector(random(0,800),random(400,800),0),0xFF0000FF);
    //u1[i].T = u1[i];
    //u2[i].T = u2[i];
  }
  friend=u1;
  enemy=u2;
}

void draw() {
  background(226);

  mouse.set(mouseX,mouseY,0);
  kolo++;

  for(int i = 0;i<u1.length;i++){
    u1[i].move();
    u2[i].move();

    u1[i].paint();
    u2[i].paint();
  }
  
  if(chosen!=null){
  stroke(0xFF00FF00);
  strokeWeight(5);
  point(chosen.p.x,chosen.p.y);
  }

}


Unit FindNear(Unit[] where,PVector to){
  float rmin = 10000000;
  int imin = 0;
  for(int i = 0;i<where.length;i++){
    to.set(mouseX,mouseY,0);
    to.sub(where[i].p);
    float mg = to.mag();
    if (mg < moff){
      rmin = mg; 
      imin = i;
    }
  }
  if (rmin<moff){
    return(where[imin]);
  }
  else {
    return(null);
  }
}

void mousePressed() 
{
  Unit found;
   if(chosen==null){
      found = FindNear(friend,mouse);
      if (found!=null){
        chosen=found;
      }
    }
    else{
      if (mode=="move"){
        chosen.T = new Unit(new PVector(mouseX,mouseY,0),0xFF000000);
      }
      if (mode=="attack"){
        found = FindNear(enemy,mouse);
        if (found!=null)chosen.T = found;
      }
    }


};

void keyPressed(){
  if (key ==' ') {
    player = -player; 
    chosen=null; 
    println("player = "+player);
    if(player==1){friend=u1;enemy=u2;} 
    if(player==-1){friend=u2;enemy=u1;}
    
  }
  if (key =='c') {
    chosen = null;
  }                              //vyber
  if (key =='a'){
    mode="attack"; 
    println("Mode = attack");
    if(chosen!=null)chosen.fighting = 1;
  }          //utok
  if (key =='m'){
    mode="move"; 
    println("Mode = move");
    if(chosen!=null)chosen.fighting = 0;
  }              //pohyb
}

