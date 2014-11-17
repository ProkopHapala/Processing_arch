class ChainChaotic extends Chain{
  
void update(){
 int sig=1;
 for(int i=1;i<nchain-1;i++){
 sig=-sig;
 float dx=x[i]-x[i-1];
 float dy=y[i]-y[i-1];
 float r = sqrt(dx*dx+dy*dy);
 dx/=(r+0.001);dy/=(r+0.001);
 
 float dx2=x[i+1]-x[i];
 float dy2=y[i+1]-y[i];
 float r2 = sqrt(dx2*dx2+dy2*dy2);
 dx2/=(r2+0.001);dy2/=(r2+0.001);
 x[i] = x[i-1] + (dx+sig*dinamic*dx2)*sl;
 y[i] = y[i-1] + (dy-sig*dinamic*dy2)*sl;

 }
 
 float dx=x[nchain-1]-x[nchain-2];
 float dy=y[nchain-1]-y[nchain-2];
 float r = sqrt(dx*dx+dy*dy);
 dx/=(r+0.001);dy/=(r+0.001);
 x[nchain-1] = x[nchain-2] + dx*sl;
 y[nchain-1] = y[nchain-2] + dy*sl;
 

}

}



ChainChaotic chainChaotic = new ChainChaotic(); 
