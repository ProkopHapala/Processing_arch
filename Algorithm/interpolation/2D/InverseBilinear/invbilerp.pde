
void bilerp( float u, float v, float x00, float x01, float x10, float x11,  float y00, float y01, float y10, float y11, float [] xy  ){
  float mv = 1 - v;
  float mu = 1 - u;
  xy[0] = mv*(  mu*x00 + u*x01 ) + v*( mu*x10 + u*x11 );
  xy[1] = mv*(  mu*y00 + u*y01 ) + v*( mu*y10 + u*y11 );
}


void invbilerp( float x, float y, float x00, float x01, float x10, float x11,  float y00, float y01, float y10, float y11, float [] uv ){
  float dx0 = x01 - x00;
  float dx1 = x11 - x10;
  float dy0 = y01 - y00;
  float dy1 = y11 - y10;
  
  float x00x = x00 - x;
  float xd   = x10 - x00;
  float dxd  = dx1 - dx0; 
  float y00y = y00 - y;
  float yd   = y10 - y00;
  float dyd  = dy1 - dy0;
  
  float c =   x00x*yd - y00y*xd;
  float b =   dx0*yd  + dyd*x00x - dy0*xd - dxd*y00y;
  float a =   dx0*dyd - dy0*dxd;
  //println ( " a,b,c = "+a+" "+b+" "+c   );
  float D2 = b*b - 4*a*c;
  //println ( " D2 = "+D2   );
  float D  = sqrt( D2 );

  float denom_x,denom_y, v1, v2;

  float u1 = (-b - D)/(2*a);
  denom_x = xd + u1*dxd;
  denom_y = yd + u1*dyd;
  if( abs(denom_x)>abs(denom_y) ){  v1 = -( x00x + u1*dx0 )/denom_x;  }else{  v1 = -( y00y + u1*dy0 )/denom_y;  }
  uv[0]=u1;
  uv[1]=v1;

 /* 
  // do you really need second solution ? 
  float u2 = (-b + D)/(2*a);
  denom_x = xd + u2*dxd;
  denom_y = yd + u2*dyd;
  if( abs(denom_x)>abs(denom_y) ){  v2 = -( x00x + u2*dx0 )/denom_x;  }else{  v2 = -( y00y + u2*dy0 )/denom_y;  }
  uv[2]=u2;
  uv[3]=v2;
 */ 
  
}



/*

derivation:

(1-v)*(  (1-u)*x00 + u*x01 ) + v*( (1-u)*x10 + u*x11 )     - x
(1-v)*(  (1-u)*y00 + u*y01 ) + v*( (1-u)*y10 + u*y11 )     - y

substituce:
dx0 = x01 - x00
dx1 = x11 - x10
dy0 = y01 - y00
dy1 = y11 - y10

(1-v) * ( x00 + u*dx0 )  + v * (  x10 + u*dx1  )  - x   = 0
(1-v) * ( y00 + u*dy0 )  + v * (  y10 + u*dy1  )  - y   = 0

x00 + u*dx0   + v*(  x10 - x00 + u*( dx1 - dx0 ) )  - x = 0
y00 + u*dy0   + v*(  y10 - y00 + u*( dy1 - dy0 ) )  - y = 0

substituce:
x00x = x00 - x
xd   = x10 - x00
dxd  = dx1 - dx0 
y00y = y00 - y
yd   = y10 - y00
dyd  = dy1 - dy0 

x00x + u*dx0   + v*(  xd + u*dxd )  = 0
y00x + u*dy0   + v*(  yd + u*dyd )  = 0

v = -( x00x + u*dx0 ) / (  xd + u*dxd  )
v = -( y00x + u*dy0 ) / (  yd + u*dyd  )

( x00x + u*dx0 ) / (  xd + u*dxd )  =  ( y00y + u*dy0 ) / (  yd + u*dyd  )

( x00x + u*dx0 ) * (  yd + u*dyd )  =  ( y00y + u*dy0 ) * (  xd + u*dxd  )

x00x*yd + u*( dx0*yd + dyd*x00x ) + u^2* dx0*dyd = ...   

substituce:
c =   x00x*yd - y00y*xd
b =   dx0*yd  + dyd*x00x - dy0*xd - dxd*y00y
a =   dx0*dyd - dy0*dxd

D2 = b*b - 4*a*c
D  = sqrt( b*b - 4*a*c )

u1 = (-b + D)/(2*a)
u2 = (-b - D)/(2*a)

*/
