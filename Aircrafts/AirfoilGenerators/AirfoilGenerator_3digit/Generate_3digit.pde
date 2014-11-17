void Generate_3digit(){
  
  float yscale = 0.1;
  
  int rdigit =9;
  int cdigit =9;
  int tdigit =9;
  
  upy = new float [4];    
  upx = new float [4];
  downy = new float [4] ; 
  downx = new float [4] ;
  
  float r =yscale*0.3 *  rdigit;    // leading edge radius
  float c =yscale*0.3 *  cdigit;    // camber
  float t =yscale*0.3 *  tdigit;    // thickness
  
  name = rdigit +"" + cdigit +""+ tdigit;
  println ("==============");
  println ("foil : "+name);
  println (" radius   "+(r*100)+"%");
  println (" camber   "+(c*100)+"%");
  println (" thicness "+(t*100)+"%");
  
 // name=nf(5*r,1)+nf(5*c,1)+nf(5*t,1);
 // println( int(r*5/yscale) +""+ int(c*5/yscale) +""+ int(t*5/yscale) );
  
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
