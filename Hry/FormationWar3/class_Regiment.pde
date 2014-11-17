class Regiment{
  
  int facing=1;
  int owner;
  
  boolean passive;
  
  float stamina;
  float moral;  // how 
  int state;    // what is doing?
 
  int N_tot, N_active, N_wound, N_dead;
    
  Type type;
  Regiment target; // ?? should it be here? - pro stihani?
  
  PVector Pcenter,Pmin,Pmax;   // centre and bounding rectangle
  
  int n;
  Segment [] segs;    // formation line segments  
  Nod     [] nods;    // formation line nods
  
  void updateBounds(){
    for (int i=0; i<nods.length; i++){ 
      PVector p = nods[i].pos;
      if(p.x>Pmax.x){ Pmax.x=p.x; }else if (p.x<Pmin.x){Pmin.x=p.x;}   
      if(p.y>Pmax.y){ Pmax.y=p.y; }else if (p.y<Pmin.y){Pmin.y=p.y;}   
    }
    Pcenter.x = (Pmin.x+Pmax.x)*0.5; Pcenter.y = (Pmin.y+Pmax.y)*0.5;
  }
  
  void move(){
    if(!passive){
      for (int i=0; i<nods.length; i++){ nods[i].move(type.speed); }   //  move nods
      for (int i=0; i<segs.length;i++ ){ segs[i].update();         }   //  update segments
    }
    updateBounds();
  }
  
  void cmd_move( PVector L, PVector R ){
    // check orientation 
    p1.set(nods[0].pos);  p1.sub(nods[n].pos);
    p2.set(L);          p2.sub(R); 
    float cs =  PVector.dot( p1 , p2 );
    if (cs<0) { PVector temp=L;  L=R; R=temp; }    
    p1.set(R); p1.sub(L);  p1.mult(1.0/n); p2.set(L);  nods[0].setDir(p2);  
    for (int i=1; i<nods.length; i++){ p2.add(p1);  nods[i].setDir( p2 );   }  
  }
  
  void paint(){
   noStroke(); 
   if (owner==1){   fill(1.0,0.5,0.5);   }else{   fill(0.5,0.5,1.0);   }
   for (int i=0; i<segs.length;i++ ){  segs[i].paint(); }
   if (owner==1){   stroke(1.0,0.0,0.0);    }else{  stroke(0.0,0.0,1.0);     };  strokeWeight(3);
   for (int i=0; i<nods.length; i++){  nods[i].paint(); }
  }
 
 Regiment( Type type, int n, int N, PVector L, PVector R, int owner ){
   this.type=type; N_active = N_tot = N;  this.owner = owner;
   this.n = n;   segs = new Segment[n]; nods = new Nod[n+1];
   Pcenter = new PVector(); Pmin=new PVector(); Pmax=new PVector();
   // interpolate   nod pos()
   p1.set(R); p1.sub(L); p1.mult(1.0/n);
   for (int i=0; i<nods.length; i++){   nods[i] = new Nod ( new PVector( L.x+p1.x*i,L.y+p1.y*i,L.z+p1.z*i  )  );   }
   // create segments
   float dN = (float)N_active/( float)n;
   for (int i=0; i<segs.length;i++ ){   segs[i] = new Segment ( this, i, dN  );   }
   updateBounds();
 }
 
}
