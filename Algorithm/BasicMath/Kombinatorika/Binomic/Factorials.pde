// SMALL N_FACTORIAL
// NOTE: for n>60 can overflow
// NOTE: time cost is O(n), for large n (like 10000) could be slow
double fact(double n){
double f = 1.0;
for(int i=0;i<n;i++){
f*=(n-i);
}
return f;
};

// SMALL LOG_N_FACTORIAL
// NOTE: time cost is O(n), for large n (like 1000) could be slow!!!! 
double logfact(int n){
double f = 0;
for(int i=0;i<n;i++){
f+= Math.log((double)(n-i));
}
return f;
}

// BIG LOG_N_FACTORIAL
// aproximation by Srinivasa Ramanujan 1988
// NOTE: error is exponentialy decaying with N
double logfact(double n){
double f=0;
f+=n*Math.log(n);
f-=n;
f+=0.5723649568384674; // 0.5723649568384674 is log(PI)/2  
f+=Math.log(n+4*n*n+8*n*n*n)/6;
return f;
}
