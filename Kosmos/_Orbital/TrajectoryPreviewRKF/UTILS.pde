

void paintAxis( int n, int step, int sc){
for (int i=0; i<(n+1); i++){
  line (20,20+i*step,220,20+i*step);
  text( sc*i*step, 223, 23+i*step );
}
}

void setVec(double pError, double vError, double [] Xsc ){
 Xsc[0]=pError; Xsc[1]=pError; Xsc[2]=pError;
 Xsc[3]=vError; Xsc[4]=vError; Xsc[5]=vError;
};


void cpVec( double [] from, double [] to ){
  for (int i=0; i<from.length; i++){   to[i] = from[i]; }
};
