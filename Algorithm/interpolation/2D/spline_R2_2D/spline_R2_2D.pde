/*

purpose of this spline interpolation is dependence on squere of radius, without explicit computation of radius using 
squere root 

*/

float [][] tris;

int randIter(int seet) {
  final int a = 1664525;
  final int b = 1013904223;
  return (a*seet ^ b);
}

int randFunc( int r ){
r = randIter( r);
r = randIter( r);
return r; 
}

float splineR2( float r2 ){
  
  //return sq(1.0-r2);
  if( (r2>0.001)|(r2>1.0) ){ return sq(1.0-r2); }else{ return 0;  }
}

float interR2( float ar2, float br2,   float fa, float fb ){
 float wa = 1.0/(ar2+0.00001); 
 float wb = 1.0/(br2+0.00001);
 return  ( fa*wa + fb*wb ) / (wa + wb);
}

float getR2( float dx, float dy   ){
 //return (dx*dx+dy*dy);
 //return (dx*dx+dy*dy)*0.75;
 return (dx*dx+dy*dy)*0.866;
}


void setup(){
tris = new float[10][10];
for (int ix=0;ix<tris.length;ix++){ for (int iy=0;iy<tris[0].length;iy++){
   tris[ix][iy] = random(1.0);
}}
  
size (512,512);
colorMode(RGB,1.0);
background(0);

strokeWeight(4);
stroke(255);
for (int ix=0;ix<512;ix+=1){ for (int iy=0;iy<512;iy+=1){
  final float a = 16.0;
  float yf =  iy/a;                              
  float xf = (ix*0.86602540378 - 0.5*iy)/a;      
  
  int ity = int( yf +10000.0 ) - 10000; // fast floor
  int itx = int( xf +10000.0 ) - 10000;
  int seet = (itx<<16)+ity;
  
    //c = tris[itx][ity]; 
    float dx = itx*1.15470053839+0.57735026919*ity - ix/a;  
    float dy = ity                                 - iy/a;
    float c2 = splineR2( getR2( dx + 1.15470053839 , dy      ) );
    float c3 = splineR2( getR2( dx + 0.57735026919 , dy +1.0 ) );
    
    float c = c2*randFunc(  seet + 0x10000   ) +
              c3*randFunc(  seet +       1   );
    
    float c1;
    if( (yf + xf-(itx+ity) )<1.0 ){  
      c1=splineR2( getR2( dx , dy  ) );
      c+= c1 * randFunc(  seet );
    }else{
      c1=splineR2( getR2( dx + 1.15470053839+0.57735026919, dy + 1.0  ) );
      c+= c1 * randFunc(  seet  + 0x10001 );
    }
    c=(c/4294967296.0)+0.5;                                   
    set(ix,iy,color(c,c,c));
    //set(ix,iy,color(c1,c2,c3));
    //set(ix,iy,color(c1+c2+c3,0,0));


   
}}




}
