
////////////////////////////////////////////////
//   
//    Vector operation utilities
//
////////////////////////////////////////////////

// set all components of A to float f
final void setAf(float A[], float f ){
  for(int i=0;i<A.length;i++){A[i]=f;}
}

// add float f to all components of A
final void addAf(float A[], float f){
  for(int i=0;i<A.length;i++){A[i]+=f;}
}

// mult all components of A by float f
final void multAf(float A[], float f){
  for(int i=0;i<A.length;i++){A[i]*=f;}
}

// copy all componets of A to B
final void AcpB( float A[], float B[] ){
  for(int i=0;i<A.length;i++){A[i]=B[i];}
}

// scalar product s = <A|B>
final float dotAB(float A[],float B[]){
  float s=0;
  for(int i=0;i<A.length;i++){s+=A[i]*B[i];}
  return s;
}

// point multiply  A[i] = A[i] * B[i]
final void AxB(float A[],float B[]){
for(int i=0;i<A.length;i++){A[i]*=B[i];}
}

// A <- c*B
final void toAcB(float A[],float B[],float c){
for(int i=0;i<A.length;i++){A[i]=c*B[i];}
}

// linar combination A = A + c*B
final void adAcB(float A[],float B[],float c){
for(int i=0;i<A.length;i++){A[i]+=c*B[i];}
}

// 
//   MORE COMPLEX THINGS
//

//  Bound length of A by rmax
final void BoundA(float [] A, float rmax){
float r = sqrt(dotAB(A,A));
if (r>rmax){ toAcB(A,A,rmax/r); }
}

// from A let part orthogonal to B
final void AortoB(float A[],float B[]){
float  c = dotAB(A,B);  // projection A on B
float rB = dotAB(B,B);  // length of B
adAcB(A,B,-c/rB);
}

// from A let part parael to B
final void AparaB(float A[],float B[]){
//float  c = cosAB(A,B);  // projection A on B
float  c  = dotAB(A,B);  // projection A on B
float rB2 = dotAB(B,B);  // length of B
//float rA = sqrt(sAB(A,A));  // length of B
toAcB(A,B, c/rB2 );
}

// redirect A to direction of B
final void AdirB(float A[],float B[]){
float rA = sqrt(dotAB(A,A));  // projection A on B
float rB = sqrt(dotAB(B,B));  // length of B
toAcB(A,B,rA/rB);
}

// compute cos of angle between A nad B
final float AonB(float A[],float B[]){
float rB = sqrt(dotAB(B,B));  // length of B
float  c = dotAB(A,B);  // projection A on B
return ( c/rB);
}

// compute cos of angle between A nad B
final float cosAB(float A[],float B[]){
float rA = sqrt(dotAB(A,A));  // length of A
float rB = sqrt(dotAB(B,B));  // length of B
float  c = dotAB(A,B);  // projection A on B
return ( c/(rB*rA));
}
