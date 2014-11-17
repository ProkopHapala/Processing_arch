String toBin(int ii){
 String s = "";
 for (int i=0; i<32; i++){
  if((ii&0x01)==0){s="0"+s;}else{s="1"+s;}
  ii=ii>>1;
 };
 return s;
};


String binIntend(int depth){
  char[]arr = new char[depth*m];
  //Arrays.fill(arr, ' ');
  Arrays.fill(arr, '_');
  return new String( arr ).intern();
}

void PaintGrid(){
for(int j=max_depth;j>0;j--){
  int nn = 1<<(j*m);
  stroke (80*j, 80*j);
  float dx = sz/( float )nn;
  for (int ix=0; ix<nn; ix++){
    float xx=dx*ix;
    line (0,xx,sz,xx);
    line (xx,0,xx,sz);
  }
}
}
