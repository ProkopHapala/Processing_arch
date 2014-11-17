void Generate_2(){
  
  float yscale = 0.1;
  float r = yscale  *0.25;
  
  float x1 =0.20;
  float x2 =0.66;
  
  float c1 =yscale*   1;
  float c2 =yscale*   1;
  
  float t1 =yscale*    2.0;
  float t2 =yscale*    0.25;
  
  // boundary points - constant
    upx[0]=0;        upx[0]=0.0;
  downx[0]=0;      downx[0]=0.0; 
    upx[4]=1.0;      upy[4]=0.0;
  downx[4]=1.0;    downy[4]=0.0;
  
  // leadin edge curvature
    upx[1]=0;   upy[1]=r;   // blunt leading edge
  downx[1]=0; downy[1]=-r;  // symetric curvature  

  // control points positions
  upx[2]=x1;  downx[2]=x1;  // symetric position 
  upx[3]=x2;  downx[3]=x2;
  
  // control points camber
  upy[2]=c1;  downy[2]=c1;  // symetric thickness
  upy[3]=c2;  downy[3]=c2;
  
  // control points thickness
  upy[2]+=0.5*t1;  downy[2]-=0.5*t1;  // symetric thicness
  upy[3]+=0.5*t2;  downy[3]-=0.5*t2;
  
};
