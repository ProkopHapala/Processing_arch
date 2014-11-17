String vec2string(double [] a){
  String s = "";
  for(int i=0; i<a.length; i++) {     s+=a[i]+" ";   }
  return s;
}

void printMat(double [][] A){
  for(int i=0; i<A.length; i++) {  println( vec2string(A[i]) );   };
}


final void randomVec( float radius, double [] a){
  for(int i=0; i<a.length; i++) {  a[i] += random(-radius,+radius);   }
}

final void randomMat( float radius, double [][] A ){
 for(int i=0; i<A.length; i++) {  randomVec( radius, A[i] );  }
}
