
class BPNN3L{
  // state variables
  double []   ai,ah,ao;
  double [][] Wih,Who;
  
  // temporary varibles
  double [][] vWih, vWho;
  double [] delta_o,delta_h;
  
  double [] ah_importance;
  
  BPNN3L( int ni, int nh, int no ){
    ni++;
    ai=new double [ni];
    ai[ni-1]=1; 
    ah=new double  [nh];          
    ao=new double  [no]; 
    Wih=new double [ni][nh];
    Who=new double [nh][no];
    // temp
    vWih=new double [ni][nh];
    vWho=new double [nh][no];
    delta_h = new double [nh];
    delta_o = new double [no]; 
   
    ah_importance=new double  [nh];
  }
  
  void init(){
    randomMatrix(-1,1,Wih);
    randomMatrix(-1,1,Who);
  }
  
  void eval( ){
    evalLayer( ai, Wih, ah ); 
    evalLayer( ah, Who, ao );
  }
  
  void getDeltas( double [] target ){
    for (int k=0; k<ao.length; k++){
      double diff = target[k]-ao[k];
      delta_o[k] += dsigmoid( ao[k] ) * diff;
    }    
    for (int j=0; j<ah.length; j++){  
      double diff = 0;
      for (int k=0; k<ao.length; k++){ diff += delta_o[k] * Who[j][k]; }
      double dahj = dsigmoid( ah[j] );
      delta_h[j] += dahj * diff;
      ah_importance[j] += Math.abs(dahj);   // to track which neurons are active 
    } 
  }
  
  void cleanDeltas(){
    for (int k=0; k<delta_o.length; k++) delta_o[k] = 0;
    for (int j=0; j<delta_h.length; j++) delta_h[j] = 0;
  }
  
  double getError2( double [] target ){
    double err2 = 0.0;
    for (int k=0; k<ao.length; k++){ 
      double dk = target[k]-ao[k];  
      err2 += dk*dk;
    }
    return 0.5d*err2;  
  }
  
  void move( ){
    
    //println( " Fo: " );   
    for (int j=0; j<ah.length; j++){  
      for (int k=0; k<ao.length; k++){
        double f    = delta_o[k] * ah[j];  
        double v    = vWho[j][k]*mu + f*dt;
        vWho[j][k]  = v;                          
         Who[j][k] += v*dt;   
        //print( f+" " );          
      }
      //println();  
    }
    //println( " Fi: " );   
    for (int i=0; i<ai.length; i++){  
      for (int j=0; j<ah.length; j++){
        double f    = delta_h[j] * ai[i];
        double v    = vWih[i][j]*mu + f*dt;
        vWih[i][j]  = v;                          
         Wih[i][j] += v * dt; 
        //print( f+" " );          
      }
      //println(); 
    }
   
  }
  
  void test( double [][] inputs ){
    for (int ii=0; ii<inputs.length; ii++){
      double [] input = inputs[ii];
      for (int i=0; i<input.length; i++) ai[i] = input[i];
      eval();
      println( vec2string( input )+" -> "+vec2string( ao ) );
    }
  }
  
  double train_epoch( double [][] inputs, double [][] targets ){
    double err2 = 0;
    for (int i=0; i<ah_importance.length; i++) ah_importance[i] = 0; // clean importance info from last step
    for( int ii=0; ii<inputs.length; ii++ ){
      double [] input = inputs[ii];
      for (int i=0; i<input.length; i++) ai[i] = input[i];
      eval ( );
      cleanDeltas();
      getDeltas( targets[ii] );
      move( );
      err2 += getError2( targets[ii] );
    }
    double error = Math.sqrt( err2 / inputs.length );
    //println( " Error: " + error );
    return error;
  }
  
  
  void plot(){
    loadPixels();
    for (int iy = 0; iy < 200; iy ++) { 
      for (int ix = 0; ix < 200; ix ++) {
        ai[0]= s2x(iy);
        ai[1]= s2x(ix);
        eval ( );
        //println( " x "+ai[0]+" y "+ai[1]+" -> "+  ao[0]);
        color c = color( toClr(ao[0]) );
        pixels[ iy*sz2 + ix ] = c;
        for (int i=0; i<ah.length; i++){
          c = color( toClr( ah[i]*0.8 ) );
          pixels[ (200+iy/4)*sz2 + ix/4 + i*50 ] = c;
        }
      }
    } 
    updatePixels();
    fill(255,0,0);
    for (int i=0; i<ah_importance.length; i++){
      text(  String.format("%2.2f", ah_importance[i]/examples_in.length ) , 50*i, 210 );
    }
    if(viewDots){  
      stroke(255,0,0,20);
      for ( int i=0; i<examples_in.length; i++ ){ 
        fill( color( toClr( examples_out[i][0] ) ) );  
        ellipse( x2s(examples_in[i][1]), x2s(examples_in[i][0]), 4,4 );
        //println( "i"+i+" sx "+x2s(examples_in[i][1])+" sy "+x2s(examples_in[i][0]));
      }
    }
  }
  
  
}
