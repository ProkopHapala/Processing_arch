
class BezierN{
  int order;
  int [] binom;
  float [] tts;
  float [] ts;

BezierN(int order_){
  order=order_;
  binom=new int[order];
  tts=new float[order];
  ts=new float[order];
  binom[0]=1;
  for(int i=1;i<=order;i++){
  int temp=binom[0];
  for(int ii=1;ii<i;ii++){
    int temp2= binom[ii];
    binom[ii]=temp+binom[ii];
    temp = temp2;
  //  print(binom[ii]+" ");
  }
  //println();
  }
  for(int i=0;i<order;i++){
  //print(binom[i]+" ");
  }  
}

final void interpolate(float [] coefs, float [] output){
int n = output.length;
float step = 1.0/(float)n;
float t = 0;
for(int i=0;i<n;i++){
t+=step; float tt=1.0-t;
float ttemp=1.0; float tttemp=1.0;
for(int j=0;j<order;j++){  // generate powers of t
 ts[j] = ttemp;  tts[order-j-1] = tttemp;
 ttemp*=t;       tttemp*=tt;
}

//for(int j=0;j<order;j++){ println(ts[j]+" "+tts[j]);  }

output[i]=0;
for(int j=0;j<order;j++){  
output[i]+=coefs[j]*tts[j]*ts[j]*binom[j];
}
//println("=========="+output[i]);

}

}

}
