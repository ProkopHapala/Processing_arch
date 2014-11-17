// SMALL BINOMICAL COEFFICIENTS
// NOTE: for n>60 can overflow
// NOTE: time cost is O(n), for large n (like 10000) could be slow
double binom(int n,int k){
  int nk = n-k;
  if (k > nk) {k = nk; nk = n-k;}     // symmetry  (n,k) = (n,n-k)
  double bn = 1.0;
  for (int i = 1; i <= k; i++)        // (n-k)! cancel out 
  bn*= (double)(nk+i) / (double)i;  
  return bn;
}


// SMALL LOG_BINOMICAL COEFFICIENTS
// NOTE: for n>60 can overflow
// NOTE: time cost is O(n), for large n (like 10000) could be slow
double log_binom(int n,int k){
  int nk = n-k;
  if (k > nk) {k = nk; nk = n-k;}     // symmetry  (n,k) = (n,n-k)
  double bn = 0;
  for (int i = 1; i <= k; i++)        // (n-k)! cancel out 
  bn+= Math.log((double)(nk+i)) - Math.log((double)i);  
  return bn;
}


// BIG LOG_BINOMICAL COEFFICIENTS
// aproximation by fractorial of Srinivasa Ramanujan 1988
// NOTE: error is exponentialy decaying with N
double log_binom(double n,double k){
  return logfact(n)-logfact(k)-logfact(n-k);
}
