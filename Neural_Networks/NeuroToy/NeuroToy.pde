
final int sz     =64;
final int sz2    = 2 * sz; 
final float zoom = 2.0/sz;

final float bias_range   =6;
final float weight_range =5;

final int yGUI = 100;

final int nlayers=3;
final int mnodes=4;

float [] Lin;
Preceptron_Layer [] layers;
PImage [][] imgs;

void setup(){
  size(nlayers*sz2, mnodes*sz2);
  Lin = new float [2];
  layers = new Preceptron_Layer[nlayers];
  imgs = new PImage[ nlayers ][ mnodes ];
  for (int i=0; i<layers.length; i++){
    if(i==0){ layers[0] = new Preceptron_Layer( mnodes, Lin                ); }
    else    { layers[i] = new Preceptron_Layer( mnodes, layers[i-1].output ); }
    layers[i].initRandom( -bias_range,bias_range, -weight_range, weight_range );
    for (int j=0; j<mnodes; j++){
        imgs[i][j] = new PImage( sz2, sz2 );
    }
  }
  makeMaps();
  plotMaps();
  plotGUI();
}

void draw(){} 

void mouseDragged(){
  int i = mouseX/sz2; int j = mouseY/sz2;
  if( (i<nlayers)&&(j<mnodes) ){
    int di = mouseX - i*sz2; int dj = mouseY - j*sz2;
    Preceptron_Layer L  = layers[i];
    int k = ((L.input.length+1)*di)/sz2;
    float f = (dj-sz)/( float)sz;
  //  println( " i " +i+" j "+j+" di " +di+" dj "+dj+" k "+k );
    if( k == 0 ){ L.bias[j]         = bias_range*f; }
    else{         L.weights[j][k-1] = weight_range*f; }    
  } 
  image( imgs[i][j], i*sz2, j*sz2 );
  plotGUIij(i,j);
  //plotMaps();
  //plotGUI();
}

void mouseReleased(){
  makeMaps();
  plotMaps();
  plotGUI();
}

/*
void mousePressed(){
  int i = mouseX/sz2; int j = mouseY/sz2;
  if( (i<nlayers)&&(j<mnodes) ){
    int di = mouseX - i*sz2; int dj = mouseY - j*sz2;
    Preceptron_Layer L  = layers[i];
    int k = ((L.input.length+1)*di)/sz2;
    float f = (dj-sz)/( float)sz;
  //  println( " i " +i+" j "+j+" di " +di+" dj "+dj+" k "+k );
    if( k == 0 ){ L.bias[j]         = bias_range*f; }
    else{         L.weights[j][k-1] = weight_range*f; }    
  } 
  makeMaps();
  plotMaps();
  plotGUI();
}
*/



