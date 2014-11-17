/*

  This is my atempt to produce the simplest and the fastest noise function in 2D
  it is composed of three parts:
   1) map given (x,y) coordinate to som trinagle (simplex) from regular simplex tiling
      we obtain index of triangle vertexes itx,ity and float coordinate inside the triangle (dx,dy)
   2) compute square of distance (r2) from the vertexes of the trinagle. 
   3) Evaluate weights of vertexes as decaying spline. We don't want use sqrt() function because it is quite slow.
      function splineR2 is able to produce smooth function just from r2 without evaluation of r
   4) Evaluate pseudo-random hash from indexes of vertexes. We use multiply and xor. also other function and "magic numbers" can be used   
   6) interpolate between the random values from the vertexes. Thanks to equally spaced vertexes we can approximate the interpolation by 
      simple sum of weighted basisfuctions 
*/

int randFunc( int r ){
r = 1664525*r ^ 1013904223;
r = 1664525*r ^ 1013904223;
return r; 
}

float [][] tris; // we can use some array instead random function;

float splineR2( float r2 ){  
  return sq(1.0-r2);
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

float VerySimpexNoise2D( float x, float y ){
  float yf =  y;                              
  float xf = (x*0.86602540378 - 0.5*y);      
  int ity = int( yf +10000.0 ) - 10000; // fast floor
  int itx = int( xf +10000.0 ) - 10000;
  int seet = (itx<<16)+ity;
  float dx = itx*1.15470053839+0.57735026919*ity - x;  
  float dy = ity                                 - y;
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
  return (c/4294967296.0)+0.5; 
}    
