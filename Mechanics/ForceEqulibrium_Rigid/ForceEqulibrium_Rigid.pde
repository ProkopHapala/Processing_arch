int cx=400; int cy=400;
float sc=100;

int iters_before_view=4;

float timescale = 0.7;
float damp = 0.9;
float dt; // estimated from stiffness
float kmax;
float maxd = 1.0;

Nod [] Nods;
Rod [] Rods;

void setup(){
  size(2*cx,2*cy);
  smooth();
  LoadMesh(); //(Nods,Sticks);
  for (int i=0; i< Rods.length;i++ ){Rods[i].init(); kmax = max(kmax,Rods[i].stiffness);}
  dt = timescale/sqrt(kmax);

  println ("kmax = "+ kmax + " N/m ");
  println ("dt = "+   dt   + " s "  );
  frameRate(30);
}

void draw(){
 background(200);
 // fill(200,50);
 // rect(0,0,2*cx,2*cy);
//  println(" ========  ");
  
 for (int i=0; i< Rods.length;i++ ){Rods[i].view();}
 fill(255,255);
 for (int i=0; i< Nods.length;i++ ){Nods[i].view();}
 
// println("= Rods =");
for (int iter=0; iter<iters_before_view; iter++){
 for (int i=0; i< Rods.length;i++ ){Rods[i].update();}
 for (int i=0; i< Nods.length;i++ ){Nods[i].update();}
}

 if(key==' '){noLoop();}
 
};
