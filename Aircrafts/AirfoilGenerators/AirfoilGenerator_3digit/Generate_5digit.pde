void Generate_5digit(){

  float yscale = 0.1;
  
  upy = new float [5];    
  upx = new float [5];
  downy = new float [5] ; 
  downx = new float [5] ;
  
  float r  =yscale*   0.25;
  float c1 =yscale*   1;
  float c2 =yscale*   1;
  float t1 =yscale*   2.0;
  float t2 =yscale*   0.25;
  
  // boundary points - constant
    upx[0]=0;        upx[0]=0.0;
  downx[0]=0;      downx[0]=0.0; 
    upx[4]=1.0;      upy[4]=0.0;
  downx[4]=1.0;    downy[4]=0.0;
  
  // leadin edge curvature
    upx[1]=0;   upy[1]=r;   // blunt leading edge
  downx[1]=0; downy[1]=-r;  // symetric curvature  

  // control points positions
  upx[2]=0.33;  downx[2]=0.33;  // symetric position 
  upx[3]=0.66;  downx[3]=0.66;
  
  // control points camber
  upy[2]=c1;  downy[2]=c1;  // symetric thickness
  upy[3]=c2;  downy[3]=c2;
  
  // control points thickness
  upy[2]+=0.5*t1;  downy[2]-=0.5*t1;  // symetric thicness
  upy[3]+=0.5*t2;  downy[3]-=0.5*t2;
  
};
