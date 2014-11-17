
// SMALL BINOMICAL COEFFICIENTS
// NOTE: for n>60 can overflow
// NOTE: time cost is O(n), for large n (like 10000) could be slow
double binomdist(int n,int k){
  int nk = n-k;
  if (k > nk) {k = nk; nk = n-k;}     // symmetry  (n,k) = (n,n-k)
  double bn = 1.0;
  for (int i = 1; i <= k; i++)        // (n-k)! cancel out 
  bn*= (double)(nk+i) / (double)(4*i);  
  int d = nk-k;
  int norm2 = (1 << d);  // 2^(nk-k)
  return bn/norm2;
}


// SMALL LOG_BINOMICAL COEFFICIENTS
// NOTE: time cost is O(n), for large n (like 10000) could be slow
double binomdist_log(int n,int k){
  int nk = n-k;
  if (k > nk) {k = nk; nk = n-k;}     // symmetry  (n,k) = (n,n-k)
  double bn = 0;
  for (int i = 1; i <= k; i++)        // (n-k)! cancel out 
  bn+= Math.log((double)(nk+i)) - Math.log((double)i);  
  return Math.exp(bn - n*0.69314718055994500); // n*log(2)
}

// BIG LOG_BINOMICAL COEFFICIENTS
// aproximation by fractorial of Srinivasa Ramanujan 1988
// NOTE: error is exponentialy decaying with N
double logbinomdist(double n,double k){
  //return logfact(n)-logfact(k)-logfact(n-k)-n*0.69314718055994500;
  return log_binom(n,k)-n*0.69314718055994500;
}
