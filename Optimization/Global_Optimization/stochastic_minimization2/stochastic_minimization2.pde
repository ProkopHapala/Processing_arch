
// Parameters 
final float [] mingenDNA = { -0.9 , -0.9 }; // span of search space
final float [] maxgenDNA = {  0.9 ,  0.9 };
final float dE = 0.1;    // Energy of agent comparing to the best in order to stay alive 

int nEvaluations;
float E_min = -100000000;
int ngens = 10;

Gen temp;
Gen mingen,maxgen;
Gen [] population = new Gen[ngens];
//Gen [] memory = new Gen[nmemory];

void setup(){
size(sz2,sz2,P2D);
frameRate(10);
initEmap();
//paintEmap();

nEvaluations = 0;
temp = new Gen(new float[lgen]);
mingen = new Gen(mingenDNA);
maxgen = new Gen(maxgenDNA);
println(mingen);
println(maxgen);
init_random();

}

void draw(){
  paintEmap();
  
paintGens();
//noLoop();
evolve_randomWalk();
getEmin();

paintGens();

//println ("Evaulations: " + nEvaluations + "      E_min = " + E_min + "  " + population[0].fitness );
}
