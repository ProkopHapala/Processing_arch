
// Parameters 
final float [] mingenDNA = { -0.9 , -0.9 }; // span of search space
final float [] maxgenDNA = {  0.9 ,  0.9 };
final float stepMin   = 0.05;  // Step size of leads frustrated
final float stepRange = 0.5;   // Step size of most frustrated is stepMin+stepRange
final float dFitness = 0.5;    // Energy of agent comparing to the best in order to stay alive
final float minDist  = 0.05;   // Minimal distance two genes can go together

int nEvaluations;
int iBest=0;
float maxFitness = -100000000;
int ngens = 10;

Gen temp;
Gen mingen,maxgen;
Gen [] population = new Gen[ngens];
//Gen [] memory = new Gen[nmemory];

void setup(){
size(sz2,sz2,P2D);
frameRate(5);
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

//noLoop();
evolve_randomWalk();
fill(255,255,255); paintGens();
getMaxFitness();

//println ("Evaulations: " + nEvaluations + "      E_min = " + E_min + "  " + population[0].fitness );
}
