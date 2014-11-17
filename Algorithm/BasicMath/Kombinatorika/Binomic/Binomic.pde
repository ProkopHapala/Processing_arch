void setup(){
int n = 50;
for (int i = 0; i<n+1;i++){
//double b = binom(n,i); 
//double lb = Math.log(b);
double lb1 = log_binom(n,i); 
double lb2 = log_binom((double)n,(double)i); 
print(" "+i);
//print(" "+b);
//print(" "+lb);
print(" "+lb1);
print(" "+lb2);
println();
}

}
