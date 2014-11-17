
int lgen = 2;   // 2D dimensional genes

class Gen{
float [] DNA;
float fitness;
boolean aLive;

/////////////////////////
//       Breed new     //
/////////////////////////

final void combine_random( Gen mother,Gen father){
for(int i=0;i<DNA.length; i++ ){
 float t = random(1.0);
 DNA[i] = t*mother.DNA[i]  + (1.0-t)*father.DNA[i] ;  
}
}

final void mutate_random( Gen source, float Rmax){
for(int i=0;i<DNA.length; i++ ){
// float dRi = random(-Rmax, Rmax);
// float dRi = randomsq(Rmax);
 DNA[i] = source.DNA[i]+rndSq()*Rmax;
}}

////////////////////////////////
//          UTILS             //
////////////////////////////////

final boolean reasonable(){
boolean OK = true;
for(int i=0;i<DNA.length; i++ ){
 if ((DNA[i] < mingen.DNA[i]) || (DNA[i] > maxgen.DNA[i])) {   OK = false; break;}
}
return OK;
}

final boolean toClose(Gen From){
  if(distance(From)<minDist){ return true; }else{return false;}
}

final float distance(Gen From){
float R2 = 0;
for(int i=0;i<DNA.length; i++ ){
 float dx = DNA[i] - From.DNA[i];
 R2 +=(dx*dx); 
}
return sqrt(R2);
}

final void clone(Gen source){
fitness = source.fitness;
aLive = source.aLive;
for(int i=0;i<DNA.length; i++ ){
 DNA[i] = source.DNA[i];
}}

/////////////////////////////////////////
/////////////////////////////////////////

Gen( float[] DNA_ ){
DNA = DNA_;
fitness = 0;
aLive = true;
}

String toString(){
 String s = " "+fitness;
 for(int i=0;i<DNA.length; i++ ){
 s = s + " " + DNA[i]; }
 return s;
}

}


