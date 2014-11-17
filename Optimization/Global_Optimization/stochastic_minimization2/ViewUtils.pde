
final int sz = 400;
final int sz2 = 2*sz;
final float pixsz = 1.0/(float)sz;

final int toSc(float f){
return int( f*sz + sz);
};

final void lineGene(Gen a, Gen b){
  line ( 
  a.DNA[0]*sz + sz,
  a.DNA[1]*sz + sz,
  b.DNA[0]*sz + sz,
  b.DNA[1]*sz + sz
  );
}

final void ellipseGenne( Gen a){
  ellipse(    a.DNA[0]*sz + sz,     a.DNA[1]*sz + sz, 4, 4  );
}

void paintGens(){
 stroke(255,0,0);
  for(int i=0;i<ngens;i++){
    ellipseGenne(population[i]);
 }
}

