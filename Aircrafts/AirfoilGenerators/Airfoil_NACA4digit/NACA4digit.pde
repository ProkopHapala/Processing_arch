
void genNACA(float camber, float at, float thickness){
  float c1 =  0.2969;
  float c2 = -0.1260;
  float c3 = -0.3516;
  float c4 =  0.2843;
  float c5 = -0.1015;
  
  for (int i=0;i<n;i++){
   float x = (float)i/(float)n;
   float xx = x;
   
   float Yt = 0;
   Yt += c1*sqrt(xx);            xx*=x;
   Yt += c2*xx;                  xx*=x;
   Yt += c3*xx;                  xx*=x;
   Yt += c4*xx;                  xx*=x;
   Yt += c5*xx;  
   pthickness[i]=thickness*Yt;
   px[i] = x;
   
   float Yc = 0;
   if(x<at){ Yc = camber * x * (2*at - x)/(at*at);        }else{
             Yc = camber * (1.0-x) * (1+x - 2*at)/((1-at)*(1-at));        }
   
  pcamber[i]   = Yc;
  pcamber[i] = Yc; 
  }
  
  for (int i=1;i<n-1;i++){
   float dx = (px[i+1] - px[i-1]);
   float dy = (pcamber[i+1] - pcamber[i-1]);
   float r = sqrt(dx*dx+dy*dy);
   float Tx = -dy/r;
   float Ty = dx/r;
   pupy[i]   = pcamber[i] + pthickness[i] * Ty;
   pdowny[i] = pcamber[i] - pthickness[i] * Ty;
   pupx[i]   = px[i]      + pthickness[i] * Tx;
   pdownx[i] = px[i]      - pthickness[i] * Tx;
  }
  
}
