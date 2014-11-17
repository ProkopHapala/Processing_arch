
class ScalarFunction{
  float evaluate( float [] xs, float [] fs  ){ return 0; }
  
  void toImage( PImage im_val, PImage im_grad ){
    img_val .loadPixels();
    img_grad.loadPixels();
    float [] xs = new float[2]; 
    float [] fs = new float[2];
    for(int ix=0; ix<im_val.width; ix++){ 
      for(int iy=0; iy<im_val.height; iy++){
       xs[0] = s2x(ix);
       xs[1] = s2x(iy);
       float E = evaluate( xs, fs );
       im_val .pixels[ ix + iy* im_val .width  ] = color( E    ,E    ,E );
       im_grad.pixels[ ix + iy* im_grad.width  ] = color( 0.5+fs[0],0.5+fs[1],0 );
    }}
    img_val.updatePixels();
    img_grad.updatePixels();
  }
  
  void plotGrad(float ix, float iy ){
    float [] xs = new float[2]; 
    float [] fs = new float[2];
    xs[0] = s2x(ix);
    xs[1] = s2x(iy);
    evaluate( xs, fs );
    println( xs[0]+" "+xs[1]+" "+ fs[0]+" "+fs[1] );
    ellipse( x2s(xs[0]),x2s(xs[1]),3,3 );
    line   ( x2s(xs[0]),x2s(xs[1]), x2s(xs[0]+fs[0]*fscale),x2s(xs[1]+fs[1]*fscale) );
  };
  
}

class testFunc_invRad extends ScalarFunction{

  float evaluate( float [] xs, float [] fs  ){
    float x = xs[0];
    float y = xs[1];
    
    float r2  = x*x+y*y;
    float ir2 = 1.0/(r2+0.00001);
    float E  = 1.0 +  ir2*ir2   -   2*ir2         + 0.1*x ; 
    float f  =      ( 4*ir2*ir2 -   4*ir2 )*ir2   ;
   
    fs[0] = x*f - 0.1;
    fs[1] = y*f; 
    return E;
  };
  
}


class testFunc_Rosenbrok extends ScalarFunction{

  float evaluate( float [] xs, float [] fs  ){
    float x = -xs[0];
    float y = xs[1];
    
    float   mx = 1.0-x;
    float ysqx = y-sq(x);
    float E  =   0.01*sq( mx ) +    sq( ysqx )   ;    
    fs[0]    = - 0.02*  ( mx ) - 4*   ( ysqx )*x ;
    fs[1]    =                 - 2*   ( ysqx )   ; 
    return E;
  };
  
}


class testFunc_Valley extends ScalarFunction{
  float wE,xk0,k;
  
  testFunc_Valley(  float wE, float xk0, float k ){
    this.wE  = wE;
    this.xk0 = xk0;
    this.k   = k;
  }
  
  float evaluate( float [] xs, float [] fs  ){
    float x =  xs[0];
    float y =  xs[1];
        
    float xk = x-xk0;
    
    float S     =  x*x - y - 1;
    float E     = -wE/(wE+S*S)   ; 
    
    float dSdx  =  2*x;
    float dEdS  = -2*E*E*S/wE;
      
    fs[0]    =   dEdS*dSdx         - 2*k*xk;
    fs[1]    =   dEdS;
    return 1+E                     + k*xk*xk;
  };
  
}



class testFunc_LambertValley extends testFunc_Valley{
  
  float xl0, wl;
  
  testFunc_LambertValley(  float wE, float xk0, float k,    float xl0, float wl ){
    super(wE,xk0,k);
    this.wl   = wl   ;
    this.xl0  = xl0  ;
  }
  
  float evaluate( float [] xs, float [] fs  ){
    float x =  xs[0];
    float y =  xs[1];
        
    float xk = x-xk0;
    
    float xl    = x - xl0;
    float L     = wl/( wl+xl*xl );
    float R     = L + y - 1;
    float dRdx  = -2*L*L*xl/wl;
    
    float E     = -wE/(wE+R*R)   ;  
    float dEdR  = -2*E*E*R/wE;
      
    fs[0]    =   dEdR*dRdx         - 2*k*xk;
    fs[1]    =   dEdR;
    return 1+E                     +   k*xk*xk;
  };
  
}

class testFunc_PolyLambertValley extends testFunc_Valley{

  final float [] hls  = {  1.0 , 2.0,  1.0  };
  final float [] wls  = {  0.04, 0.04, 0.04 };
  final float [] xl0s = { -0.8 , 0.0,  0.8  };
  
  testFunc_PolyLambertValley(  float wE, float xk0, float k ){
    super(wE,xk0,k);
  }
  
  float evaluate( float [] xs, float [] fs  ){
    float x =  xs[0];
    float y =  xs[1];
        
    float xk  = x-xk0;
    float R=-3, dRdx=0;
    for (int i=0; i<wls.length; i++){
      float wl   = wls [i]; 
      float xl0  = xl0s[i];
      float hl   = hls [i];
      float whl  = wl*hl;
      float xl   = x - xl0;
      float L    = 1.0/( wl+xl*xl );
            R   +=    whl*L + y ;
           dRdx += -2*whl*L*L*xl;
    }
    
    float E     = -wE/(wE+R*R);  
    float dEdR  = -2*E * E*R/wE;
    fs[0]    =   dEdR*dRdx         - 2*k*xk;
    fs[1]    =   dEdR;
    
    return 1+E                     +   k*xk*xk;
  };
  
}


class testFunc_SinLambertValley extends testFunc_Valley{
  
  float freq,wl,xl0;
  
  testFunc_SinLambertValley(  float wE, float xk0, float k,    float xl0, float wl, float freq ){
    super(wE,xk0,k );
    this.freq = freq ;
    this.wl   = wl   ;
    this.xl0  = xl0  ;
  }
  
  float evaluate( float [] xs, float [] fs  ){
    float x =  xs[0];
    float y =  xs[1];
        
    float xk    = x-xk0;
    float xl    = freq*(x - xl0);
    float sxl   = sin( xl );
    float L     = wl/( wl+sxl*sxl );
    float R     = L + y - 1.5;
    float dRdx  = -2*L*L*sxl/wl*cos(xl)*freq;
    
    float E     = -wE/(wE+R*R);  
    float dEdR  = -2*E * E*R/wE;
    fs[0]    =   dEdR*dRdx         - 2*k*xk;
    fs[1]    =   dEdR;
    
    return 1+E                     +   k*xk*xk;
  };
  
}


class testFunc_HermiteSplineValley extends testFunc_Valley{
    
  float step = 0.5; 
  float [] cs;
  
  testFunc_HermiteSplineValley( float wE, float xk0, float k, float [] cs){ 
    super(wE,xk0,k);
    this.cs = cs;  
  }
  testFunc_HermiteSplineValley( float wE, float xk0, float k, int n){
    super(wE,xk0,k);
    cs = new float[n];
    for (int i=0; i<n; i++ ){ cs[i] = random( -1,1 );  }  
  }
  
  float evaluate( float [] xs, float [] fs  ){
    float x =  xs[0];
    float y =  xs[1];
    
    float xk  = x-xk0;
    
    float xu = x / step;
    int ix  = (int)(xu+1000)-1000;       float u = xu-ix; 
        ix += (cs.length>>1);
    
    if ( (ix<0)||(ix>cs.length) ){
      fs[0] = Float.NaN; 
      fs[1] = Float.NaN;
      return  Float.NaN;
    }  
    
    float s0  = cs[ix+1]; 
    float s1  = cs[ix+2];    
    float ds0 = (s1-cs[ix  ]) * 0.5;
    float ds1 = (cs[ix+3]-s0) * 0.5;
    float a    =  2*s0 +  ds0  -2*s1 + ds1 ;
    float b    = -3*s0 -2*ds0  +3*s1 - ds1 ;
    
    float S    =  s0 + u*(  ds0 + u*(   b +   u*a ) ) - y;              
    float dSdx =         (  ds0 + u*( 2*b + 3*u*a ) )/step;            
    
    float E    = -wE/( wE+S*S );    
    float dEdS = -E*E*2*S/wE;

    fs[0]    =    dEdS*dSdx         - 2*k*xk;
    fs[1]    =   -dEdS;
    
    // println( "x "+x+" ix "+ix+" S "+S+" E "+E+" dSdx "+dSdx+" dEdS "+dEdS+" wE "+wE  );
    
    return 1+E                      + k*xk*xk;
    
  };
  
}



