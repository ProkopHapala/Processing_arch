
class RndPow{
  
float fmin;
float fmax;
float n;

private float A,B;
private float unitRange;
  
RndPow(float n_, float fmin_, float fmax_){
  n = n_;
  fmin = fmin_;
  fmax = fmax_;
  unitRange = 1.0/(fmax-fmin); 
if (n== -1.0){
  A = log(fmin);
  B = log(fmax) - A;
}else{
  A = pow(fmin, n+1 );
  B = pow(fmax, n+1 ) - A;
}  
}

final float rnd(){
  float  r = random(1.0);  
  if (n== -1.0){
    return exp(  B*r + A );
  }else{
    return pow(  B*r + A,  1.0/(n+1) );
  }
}

final float rndUnit(){
 return (rnd() - fmin) * unitRange;
}

}
