
/*
final double f_inc  = 1.1d;
final double f_dec  = 0.5d;
final double f_alfa = 0.9d;
final double alfa0  = 0.03d;
final int Nmin      =   5; 
double dt_min = 0.00001; 
double dt_max = 0.1; 
*/


final double f_inc  = 1.1d;
final double f_dec  = 0.5d;
final double f_alfa = 0.9d;
final double alfa0  = 0.05d;
final int Nmin      =   5; 
//double dt_min = 0.0005; 
double dt_min = 0.0002; 
double dt_max = 0.1; 


/*
final double f_inc  = 1.3d;
final double f_dec  = 0.5d;
final double f_alfa = 0.8d;
final double alfa0  = 0.1d;
final int Nmin      =   3; 
double dt_min = 0.002; 
//double dt_min = 0.000001; 
double dt_max = 0.1; 
*/

double alfa   = alfa0;
double dt     = dt_min;
int idown=0;


double move_FIRE( double [][] Cs, double [][] fCs,  double [][] vCs ){
  double []  xs =  Cs[0];
  double []  ys =  Cs[1];
  double [] vxs = vCs[0];
  double [] vys = vCs[1];
  double [] fxs = fCs[0];
  double [] fys = fCs[1];
  double a = alfa; double ma = 1.0d-a;
  double ff = 0,vv = 0,P=0; 
  for (int i=2;i<(ncoef-2);i++){ 
    double vxi = vxs[i]; 
    double fxi = fxs[i];
    double vyi = vys[i]; 
    double fyi = fys[i];
    ff += fxi*fxi + fyi*fyi;
    vv += vxi*vxi + vyi*vyi;
    P  += vxi*fxi + vyi*fyi;
  }
  double fvscale = a*Math.sqrt( vv/ff );
  //println( "vv: "+vv+" ff: "+ff+" P: "+P+" fscale: "+fvscale  );
  for (int i=2;i<(ncoef-2);i++){
    //double vx_  = ma*vxs[i] + ( 1 + fvscale )*fxs[i];
    //double vy_  = ma*vys[i] + ( 1 + fvscale )*fys[i]; 
      double vx_  = ma*vxs[i] + ( a + fvscale )*fxs[i];
      double vy_  = ma*vys[i] + ( a + fvscale )*fys[i];
    //double vx_  = ma*vxs[i] + ( dt + fvscale )*fxs[i];
    //double vy_  = ma*vys[i] + ( dt + fvscale )*fys[i];
    vxs[i]  = vx_    ;
    vys[i]  = vy_    ;
     xs[i] += vx_*dt ; 
     ys[i] += vy_*dt ; 
  }
  
  /*
  if(P>0){
    idown++; 
    if( idown>Nmin ){
      dt = Math.min( dt*f_inc, dt_max );
      alfa*=f_alfa;
    }
  }else{
    idown=0;
    dt = Math.max( dt*f_dec, dt_min );
    alfa  = alfa0;
  }
  */
  
  
  return ff;
  //println( " dt: "+dt+" alfa: "+alfa+" idown: "+idown  );
  
}


