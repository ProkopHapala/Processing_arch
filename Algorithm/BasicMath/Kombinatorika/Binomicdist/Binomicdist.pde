void setup(){
int n = 30;
for (int i = 0; i<n+1;i++){
double b = binomdist(n,i); 
//double lb = Math.log(b);
double b1 = binomdist_log(n,i); 
double b2 = Math.exp(logbinomdist((double)n,(double)i)); 
print(" "+i);
print(" "+b);
//print(" "+lb);
print(" "+b1);
print(" "+b2);
println();
}

}
