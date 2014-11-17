
int lgen = 2;   // 2D dimensional genes

class Gen{
float [] DNA;
float fitness;

Gen( float[] DNA_ ){
DNA = DNA_;
fitness = 0;
}

//                            //
//          UTILS             //
//                            //

final boolean reasonable(){
boolean OK = true;
for(int i=0;i<DNA.length; i++ ){
 if ((DNA[i] < mingen.DNA[i]) || (DNA[i] > maxgen.DNA[i])) {   OK = false; break;}
}
return OK;
}


final void clone(Gen source){
fitness = source.fitness;
for(int i=0;i<DNA.length; i++ ){
 DNA[i] = source.DNA[i];
}}

/*
final void constrain_range( Gen mingen, Gen maxgen){
for(int i=0;i<DNA.length; i++ ){
 if      (DNA[i] < mingen.DNA[i]) {DNA[i] = mingen.DNA[i];}
 else if (DNA[i] > maxgen.DNA[i]) {DNA[i] = maxgen.DNA[i];}
}}
*/

/*
final void roundgen(float step){
for(int i=0;i<DNA.length; i++ ){
 DNA[i] = step*round(DNA[i]/step);
}}
*/

//                     //
//       Breed new     //
//                     //

final void combine_random( Gen mother,Gen father){
for(int i=0;i<DNA.length; i++ ){
 float t = random(1.0);
 DNA[i] = t*mother.DNA[i]  + (1.0-t)*father.DNA[i] ;  
}
}

final void mutate_random( Gen source, float Rmax){
for(int i=0;i<DNA.length; i++ ){
// float dRi = random(-Rmax, Rmax);
 float dRi = randomsq(Rmax);
 DNA[i] = source.DNA[i]+dRi;
}}

String toString(){
 String s = " "+fitness;
 for(int i=0;i<DNA.length; i++ ){
 s = s + " " + DNA[i]; }
 return s;
}

}


