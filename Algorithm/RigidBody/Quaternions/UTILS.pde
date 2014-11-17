

String vec2string(double [] a){
  String s = "";
  for(int i=0; i<a.length; i++) {     s+=a[i]+" ";   }
  return s;
}

void printMat(double [][] A){
  for(int i=0; i<A.length; i++) {  println( vec2string(A[i]) );   };
}


void rand_vec( float radius, double [] R ){
  for (int i=0; i<R.length;  i++){ R[i] = random(-radius, radius);  }
}

final static float x2s( double x  ){
   return zoom*((float)x)+sz;
};



void plotVecInRotation( double [] v, double [][] R ){
  float x = x2s(  R[1][0]*v[0] + R[1][1]*v[1] + R[1][2]*v[2]     );
  float y = x2s(  R[2][0]*v[0] + R[2][1]*v[1] + R[2][2]*v[2]     );
  float x0 = x2s(0);
  //line( x0, x0,  x,  y  );
  point( x,  y  );
}


