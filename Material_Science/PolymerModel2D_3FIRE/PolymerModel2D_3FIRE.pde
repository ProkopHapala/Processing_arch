import java.util.*;

final int   sz   = 400;
final float zoom = 8;
final float fscale = 10;
final int perFrame = 10;
final static double atomSize = 2.0d;

double initialDist = 1.5;
double bondLength  = 1.5;
float randpos = 0.0; 

double wallstep   = 0.1; 
double kWall      = 10;
double wall_left  = -40; 
double wall_right = 40;
double wall_down  = -30;
double wall_up    = 30;

// GUI
boolean stop         = false;
boolean mouseForceOn = true;
int     i_applyForce = -1;
double  kMouse = 3.0;


//  Grid Accelaration

double binSize=3;
double iBinSize = 1/binSize;
int mbin = 40;
double binsx0 = - (binSize*mbin)/2;
double binsy0 = binsx0;
Atom [] bins   = new Atom[mbin*mbin];

final static double dt = 0.01; 

int nchain = 21; 
int m      = 41;
Atom [] atoms = new Atom[nchain*m];
Bond [] bonds;

final static double damping = 0.99;

void setup(){
  size(2*sz,2*sz);  
  rectMode(CORNERS);
  for(int i=0; i<atoms.length; i++ ){
    atoms[i] = new Atom( initialDist* ( (i%m) - m/2), random(-randpos,randpos)+initialDist*(i/m-nchain/2),   1, 2*( i%2 ) - 1 );
    atoms[i].id = i;
    //if( ((i%m)==0)&&(((i/m))%2==0) ) atoms[i].fixed=true; 
  }
  int ibond = 0;
  /*
  bonds = new Bond[nchain*(m-1)];
  for(int i=0; i<nchain; i++ ){
    for(int j=1; j<m; j++ ){
      bonds[ibond] = new Bond( atoms[i*m+j-1], atoms[i*m+j],  bondLength , 100 );
      ibond++;
    }
  }
    */
  
  
  bonds = new Bond[(nchain/2)*(m-1)];
  for(int i=0; i<=(3+nchain/2); i+=2 ){
    for(int j=1; j<m; j++ ){
      bonds[ibond] = new Bond( atoms[i*m+j-1], atoms[i*m+j],  bondLength , 100 );
      ibond++;
    }
  }
  
  //bonds = new Bond[0];
  if(bonds!=null) println( ibond+" "+bonds.length );
  
  for( Atom a : atoms ){ a.checkBin(); /*print( a.ibin+" " );*/ }
  
  //frameRate(5);
}

void draw(){
  if(!stop){
    for (int i=0; i<perFrame; i++){
      for( Atom a : atoms ){ a.cleanForce();   }
      for( Atom a : atoms ){ a.getWeakForce(); a.checkWalls(); }
      applyMouseForce();
      if(bonds!=null) for( Bond b : bonds ){ if(b!=null) b.assertForce();  }
      //move_FIRE();
      for( Atom a : atoms ){ a.friction(damping); a.move();   }
    }
  }
  println("============== "+frameCount+" "+frameRate );
  background(128);
  drawWalls();
  stroke(0);
  if(bonds!=null) for( Bond b : bonds ){ if(b!=null) b.plot(); }
  for( Atom a : atoms ){ a.plot(); }
  stroke(0);
  plotMouseForce();
  
  //noLoop();
  
  //int ncheck = 0;
  //for (int i=0; i<bins.length; i++ ) { Atom a = bins[i]; if(a!=null){ int na = numInBin(a); ncheck+=na; println( "in bin "+i+" "+na  );  }  }
  //println( "ncheck = "+ncheck  );
  
  //for( Atom a : atoms ){ a.checkBin(); print( a.ibin+" " ); }
}



void keyPressed(){
  switch(key){
    case ' ': stop=!stop; break;
    case '5': wall_up-=wallstep; wall_down-=wallstep; break;
    case '2': wall_up+=wallstep; wall_down+=wallstep; break;
    case '1': wall_left-=wallstep; wall_right-=wallstep; break;
    case '3': wall_left+=wallstep; wall_right+=wallstep; break;
    
    case '7': wall_up+=wallstep; wall_down-=wallstep; break;
    case '4': wall_up-=wallstep; wall_down+=wallstep; break;
    case '9': wall_left-=wallstep; wall_right+=wallstep; break;
    case '6': wall_left+=wallstep; wall_right-=wallstep; break;
  }  
}

void mousePressed(){
  int imin=-1; double r2min = atomSize*atomSize;
  double x = s2x(mouseX);
  double y = s2x(mouseY);
  for( int i=0; i<atoms.length; i++ ){ double r2 = atoms[i].dist2( x,y ); if(r2<r2min){r2min=r2; imin=i;}  }
  switch(mouseButton){
    case LEFT:   i_applyForce = imin; mouseForceOn=!mouseForceOn;   break;
    case RIGHT:  if(imin>=0){atoms[imin].fixed=!atoms[imin].fixed;}    break;
  }  
}

void applyMouseForce(){
  if( mouseForceOn && (i_applyForce>=0) ){
    double x = s2x(mouseX);
    double y = s2x(mouseY);
    atoms[i_applyForce].forceToTarget( kMouse, x, y );
  }
}

void plotMouseForce(){
  if( mouseForceOn && (i_applyForce>=0) ){
    double x = s2x(mouseX);
    double y = s2x(mouseY);
    Atom a = atoms[i_applyForce];
    line( x2s(a.x), x2s(a.y),  x2s( x ), x2s( y )  ); 
  }
}
