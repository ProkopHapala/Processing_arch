
class Relaxator{

// parameters
float rnd_size  = 0.05;
  
// variables 
float    E;
float [] X;
float [] newX, rndX;


Relaxator( float [] X){   init( X); };
Relaxator(){};
void init( float [] X ){ this.X=X; newX= new float[X.length]; rndX= new float[X.length]; this.E = +100000000; }

boolean move(){
  float rndR2 = 0;
  for (int i=0; i<X.length; i++){  rndX[i] = random(-1,1); rndR2+=sq(rndX[i]);  }
  float rndsc = random(rnd_size)/sqrt(rndR2);
 // println ( " rndsc "+rndsc+"      rndX= "+arrayToStr(rndX) );
  for (int i=0; i<X.length; i++){  newX[i] = X[i]+rndsc*rndX[i];  }
  float newE = getE( newX );
  if(newE<E){
    stroke(255,0,0); line(  sx(X),sy(X), sx(newX),sy(newX) ); ellipse(sx(newX),sy(newX),2,2);
    for (int i=0; i<X.length; i++){   X[i] = newX[i];          }  
    E=newE;
    return true;
  }else{
    stroke(0,128,0);  point(sx(newX),sy(newX));
    return false;
  }
};

}
