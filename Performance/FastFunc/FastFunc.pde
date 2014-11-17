

final int m = 10000000;

int sec;
int msec;

void setup() {
/*
int n = 20;

float dt = 2*PI/n;
//float dt = 0.1;

for (int i = 0; i<n;i++){
//double b = binom(n,i); 
//double lb = Math.log(b);
float x = i*dt; 

//float f = (float)Math.cos((double)x); 
//float f1 = sin2(x); 

float f = sin(x); 
float f1 = sintab(x); 

//float f = exp(x); 
//float f1 = (float) exp1((double)x); 
//float f1 = exp1(x); 
//float f = exp(x); 

//float f = sqrt(i*i); 

//float f = log(i*i); 
//float f1 = (float)exp1((double)i*i); 

//float f = pow(i*i*i*i,0.25); 
//float f1 = (float)fpow((double)i*i*i*i,0.25); 

//float f = sqrt(i*i); 
//float f1 = sqrt1(i*i); 

print(" "+x);
print(" "+f);
print(" "+f1);
print(" "+(f-f1));
//print(" "+(i-f1));
println();
}

*/


  sec = second();
  msec = millis();
  
  float test = 0;
  for (int i = 0; i<m;i++){
  //test+= (float)pow1((double)i*i,0.5);
  //test+= pow(i*i,0.5);
  
  //test+= (float)fsqrt((double)i);
  //test+= (float)fpow((double)1.0/i,0.5);
  //test+= (float)Math.sqrt((double)1.0/i);
  
  //test+=fsin(i);
  test+=sintab(i%1000);
  //test+=sin(i%100);
  //test+=cos(i);
  //test+=tan(i);
  
  //test+=log(i);
  //test+=exp(1.0/i);
  
  //test+=exp((float)i);
  //test+=exp1(i);
  //test+=fexp(1.0/i);
  //test+=smallexp(1.0/i);
  }
  
  
  int time = 1000*(second()-sec)+millis()-msec;  
  println (m+" ops");
  println (time+" ms");
  println (time/float(m)+" ms/ops");
  println (float(m)/time+" ops/ms");



}






