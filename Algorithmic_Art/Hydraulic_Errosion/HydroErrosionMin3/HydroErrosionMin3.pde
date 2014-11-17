final int n = 500;
final float dt            = 0.2;
final float c_errode      = 0.4 *dt;
final float c_rain        = 0.001*dt;
final float c_sediment    = 0.001*dt;
final float f_sediment    = 0.1;    
final float f_mix         = 0.1;  final float mf_mix  = 1.0-f_mix; 
//final float f_orig        = 0.001; final float mf_orig = 1.0-f_orig; 
final float max_erode     = 0.9;

float [][] h_orig  = new float[n][n];
float [][] h       = new float[n][n];
float [][] watter  = new float[n][n];
float [][] watter_ = new float[n][n];
float [][] slope   = new float[n][n];

final int perframe = 10;

void setup(){
  size(1000,500);
  for(int i=0;i<n;i++){ for(int j=0;j<n;j++){ 
    //h  [i][j] = 0.5 * ( 1.0 +  sin( i*0.12 + sin(i*0.07 ) ) * sin( j*0.08 + sin(i*0.045 ) ) );
    //h       [i][j] = h_orig  [i][j] = noise( 0.01 * i, 0.01 * j );
    h       [i][j] = h_orig  [i][j] = 2*noise( 0.01 * i, 0.01 * j )*( 10000.0/(10000.0+(i-200)*(i-200)+(j-200)*(j-200)) );
    if((i*i+j*j)<40000) h       [i][j] = h_orig  [i][j] = 0.5 + 0.1*noise( 0.01 * i, 0.01 * j );
    watter  [i][j] = watter_ [i][j] = 0.1;
  } }
  frameRate(3);
}

void draw(){
  for (int i=0;i<perframe;i++){
    rain_and_evaporation ( );
    flow_and_errosion    ( );
  }
  //plot(0  ,0, 1.0, h      );
  //plot(500,0, 1.0, watter );
  plot(0  ,0, -1.0, h      );
  plot(500,0, -100.0, watter );
}

