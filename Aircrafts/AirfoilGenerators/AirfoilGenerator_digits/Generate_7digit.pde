void Generate_7digit(){

  float yscale = 0.1;
  
  upy = new float [5];    
  upx = new float [5];
  downy = new float [5] ; 
  downx = new float [5] ;
  
  int x1digit =4;
  int x2digit =3;
  int c1digit =6;
  int c2digit =3;
  int t1digit =5;
  int t2digit =1;
  int rdigit  =2;
   
  float r  =yscale*0.2  *  rdigit;    // leading edge radius
  float c1 =yscale*0.3  *  c1digit;    // camber
  float t1 =yscale*0.3  *  t1digit;    // thickness
  float x1 =0.05        *  x1digit;    // thickness
  float c2 =yscale*0.3  *  c2digit ;    // camber
  float t2 =yscale*0.3  *  t2digit ;    // thickness
  float x2 =0.5 +( 0.05 *  x2digit);    // thickness
  
  name =  x1digit +""+ x2digit
    +""+  c1digit +""+ c2digit 
    +""+  t1digit +""+ t2digit 
    +""+  rdigit;
  println ("==============");
  println ("foil : "+name);
  println (" leading edge radius "+(r*100)+"%");
  println (" camber   @"+(x1*100)+"%     "+(c1*100)+"%");
  println (" thicness @"+(x1*100)+"%     "+(t1*100)+"%");
  println (" camber   @"+(x2*100)+"%     "+(c2*100)+"%");
  println (" thicness @"+(x2*100)+"%     "+(t2*100)+"%");
  
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
