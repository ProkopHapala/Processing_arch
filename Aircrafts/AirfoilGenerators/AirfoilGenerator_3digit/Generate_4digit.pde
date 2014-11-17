void Generate_4digit(){
  
  float yscale = 0.1;
  
  upy = new float [4];    
  upx = new float [4];
  downy = new float [4] ; 
  downx = new float [4] ;
  
  float r =yscale*   0.35;     // leading edge radius
  float c =yscale*   1.50;     // camber
  float t =yscale*   1.00;     // thickness
  
  float x =0.30;     // control point position
  
  // boundary points - constant
    upx[0]=0;        upx[0]=0.0;
  downx[0]=0;      downx[0]=0.0; 
    upx[3]=1.0;      upy[3]=0.0;
  downx[3]=1.0;    downy[3]=0.0;
  
  // leadin edge curvature
    upx[1]=0;   upy[1]=r;   // blunt leading edge
  downx[1]=0; downy[1]=-r;  // symetric curvature  

  // control points positions
  upx[2]=x;  downx[2]=x;  // symetric position 
  
  // control points camber
  upy[2]=c;  downy[2]=c;  // symetric thickness
  
  // control points thickness
  upy[2]+=0.5*t;  downy[2]-=0.5*t;  // symetric thicness
  
};
