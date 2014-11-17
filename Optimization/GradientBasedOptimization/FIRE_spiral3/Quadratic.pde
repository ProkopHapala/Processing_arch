
float K=0;
float dropt=0;

void Parabola(float [] F1, float [] F2, float [] R,int n){
  float df1 = AonB(F1,R);
  float df2 = AonB(F2,R);
  float   r =  sAB( R,R); 
  
  /*
  print ("\n");
  print ("R=   " +R[0] +"   "+R[1]+ "\n");
  print ("F1=  "+F1[0]+"   "+F1[1]+"\n");
  print ("F2=  "+F2[0]+"   "+F2[1]+"\n");
  */
  print ("df1="+df1+" df2="+df2+" r="+r+"\n");
  
  K=0.5*(df2-df1)/r;
  dropt = -df1/(2*K)/r;
  
  print ("k= "+K+" opt= "+dropt+"\n");
}
