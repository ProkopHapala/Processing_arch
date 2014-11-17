

int n = 10000000;
float t1,t2;


double step = 0.01;
double param1=0.2,param2=0.0, param3;

  float restZoom = 20.0;
  int subpix  = 4; 
  float x0    = 0.0;
  float y0    = 400.0;
  float yzoom = 200.0;

void setup(){
 size(1000,800);
}

void draw(){
 background(255);
// visualization  

  float x0 =  -1.0;
  float dx =  1.0/200.0;
  for (int i=0;i<400*subpix;i++  ){
    float ix= i/( float )subpix;
    float x = ix*dx+x0;
    float prec  =          asin (x);
    //testplot( ix, (float) fast_asin2816(x), prec,  #FF00FF ); 
    testplot( ix, (float) fast_asin4(x), prec,  #FF8800 ); 
    testplot( ix, (float) fast_asin28(x), prec,  #0088FF ); 
    //testplot( ix, (float) fast_asin216(x), prec,  #FF8800 ); 
    //testplot( ix, (float) fast_asin248(x), prec,  #00FFFF ); 
   // testplot( ix, (float) fast_asin_sqrtif(x), prec,  #FF0000 ); 
    testplot( ix, (float) fast_asin_sqrtif2(x), prec, #0000FF ); 
    testplot( ix, (float) fast_asin_table(x), prec,   #008800 );    
    testplot( ix, prec, prec, #000000 ); 
  }


  double dxx=0.99d/n;
  double sum = 0.0;
  
  t1 = millis();
   sum=0; for (int i=0;i<n;i++ ){  sum+= i;  };
  t2 = millis();
  println( " sum+= i         "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
   sum=0; for (int i=0;i<n;i++ ){  sum+= i*dxx;  };
  t2 = millis();
  println( " sum+= i*dx       "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );

  t1 = millis();
   sum=0; for (int i=0;i<n;i++ ){  sum+= Math.sqrt(i*dxx);  };
  t2 = millis();
  println( " sqrt(i*dx)       "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
   sum=0; for (int i=0;i<n;i++ ){  sum+= fast_asin4(i*dxx);  };
  t2 = millis();
  println( " fast_asin4     "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
   sum=0; for (int i=0;i<n;i++ ){  sum+= fast_asin28(i*dxx);  };
  t2 = millis();
  println( " fast_asin28     "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    sum=0; for (int i=0;i<n;i++ ){  sum+= fast_asin_sqrtif(i*dxx);   };
  t2 = millis();
  println( " fast_asin_sqrtif  "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
  
  t1 = millis();
    sum=0; for (int i=0;i<n;i++ ){  sum+= fast_asin_sqrtif2(i*dxx);   };
  t2 = millis();
  println( " fast_asin_sqrtif2  "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
   
  t1 = millis();
    sum=0; for (int i=0;i<n;i++ ){  sum+= fast_asin_table(i*dxx);   };
  t2 = millis();
  println( " fast_asin_table    "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );

 
 save("out.png");
 noLoop(); 


 /* 
  t1 = millis();
    sum=0; for (int i=0;i<n;i++ ){  sum+= Math.asin(i*dxx);  };
  t2 = millis();
  println( " asin           "+n+" [ops] "+  (t2-t1) + " [ms] " +  (1000000.0*(t2-t1)/n)   +" [ns/op]" );
*/

}

void keyPressed(){
 if (key == '7'){param1+=step;}
 if (key == '4'){param1-=step;}
 if (key == '8'){param2+=step;}
 if (key == '5'){param2-=step;}
 if (key == '9'){param3+=step;}
 if (key == '6'){param3-=step;}
 println(param1+" "+param2+" "+param3);
}
