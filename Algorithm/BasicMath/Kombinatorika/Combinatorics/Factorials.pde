// SMALL LOG_N_FACTORIAL
// note time cost is O(n), for large n (like 10000) could be slow 
double logfact(int n){
double f = 0;
for(int i=0;i<n;i++){
f+= Math.log(n-i);
}
return f;
}

// SMALL N_FACTORIAL
// note time cost is O(n), for large n (like 10000) could be slow, numbers can ovreflow
double fact(double n){
double f = 1.0;
for(int i=0;i<n;i++){
f*=(n-i);
}
return f;
};

// BIG LOG_N_FACTORIAL
// aproximation by Srinivasa Ramanujan 1988
double logfact(double n){
double f=0;
f+=n*Math.log(n);
f-=n;
f+=0.5723649568384674; // 0.5723649568384674 is log(PI)/2  
f+=Math.log(n+4*n*n+8*n*n*n)/6;
return f;
}
