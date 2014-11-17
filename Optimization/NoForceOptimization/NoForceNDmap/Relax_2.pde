

class Relaxator_2 extends Relaxator{
  
  // parameters
  /*
  float dir_max   = 1.3;
  float dir_decay = 0.98;  
  float rnd_size  = 0.01;
  float dir2rnd   = 0.1;
  */
     
  float dir_max   = 1.2;
  float dir_decay = 0.9;  
  float rnd_size  = 0.01;
  float dir2rnd   = 0.2;
  
  // variables
  float odR2;
  float dirsc;  
  float [] odX;
  
  Relaxator_2( float [] X){   init( X ); odX= new float[X.length]; }
  Relaxator_2(){};
  
  boolean move(){
  float rndR2 = 0;
  for (int i=0; i<X.length; i++){  rndX[i] = random(-1,1); rndR2+=sq(rndX[i]);  }
    float rndsc = sqrt(random(sq(rnd_size)+ dir2rnd*dirsc*odR2)/rndR2);
    for (int i=0; i<X.length; i++){  newX[i] = X[i] + dirsc*odX[i] + rndsc*rndX[i];     }
    float newE = getE( newX );
    if(newE<E){
      dirsc=dir_max;
      odR2 = 0;
      stroke(255,0,0); line(  sx(X),sy(X), sx(newX),sy(newX) ); ellipse(sx(newX),sy(newX),2,2);
      for (int i=0; i<X.length; i++){
          odX[i]  = newX[i] - X[i];
          X  [i]  = newX[i];
          odR2   += sq(odX[i]);
      } 
      E=newE;
      return true;
    } else {
      dirsc*=dir_decay;
      return false;
    }
  }

}
