
float isX(float x){ return zoom*(x-sz); }

float toCrl( float x ){
  return constrain( 128*x+128 ,0,255 );
}

void makeMaps( ){
  for (int i=0; i<nlayers; i++) { for (int j=0; j<mnodes; j++) { imgs[i][j].loadPixels(); } }
  for (int iy = 0; iy < sz2; iy ++) { 
    Lin[1] = isX(iy);
    for (int ix = 0; ix < sz2; ix ++) {
      Lin[0] = isX(ix); 
      for (int i=0; i<nlayers; i++){
        layers[i].eval(); 
        for (int j=0; j<mnodes; j++){
          color c = color( toCrl( layers[i].output[j] ) );
          imgs[i][j].pixels[ iy*sz2 + ix ] = c;
        }
      }
    }
  } 
  for (int i=0; i<nlayers; i++) for (int j=0; j<mnodes; j++) {  imgs[i][j].updatePixels(); }
}


void plotMaps(){
  for (int i=0; i<nlayers; i++){    for (int j=0; j<mnodes; j++){   image( imgs[i][j], i*sz2, j*sz2 );  }   }
};

void plotGUI(){
  for (int i=0; i<nlayers; i++){    for (int j=0; j<mnodes; j++){      plotGUIij(i,j);    }  }
}

void plotGUIij(int i, int j){
  Preceptron_Layer L = layers[i];
  stroke(0); fill(255);  
  ellipse( i*sz2, j*sz2 + (L.bias[j]/bias_range)*sz+sz ,5,5);
  stroke(255); fill(0);
  for (int k=0; k<L.input.length; k++){ 
    ellipse( i*sz2 + (k+1)*sz2/( float)(L.input.length+1), j*sz2 + (layers[i].weights[j][k]/weight_range)*sz+sz ,5,5);
  }
}
