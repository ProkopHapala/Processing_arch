

class Relaxator{
  float dt;       // time step
  float crnd;     // random component
  float cv_sucess,cv_fail;
  float cx_sucess,cx_fail;
  
  Func_vec2float fitnessFunc;
  
  int ibad=0;
  boolean success;
  float E;
  float [] X,Xnew,dX,V,Xrnd; 
  
  int printlevel, paintlevel = 0;
  
  Relaxator(            ){  };
  Relaxator( Func_vec2float fitnessFunc, float [] X ){ this.fitnessFunc = fitnessFunc; this.X=X; int n=X.length;  Xnew=new float[n]; dX=new float[n]; V=new float[n]; Xrnd=new float[n];    }
  Relaxator( Func_vec2float fitnessFunc, int n      ){this.fitnessFunc = fitnessFunc; X=new float[n]; Xnew=new float[n]; dX=new float[n]; V=new float[n]; Xrnd=new float[n];  }
  
  void setParams( float dt, float cv_sucess, float cv_fail, float cx_sucess, float cx_fail,  float crnd){ this.dt=dt; this.cv_sucess=cv_sucess; this.cv_fail=cv_fail; this.cx_sucess=cx_sucess; this.cx_fail=cx_fail;  this.crnd=crnd; }
  void setParams( float [] params ){ dt=params[0]; cv_sucess=params[1]; cv_fail=params[2]; cx_sucess=params[3]; cx_fail=params[4];  crnd=params[5]; }
  
  // ============= simple
  void move(){
    success = false;
    setRandom( -crnd, crnd, Xrnd );         // cnd should develop somehow ... how?
    // generate new configuration
    for (int i=0;i<X.length;i++){  
      float dxi = crnd*Xrnd[i] + V[i]*dt;              
      dX[i]=dxi;  
      Xnew[i] = X[i] + dxi; 
    } 
    // test new configuration
    float Enew = fitnessFunc.eval( Xnew );
    float dE = Enew - E;
    if(paintlevel>2){  point( sx(Xnew[0]), sy(Xnew[1]) ); }
    if(printlevel>2){ println( "    ibad "+ibad+" dE= "+dE+" X: "+vec2string(Xnew) );  };
    if( dE<0 ) { 
      if(paintlevel>1){ point( sx(X[0]),sy(X[1]) );  line ( sy(X[0]),sy(X[1]), sx(Xnew[0]),sy(Xnew[1]) ); }
      if(printlevel>1){ println( "  success: Enew: " +Enew+ " Xnew: "+vec2string(Xnew) );  };
      copy( Xnew, X ); 
      E = Enew; ibad=0; 
      success = true;
    } else{ 
      ibad++;
    }
    // update velocity    
    float dr2 = dot(dX,dX);  float dr = sqrt(dr2);
    float cv, cdx;
    if( success ){
      cv  = cv_sucess;
      cdx = cx_sucess*dt/dr;
    }else{
      cv  = cv_fail;
      cdx = cx_fail*dt/dr;
    };
    for (int i=0;i<dX.length;i++){ V[i] = cv * V[i]  + cdx * dX[i]; }  
  }
  
  
  
  /*
  // ============= MD
  void move(){
    success = false;
    setRandom( -crnd, crnd, Xrnd );         // cnd should develop somehow ... how?
    // generate new configuration
    for (int i=0;i<X.length;i++){  
      float dxi = crnd*Xrnd[i] + V[i]*dt;              
      dX[i]=dxi;  
      Xnew[i] = X[i] + dxi; 
    } 
    // test new configuration
    if(paint) point( sx(Xnew[0]), sy(Xnew[1]) );
    float Enew = fitnessFunc.eval( Xnew );
    float dE = Enew - E;
    if( dE<0 ) { 
      if(paint){ point( sx(X[0]),sy(X[1]) );  line ( sy(X[0]),sy(X[1]), sx(Xnew[0]),sy(Xnew[1]) ); }
      copy( Xnew, X ); 
      E = Enew; ibad=0; 
      success = true;
    } else{ 
      ibad++;
    }
    // update velocity    
    float dR2 = dot(dX,dX);
    float fr = -dE/dR2;
    // update velocity
    for (int i=0;i<dX.length;i++){  
      float fi = dX[i]*fr;
      V[i] = V[i] * vdecay + fi*dt*imass;
    }
  }
  */

  void init(){
    E = fitnessFunc.eval( X );
    ibad=0;
    set(0,V);
    if(paintlevel>0){ ellipse( sx(X[0]),sy(X[1]),5,5 ); }
  }

  void relax(){
    init();
    for (int istep=0; istep<maxSteps; istep++){
      //println ( " istep "+istep+" E "+E );
      move();
      if (E<Ecriterium) { 
        if(paintlevel>0){ ellipse ( sx(X[0]),sy(X[1]),5,5 ); }
        if(printlevel>0){ println ( " DONE: iters: "+istep+" Efinal= "+E+" Xfinal: "+vec2string(Xnew) ); }
        break;  
      };
    }
  }

}

