void Generate_3digit(){
  
  float yscale = 0.1;
  
  upy = new float [4];    
  upx = new float [4];
  downy = new float [4] ; 
  downx = new float [4] ;
  
  int rdigit =2;
  int cdigit =6;
  int tdigit =3;
    
  float r =yscale*0.2 *  rdigit;    // leading edge radius
  float c =yscale*0.3 *  cdigit;    // camber
  float t =yscale*0.3 *  tdigit;    // thickness
  
  name = cdigit+""+ tdigit+""+rdigit;
  println ("==============");
  println ("foil : "+name);
  println (" leading edge radius   "+(r*100)+"%");
  println (" camber   @50%         "+(c*100)+"%");
  println (" thicness @50%         "+(t*100)+"%");
  
  // boundary points - constant
    upx[0]=0;        upx[0]=0.0;
  downx[0]=0;      downx[0]=0.0; 
    upx[3]=1.0;      upy[3]=0.0;
  downx[3]=1.0;    downy[3]=0.0;
  
  // leadin edge curvature
    upx[1]=0;   upy[1]=r;   // blunt leading edge
  downx[1]=0; downy[1]=-r;  // symetric curvature  

  // control points positions
  upx[2]=0.5;  downx[2]=0.5;  // symetric position 
  
  // control points camber
  upy[2]=c;  downy[2]=c;  // symetric thickness
  
  // control points thickness
  upy[2]+=0.5*t;  downy[2]-=0.5*t;  // symetric thicness
  
};
