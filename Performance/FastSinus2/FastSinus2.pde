

int n = 10000000;
float t1,t2;

void setup(){
 size(800,400);
}

void draw(){

// visualization  
  int subpix = 10; 
  float x0 = -2.0*TWO_PI;
  float dx =  8.0*TWO_PI/800.0;
  for (int i=0;i<400*subpix;i++  ){
    float x= i/( float )subpix;
    stroke(0      );       point ( x, 200 );
    stroke(0      );       point ( x, 200-cos(dx*x+x0)     *200 );
    stroke(0,128,0);       point ( x, 200-fastCos_lin(dx*x+x0)*200 );
    stroke(255,0,0);       point ( x, 200-fastCos_int(dx*x+x0)*200 );
    stroke(0,0,255);       point ( x, 200-fastCos_int2(dx*x+x0)*200 );
  }

  int ni = 10000;
  for (int i=0;i<ni;i++  ){
    float x = 2.0*TWO_PI*i/ni;
    stroke(0      );       point ( 600+sin(x)         *200, 200+cos(x)         *200 );
    stroke(0,128,0);       point ( 600+fastSin_lin (x)*200, 200+fastCos_lin (x)*200 );
    stroke(255,0,0);       point ( 600+fastSin_int (x)*200, 200+fastCos_int (x)*200 );
    stroke(  0,0,255);     point ( 600+fastSin_int2(x)*200, 200+fastCos_int2(x)*200 );
  }


  dx=100.0*TWO_PI/n;
  float sum = 0.0;
  
  t1 = millis();
    for (int i=0;i<n;i++ ){  sum+= i;  };
  t2 = millis();
  println( " sum+= i         "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    for (int i=0;i<n;i++ ){  sum+= i*dx;  };
  t2 = millis();
  println( " sum+= i*dx       "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    for (int i=0;i<n;i++ ){  sum+= fastCos_lin(i*dx);  };
  t2 = millis();
  println( " fastCos_lin     "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    for (int i=0;i<n;i++ ){  sum+= fastSin_lin(i*dx);  };
  t2 = millis();
  println( " fastSin_lin     "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    for (int i=0;i<n;i++ ){  sum+= fastCos_int(i*dx);  };
  t2 = millis();
  println( " fastCos_int     "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    for (int i=0;i<n;i++ ){  sum+= fastSin_int(i*dx);  };
  t2 = millis();
  println( " fastSin_int     "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    for (int i=0;i<n;i++ ){  sum+= fastCos_int2(i*dx);  };
  t2 = millis();
  println( " fastCos_int2    "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    for (int i=0;i<n;i++ ){  sum+= fastSin_int2(i*dx);  };
  t2 = millis();
  println( " fastSin_int2    "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    for (int i=0;i<n;i++ ){  sum+= cos(i*dx);  };
  t2 = millis();
  println(" cos              "+ n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    for (int i=0;i<n;i++ ){  sum+= sin(i*dx);  };
  t2 = millis();
  println(" sin              "+ n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );

 
  noLoop();
  
}
