/* JAT: Java Astrodynamics Toolkit
 * Implements a Runge-Kutta-Fehlberg adaptive step size integrator
 * from Numerical Recipes. Modified to RK78 from the original RK45 in NR.
 * RK78 values from Erwin Fehlberg, NASA TR R-287
 * gets derivs via Derivatives interface
 * 
 * @author <a href="mailto:dgaylor@users.sourceforge.net">Dave Gaylor
 * @author modified by Steven Hugg
 * @version 1.0
 */
 

class Body_RKF {
  
 double [] uR,uT,uS;  // radial, tangential and sideways unti vectors 
 double [] Thrust;
 double [] X;
 double [] X_old;
 double [] Xinterp;
 int id;

 // double[] Y, double[] Yout, double[] Yerr, Derivatives dv
 
 // ==================== standart Body subroutines =======================  

 void move(double t_glob){
  // print(" === "+ t +"  "+t_glob+" | " );
   if(t<t_glob){
     X_old = X.clone(); t_old = t; nevals_old = nevals;
     while (t<t_glob){
      // print("  " + X[0]  );
       evalUs();
       RKF45_adaptive( X, X, Xerr );
     }
   }  
   //interpolate_lin( t_glob,t,t_old, X_old, X, Xinterp );
   interpolate_xvcub( t_glob,t,t_old, X_old, X, Xinterp );
   //println( " X: "+X[0]+" "+X[1]+" "+X[2]+ "    |   "+ X_old[0]+" "+X_old[1]+" "+X_old[2]+"    |   "+ Xinterp[0]+" "+Xinterp[1]+" "+Xinterp[2] );
 };

 Body_RKF( int id, double [] X0, double t0, double dt0 ){
     uR     = new double [3];  uT = new double [3];   uS = new double [3];
     Thrust = new double [3];
     this.id = id;
     X    = X0;
     X_old   = new double[X.length];
     Xinterp = new double[X.length];
     t  = t0; dt = dt0;
     init_RKF45( X.length , Xacc );
     clr = 0xFF000000 | int(random(255)) | (int(random(255))<<8) | (int(random(255))<<16);
 }
 
  void beLike( Body_RKF B ){
     System.arraycopy( B.uR, 0, uR, 0, 3);      System.arraycopy( B.uT, 0, uT, 0, 3);      System.arraycopy( B.uS, 0, uS, 0, 3); 
     System.arraycopy( B.Thrust, 0, Thrust, 0, 3); 
     System.arraycopy( B.X, 0, X, 0, 6);       System.arraycopy( B.X_old, 0, X_old, 0, 6);       System.arraycopy( B.Xinterp, 0, Xinterp, 0, 6);  
     t  = B.t; dt = B.dt;
     Xaccuracy = B.Xaccuracy;
 }

 color clr;
 void paint(){
     stroke(clr);  
     //println( "X[0]*zoom " + X[0]*zoom );
     strokeWeight(2);  point( (float)(X[0]/zoom)       , (float)(X[1]/zoom)       ); 
     strokeWeight(1);  point( (float)(Xinterp[0]/zoom) , (float)(Xinterp[1]/zoom) );
   //  line ( (float)Xinterp[0]*zoom + 400, (float)Xinterp[1]*zoom + 400, (float)X_old[0]*zoom + 400, (float)X_old[1]*zoom + 400 ); 
 };

// ==================== Interpolations =======================  

 void  interpolate_lin( double t_glob, double  t, double  t_old, double []  X_old, double []  X, double [] Xinterp ){
   double  tt=(t_glob-t_old)/(t-t_old); double  mt=(1-tt);
   for (int i = 0; i < ndim; i++){ Xinterp[i] = X_old[i]*mt + X[i]*tt;  }
 }
 
 double interCubXV( double t, double x0, double x1, double v0, double v1 ){
    double tt = t*t;   
    double dx  =  x1-x0;        double pv = v1+v0;
    double B   = -v0-pv +3*dx;  double A =  pv-2*dx;
    return A*tt*t + B*tt + v0*t + x0;
 };
 
  void  interpolate_xvcub( double t_glob, double  t, double  t_old, double []  X_old, double []  X, double [] Xinterp ){
   double tstep = (t-t_old); 
   double tt=(t_glob-t_old)/tstep;
   int ndim_half = ndim>>1;
   for (int i = 0; i < ndim_half; i++){ Xinterp[i] = interCubXV ( tt,  X_old[i], X[i], X_old[i+ndim_half]*tstep, X[i+ndim_half]*tstep );  }
 }
 
// ==================== Force model =======================  

double [] as  = new double[3]; 

void setThrust( double thT, double thR, double thS ){
  Thrust[0]=thT; Thrust[1]=thR; Thrust[2]=thS;
};

void evalUs(){
  double lr = Math.sqrt(X[0]*X[0] + X[1]*X[1] + X[2]*X[2]);  uR[0]=X[0]/lr; uR[1]=X[1]/lr; uR[2]=X[2]/lr; 
  double lt = Math.sqrt(X[3]*X[3] + X[4]*X[4] + X[5]*X[5]);  uT[0]=X[3]/lt; uT[1]=X[4]/lt; uT[2]=X[5]/lt; 
  uS[0] = uR[1]*uR[2] - uR[2]*uR[1];  
  uS[1] = uR[2]*uR[0] - uR[0]*uR[2];  
  uS[2] = uR[0]*uR[1] - uR[1]*uR[0];  
}

public void derivs(  double t, double[] X, double[] dX ){
  // eval accleateration
  G_acceleartion(X,as);
  as[0]+= Thrust[0]*uT[0] + Thrust[1]*uR[0] + Thrust[2]*uS[0];
  as[1]+= Thrust[0]*uT[1] + Thrust[1]*uR[1] + Thrust[2]*uS[1];
  as[2]+= Thrust[0]*uT[2] + Thrust[1]*uR[2] + Thrust[2]*uS[2];
  // update state vector
  dX[0]= X[3];  dX[1]= X[4];  dX[2]= X[5];   // update positions 
  dX[3]=as[0];  dX[4]=as[1];  dX[5]=as[2];   // update forces
}
 
 
// ==================== RKF45 integration scheme =======================  
  final int RK_LEN = 6; 
  final double [] at = { 0, 1d/4d, 3d/8d, 12d/13d, 1, 1d/2d };   // time0
  final double [] chat = {25d/216d, 0, 1408d/2565d, 2197d/4104d, -1d/5d};
  final double [] c    = {16d/135d, 0, 6656d/12825d, 28561d/56430d, -9d/50d, 2d/55d};
        double [][] b = new double [6][5];
        
  int ndim;
  double [][] f;         // derivatives
  double []   Xtmp;      // temporary state
  double []   Xerr;      // temporary state
  
  double t, t_old, dt;
  int nevals, nevals_old;
  
  double [] Xaccuracy;
    
  void init_RKF45( int ndim, double [] Xaccuracy ){
    nevals = 0;
    this.ndim = ndim;
    this.Xaccuracy = Xaccuracy;
    Xerr = new double [ ndim ];
    Xtmp = new double [ ndim ];
    f    = new double [RK_LEN][ndim]; 
    b    = new double [6][5];
    b[1][0] = 1d/4d;        
    b[2][0] = 3d/32d;      b[2][1] = 9d/32d;       
    b[3][0] = 1932d/2197d; b[3][1] = -7200d/2197d; b[3][2] = 7296d/2197d;
    b[4][0] = 439d/216d;   b[4][1] = -8d;          b[4][2] = 3680d/513d;   b[4][3] = -845d/4104d;
    b[5][0] = -8d/27d;     b[5][1] = 2d;           b[5][2] = -3544d/2565d; b[5][3] = 1859d/4104d;  b[5][4] = -11d/40d;    
  }
        
  void RKF45_step(double[] y, double t, double h, double[] yout, double[] yerr) {  
      derivs( t + at[0]*h, y   , f[0] ); for (int i = 0; i < ndim; i++) { Xtmp[i] = y[i] + h *   b[1][0]*f[0][i]; } 
      derivs( t + at[1]*h, Xtmp, f[1] ); for (int i = 0; i < ndim; i++) { Xtmp[i] = y[i] + h * ( b[2][0]*f[0][i] + b[2][1]*f[1][i]   ); } 
      derivs( t + at[2]*h, Xtmp, f[2] ); for (int i = 0; i < ndim; i++) { Xtmp[i] = y[i] + h * ( b[3][0]*f[0][i] + b[3][1]*f[1][i] + b[3][2]*f[2][i]   ); }  
      derivs( t + at[3]*h, Xtmp, f[3] ); for (int i = 0; i < ndim; i++) { Xtmp[i] = y[i] + h * ( b[4][0]*f[0][i] + b[4][1]*f[1][i] + b[4][2]*f[2][i] + b[4][3]*f[3][i]   ); } 
      derivs( t + at[4]*h, Xtmp, f[4] ); for (int i = 0; i < ndim; i++) { Xtmp[i] = y[i] + h * ( b[5][0]*f[0][i] + b[5][1]*f[1][i] + b[5][2]*f[2][i] + b[5][3]*f[3][i] + b[5][4]*f[4][i]  ); }  
      derivs( t + at[5]*h, Xtmp, f[5] ); 
      
      // construct solutions
      // yout is the 8th order solution
      for (int i = 0; i < ndim; i++) {
          yout[i] = y[i] + h*(    c[0]*f[0][i] +   c[2]*f[2][i] +    c[3]*f[3][i] +    c[4]*f[4][i] + c[5]*f[5][i] );
          yerr[i] = y[i] + h*( chat[0]*f[0][i] +chat[2]*f[2][i] + chat[3]*f[3][i] + chat[4]*f[4][i]                ) - yout[i];
         // yout[i]-=0.5*yerr[i];
          
      }
      nevals+=6;
  }
  
  void RKF45_adaptive( double[] Y, double[] Yout, double[] Yerr ){
  final double SAFETY = 0.9; 
  final double PGROW = -0.2;
  final double PSHRINK = -0.25;
  final double ERRCON = 1.89E-4;
 // final double ERRCON = 0.5;
  final double TINY = 1.0E-30;
  
  double error=0;
  int n = Y.length;
  double dt_temp;
  for (int itr=0; itr<MAX_ITER; itr++ ){
    RKF45_step(  Y, t, dt, Xtmp,  Yerr );
    for (int i=0; i<n; i++ ){  error = Math.max( error, Math.abs( Xerr[i]/Xaccuracy[i] ) ); }
    if (error <= 1){
      //println("dt  "+dt); 
      t+=dt;
      for (int i=0; i<n; i++ ){ Yout[i] = Xtmp[i]; }
      dt_temp = dt * SAFETY * Math.pow(error,PGROW);
      dt = Math.min(dt_temp, 2.0 * dt);
      break;
    }
    dt_temp = SAFETY * dt * Math.pow(error,PSHRINK);
    dt = Math.max(dt_temp, 0.25 * dt);
  }
  //for (int i=0; i<n; i++ ){ Yout[i] = Xtmp[i]; }
}  
  
}
    
