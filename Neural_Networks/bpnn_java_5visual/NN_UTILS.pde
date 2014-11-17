// our sigmoid function, tanh is a little nicer than the standard 1/(1+e^-x)
final static double sigmoid( double x){
  return Math.tanh(x);
}

// derivative of our sigmoid function, in terms of the output (i.e. y)
final static double dsigmoid( double y){
  return 1 - y*y;
}

void evalLayer( double [] in, double w [][], double [] out  ){
  double sum = 0;
  for(int j=0;j<out.length;j++){
    sum=0;
    for(int i=0;i<in.length;i++){ sum+=in[i]*w[i][j]; }
    //println ( j+"  "+ sum );
    out[j] = sigmoid( sum );
  }
}


