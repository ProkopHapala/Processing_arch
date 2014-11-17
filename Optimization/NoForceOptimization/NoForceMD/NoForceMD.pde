

int perFrame = 1;

int   nEvals=0;
float Ecriterium = 0.001;
int   maxSteps=100000;

PImage Eimage;
final int sz = 300;
final int sz2 = 2*sz;
final float pixsz = 1.0/(float)sz;
float zoom = sz*0.15;

PrintWriter out;
boolean stop=false;

SinValley sinValley;
RelaxatorFittness relaxatorFittness;
Relaxator relaxator;
Relaxator metaRelaxator;

final float [] X0 = { PI, 1  };

//                                 dt,   cv_sucess, cv_fail,    cx_sucess, cx_fail,      crnd
// final float [] relaxParams0 = {   0.25,      1.0,     0.8,         0.5,     -0.3,       0.15  };
// final float [] relaxParams0 = {   0.6292108, 0.35250574, 0.64887273, 1.2175977, 0.026782766, 0.3666878 };
 final float [] relaxParams0 = {  0.855103, 0.50021464, 0.61466384, 1.3903406, 0.004395957, 0.076802194 }; 
// final float [] relaxParams0 = {  1.0134702, 0.6441425, 0.6707004, 1.3203192, 0.0024785842, 0.059617184}; 
//  final float [] relaxParams0 = {   0.9936104, 0.62932295, 0.68048763, 1.3001337, 0.0015392094, 0.053200733  };
// final float [] relaxParams0 = {   1.0462326, 0.5785182, 0.7067075, 1.3444697, 9.519183E-4, 0.036745936  }; 
// final float [] relaxParams0 = {   0.35056758, 0.54901266, 0.96650016, 0.528385, -0.033449136, 0.1446733   };
 
 
// final float [] metaParams   = {   0.25,      1.0,     0.8,         0.5,     -0.3,       0.15  };
// final float [] metaParams   = {   0.25,      1.0,     0.8,         0.5,     -0.3,       0.5  };
// final float [] metaParams   = {   0.6292108, 0.35250574, 0.64887273, 1.2175977, 0.026782766, 0.3666878  };
// final float [] metaParams   = {   0.8930181, 0.5328346, 0.50032794, 1.4787699, 0.00268016, 0.078206055 }; 
// final float [] metaParams   = {   0.9, 0.5, 0.5, 1.5, 0.00, 0.05 }; 
// final float [] metaParams   = {   0.855103, 0.50021464, 0.61466384, 1.3903406, 0.004395957, 0.076802194 }; 
//final float [] metaParams   = {   1.0134702, 0.6441425, 0.6707004, 1.3203192, 0.0024785842, 0.059617184  }; 
// final float [] metaParams   = {   0.9936104, 0.62932295, 0.68048763, 1.3001337, 0.0015392094, 0.053200733 }; 
final float [] metaParams   = {   1.0462326, 0.5785182, 0.7067075, 1.3444697, 9.519183E-4, 0.036745936 }; 
 
//  success: Enew: 272.64 Xnew: 0.32157335 1.0926628 0.8220192 0.5205952 -0.303809 0.13158199 
//  success: Enew: 190.72 Xnew: 0.6292108 0.35250574 0.64887273 1.2175977 0.026782766 0.3666878
// 3D success: Enew: 757.6 Xnew: 0.35056758 0.54901266 0.96650016 0.528385 -0.033449136 0.1446733 
// 3D success: Enew: 1807.36 Xnew: 1.2191229 0.4881392 0.9573846 1.0860977 -0.020003129 0.347335 
// 3D success: Enew: 977.4 Xnew: 0.2758446 0.61840403 0.98029774 0.36531585 -0.055301964 0.07589808 
// 4D success: Enew: 5946.72 Xnew: 0.8930181 0.5328346 0.50032794 1.4787699 0.00268016 0.078206055
// 4D success: Enew: 4960.92 Xnew: 0.88598865 0.53991914 0.51191765 1.4703444 0.0050442545 0.075011626 
// 5D success: Enew: 27559.28 Xnew: 0.855103 0.50021464 0.61466384 1.3903406 0.004395957 0.076802194 
// 5D success: Enew: 14132.96 Xnew: 1.0134702 0.6441425 0.6707004 1.3203192 0.0024785842 0.059617184 
// 5D success: Enew: 13440.8 Xnew: 0.9936104 0.62932295 0.68048763 1.3001337 0.0015392094 0.053200733 
// 6D success: Enew: 45484.28 Xnew: 1.0462326 0.5785182 0.7067075 1.3444697 9.519183E-4 0.036745936


 






void setup(){
  size(sz2,sz2);
  
  sinValley = new SinValley( 0.1, 4.0,  X0.length );
  sinValley.Freqs[1] = 2.0;
  //setRandom( 0.0, 3.0, sinValley.Freqs );
  //Eimage = makeEmap( sinValley );
  //paintEmap( );
  
 relaxator = new Relaxator( sinValley, X0.length );
 relaxator.setParams(  relaxParams0  );
 //frameRate(1);
 
 relaxatorFittness = new RelaxatorFittness( relaxator, sinValley, -2, 2, 5, 5 );
 relaxatorFittness.genTests();
 relaxatorFittness.sinValley.Freqs=relaxatorFittness.tests[0];
 Eimage = makeEmap( relaxatorFittness.sinValley );
  
 metaRelaxator = new Relaxator( relaxatorFittness, relaxParams0.length );
 metaRelaxator.setParams(  metaParams  );
 copy( relaxParams0, metaRelaxator.X );
 metaRelaxator.init();
 
}


void draw(){
  
  // ====== Test Simple Relaxator
  /*
  setRandom( -2, 2, sinValley.Freqs );
  //sinValley.Freqs[1] = 2.0;  
  Eimage = makeEmap( sinValley );
  stroke( 255,0,0);
  relaxator.paintlevel=3;
  relaxator.printlevel=1;
  sinValley.setToMin(PI*1.5, relaxator.X );
  nEvals = 0;
  relaxator.relax();
  //noLoop();
  */
  
  // ==== Optimize Relaxator
  metaRelaxator.printlevel = 2;
  for ( int i=0; i<perFrame; i++ ){
    metaRelaxator.move();
    print( " "+metaRelaxator.ibad+" " );
    if ( metaRelaxator.success ){
      relaxator.paintlevel = 2;
      paintEmap();
      stroke( 255,0,0);
      relaxatorFittness.evalTestCase( 0 );
      relaxator.paintlevel = 0;
    }
  }
  //println( " fitness = "+metaRelaxator.E+" params: "+vec2string(metaRelaxator.X) );
  
  //metaRelaxator.relax();
  //noLoop();
}

