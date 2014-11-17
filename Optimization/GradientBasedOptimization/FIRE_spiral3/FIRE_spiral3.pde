
final int n=2;    // number of degrees of freedom

//float dt=0.15;

final float Fcriterium = 0.00001;

final float dtmax = 0.10;
float dt=dtmax;

boolean stop=false;
//float fmax=1;
//float vmax=1;

float damp=0.8;

final int sz=400; // size of screen

// Variables of state
// Energy
float E    = 0;
float oE   = 0;
float ooE  = 0;
// Force
float [] F   = new float[2];
float [] oF  = new float[2];
// Position 
float [] R   = new float[2];
float [] oR  = new float[2];
// Velocity
float [] V  = new float[2];
float [] oV  = new float[2];

// covergence informations
float normF = 0;
int iter;
float up = 0;

// visualization
int cl=0;


void setup() { 
  //size(sz*2, sz*2, P3D);
  size(sz*2, sz*2);	
  frameRate(10);
  ellipseMode(CENTER);   

  loadPixels();
  for(int ix=0;ix<2*sz;ix++){
     for(int iy=0;iy<2*sz;iy++){
      Potential(  (float)(ix-sz)/(float)sz,(float)(iy-sz)/(float)sz);
      float fcl  = 50+E*200; 
      pixels[ix + iy*width  ] = color( fcl,fcl,fcl );
  }}
  updatePixels();

   R[0]=-0.2;    R[1]=-0.8;
  oR[0]=oR[0]; oR[1]=R[1];
  V[0]=0.001;     V[1]=0.001;
  stroke(0,0,255);
  ellipse(sz*R[0]+sz,sz*R[1]+sz, 10, 10);
}

void draw() {
if(!stop){
  //stop=true;
  iter++;
  // backup things
  ooE = oE; oE=E;     toAcB(oF,F,1);    toAcB(oV,V,1);     toAcB(oR,R,1);
  Potential(R[0],R[1]);
  
  print (" iter = "+ iter);
  //Move_SD();
  //Move_MD();
  //Move_MDp();
   Move_MDp2();
  //if (iter>10){ Move_MDp2(); }else{  Move_MD(); }
  //if (iter>30){ Move_FIRE(); }else{  Move_MD(); }
  //if (iter>30){ Move_FIREpro(); }else{  Move_MD(); }
  //Move_FIRE();
  //Move_FIREpro();
  //Move_OMD();
  
  /*
  if (iter>10){
    normF = sqrt( sAB(F,F)); 
    if(normF>0.2){ 
      Move_MDp2();
    }else{
      Move_FIRE();
    } 
  }else{  
      Move_MD(); 
  }
 */

//stroke(255-cl,cl,0,64);
stroke(255-cl,cl,0);
line(sz*R[0]+sz,sz*R[1]+sz,sz*oR[0]+sz,sz*oR[1]+sz);
noFill();
//stroke(255-cl,cl,0,255); point(sz*R[0]+sz,sz*R[1]+sz);
ellipse(sz*R[0]+sz,sz*R[1]+sz, 2, 2);

// check lower energy ?
float diffE=(E-oE);
if (diffE<0){
  stroke(0,0,100);     line(iter,100,iter,100-log(-(E-oE))*10);
}else{
  stroke(100,0,0);     line(iter,100,iter,100-log((E-oE))*10);
}

stroke(0,100,0);
line(iter,2*sz-200,iter,2*sz-200-log(normF)*10);

normF = sqrt( sAB(F,F));	
print(iter+" up="+up+" E="+E+" F="+normF+"\n");

if ( normF<Fcriterium ) {    print("CONVERGENCE DONE");    noLoop();   }
}
}


void keyPressed(){
 if(key==' ')stop=!stop;
};

void mouseDragged(){
 Potential(float(mouseX - sz)/sz,float(mouseY - sz)/sz);
 line(mouseX + F[0]*10,  mouseY + F[1]*10, mouseX, mouseY );
}

