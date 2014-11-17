
int nplot = 1000;
int n = (int)1e+7;


double r0  = 7.648d;
double sqrtr0 = Math.sqrt(r0);
double ir0 = 1/r0;

double x0 =  0.01 * r0;
double x1 =  1.99 * r0;
double dx = (x1-x0)/n; 
double dxplot = (x1-x0)/nplot; 

int sz = 400;

void setup(){
 size(2*sz,2*sz);
  
  double x;
  
  x = x0;
  for (int i=0;i<nplot;i++  ){ 
    float xx=sz*(float)((x-x0)/(x1-x0));
    stroke(0      );       point ( xx, sz );
    stroke(0      );       point ( xx, sz - (float)( 0.1*sz*Math.sqrt(x)            ) );
    stroke(255,0,0);       point ( xx, sz - (float)( 0.1*sz*sqrtr0*fastSqrtOne_taylor(x*ir0-1) ) );
    stroke(0,0,255);       point ( xx, sz - (float)( 0.1*sz*sqrtr0*fastSqrtOne_pade(x*ir0-1)   ) );
    x += dxplot;
  }

  x = x0;
  for (int i=0;i<nplot;i++  ){
    float xx=sz*(float)((x-x0)/(x1-x0));
    stroke(0      );      point ( sz + xx, sz );
    stroke(255,0,0);      point ( sz + xx, sz - (float)( 0.02*sz*logabs( Math.sqrt(x) - sqrtr0*fastSqrtOne_taylor(x*ir0-1) ) ) );
    stroke(0,0,255);      point ( sz + xx, sz - (float)( 0.02*sz*logabs( Math.sqrt(x) - sqrtr0*fastSqrtOne_pade(x*ir0-1)   ) ) );
    x += dxplot;
    //println ( i+" "+x+"  " );
  }


  long t1,t2,tref; 
  double sum=0;
  
  
  x = x0; sum=0;
  t1 = System.nanoTime();
    for (int i=0;i<n;i++ ){  sum+= x; x+=dx;  };
  t2 = System.nanoTime();
  tref = t2-t1;
  println( " sum+= x         "+((double)tref/n) );
  tref = 0;
      
  x = x0-1; sum=0;
  t1 = System.nanoTime();
    for (int i=0;i<n;i++ ){  sum+= sqrtr0*fastSqrtOne_taylor(x*ir0-1); x+=dx;  };
  t2 = System.nanoTime();
  println( " sum+= sqrt_taylor(x)         "+((double)(t2-t1-tref)/n) );
  
  x = x0-1; sum=0;
  t1 = System.nanoTime();
    for (int i=0;i<n;i++ ){  sum+= sqrtr0*fastSqrtOne_pade(x*ir0-1); x+=dx;  };
  t2 = System.nanoTime();
  println( " sum+= sqrt_pade(x)         "+((double)(t2-t1-tref)/n) );
  
  x = x0; sum=0;
  t1 = System.nanoTime();
    for (int i=0;i<n;i++ ){  sum+= Math.sqrt(x); x+=dx;  };
  t2 = System.nanoTime();
  println( " sum+= sqrt(x)         "+((double)(t2-t1-tref)/n) );
  

  noLoop();
  
}
