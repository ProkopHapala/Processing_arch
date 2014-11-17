void setup(){

for (int i = 1; i<100;i++){
double lf1 = logfact(i); 
double lf2 = logfact((double)i);  
double f3 = fact(i);
double lf3=Math.log(f3);
print(i);
//print(" "+f3);
//print(" "+lf3);
print(" "+lf1);
print(" "+lf2);
println();
}

}
