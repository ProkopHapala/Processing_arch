


void Jtrans( float x0, float y0 ){
  for (int i=0; i<Cre.length; i++){
     float Cx = Cre[i] + x0;
     float Cy = Cim[i] + y0;
     float R2 = Cx*Cx + Cy*Cy;
     float iR2 = 1.0/R2;
     Zre[i] = Cx * (R2 + 1) * iR2;
     Zim[i] = Cy * (R2 - 1) * iR2;
  }
};



float RCirc_Func(){
   float x_ = (1.0-x0);
   return sqrt( x_*x_ + y0*y0 );
   //return sqrt( x0*x0 + y0*y0 );
}

float Gamma_Func( ){
   return 4.0 * PI * RCirc * ( alfa + asin( y0 / RCirc  ) );
}


void VCircle( float x, float y  ){
 vx=0; vy=0;
 // uniform flow
 println(alfa);
 float ex = cos(alfa);     float ey = sin(alfa);
 vx+=  ex;                 vy+=  ey;
 
 
 // circulation
 float dx = x-x0; float dy = y-y0;
 cdiv( 0, Gamma/TWO_PI,     dx, dy );
 //vx+=cx;   vy+=cy;
 
 
 // doublet
 float dx2 = dx*dx-dy*dy; float dy2 = 2.0*dx*dy;
 cdiv( ex, ey,    dx2, dy2   );
 float RCirc2 = RCirc*RCirc;
 vx-=   RCirc2 * cx;  vy+=RCirc2 * cy;
 
}






