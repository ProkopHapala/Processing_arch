

class Preceptron_Layer{
  float [] input;
  float [] bias;
  float [][] weights;
  float [] output;
  
  Preceptron_Layer(int n, float [] input ){
    this.input = input;
    bias    = new float[n];
    output  = new float[n]; 
    weights = new float[n][input.length];   
  }
  
  void initRandom( float bmin, float  bmax, float  wmin, float  wmax  ){
    for (int i=0; i<output.length;i++){ 
      bias[i]=random(bmin,bmax);
      rndVec( wmin,wmax, weights[i] );
    }  
  }
  
  final float acfunc(float x ){
    //return x;
    return x/(1+abs(x));
    //if(x<-1){return -1}else if (x>1){ return -1 } else{ return x };
  }
  
  float preceptron( float [] x, float [] w, float b ){
    float sum=0;
    for (int i=0; i<x.length; i++) sum+=w[i]*input[i];
    return acfunc( sum - b );
  }
  
  void eval(){ 
    for (int i=0; i<output.length; i++) output[i] = preceptron( input, weights[i], bias[i] );
  }
  
}

void rndVec( float fmin, float fmax, float [] vec ){ for (int i=0; i<vec.length; i++ ) vec[i]=random(fmin,fmax); }

