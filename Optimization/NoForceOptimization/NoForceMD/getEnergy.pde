
interface Func_vec2float {
 float eval( float [] X );
}

// =========== This function evaluate some long wavy valley in N-dimensional space

class SinValley implements Func_vec2float {
  float [] Freqs;
  float [] X0tmp;
  float kx0   = 0.01;
  float krest = 2;
  
  SinValley () {};
  SinValley ( float kx0, float krest, int ndim                       ) { this.kx0=kx0; this.krest=krest; Freqs = new float[ndim]; X0tmp = new float[ndim]; };
  SinValley ( float kx0, float krest, float [] Freqs                 ) { this.kx0=kx0; this.krest=krest; this.Freqs = Freqs; X0tmp = new float[Freqs.length]; };
  SinValley ( float kx0, float krest,float [] Freqs, float [] X0tmp ) { this.kx0=kx0; this.krest=krest; this.Freqs = Freqs; this.X0tmp = X0tmp; };
 
  float eval( float [] X ){
    nEvals++;
    float x0 = X[0];
    float r2 = 0;
    setToMin( x0, X0tmp);
    for ( int i=1;i<X.length ;i++  ){
      float dxi = X[i] - X0tmp[i];
      r2 += dxi*dxi;
    }
    return krest*r2 + x0*x0*kx0;
  }
  void setToMin(float x0, float X[]){
    X[0] = x0;
    for ( int i=1;i<X.length ;i++  ){
      X[i] = sin( 2*x0 ) - sin( x0 )*Freqs[i];
    }  
  }
}  

// =========== This function evaluate fitness of some optimalization algorithm

class RelaxatorFittness implements Func_vec2float {  
  Relaxator myRelax;
  int ntests, ntimes;
  float [][] tests;
  SinValley sinValley;
  float minFreq=-2.0,maxFreq=2.0;
  
  RelaxatorFittness () {};
  RelaxatorFittness ( Relaxator relax, SinValley valley, float minFreq, float maxFreq, int ntests, int ntimes ) { myRelax=relax; sinValley=valley; this.minFreq=minFreq; this.maxFreq=maxFreq; this.ntests=ntests; this.ntimes=ntimes; }
  
  void genTests(){
    tests = new float[ntests][sinValley.Freqs.length];
    for ( int itest=0; itest<ntests; itest++ ){
      setRandom( minFreq, maxFreq, tests[itest] );
    }
  }
  
  float evalTestCase( int itest ){
     float myFitness = 0;
     sinValley.Freqs = tests[itest];
       //Eimage = makeEmap( sinValley );
       //stroke( 255,0,0);
     for ( int j=0; j<ntimes; j++ ){  
       sinValley.setToMin( 2*PI, myRelax.X );
       nEvals = 0;  
       myRelax.relax( );   
       myFitness += nEvals;
     }
     return myFitness;
  }
  
  float eval( float [] X ){
    myRelax.setParams( X );
    float myFitness = 0;
    //print( " HERE: ntests "+ntests );
    for ( int itest=0; itest<ntests; itest++ ){
      myFitness+=evalTestCase( itest );
    }
    return myFitness/(ntests*ntimes);
  }
}  






