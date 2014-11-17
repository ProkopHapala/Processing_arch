


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
}

float Gamma_Func( ){
   return 4.0 * PI * RCirc * ( alfa + asin( y0 / RCirc  ) );
}

float alfa  = 0.0;
float RCirc = RCirc_Func();
float Gamma = Gamma_Func();   

float vx,vy;

void VCircle( float x, float y  ){
 vx=0;vy=0;
 // uniform flow
 vx+=   cos(alfa);
 vy+=   sin(alfa);
 //
 float dx = x-x0; float dy = y-y0;
 // circulation
 
 // doublet

 
}






